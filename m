Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A126E1BA22D
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0LS6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 07:18:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42155 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgD0LS5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 07:18:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id m18so25419462otq.9;
        Mon, 27 Apr 2020 04:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXoIxJ0w84+gaX7lsp/3b8bY8viRFcnPlJWfzHbiZf8=;
        b=mteN7XTr4EBwrrONWMEYcxD6AFays0+0pgkurGjIlgteLqhhLOTNLP6D2Su5PGIbcZ
         +UNkqmQiEUPV0KbZ117LEMUf1cP25ORvMgtlnOvdzXRhKsyAaMuF6Nx2qF7Kz4XRH2jy
         4vWV8F8bnH8bhRzUVfPSz24l72c/vng3qNA8eL4bTTnRmuAJ4/TTCF8PSm/urj727vb5
         kmEk9wdiy+vOcdanyCO4hl7xcTvzIAGkjiSuSfYRvBwfdkxowgh5LDypVQB1d3T/m+M0
         49+9vIIknViMRuwJWoPgHPN613DCQxo8i3DIbKTieiwmWFep1Iizipq1n6nINQe+aJf2
         sE5w==
X-Gm-Message-State: AGi0PuZI1H6LztnpE0zhoLuIexgK1uPRLMpO/pnv6E/p0cfraHwGQRdO
        THsRpVEI54FLyjC9LA42oZmn5KFTaH7mEou812A=
X-Google-Smtp-Source: APiQypL5O90eZiVP91Spazxw9kNLM/oUk/UxGHPayskHGw0X4cu3MGkQ9jx0LWUyAkboJxHXtR2bszWrIXRFKtjKifw=
X-Received: by 2002:a9d:564:: with SMTP id 91mr17871599otw.250.1587986335286;
 Mon, 27 Apr 2020 04:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXwsUAaeY+b6t-nqPE8kL-p+F4HqXE2mujP0eXPjrbooQ@mail.gmail.com> <CA+V-a8sH4sLN1XuRM+SgbbN5O38wrtMyk5QEXEPhV5tOkbchJw@mail.gmail.com>
In-Reply-To: <CA+V-a8sH4sLN1XuRM+SgbbN5O38wrtMyk5QEXEPhV5tOkbchJw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 13:18:44 +0200
Message-ID: <CAMuHMdXW1YQMUzzTGcyz2d=NxkcLtLasTqgZH0CRufQx=vfT0g@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add RZ/G1H support.
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
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
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prabhakar,

On Mon, Apr 27, 2020 at 12:31 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Apr 27, 2020 at 10:28 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > This patch series aims to add support for Renesas RZ/G1H (r8a7742) SoC.
> > >
> > > RZ/G1H SoC is similar to R-Car Gen2 H2 SoC.
> > >
> > > This patch set is based on renesas-drivers/master-v5.7-rc1.
> >
> > Thanks for your series!
> >
> > Looks mostly OK to me.
> Thank you for the review. After fixing patch 8/10 shall I just post a
> v2 with a single patch or the entire series ?

A single v2 patch is fine.  The clock driver goes in through a different
tree anyway/

> > The missing code part seems to be the introduction of the main
> > CONFIG_ARCH_R8A7742 symbol?
> >
> I was planning to post them once these patches were reviewed, just
> didn't wanted to flood with too many patches.
>
> for enabling r8a7742 SoC in multi_v7_defconfig should this be only
> sent out wen its accepted in shmobile_defconfig or can it be part of
> same series as below ?
>
> 05ba50a4cf99 ARM: multi_v7_defconfig: Enable r8a7742 SoC
> 99b69d08729a ARM: shmobile: defconfig: Enable r8a7742 SoC
> 6b7bcd6635c7 ARM: debug-ll: Add support for r8a7742
> 1cf4e52e3a0e soc: renesas: Add Renesas R8A7742 config option

It can be part of the same series.

> > I assume you plan to submit the DTS for v5.8, too, so I'll have to be
> > careful and apply the binding definitions to a separate shared branch?
> >
> Yes I do plan to submit the DTS changes for v5.8.

Thanks. Looking forward to it!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
