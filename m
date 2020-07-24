Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85B22CDEB
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgGXSmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:42:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38253 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXSmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 14:42:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id a14so9183284wra.5;
        Fri, 24 Jul 2020 11:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J0wBk/6vaO0g7QfilA4yE/XNc/ENevl3w3KNoqKUGUg=;
        b=JX67EWFSrCgYUIaKKHEps2NspcqsAebnQvui8r2KffYses0crAF3xw/lEL/YwesbqS
         j2HE1Lrn5oZJC5z+z9iu6WayFwdz9DvXd0ZBqcNpWcNWPdiKCZC3Sv+WLtSQJ3S+hqR2
         kUQxlpjHDMxXleRTAQNkmGEc7iuMegcKL2S6Ney5jB1xWdogeIjaYIuAhWTTyobymVNA
         Ss8gg6bL/yBqaND0hPvpmMkxkaQOuMaES7y9Wy41rjPPjzaBiKJn0H7GOoWGmH8VFLz2
         HCM3RhwVKWwCCK7RSVOtZ8ldzfEjJ3yrqFMnk9ZKYQS851fXEcdooe1Pbp53LRQoa4Ur
         28SA==
X-Gm-Message-State: AOAM530dwiCJzorXTxvNaSyBI37ixUUjtGY3/Lii/x9AfMLWJqo1+z75
        xODoIcnM2/Mid9USeZUfMRDxP6OnEfU=
X-Google-Smtp-Source: ABdhPJzZJ+86rVVgc4VYErzo8iaWzUH13pTk1ZyZ0TGQDiMpbauNPPK8NiSa4t0knu/LgxjZ7ip5Ag==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr10508907wrw.363.1595616137156;
        Fri, 24 Jul 2020 11:42:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id x11sm2174602wrl.28.2020.07.24.11.42.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 11:42:16 -0700 (PDT)
Date:   Fri, 24 Jul 2020 20:42:13 +0200
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
Message-ID: <20200724184213.GA24993@kozik-lap>
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

Sure, I'll fix it up. Thanks for feedback.

Best regards,
Krzysztof
