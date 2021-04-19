Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54F0364ED6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 01:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhDSXny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 19:43:54 -0400
Received: from gw.atmark-techno.com ([13.115.124.170]:42778 "EHLO
        gw.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhDSXnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 19:43:52 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 70BD5804B9
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 08:43:09 +0900 (JST)
Received: by mail-ot1-f70.google.com with SMTP id h11-20020a9d61cb0000b029028e9bba56d9so9098327otk.20
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 16:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YfTDNxUjME1kzwn4ONpBlmaWp5uEs0PGjlewRbiJ8O0=;
        b=I1XP7cXCVmUJcT29giRPFbhIXlwFPXypPur5YpnKa3W5Dre2iINiZk6/g+y27uIsOD
         6vd1gxCXgiQUBfsWjQw9RxXZisWXAKD7wQHa8tvyUqkD7gfHAraOj1+c9jaRupKjs+QC
         rxW/cS5tHiIICMpfoLueletcaEVlJpE4VimfpVgQ3sF/cYWNDdlpG1J2N1L6ycQ72KU7
         qy1+D4ZfbXmIyt/WBkh3BgLyCK58llFSniql2U6lw1yj0Ew1QiOjykp5oHpyq8+1eXjy
         lgkE+kZ3KfF4UhAtPv3VVHspMiMHsM7AaHDUrmigsr2QY4/K8/Y8I2lG23l9SX3DrUrv
         HTYQ==
X-Gm-Message-State: AOAM533Jb+ev4IQf3lA9Kcj0GL+ku/9DgxxWjiS8XfBsW2Kmu17Hu6S9
        Wlw5iPGQJGPTEs2U8cLvQx20hUzINoTJXm+brluPZsY+M9QikGL0xBaT2YO5DbN8CsjTxcgJ76A
        G6Ijg6ZOVDsjXc2uIRSR6hxI=
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr1708176pjd.190.1618875776930;
        Mon, 19 Apr 2021 16:42:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRGNIqy2AO5m9iOwuC4N09BxordE8LmUXYTIIeyniOtbCQKfA0MKaQl391n1ZLV3YIJOra8w==
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr1708139pjd.190.1618875776711;
        Mon, 19 Apr 2021 16:42:56 -0700 (PDT)
Received: from pc-0115 (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id r3sm8384971pgn.82.2021.04.19.16.42.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Apr 2021 16:42:55 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94)
        (envelope-from <martinet@pc-0115>)
        id 1lYdXa-002mPj-58; Tue, 20 Apr 2021 08:42:54 +0900
Date:   Tue, 20 Apr 2021 08:42:44 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        aymen.sghaier@nxp.com, Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        peter.ujfalusi@gmail.com, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>, tomba@kernel.org,
        jyri.sarha@iki.fi, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kishon <kishon@ti.com>, Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Roy Pledge <Roy.Pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Felipe Balbi <balbi@kernel.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, dmaengine@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-staging@lists.linux.dev,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC v1 PATCH 3/3] driver: update all the code that use
 soc_device_match
Message-ID: <YH4VdPNO9cdzc5MD@atmark-techno.com>
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-4-alice.guo@oss.nxp.com>
 <YH0O907dfGY9jQRZ@atmark-techno.com>
 <CAMuHMdVY1SLZ0K30T2pimyrR6Mm=VoSTO=L-xxCy2Bj7_kostw@mail.gmail.com>
 <YH1OeFy+SepIYYG0@atmark-techno.com>
 <CAK8P3a1Mu2F0irDDCL-50HiHth29iYFL5b7WHZ=UX6W7zzoxAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Mu2F0irDDCL-50HiHth29iYFL5b7WHZ=UX6W7zzoxAg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Arnd Bergmann wrote on Mon, Apr 19, 2021 at 02:16:36PM +0200:
> In some cases, you can use the device_link infrastructure to deal
> with dependencies between devices. Not sure if this would help
> in your case, but have a look at device_link_add() etc in drivers/base/core.c

I'll need to actually try to convince myself but if creating the link
forces driver registration then it should be workable.

> > In this particular case the problem is that since 7d981405d0fd ("soc:
> > imx8m: change to use platform driver") the soc probe tries to use the
> > nvmem driver for ocotp fuses for imx8m devices, which isn't ready yet.
> > So soc loading gets pushed back to the end of the list because it gets
> > defered and other drivers relying on soc_device_match get confused
> > because they wrongly think a device doesn't match a quirk when it
> > actually does.
> >
> > If there is a way to ensure the nvmem driver gets loaded before the soc,
> > that would also solve the problem nicely, and avoid the need to mess
> > with all the ~50 drivers which use it.
> >
> > Is there a way to control in what order drivers get loaded? Something in
> > the dtb perhaps?
> 
> For built-in drivers, load order depends on the initcall level and
> link order (how things are lined listed in the Makefile hierarchy).
> 
> For loadable modules, this is up to user space in the end.
> 
> Which of the drivers in this scenario are loadable modules?

All the drivers involved in my case are built-in (nvmem, soc and final
soc_device_match consumer e.g. caam_jr that crashes the kernel if soc is
not identified properly).

I frankly don't like the idea of moving nvmem/ above soc/ in
drivers/Makefile as a "solution" to this (especially as there is one
that seems to care about what soc they run on...), so I'll have a look
at links first, hopefully that will work out.


Thanks,
-- 
Dominique
