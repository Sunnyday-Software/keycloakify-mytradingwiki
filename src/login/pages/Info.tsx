import type { PageProps } from "keycloakify/login/pages/PageProps";
import { kcSanitize } from "keycloakify/lib/kcSanitize";
import { useEffect, useMemo, useState } from "react";
import type { KcContext } from "../KcContext";
import type { I18n } from "../i18n";
import styles from "./Info.module.css";

const DEFAULT_REDIRECT_TIMEOUT_SECONDS = 5;
const DEFAULT_REDIRECT_TIMEOUT_MS = DEFAULT_REDIRECT_TIMEOUT_SECONDS * 1000;
const REDIRECT_TIMEOUT_PROPERTY_KEY = "ASTRO_INFO_REDIRECT_TIMEOUT_MS";
const DASHBOARD_PATH = "/dashboard";

function normalizeBaseUrl(rawBaseUrl: string | undefined): string | undefined {
    const baseUrl = rawBaseUrl?.trim();

    if (!baseUrl) {
        return undefined;
    }

    return baseUrl.replace(/\/+$/, "");
}

function createLocalizedPath(languageTag: string, pathname: string): string {
    const normalizedPathname = pathname.startsWith("/") ? pathname : `/${pathname}`;
    return `/${languageTag}${normalizedPathname}`;
}

function getStringProperty(properties: KcContext["properties"] | undefined, key: string): string | undefined {
    const value = (properties as Record<string, unknown> | undefined)?.[key];

    if (typeof value !== "string") {
        return undefined;
    }

    const normalizedValue = value.trim();
    return normalizedValue.length > 0 ? normalizedValue : undefined;
}

function parseRedirectTimeoutMs(rawTimeoutMs: string | undefined): number {
    if (!rawTimeoutMs) {
        return DEFAULT_REDIRECT_TIMEOUT_MS;
    }

    const timeoutMs = Number.parseInt(rawTimeoutMs, 10);

    if (!Number.isFinite(timeoutMs) || timeoutMs <= 0) {
        return DEFAULT_REDIRECT_TIMEOUT_MS;
    }

    return timeoutMs;
}

export default function Info(props: PageProps<Extract<KcContext, { pageId: "info.ftl" }>, I18n>) {
    const { kcContext, i18n, doUseDefaultCss, Template, classes } = props;

    const { advancedMsgStr, msg, currentLanguage } = i18n;

    const { messageHeader, message, requiredActions, skipLink, pageRedirectUri, actionUri, properties, client } = kcContext;

    const targetUrl = useMemo(() => {
        const baseUrl = normalizeBaseUrl(properties?.ASTRO_APP_URL);

        if (baseUrl) {
            return `${baseUrl}${createLocalizedPath(currentLanguage.languageTag, DASHBOARD_PATH)}`;
        }

        return pageRedirectUri ?? actionUri ?? client?.baseUrl ?? undefined;
    }, [properties?.ASTRO_APP_URL, currentLanguage.languageTag, pageRedirectUri, actionUri, client?.baseUrl]);

    const totalMs = useMemo(
        () => parseRedirectTimeoutMs(getStringProperty(properties, REDIRECT_TIMEOUT_PROPERTY_KEY)),
        [properties]
    );
    const [elapsedMs, setElapsedMs] = useState(0);

    useEffect(() => {
        if (!targetUrl || skipLink) {
            return;
        }

        setElapsedMs(0);

        const startedAt = Date.now();
        const intervalId = window.setInterval(() => {
            const nextElapsed = Date.now() - startedAt;
            if (nextElapsed >= totalMs) {
                window.clearInterval(intervalId);
                window.location.assign(targetUrl);
                return;
            }

            setElapsedMs(nextElapsed);
        }, 100);

        return () => {
            window.clearInterval(intervalId);
        };
    }, [skipLink, targetUrl, totalMs]);

    const secondsLeft = Math.max(0, Math.ceil((totalMs - elapsedMs) / 1000));
    const progressPercent = Math.min(100, Math.round((elapsedMs / totalMs) * 100));

    return (
        <Template
            kcContext={kcContext}
            i18n={i18n}
            doUseDefaultCss={doUseDefaultCss}
            classes={classes}
            displayMessage={false}
            headerNode={messageHeader &&
                <span
                    dangerouslySetInnerHTML={{
                        __html: kcSanitize(messageHeader ?? message.summary)
                    }}
                />
            }
        >
            <div className={styles.infoContainer}>
                <div id="kc-info-message">
                    {requiredActions && (
                        <p
                            className={styles.instruction}
                            dangerouslySetInnerHTML={{
                                __html: kcSanitize(
                                    ` <b>${requiredActions
                                        .map(requiredAction => advancedMsgStr(`requiredAction.${requiredAction}`))
                                        .join(", ")}</b>`
                                )
                            }}
                        />
                    )}
                    {(() => {
                        if (skipLink) {
                            return null;
                        }

                        if (!targetUrl) {
                            return null;
                        }

                        return (
                            <div className={styles.actions}>
                                <p className={styles.countdownText}>
                                    Redirecting in {secondsLeft}s
                                </p>
                                <div className={styles.progressBar} role="progressbar" aria-valuemin={0} aria-valuemax={100} aria-valuenow={progressPercent}>
                                    <div className={styles.progressBarFill} style={{ width: `${progressPercent}%` }} />
                                </div>
                                <button
                                    type="button"
                                    className={styles.redirectButton}
                                    onClick={() => window.location.assign(targetUrl)}
                                >
                                    {msg("backToApplication")}
                                </button>
                            </div>
                        );
                    })()}
                </div>
            </div>
        </Template>
    );
}
