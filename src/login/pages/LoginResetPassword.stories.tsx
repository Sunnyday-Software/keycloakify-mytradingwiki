import type { Meta, StoryObj } from "@storybook/react";
import { createKcPageStory, createStorybookStoryHref } from "../KcPageStory";

const { KcPageStory } = createKcPageStory({ pageId: "login-reset-password.ftl" });
const LOGIN_STORY_TITLE = "Authentication/Login Flow/Sign In (login.ftl)";

const meta = {
    title: "Authentication/Login Flow/Password Recovery (login-reset-password.ftl)",
    component: KcPageStory
} satisfies Meta<typeof KcPageStory>;

export default meta;

type Story = StoryObj<typeof meta>;

export const DefaultState: Story = {
    render: () => <KcPageStory />
};

export const ReturnToSignIn: Story = {
    render: () => (
        <KcPageStory
            kcContext={{
                url: {
                    loginUrl: createStorybookStoryHref({
                        title: LOGIN_STORY_TITLE,
                        exportName: "DefaultState"
                    })
                }
            }}
        />
    )
};
