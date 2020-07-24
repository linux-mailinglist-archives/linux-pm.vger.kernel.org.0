Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7822CDE9
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGXSkR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXSkR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 14:40:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FC8C0619D3;
        Fri, 24 Jul 2020 11:40:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so8407420wmg.1;
        Fri, 24 Jul 2020 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZlSUbDhdE53sVd33d+LQLymoBYl1U1XEv8/R2vSrtz0=;
        b=jsF8paOaXApGFBfZOQSFlI0uLFaS1BGCoABV96/OS83jhzEXtboABcU8LQVLhpAbnK
         +dCqhmqrW+nSAo6uXRZyWXIYuWC7QyVXPNefO6NBGF0QIYh6cUVKTZyhENUKNIMclkMl
         Yd4dYWUkBiBXp4RLtnL5daaHyTFmDQz/8l5YXqzz4fZDsT7UQAW8uwwJxyl3kW5hJNkP
         kAItf8EfaWW9yZxTpEtNqg58QnACSPA5b2mW6Nln4Zsbdo7WUk5M0bvc13P8q+KpomVG
         RA/furP4g9VRkvE8Gjyx1vgGb6lbqz41TZiyXKNEcKNrHf3n3w8Aa+FlIBQs1F3PmWaj
         t42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZlSUbDhdE53sVd33d+LQLymoBYl1U1XEv8/R2vSrtz0=;
        b=c3jVxc69Xyo0CE/ecmrTvoNFvBgfGMU91tJe4yCotVXPWZZa1lyF6x1poPcsiC8sJZ
         uDBDqz2jF3NVyjR1UPkb4yLQ1pk6CJz86i0Ef/TwOZQCFJXJzClyIoxl5Iteyou93Klf
         OOhlN0YQEaGGI7srEEEwwbZDsKt303wMR9+k4JdogOwjgv0NlPD4W4jQUx7tmeCR9KQ+
         n9/fsYi9OOcCaTrM1kWuh5dnxCtmDL9jjV4G+ebemigjTTujekjHE3jSzFZ2sW6lCP6I
         GRKyzd3q8oiBTz4PigUW3LPEXDSFed6r4IVbd29FHv1plaInphdJd4La8jLy9Xs7CfT0
         9JKw==
X-Gm-Message-State: AOAM53222H08u9BrkivazcMxGA+9BDl7cj9Du16hapeFc84lxpKE5Z20
        eWSxbNOIc+U/og35DyjEJb6JCnm4
X-Google-Smtp-Source: ABdhPJzo7JuqMYGDQrYXjLAp2UKUWitZh530xrAbHgW4YAdM2WI3C+vNih5hZOkIy3zRJ+KZzLAvBg==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr10355954wma.4.1595616015612;
        Fri, 24 Jul 2020 11:40:15 -0700 (PDT)
Received: from [10.67.50.75] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 2sm7865692wmo.44.2020.07.24.11.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 11:40:14 -0700 (PDT)
Subject: Re: [RFT 12/16] memory: brcmstb_dpfe: Add separate entry for compile
 test
To:     Krzysztof Kozlowski <krzk@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-13-krzk@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <7797a55e-bbf0-ef0f-daec-d56326167586@gmail.com>
Date:   Fri, 24 Jul 2020 11:40:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724182328.3348-13-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/24/20 11:23 AM, Krzysztof Kozlowski wrote:
> Add separate entry for Broadcom STB DPFE driver, selected by platforms
> by default.  This allows further customization and compile testing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> 
> I have other changes around drivers/memory/Kconfig pending. Sending them
> together would avoid conflicts.
> 
> ---
>  arch/arm/mach-bcm/Kconfig    |  1 +
>  arch/arm64/Kconfig.platforms |  1 +
>  drivers/memory/Kconfig       | 11 +++++++++++
>  drivers/memory/Makefile      |  2 +-
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 1df0ee01ee02..b0c45238e69b 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -208,6 +208,7 @@ config ARCH_BRCMSTB
>  	select ARM_GIC
>  	select ARM_ERRATA_798181 if SMP
>  	select HAVE_ARM_ARCH_TIMER
> +	select BRCMSTB_DPFE
>  	select BRCMSTB_L2_IRQ
>  	select BCM7120_L2_IRQ
>  	select ARCH_HAS_HOLES_MEMORYMODEL
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index ddc3bf75257f..f7791ed0ed6d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -68,6 +68,7 @@ config ARCH_BRCMSTB
>  	bool "Broadcom Set-Top-Box SoCs"
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select BCM7038_L1_IRQ
> +	select BRCMSTB_DPFE

The select is probably not warranted, see below.

>  	select BRCMSTB_L2_IRQ
>  	select GENERIC_IRQ_CHIP
>  	select PINCTRL
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index cd4fc93b50df..fef6f0873fda 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -54,6 +54,17 @@ config ATMEL_EBI
>  	  tree is used. This bus supports NANDs, external ethernet controller,
>  	  SRAMs, ATA devices, etc.
>  
> +config BRCMSTB_DPFE
> +	bool "Broadcom STB DPFE driver" if COMPILE_TEST
> +	depends on ARCH_BRCMSTB || COMPILE_TEST

Can you make it default ARCH_BRCMSTB and remove the select above?

With that:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> +	help
> +	  This driver provides access to the DPFE interface of Broadcom
> +	  STB SoCs. The firmware running on the DCPU inside the DDR PHY can
> +	  provide current information about the system's RAM, for instance
> +	  the DRAM refresh rate. This can be used as an indirect indicator
> +	  for the DRAM's temperature. Slower refresh rate means cooler RAM,
> +	  higher refresh rate means hotter RAM.
> +
>  config BT1_L2_CTL
>  	bool "Baikal-T1 CM2 L2-RAM Cache Control Block"
>  	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index b4533ffff2bc..e71cf7b99641 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -10,7 +10,7 @@ endif
>  obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
>  obj-$(CONFIG_ATMEL_SDRAMC)	+= atmel-sdramc.o
>  obj-$(CONFIG_ATMEL_EBI)		+= atmel-ebi.o
> -obj-$(CONFIG_ARCH_BRCMSTB)	+= brcmstb_dpfe.o
> +obj-$(CONFIG_BRCMSTB_DPFE)	+= brcmstb_dpfe.o
>  obj-$(CONFIG_BT1_L2_CTL)	+= bt1-l2-ctl.o
>  obj-$(CONFIG_TI_AEMIF)		+= ti-aemif.o
>  obj-$(CONFIG_TI_EMIF)		+= emif.o
> 


-- 
Florian
