Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163EC32B346
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352507AbhCCDu2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:50:28 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46577 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572968AbhCBQ3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 11:29:32 -0500
Received: by mail-ot1-f46.google.com with SMTP id u3so2315938otg.13;
        Tue, 02 Mar 2021 08:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gl4hjiHKJy1s/pa5uHe5bdioR5LZI5TvDUElq6VVCEY=;
        b=glLUhpbxldWg1Mk4yKFx+f2YZsyeZTAtQsMPETV9WWp4+vU2hwLl+C/ttJjONsFk9j
         m5C3Tf2sOXEJM7mIMWuYqW01gvpGSXOSvI8tZ190k6WWNDIw/HlxCzN5en0OolyfWkI1
         jmERVHnRDe7JdJNeQ5z0S+iTOID83AVgUzM8TO86rR78rp5RNFN4y9GleXTBEOGsVUmE
         Tfgno+FsJX3CJZhBiU3K4hgqUIGQZmP0b+aN+IEQVK0RR4iWHk7V3Uv1S/9jcCY2Pcij
         s2ECNq+WaHFOO2q6Ypqd4hbhYYv8ogYkFz9p0rspjrQWW91I0AS7I/XjXXmgEsGf2tbu
         93UQ==
X-Gm-Message-State: AOAM530tedjkR2teesHRwn10mye7GxvuTp4y8ZgYebtaC/KEftk3Kaio
        IYqIV7cnpJh+X3MFkFF+7KrK/wzUL3TKSjMspC92PYy8rEs=
X-Google-Smtp-Source: ABdhPJztTHMzuXcHCjGbmrjI4AMUu6Glc/djgNvb8fellR0BArfBNLJ9CkYs0e26C4oxiYqrdEI+hfRZbyAumBmTNSE=
X-Received: by 2002:ab0:60b8:: with SMTP id f24mr12507685uam.58.1614701912455;
 Tue, 02 Mar 2021 08:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20210205133319.1921108-1-geert+renesas@glider.be> <20210302154406.n4d6euiruwan4pm5@earth.universe>
In-Reply-To: <20210302154406.n4d6euiruwan4pm5@earth.universe>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 17:18:21 +0100
Message-ID: <CAMuHMdULLDcRFhOQrGXuRxTcMeX5bc3fi-CkSSmrejSP6JUKWA@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
 reset handling
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On Tue, Mar 2, 2021 at 4:44 PM Sebastian Reichel <sre@kernel.org> wrote:
> On Fri, Feb 05, 2021 at 02:33:19PM +0100, Geert Uytterhoeven wrote:
> > Currently, there are two drivers binding to the R-Mobile System
> > Controller (SYSC):
> >   - The rmobile-sysc driver registers PM domains from a core_initcall(),
> >     and does not use a platform driver,
> >   - The rmobile-reset driver registers a reset handler, and does use a
> >     platform driver.
> >
> > As fw_devlink only considers devices, it does not know that the
> > rmobile-sysc driver is ready.  Hence if fw_devlink is enabled, probing
> > of on-chip devices that are part of the SYSC PM domain is deferred until
> > the optional rmobile-reset has been bound, which may happen too late
> > (for e.g. the system timer on SoCs lacking an ARM architectured or
> > global timer), or not at all, leading to complete system boot failures.
> >
> > Fix this by:
> >   1. Setting the OF_POPULATED flag for the SYSC device node after
> >      successful initialization.
> >      This will make of_link_to_phandle() ignore the SYSC device node as
> >      a dependency, making consumer devices probe again.
> >   2. Move reset handling from its own driver into the rmobile-sysc
> >      driver.
> >      This is needed because setting OF_POPULATED prevents the
> >      rmobile-reset driver from binding against the same device.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > To be queued in renesas-devel for v5.13.
>
> Acked-by: Sebastian Reichel <sre@kernel.org>

In the meantime, this has method been abandoned, and this patch was
superseded by "[PATCH v2] soc: renesas: rmobile-sysc: Mark fwnode when
PM domain is added"
https://lore.kernel.org/linux-arm-kernel/20210216123958.3180014-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
