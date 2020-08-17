Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB3247224
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389317AbgHQSiu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 14:38:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45097 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389022AbgHQSiZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 14:38:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id di22so13105061edb.12;
        Mon, 17 Aug 2020 11:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygsRrFQKNNgr0RK++uWNK1Es6XzBSNHbUC5sc4XjiKQ=;
        b=nSJMbLxHj64Y0EEqSkptelHN4fy6ILsP1yu/fB9R2kTZdY8BAX7iMIvaAfwwncMG8Y
         kZmG72942WuiChC79nQsI8bhGCRm8cBdMXxl72C5KTQKthbFSZhAvzsX/MqiC5jg3J2C
         ZABroBSa4rVL+tFbsk2DvCl94EL1f4yvrscMZoYKslgvxE7RHVTJOPHQhBKhUih6tox8
         4r3GwsbPu6RESueYhzQe8BlR6ag/21BR747TiqSKpchtdGJGaaKbVeCkPwyLuQlhTmfP
         pkLRVxNRQO7z6GNOuQevV8te1DWEzbM3QCcrrEq/rdipHxhD8Q5W/Kwnf/dARM2LXnGr
         oKHA==
X-Gm-Message-State: AOAM530tVFjYJJRPixyvaqrlzGeBoTUaa321+lUjceqTbUuy8xkLyPHE
        l7MFnuz8IiE2Ew3kRFuu4Bo=
X-Google-Smtp-Source: ABdhPJwTHkl2N45n7OMVOzl8gJxUEHQgoH3VvkybLtipP1zhCy2cCEkRCEFnt89iK8ZP7yOOj3jNyw==
X-Received: by 2002:aa7:c6c3:: with SMTP id b3mr16422506eds.215.1597689502561;
        Mon, 17 Aug 2020 11:38:22 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id c5sm14730574ejb.103.2020.08.17.11.38.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 11:38:21 -0700 (PDT)
Date:   Mon, 17 Aug 2020 20:38:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
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
        linux-pm@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFT 12/16] memory: brcmstb_dpfe: Add separate entry for compile
 test
Message-ID: <20200817183819.GI3464@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-13-krzk@kernel.org>
 <7797a55e-bbf0-ef0f-daec-d56326167586@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7797a55e-bbf0-ef0f-daec-d56326167586@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 11:40:09AM -0700, Florian Fainelli wrote:
> On 7/24/20 11:23 AM, Krzysztof Kozlowski wrote:
> > Add separate entry for Broadcom STB DPFE driver, selected by platforms
> > by default.  This allows further customization and compile testing.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> > 
> > I have other changes around drivers/memory/Kconfig pending. Sending them
> > together would avoid conflicts.
> > 
> > ---
> >  arch/arm/mach-bcm/Kconfig    |  1 +
> >  arch/arm64/Kconfig.platforms |  1 +
> >  drivers/memory/Kconfig       | 11 +++++++++++
> >  drivers/memory/Makefile      |  2 +-
> >  4 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> > index 1df0ee01ee02..b0c45238e69b 100644
> > --- a/arch/arm/mach-bcm/Kconfig
> > +++ b/arch/arm/mach-bcm/Kconfig
> > @@ -208,6 +208,7 @@ config ARCH_BRCMSTB
> >  	select ARM_GIC
> >  	select ARM_ERRATA_798181 if SMP
> >  	select HAVE_ARM_ARCH_TIMER
> > +	select BRCMSTB_DPFE
> >  	select BRCMSTB_L2_IRQ
> >  	select BCM7120_L2_IRQ
> >  	select ARCH_HAS_HOLES_MEMORYMODEL
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index ddc3bf75257f..f7791ed0ed6d 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -68,6 +68,7 @@ config ARCH_BRCMSTB
> >  	bool "Broadcom Set-Top-Box SoCs"
> >  	select ARCH_HAS_RESET_CONTROLLER
> >  	select BCM7038_L1_IRQ
> > +	select BRCMSTB_DPFE
> 
> The select is probably not warranted, see below.
> 
> >  	select BRCMSTB_L2_IRQ
> >  	select GENERIC_IRQ_CHIP
> >  	select PINCTRL
> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > index cd4fc93b50df..fef6f0873fda 100644
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -54,6 +54,17 @@ config ATMEL_EBI
> >  	  tree is used. This bus supports NANDs, external ethernet controller,
> >  	  SRAMs, ATA devices, etc.
> >  
> > +config BRCMSTB_DPFE
> > +	bool "Broadcom STB DPFE driver" if COMPILE_TEST
> > +	depends on ARCH_BRCMSTB || COMPILE_TEST
> 
> Can you make it default ARCH_BRCMSTB and remove the select above?
> 
> With that:
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Applied with mentioned change.

Best regards,
Krzysztof

