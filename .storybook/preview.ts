import type { Preview } from "@storybook/react";

const preview: Preview = {
    parameters: {
        controls: {
            matchers: {
                color: /(background|color)$/i,
                date: /Date$/i
            }
        },
        options: {
            storySort: {
                order: [
                    "Authentication",
                    [
                        "Login Flow",
                        [
                            "Sign In (login.ftl)",
                            "Password Recovery (login-reset-password.ftl)",
                            "First Login Confirm Email Address (login-idp-link-email.ftl)",
                            "Enrollment Email Verified (login-verify-email.ftl)",
                            "Post Login Information (info.ftl)"
                        ]
                    ]
                ]
            }
        }
    }
};

export default preview;
