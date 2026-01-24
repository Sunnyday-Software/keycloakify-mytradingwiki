import type { PageProps } from "keycloakify/login/pages/PageProps";
import { kcSanitize } from "keycloakify/lib/kcSanitize";
import type { KcContext } from "../KcContext";
import type { I18n } from "../i18n";
import styles from "./Info.module.css";

export default function Info(props: PageProps<Extract<KcContext, { pageId: "info.ftl" }>, I18n>) {
    const { kcContext, i18n, doUseDefaultCss, Template, classes } = props;

    const { advancedMsgStr, msg } = i18n;

    const { messageHeader, message, requiredActions, skipLink, pageRedirectUri, actionUri, properties } = kcContext;

    return (
        <Template
            kcContext={kcContext}
            i18n={i18n}
            doUseDefaultCss={doUseDefaultCss}
            classes={classes}
            displayMessage={false}
            headerNode={
                <span
                    dangerouslySetInnerHTML={{
                        __html: kcSanitize(messageHeader ?? message.summary)
                    }}
                />
            }
        >
            <div className={styles.infoContainer}>
                <div id="kc-info-message" className={styles.infoCard}>
                    <p
                        className={styles.instruction}
                        dangerouslySetInnerHTML={{
                            __html: kcSanitize(
                                (() => {
                                    let html = message.summary?.trim();

                                    if (requiredActions) {
                                        html += " <b>";

                                        html += requiredActions.map(requiredAction => advancedMsgStr(`requiredAction.${requiredAction}`)).join(", ");

                                        html += "</b>";
                                    }

                                    return html;
                                })()
                            )
                        }}
                    />
                    {(() => {
                        if (skipLink) {
                            return null;
                        }

                        if (pageRedirectUri) {
                            return (
                                <p>
                                    <a href={pageRedirectUri} className={styles.link}>
                                        {msg("backToApplication")}
                                    </a>
                                </p>
                            );
                        }
                        if (actionUri) {
                            return (
                                <p>
                                    <a href={actionUri} className={styles.link}>
                                        {msg("proceedWithAction")}
                                    </a>
                                </p>
                            );
                        }

                        if (properties?.ASTRO_APP_URL) {
                            return (
                                <p>
                                    <a href={properties.ASTRO_APP_URL} className={styles.link}>
                                        {msg("backToApplication")}
                                    </a>
                                </p>
                            );
                        }
                    })()}
                </div>
            </div>
        </Template>
    );
}
