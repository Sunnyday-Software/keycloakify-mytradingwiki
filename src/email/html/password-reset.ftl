<#--
  WARNING: Before modifying this file, run the following command:
  
  $ npx keycloakify own --path "email/html/password-reset.ftl"
  
  This file is provided by @keycloakify/email-native version 260007.0.0.
  It was copied into your repository by the postinstall script: `keycloakify sync-extensions`.
-->

<#import "template.ftl" as layout>

<#assign
    brandName=msg("emails.brand.name")
    preheader=msg("emails.reset.preheader", brandName)
    title=msg("emails.reset.title")
    intro=msg("emails.reset.intro", brandName)
    context=msg("emails.reset.context")
    ctaLabel=msg("emails.reset.cta")
    ctaAria=msg("emails.reset.aria.cta")
    expiration=msg("emails.meta.expiresIn", linkExpirationFormatter(linkExpiration))
    fallbackIntro=msg("emails.fallbackIntro")
    fallbackLabel=msg("emails.reset.fallbackLabel")
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
