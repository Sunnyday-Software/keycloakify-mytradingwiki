<#--
  WARNING: Before modifying this file, run the following command:
  
  $ npx keycloakify own --path "email/html/org-invite.ftl"
  
  This file is provided by @keycloakify/email-native version 260007.0.0.
  It was copied into your repository by the postinstall script: `keycloakify sync-extensions`.
-->

<#import "template.ftl" as layout>
<#assign
    brandName=msg("emails.brand.name")
    orgName=(organization?? && organization.name??)?then(organization.name, "")
    orgNameSafe=kcSanitize(orgName)
    firstNameSafe=(firstName??)?then(kcSanitize(firstName), "")
    lastNameSafe=(lastName??)?then(kcSanitize(lastName), "")
    preheader=msg("emails.invite.preheader", orgNameSafe)
    title=msg("emails.invite.title", orgNameSafe)
    intro=(firstName?? && lastName??)?then(
        msg("emails.invite.introPersonalized", firstNameSafe, lastNameSafe, orgNameSafe),
        msg("emails.invite.intro", orgNameSafe)
    )
    context=msg("emails.invite.context")
    ctaLabel=msg("emails.invite.cta")
    ctaAria=msg("emails.invite.aria.cta")
    expiration=msg("emails.meta.expiresIn", linkExpirationFormatter(linkExpiration))
    fallbackIntro=msg("emails.fallbackIntro")
    fallbackLabel=msg("emails.invite.fallbackLabel")
    securityNote=msg("emails.security.neverShareLink")
    disclaimer=msg("emails.security.ignoreIfNoRequested")
    footerSupport=msg("emails.support")
    footerSignature=msg("emails.signature")
>

<@layout.BrandedEmail
    preheader=preheader
    title=title
    intro=intro
    context=context
    ctaLabel=ctaLabel
    ctaLink=link
    ctaAria=ctaAria
    metaText=expiration
    fallbackIntro=fallbackIntro
    fallbackLabel=fallbackLabel
    fallbackLink=link
    securityNote=securityNote
    disclaimer=disclaimer
    footerSupport=footerSupport
    footerSignature=footerSignature
    brandName=brandName
/>
