import type { Meta, StoryObj } from "@storybook/react";
import { createKcPageStory, createStorybookStoryHref } from "../KcPageStory";

const { KcPageStory } = createKcPageStory({ pageId: "info.ftl" });
const LOGIN_STORY_TITLE = "Authentication/Login Flow/Sign In (login.ftl)";

type PrimaryStoryProps = {
    astroAppUrl?: string;
};

function PrimaryStory(props: PrimaryStoryProps) {
    const {  astroAppUrl } = props;

    return (
        <KcPageStory
            kcContext={{
                messageHeader: "Your account has been updated.",
                message: {
                    summary: "Your account has been updated."
                },
                properties: {
                    ASTRO_APP_URL: astroAppUrl
                }
            }}
        />
    );
}

const meta = {
    title: "Authentication/Login Flow/Post Login Information (info.ftl)",
    component: PrimaryStory,
    argTypes: {
        astroAppUrl: {
            control: "text"
        }
    }
} satisfies Meta<typeof PrimaryStory>;

export default meta;

type Story = StoryObj<typeof meta>;

export const DefaultMessage: Story = {
    render: () => (
        <KcPageStory
            kcContext={{
                messageHeader: "Message header",
                message: {
                    summary: "Server info message"
                }
            }}
        />
    )
};

export const ReturnToSignIn: Story = {
    render: () => (
        <KcPageStory
            kcContext={{
                messageHeader: "Message header",
                message: {
                    summary: "Server message"
                },
                actionUri: createStorybookStoryHref({
                    title: LOGIN_STORY_TITLE,
                    exportName: "DefaultState"
                }),
                pageRedirectUri: undefined,
                skipLink: false,
                properties: {
                    ASTRO_INFO_REDIRECT_TIMEOUT_MS: "60000"
                }
            }}
        />
    )
};

export const RequiredActionsSummary: Story = {
    render: () => (
        <KcPageStory
            kcContext={{
                messageHeader: "Message header",
                message: {
                    summary: "Required actions:"
                },
                requiredActions: ["CONFIGURE_TOTP", "UPDATE_PROFILE", "VERIFY_EMAIL", "CUSTOM_ACTION"],
                "x-keycloakify": {
                    messages: {
                        "requiredAction.CUSTOM_ACTION": "Custom action"
                    }
                }
            }}
        />
    )
};

export const RedirectToApplication: Story = {
    args: {
        astroAppUrl: "https://example.com"
    },
    render: args => <PrimaryStory {...(args as PrimaryStoryProps)} />
};
