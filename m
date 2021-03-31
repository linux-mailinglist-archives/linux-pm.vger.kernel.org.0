Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9EE34F966
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhCaHFQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 03:05:16 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:35518 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbhCaHFN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 03:05:13 -0400
Received: by mail-vs1-f44.google.com with SMTP id h11so772176vsl.2;
        Wed, 31 Mar 2021 00:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FcWqzUO5UA3cR6NbW4yOHK8OR5G4ZVaphs7Wom8voI=;
        b=ljnC7bzJ+PyI0IB1/8/PJhjQD2cdKwo34oODmegXwaFIoI9IUzci4Ah4ogKkIkh7u3
         I2uUKzpdGqt7PFKEwVjhr8KiGmWeAZa4V4LpMAwof1vL6/jaZMaVxpXlvh38hkC2JfuO
         x9mbm2Oo+gwlQan9nu0bvazBLyf7hWJ9pn7lc4GFcPM4Oje/1nVfjAYjMgjt3LnsdoPE
         y3cKpUUDd3K6luPZsgOHiEOvO/9FrOAZOm9QK4H6r26pkUUNa+WHLeM0DRF+GdRjuRWC
         iGtL6Tg/1wEznYkTYXB9qe501FpezwDHdX3F1ia0v9gptZ7koFbwpd0l9zWtwGuN5zXd
         wRDg==
X-Gm-Message-State: AOAM533QpVQ3XU7W4j5tZqacQvGPyy02ppwX/psc8k+TRMIKo7T0Rb2n
        3yVYZ4zcLv6qEt3PzT76ttRUz3rKLCLKviWtsZc=
X-Google-Smtp-Source: ABdhPJz12mWOTz8tEinky2k83Ps60+VailbnPpLTMg//vGWbxzLaGxgDV6inNb8fwJdVyog4bNT7013JCqCOb6ltT/E=
X-Received: by 2002:a05:6102:7cd:: with SMTP id y13mr691011vsg.40.1617174312465;
 Wed, 31 Mar 2021 00:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210205222644.2357303-9-saravanak@google.com>
 <CGME20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e@eucas1p2.samsung.com>
 <d24bebc5-0f78-021f-293f-e58defa32531@samsung.com> <9b206c4d00dfe8b7f941260f18909914b2b2eecb.camel@suse.de>
 <161678243444.3012082.5031467952132861429@swboyd.mtv.corp.google.com>
 <CAMuHMdV5PGUujsFP2TXMxij4UxVnrrurh_qVhq8+480w21jJAg@mail.gmail.com>
 <161705310317.3012082.15148238105608149214@swboyd.mtv.corp.google.com>
 <CAGETcx8reqKoPoJ8dV7f9=SHYKmNhcVpkNHoCS-0L4UHCBahoA@mail.gmail.com>
 <161706920822.3012082.10047587064612237296@swboyd.mtv.corp.google.com>
 <CAMuHMdX7OxTjwQmdP8xDbVkjtZ5442qFao8K6bNpDQ5S3GPSgQ@mail.gmail.com> <161715734080.2260335.881350237641202575@swboyd.mtv.corp.google.com>
In-Reply-To: <161715734080.2260335.881350237641202575@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 Mar 2021 09:05:00 +0200
Message-ID: <CAMuHMdXMhiOBSSwrC2A_ijXCaekBMfC8h9PFhqLtNGhtPDba=A@mail.gmail.com>
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetre e
        @vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>, linux-rpi-kernel" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

On Wed, Mar 31, 2021 at 4:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2021-03-29 23:58:23)
> > On Tue, Mar 30, 2021 at 3:53 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > Quoting Saravana Kannan (2021-03-29 16:28:20)
> > > > On Mon, Mar 29, 2021 at 2:25 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > Quoting Geert Uytterhoeven (2021-03-26 11:29:55)
> > > > > > On Fri, Mar 26, 2021 at 7:13 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > > > Quoting Nicolas Saenz Julienne (2021-03-25 11:25:24)
> > > > > > > > >
> > > > > > > > > This patch mainly revealed that clk/bcm/clk-raspberrypi.c driver calls
> > > > > > > > > devm_of_clk_add_hw_provider(), with a device pointer, which has a NULL
> > > > > > > > > dev->of_node. I'm not sure if adding a check for a NULL np in
> > > > > > > > > of_clk_add_hw_provider() is a right fix, though.
> > > > > > > >
> > > > > > > > I believe the right fix is not to call 'devm_of_clk_add_hw_provider()' if
> > > > > > > > 'pdev->dev.of_node == NULL'. In such case, which is RPi3's, only the CPU clock
> > > > > > > > is used, and it's defined and queried later through
> > > > > > > > devm_clk_hw_register_clkdev().
> > > > > > > >
> > > > > > > > @Marek, I don't mind taking care of it if it's OK with you.
> > > > > > > >
> > > > > > >
> > > > > > > Ah I see this is related to the patch I just reviewed. Can you reference
> > > > > > > this in the commit text? And instead of putting the change into the clk
> > > > > > > provider let's check for NULL 'np' in of_clk_add_hw_provider() instead
> > > > > > > and return 0 if there's nothing to do. That way we don't visit this
> > > > > > > problem over and over again.
> > > > > >
> > > > > > I'm not sure the latter is what we reall want: shouldn't calling
> > > > > > *of*_clk_add_hw_provider() with a NULL np be a bug in the provider?
> > > > > >
> > > > >
> > > > > I don't have a strong opinion either way. Would it be useful if the
> > > > > function returned an error when 'np' is NULL?
> > > >
> > > > I lean towards returning an error. Not a strong opinion either.
> > >
> > > Does it have any use?
> >
> > of_clk_del_provider() removes the first provider found with node == NULL.
> > If there are two drivers calling of_clk_add_hw_provider(), and one of
> > hem calls of_clk_del_provider() later, the wrong provider may be
> > removed from the list.
> >
>
> So you're saying we shouldn't add a NULL device node pointer to the list
> so that this can't happen? That doesn't mean returning an error from
> of_clk_add_hw_provider() would be useful though.
> of_clk_add_hw_provider() can return 0 if np == NULL and
> of_clk_del_provider() can return early if np == NULL too.

I don't know if I grasp all meanings of the above.

The main question is if it is valid for a driver to call
of_clk_add_hw_provider()
with np == NULL.
  - If yes, should that register the provider?
      - If yes, how to handle two drivers calling of_clk_add_hw_provider()
        with np = NULL, as their unregistration order is not guaranteed to
        be correct.

If no, is that something to ignore (0), or a bug (error)?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
