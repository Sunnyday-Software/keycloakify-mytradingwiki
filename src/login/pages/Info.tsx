import type { PageProps } from "keycloakify/login/pages/PageProps";
import { kcSanitize } from "keycloakify/lib/kcSanitize";
import { useEffect, useMemo, useState } from "react";
import type { KcContext } from "../KcContext";
import type { I18n } from "../i18n";
import styles from "./Info.module.css";

export default function Info(props: PageProps<Extract<KcContext, { pageId: "info.ftl" }>, I18n>) {
    const { kcContext, i18n, doUseDefaultCss, Template, classes } = props;

    const { advancedMsgStr, msg } = i18n;

    const { messageHeader, message, requiredActions, skipLink, pageRedirectUri, actionUri, properties, client } = kcContext;

    const targetUrl = useMemo(() => {
        if (properties?.ASTRO_APP_URL) {
            return `${properties.ASTRO_APP_URL}/dashboard`;
        }

        return pageRedirectUri ?? actionUri ?? client?.baseUrl ?? undefined;
    }, [properties?.ASTRO_APP_URL, pageRedirectUri, actionUri, client?.baseUrl]);

    const totalSeconds = 5;
    const totalMs = totalSeconds * 1000;
    const [elapsedMs, setElapsedMs] = useState(0);

    useEffect(() => {
        if (!targetUrl) {
            return;
        }

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
    }, [targetUrl, totalMs]);

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
