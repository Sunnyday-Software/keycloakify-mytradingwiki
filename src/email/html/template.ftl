<#macro RootLayout preheader="" title="">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="color-scheme" content="light dark">
    <meta name="supported-color-schemes" content="light dark">
    <title>${title}</title>
    <style type="text/css">
        body { margin: 0; padding: 0; background-color: #f1f4f8; }
        table { border-collapse: collapse; }
        img { border: 0; line-height: 100%; outline: none; text-decoration: none; }
        a { color: #2c6fce; }
        .preheader {
            display: none !important;
            visibility: hidden;
            opacity: 0;
            color: transparent;
            height: 0;
            width: 0;
            mso-hide: all;
            overflow: hidden;
        }
        .email-shell { background-color: #f1f4f8; }
        .email-card {
            background-color: #ffffff;
            border: 1px solid #dbe3ee;
            border-radius: 20px;
        }
        .hero {
            background-color: #040a1d;
            border: 1px solid #18233f;
            border-radius: 16px;
        }
        .hero-title {
            color: #d43474;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.3px;
            line-height: 18px;
        }
        .text-title {
            color: #111827;
            font-size: 30px;
            font-weight: 700;
            line-height: 38px;
            letter-spacing: -0.2px;
        }
        .text-body {
            color: #4b5567;
            font-size: 16px;
            line-height: 25px;
        }
        .text-muted {
            color: #6e788a;
            font-size: 14px;
            line-height: 21px;
        }
        .button {
            background-color: #4eb780;
            border-radius: 10px;
        }
        .button a {
            color: #ffffff !important;
            display: inline-block;
            font-size: 16px;
            font-weight: 700;
            line-height: 24px;
            text-decoration: none;
        }
        .fallback {
            background-color: #f8fafc;
            border: 1px solid #dfe5ee;
            border-radius: 14px;
        }
        .fallback-link {
            color: #2c6fce !important;
            word-break: break-all;
        }
        .footer-divider {
            border-top: 1px solid #e7edf5;
            height: 1px;
            line-height: 1px;
            font-size: 1px;
        }
        @media (prefers-color-scheme: dark) {
            body, .email-shell { background-color: #040a1d !important; }
            .email-card {
                background-color: #0d1730 !important;
                border-color: #273857 !important;
            }
            .hero {
                background-color: #040a1d !important;
                border-color: #2c3b5e !important;
            }
            .hero-title { color: #f071a5 !important; }
            .text-title { color: #f8fbff !important; }
            .text-body { color: #d6def0 !important; }
            .text-muted { color: #9ca9c1 !important; }
            .fallback {
                background-color: #111d37 !important;
                border-color: #334565 !important;
            }
            .fallback-link { color: #9cc3ff !important; }
            .footer-divider { border-top-color: #2a3c5f !important; }
            .button { background-color: #4eb780 !important; }
            a { color: #9cc3ff !important; }
        }
        [data-ogsc] .email-shell,
        [data-ogsb] .email-shell {
            background-color: #040a1d !important;
        }
        [data-ogsc] .email-card,
        [data-ogsb] .email-card {
            background-color: #0d1730 !important;
            border-color: #273857 !important;
        }
        [data-ogsc] .text-title,
        [data-ogsb] .text-title {
            color: #f8fbff !important;
        }
        [data-ogsc] .text-body,
        [data-ogsb] .text-body {
            color: #d6def0 !important;
        }
        [data-ogsc] .text-muted,
        [data-ogsb] .text-muted {
            color: #9ca9c1 !important;
        }
        [data-ogsc] .fallback,
        [data-ogsb] .fallback {
            background-color: #111d37 !important;
            border-color: #334565 !important;
        }
        [data-ogsc] .fallback-link,
        [data-ogsb] .fallback-link {
            color: #9cc3ff !important;
        }
    </style>
</head>
<body class="email-shell" style="margin:0; padding:0; background-color:#f1f4f8;">
    <span class="preheader">${preheader}</span>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#f1f4f8;" class="email-shell">
        <tr>
            <td align="center" style="padding:24px 12px;">
                <#nested>
            </td>
        </tr>
    </table>
</body>
</html>
</#macro>

<#macro CenteredCardLayout>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:520px; width:100%;">
        <tr>
            <td>
                <#nested>
            </td>
        </tr>
    </table>
</#macro>

<#macro CardStackLayout>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" class="email-card" style="background-color:#ffffff; border:1px solid #dbe3ee; border-radius:20px;">
        <tr>
            <td style="padding:0; font-family:'Inter','Segoe UI',Arial,sans-serif; color:#111827;">
                <#nested>
            </td>
        </tr>
    </table>
</#macro>

<#macro BrandHero brandName logoUrl>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin:0 0 24px 0;">
        <tr>
            <td align="center">
                <table role="presentation" width="100%" cellpadding="0" cellspacing="0" class="hero" style="background-color:#040a1d; border-radius:16px; border:1px solid #18233f;">
                    <tr>
                        <td align="center" style="padding:20px 12px 8px 12px;">
                            <img src="${logoUrl}" width="140" height="44" alt="${brandName}" style="border:0; display:block; outline:none; text-decoration:none; max-width:140px; width:100%; height:auto;">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" style="padding:0 12px 16px 12px;" class="hero-title">
                            ${brandName}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</#macro>

<#macro TitleBlock title>
    <h1 style="margin:0 0 16px 0;" class="text-title">${title}</h1>
</#macro>

<#macro BodyCopy intro context>
    <#if intro?has_content>
        <p style="margin:0 0 10px 0;" class="text-body">${intro}</p>
    </#if>
    <#if context?has_content>
        <p style="margin:0 0 20px 0;" class="text-body">${context}</p>
    </#if>
</#macro>

<#macro PrimaryCTA label link aria>
    <#if label?has_content && link?has_content>
        <table role="presentation" cellpadding="0" cellspacing="0" style="margin:0 0 18px 0;">
            <tr>
                <td align="center" bgcolor="#4eb780" class="button" style="border-radius:10px;">
                    <a href="${link}" aria-label="${aria}" style="padding:14px 24px;">${label}</a>
                </td>
            </tr>
        </table>
    </#if>
</#macro>

<#macro MetaRow text>
    <#if text?has_content>
        <p style="margin:0 0 18px 0;" class="text-muted">${text}</p>
    </#if>
</#macro>

<#macro FallbackPanel intro label link>
    <#if link?has_content>
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" class="fallback" style="background-color:#f8fafc; border:1px solid #dfe5ee; border-radius:14px; margin:0 0 18px 0;">
            <tr>
                <td style="padding:14px 16px; font-family:'Inter','Segoe UI',Arial,sans-serif;" class="text-muted">
                    <#if intro?has_content>
                        <p style="margin:0 0 8px 0;" class="text-muted">${intro}</p>
                    </#if>
                    <#if label?has_content>
                        <p style="margin:0 0 6px 0; font-weight:600;" class="text-body">${label}</p>
                    </#if>
                    <p style="margin:0;" class="text-muted">
                        <a href="${link}" style="text-decoration:underline;" class="fallback-link">${link}</a>
                    </p>
                </td>
            </tr>
        </table>
    </#if>
</#macro>

<#macro SecurityNotice note disclaimer>
    <#if note?has_content>
        <p style="margin:0 0 8px 0;" class="text-muted">${note}</p>
    </#if>
    <#if disclaimer?has_content>
        <p style="margin:0 0 18px 0;" class="text-muted">${disclaimer}</p>
    </#if>
</#macro>

<#macro FooterLayout support signature>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin:0 0 14px 0;">
        <tr>
            <td class="footer-divider">&nbsp;</td>
        </tr>
    </table>
    <#if support?has_content>
        <p style="margin:0 0 6px 0;" class="text-muted">${support}</p>
    </#if>
    <#if signature?has_content>
        <p style="margin:0;" class="text-muted">${signature}</p>
    </#if>
</#macro>

<#macro BrandedEmail preheader title intro context ctaLabel ctaLink ctaAria metaText fallbackIntro fallbackLabel fallbackLink securityNote disclaimer footerSupport footerSignature brandName>
    <@RootLayout preheader=preheader title=title>
        <@CenteredCardLayout>
            <@CardStackLayout>
                <@BrandHero brandName=brandName logoUrl="${url.resourcesUrl}/mtw-logo-email.png" />
                <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="padding:0 30px 30px 30px; font-family:'Inter','Segoe UI',Arial,sans-serif; color:#111827;">
                            <@TitleBlock title=title />
                            <@BodyCopy intro=intro context=context />
                            <@PrimaryCTA label=ctaLabel link=ctaLink aria=ctaAria />
                            <@MetaRow text=metaText />
                            <@FallbackPanel intro=fallbackIntro label=fallbackLabel link=fallbackLink />
                            <@SecurityNotice note=securityNote disclaimer=disclaimer />
                            <@FooterLayout support=footerSupport signature=footerSignature />
                        </td>
                    </tr>
                </table>
            </@CardStackLayout>
        </@CenteredCardLayout>
    </@RootLayout>
</#macro>

<#macro emailLayout preheader="" title="">
    <@RootLayout preheader=preheader title=title>
        <@CenteredCardLayout>
            <@CardStackLayout>
                <#nested>
            </@CardStackLayout>
        </@CenteredCardLayout>
    </@RootLayout>
</#macro>
