Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C861B9FD9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgD0J2H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 05:28:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39573 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0J2H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 05:28:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id m13so24995621otf.6;
        Mon, 27 Apr 2020 02:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=satcs0L6pCESi5s1zRT0opUmLRyAMa2F37DYw2oCF+o=;
        b=ol0F7Rtxb6Gb+9Dnw0WNZUdvytHtpgIc+/KqV098Nk9R4sEj4a9p+Z4gDFEgAVwhoT
         lLsTPikzwIoG/XZREvvmDnvc9v4cy5deA5WzaXSe1AMwESqbPzF3VYNlSTlqr3op/rJ0
         gCPJ2b+5V9zTaS5tz6BCwATxojWf+5eN6m3CgEyujLw6ivWq8NjZigru2tnVDvD4HuOE
         jfKJhOzSeskRLAHJqornMCPAwuTgscZ8BbumiyC12bV3Ty3gXDwDck1kpR5o765D84ji
         MEaGSd2ZOg1JL18X/uQDFHfNtu41wzD8qmfSFcahRAojySrBWBlhwYiEGShb2dRiL6lL
         v/Vg==
X-Gm-Message-State: AGi0PuahJnDw5VZhzN/HcYMKmd+m+tuP06kK6NRkALxkMz2oafS89LEs
        HVz8/lSE6ZlTtstLhOgbHKvVUiCK/eU036Grl+w=
X-Google-Smtp-Source: APiQypJzALJgRY1d91rA8c98t1wolcYkZSylcGRu1D6EuuJWyXLxqd15Cj20htAHNIdKONFRaH1i3C9mh1n0ja0zK0E=
X-Received: by 2002:a9d:564:: with SMTP id 91mr17595764otw.250.1587979686512;
 Mon, 27 Apr 2020 02:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 11:27:55 +0200
Message-ID: <CAMuHMdXwsUAaeY+b6t-nqPE8kL-p+F4HqXE2mujP0eXPjrbooQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add RZ/G1H support.
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prabhakar,

On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> This patch series aims to add support for Renesas RZ/G1H (r8a7742) SoC.
>
> RZ/G1H SoC is similar to R-Car Gen2 H2 SoC.
>
> This patch set is based on renesas-drivers/master-v5.7-rc1.

Thanks for your series!

Looks mostly OK to me.
The missing code part seems to be the introduction of the main
CONFIG_ARCH_R8A7742 symbol?

I assume you plan to submit the DTS for v5.8, too, so I'll have to be
careful and apply the binding definitions to a separate shared branch?

Thanks again!

> Lad Prabhakar (10):
>   dt-bindings: power: rcar-sysc: Document r8a7742 SYSC binding
>   dt-bindings: power: rcar-sysc: Add r8a7742 power domain index macros
>   soc: renesas: rcar-sysc: add R8A7742 support
>   dt-bindings: reset: rcar-rst: Document r8a7742 reset module
>   soc: renesas: rcar-rst: Add support for RZ/G1H
>   dt-bindings: clock: renesas: cpg-mssr: Document r8a7742 binding
>   clk: renesas: Add r8a7742 CPG Core Clock Definitions
>   clk: renesas: cpg-mssr: Add R8A7742 support
>   ARM: shmobile: r8a7742: Basic SoC support
>   cpufreq: dt: Add support for r8a7742

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
