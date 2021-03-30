Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC42034E1A1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhC3G66 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 02:58:58 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:34573 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhC3G6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 02:58:36 -0400
Received: by mail-vs1-f50.google.com with SMTP id a23so7617425vsd.1;
        Mon, 29 Mar 2021 23:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnwPv7y5OHu0yeCeQ6EYirmX4Vq+HIGj3Ah9npDPAoc=;
        b=cDfE+5uCsygF7b5QBRVRHZi1gXqAoy3rjiwFMbfjCqtUsNhhmxebRF4VFE7pGGUQ5s
         mbBOIeTgllEF0Vaj4YC/trbzaJ0I8gwfeUchMZcHSPa+LqydLn0vooIyFNn4GHNEG+YW
         oV/+6lA68KItTce4WbSLjzn3NSV4OyPwes/C/u5XAwRuBTp1KJb6Cl1xm5FeXkLe9Wvf
         7c1Q6rlqGMYkWsVWydDIeLorK1t+o5RNMe5PuGB7tFvk6Gp0/su+/2M060gVfHFBHxOX
         fkhpEHLAdMgY/Pi+9PvClPcJLAMh4PWPEKg565ME6hYtlhrnf6SvmO3yNqywYp+ZLmq1
         c3FQ==
X-Gm-Message-State: AOAM533A57yWKph291cbbdqPBhNKR9HL+FXGue154oLHOJ3Y3u4phy4P
        psXSL3PZ4T/O1yTe+LDBH6fp/MgnmuTT56g//m0=
X-Google-Smtp-Source: ABdhPJwB8IDQMGCK8UksZ76+EVDydytwxsLpOIxjQnV8FZ/FaIQOC1E4BNZkNYyqYoFD/ZWQNVWs4kE6iQyNgJ7RRO0=
X-Received: by 2002:a05:6102:7cd:: with SMTP id y13mr4806799vsg.40.1617087515138;
 Mon, 29 Mar 2021 23:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210205222644.2357303-9-saravanak@google.com>
 <20210210114435.122242-1-tudor.ambarus@microchip.com> <20210210114435.122242-2-tudor.ambarus@microchip.com>
 <CGME20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e@eucas1p2.samsung.com>
 <d24bebc5-0f78-021f-293f-e58defa32531@samsung.com> <9b206c4d00dfe8b7f941260f18909914b2b2eecb.camel@suse.de>
 <161678243444.3012082.5031467952132861429@swboyd.mtv.corp.google.com>
 <CAMuHMdV5PGUujsFP2TXMxij4UxVnrrurh_qVhq8+480w21jJAg@mail.gmail.com>
 <161705310317.3012082.15148238105608149214@swboyd.mtv.corp.google.com>
 <CAGETcx8reqKoPoJ8dV7f9=SHYKmNhcVpkNHoCS-0L4UHCBahoA@mail.gmail.com> <161706920822.3012082.10047587064612237296@swboyd.mtv.corp.google.com>
In-Reply-To: <161706920822.3012082.10047587064612237296@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Mar 2021 08:58:23 +0200
Message-ID: <CAMuHMdX7OxTjwQmdP8xDbVkjtZ5442qFao8K6bNpDQ5S3GPSgQ@mail.gmail.com>
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        DOCUMENTATION <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetre
        e@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>, linux-rpi-kernel" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

On Tue, Mar 30, 2021 at 3:53 AM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Saravana Kannan (2021-03-29 16:28:20)
> > On Mon, Mar 29, 2021 at 2:25 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > Quoting Geert Uytterhoeven (2021-03-26 11:29:55)
> > > > On Fri, Mar 26, 2021 at 7:13 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > Quoting Nicolas Saenz Julienne (2021-03-25 11:25:24)
> > > > > > >
> > > > > > > This patch mainly revealed that clk/bcm/clk-raspberrypi.c driver calls
> > > > > > > devm_of_clk_add_hw_provider(), with a device pointer, which has a NULL
> > > > > > > dev->of_node. I'm not sure if adding a check for a NULL np in
> > > > > > > of_clk_add_hw_provider() is a right fix, though.
> > > > > >
> > > > > > I believe the right fix is not to call 'devm_of_clk_add_hw_provider()' if
> > > > > > 'pdev->dev.of_node == NULL'. In such case, which is RPi3's, only the CPU clock
> > > > > > is used, and it's defined and queried later through
> > > > > > devm_clk_hw_register_clkdev().
> > > > > >
> > > > > > @Marek, I don't mind taking care of it if it's OK with you.
> > > > > >
> > > > >
> > > > > Ah I see this is related to the patch I just reviewed. Can you reference
> > > > > this in the commit text? And instead of putting the change into the clk
> > > > > provider let's check for NULL 'np' in of_clk_add_hw_provider() instead
> > > > > and return 0 if there's nothing to do. That way we don't visit this
> > > > > problem over and over again.
> > > >
> > > > I'm not sure the latter is what we reall want: shouldn't calling
> > > > *of*_clk_add_hw_provider() with a NULL np be a bug in the provider?
> > > >
> > >
> > > I don't have a strong opinion either way. Would it be useful if the
> > > function returned an error when 'np' is NULL?
> >
> > I lean towards returning an error. Not a strong opinion either.
>
> Does it have any use?

of_clk_del_provider() removes the first provider found with node == NULL.
If there are two drivers calling of_clk_add_hw_provider(), and one of
hem calls of_clk_del_provider() later, the wrong provider may be
removed from the list.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
