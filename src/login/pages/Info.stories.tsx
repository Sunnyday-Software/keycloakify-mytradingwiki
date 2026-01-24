import type { Meta, StoryObj } from "@storybook/react";
import { createKcPageStory } from "../KcPageStory";

const { KcPageStory } = createKcPageStory({ pageId: "info.ftl" });

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
    title: "login/info.ftl",
    component: PrimaryStory,
    argTypes: {
        astroAppUrl: {
            control: "text"
        }
    }
} satisfies Meta<typeof PrimaryStory>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Default: Story = {
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

export const WithLinkBack: Story = {
    render: () => (
        <KcPageStory
            kcContext={{
                messageHeader: "Message header",
                message: {
                    summary: "Server message"
                },
                actionUri: undefined
            }}
        />
    )
};

export const WithRequiredActions: Story = {
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

export const WithRedirectLink: Story = {
    args: {
        astroAppUrl: "https://example.com"
    },
    render: args => <PrimaryStory {...(args as PrimaryStoryProps)} />
};
