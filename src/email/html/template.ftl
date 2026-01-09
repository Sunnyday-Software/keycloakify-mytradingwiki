<#macro emailLayout preheader title intro context ctaLabel ctaLink ctaAria expiration fallbackIntro fallbackLabel fallbackLink securityNote disclaimer footerSupport footerSignature>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="color-scheme" content="light dark">
    <meta name="supported-color-schemes" content="light dark">
    <title>${title}</title>
    <style type="text/css">
        body { margin: 0; padding: 0; }
        table { border-collapse: collapse; }
        img { border: 0; line-height: 100%; outline: none; text-decoration: none; }
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
    </style>
</head>
<body style="margin:0; padding:0; background-color:#f8fafc;">
    <span class="preheader">${preheader}</span>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#f8fafc;">
        <tr>
            <td align="center" style="padding:24px 12px;">
                <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:520px; width:100%;">
                    <tr>
                        <td align="center" style="padding:8px 0 20px 0;">
                            <img src="${url.resourcesUrl}/mytradingwiki.svg" width="160" height="48" alt="MyTradingWiki" style="border:0; display:block; outline:none; text-decoration:none; max-width:160px; width:100%; height:auto;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#ffffff; border:1px solid #e2e8f0; border-radius:16px;">
                                <tr>
                                    <td style="padding:24px; font-family: 'Inter', 'Segoe UI', Arial, sans-serif; color:#0f172a;">
                                        <h1 style="margin:0 0 12px 0; font-size:20px; line-height:28px; font-weight:700;">${title}</h1>
                                        <p style="margin:0 0 12px 0; font-size:14px; line-height:22px; color:#334155;">${intro}</p>
                                        <p style="margin:0 0 20px 0; font-size:14px; line-height:22px; color:#334155;">${context}</p>

                                        <table role="presentation" cellpadding="0" cellspacing="0" style="margin:0 0 16px 0;">
                                            <tr>
                                                <td align="center" bgcolor="#10b981" style="border-radius:8px;">
                                                    <a href="${ctaLink}" aria-label="${ctaAria}" style="display:inline-block; padding:12px 18px; font-size:14px; line-height:20px; color:#ffffff; text-decoration:none; font-weight:600;">${ctaLabel}</a>
                                                </td>
                                            </tr>
                                        </table>

                                        <p style="margin:0 0 16px 0; font-size:12px; line-height:18px; color:#64748b;">${expiration}</p>

                                        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#f1f5f9; border:1px solid #e2e8f0; border-radius:12px;">
                                            <tr>
                                                <td style="padding:12px; font-size:12px; line-height:18px; color:#475569; font-family: 'Inter', 'Segoe UI', Arial, sans-serif;">
                                                    <p style="margin:0 0 8px 0;">${fallbackIntro}</p>
                                                    <p style="margin:0; font-weight:600; color:#0f172a;">${fallbackLabel}</p>
                                                    <p style="margin:4px 0 0 0; word-break:break-all;">
                                                        <a href="${fallbackLink}" style="color:#0f766e; text-decoration:underline;">${fallbackLink}</a>
                                                    </p>
                                                </td>
                                            </tr>
                                        </table>

                                        <p style="margin:16px 0 8px 0; font-size:12px; line-height:18px; color:#64748b;">${securityNote}</p>
                                        <p style="margin:0 0 16px 0; font-size:12px; line-height:18px; color:#64748b;">${disclaimer}</p>

                                        <p style="margin:0 0 6px 0; font-size:12px; line-height:18px; color:#475569;">${footerSupport}</p>
                                        <p style="margin:0; font-size:12px; line-height:18px; color:#475569;">${footerSignature}</p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
</#macro>
