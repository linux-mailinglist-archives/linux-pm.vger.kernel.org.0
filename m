Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98632FEF1F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbhAUPkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 10:40:09 -0500
Received: from mail-oo1-f43.google.com ([209.85.161.43]:36366 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733243AbhAUPjs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 10:39:48 -0500
Received: by mail-oo1-f43.google.com with SMTP id j8so600140oon.3;
        Thu, 21 Jan 2021 07:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0R3/vn4OjBwMbm80SVwgo6ViJcCgYeuJbJTYwOEMXho=;
        b=FaAxe0ztYmmDlexY5mGRDzmKb2lVBFnCvnJHpV1+ewthxB5t6g0thxRsXFeswBCnB8
         5eUQDgGM2/Q+k/kuGT09vjNKxRHCIKuFbnrYWQYon58g90pVJ+Zlr2a7H0i6zZQ6eNnx
         mK4BQRLmACvkoFM9DiRsjCk5MbmdCZC2Foe7WAJ+upyfi54xWNX/4avWmIesfGNGF5AQ
         aDgxDyJ5xeJkOqAzk/wBmD5Lz4XPiBXk8gKZz26ZMipIylFMwCEAREYmaEevW6jjr50L
         LHFDNSb8tyv1zRxdhPzd0p+ujD+sN4sySCtMoRMZqjad+mtdECkLIvO7x+YtORNNaTW7
         Psow==
X-Gm-Message-State: AOAM5321E2n1TMlqHoQrXv9CruAo6ZlThup+fVuMCDGUA+aNmN8JwyfT
        PpN2dsIY8+e25FDkjt5tOVxDeoVJT5NtEcOH0JYJCaF9
X-Google-Smtp-Source: ABdhPJyPp4o0v1chZHpawhDO/ZE7GYsY5Wdnka7U4wtIxMUDBXOJwl/XQxnwKaYrFAo6tvTDBufd8fPO824Jnc+3JAI=
X-Received: by 2002:a4a:8353:: with SMTP id q19mr156184oog.40.1611243529514;
 Thu, 21 Jan 2021 07:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20210120142323.2203705-1-geert+renesas@glider.be> <CAGETcx-ZcXB9Zw_RnMjA0G2oKAyeK3VfKgha=Mvqnn_dDREuOw@mail.gmail.com>
In-Reply-To: <CAGETcx-ZcXB9Zw_RnMjA0G2oKAyeK3VfKgha=Mvqnn_dDREuOw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jan 2021 16:38:38 +0100
Message-ID: <CAMuHMdUfA2LgXxz1srbgQLiMw=oadrJ0ASMnwcvCO2xVXqWnUw@mail.gmail.com>
Subject: Re: [PATCH/RFC] soc: renesas: rcar-sysc: Mark device node
 OF_POPULATED after init
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On Wed, Jan 20, 2021 at 6:09 PM Saravana Kannan <saravanak@google.com> wrote:
> On Wed, Jan 20, 2021 at 6:23 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > The R-Car System Controller (SYSC) driver registers PM domains from an
> > early_initcall().  It does not use a platform driver, as secondary CPU
> > startup on R-Car H1 needs to control the CPU power domains, before
> > initialization of the driver framework.
> >
> > As fw_devlink only considers platform devices,
>
> Correction. It only considers devices. As in, devices on all types of
> busses are supported.

OK.

> > it does not know that the
> > System Controller is ready.  Hence probing of on-chip devices that are
> > part of the SYSC PM domain fail:
> >
> >     probe deferral - supplier e6180000.system-controller not ready
> >
> > Fix this by setting the OF_POPULATED flag for the SYSC device node after
> > successful initialization.  This will make of_link_to_phandle() ignore
> > the SYSC device node as a dependency, and consumer devices will be
> > probed again.
>
> It'd still be nice if you could (maybe in a later patch), at least
> probe all the power domains that aren't really needed this early.
> Using the driver core framework (when it's possible), gives you nice
> things :)

Which nice things are you thinking of? Making the driver modular?
At least on R-Car H1, it needs to be built-in for SMP to work.

> +Rob. I know he hates people using OF_POPULATED, but I think this case
> is reasonable and want to make sure he's aware of this.
>
> Once you fix my commit nitpick, you can add:
> Reviewed-by: Saravana Kannan <saravanak@google.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
