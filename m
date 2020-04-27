Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC61BA138
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgD0KbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbgD0KbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 06:31:22 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46847C0610D5;
        Mon, 27 Apr 2020 03:31:22 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c3so25250386otp.8;
        Mon, 27 Apr 2020 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3d7vs20E1Et9twZMWtdoqd2YRjkdvKBGwACExL5kyRg=;
        b=tvtrT3kris+dM2Fd6C2U6qTO23oFqBPH6nLTx0ZEhnnfleDuIP/+oa2CScVy19rpkk
         COfloMiCX95ftcXhVLOPW9KP7+/PaNrE5zONJMcZOrxURYrILEre8ttKPbOuS9tNpbc+
         LQyyBkxNObiImX/P5y/ncL6LJQndQzzc6Jy+qhTjr9Nw6vZAm/8Q2PpozO/2q7mhIQjP
         r8TjF1g2Kr1eXk4Xa8TSMGOR2HVZBkAYtqRAzb+771Tp+yqOfrydKCWcUx6jcrSjXd0d
         O2ekoMICDb+M+9eC8HjlW8bLQL5QPtmmvnkdbcSe0V5vhWaWzrOcN9XgUbUpCCVKD8Nd
         4kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3d7vs20E1Et9twZMWtdoqd2YRjkdvKBGwACExL5kyRg=;
        b=bejcDyz1aMlUPfSlZkCOAbvetcWvg+aD+3DK9dS97ntfaWiS8Bix9bHLkj/AmAN8/W
         eyc1OqyEtykUgD7KUbY5b01OmQ8MGe8pbleWQDEegryrl03jIrQyML9uZlvotFKG9UEL
         HsE7gbBl3qHuCKHDdTlmek290NjvHT69fRHcyTIH/C8/cykMrU0y8PdCzlx4xTfvHMJZ
         ehG3PLxPvIQS95N87UyGj8PBzPoT2o9GcOZG8mIftlt6B6BkYD5mc8msMhewtoIvr+TY
         lugYCODjhb+52MCn0cuPsZhT5BckllM7Uwiuyh4FbG9Udd7bsBMkZY242lf5szejfqrs
         SS7w==
X-Gm-Message-State: AGi0PuaafEg7jv8V8546/sfGgjguGrdkg3bcWqxVlNiIBzcrXkTFkJWR
        13/hR4O4gGmDTfBSU3jYPw9Nw/V1214WZN0PsPg=
X-Google-Smtp-Source: APiQypLDnWLyGAgDCNv98J886odnQ8mX26B9JoocB96gAjQ4sJvW7pv565vVlbaHXsTMdz90L4H275X8XO7T/WINWDQ=
X-Received: by 2002:aca:b783:: with SMTP id h125mr3069784oif.62.1587983481703;
 Mon, 27 Apr 2020 03:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXwsUAaeY+b6t-nqPE8kL-p+F4HqXE2mujP0eXPjrbooQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXwsUAaeY+b6t-nqPE8kL-p+F4HqXE2mujP0eXPjrbooQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 27 Apr 2020 11:30:55 +0100
Message-ID: <CA+V-a8sH4sLN1XuRM+SgbbN5O38wrtMyk5QEXEPhV5tOkbchJw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add RZ/G1H support.
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

On Mon, Apr 27, 2020 at 10:28 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > This patch series aims to add support for Renesas RZ/G1H (r8a7742) SoC.
> >
> > RZ/G1H SoC is similar to R-Car Gen2 H2 SoC.
> >
> > This patch set is based on renesas-drivers/master-v5.7-rc1.
>
> Thanks for your series!
>
> Looks mostly OK to me.
Thank you for the review. After fixing patch 8/10 shall I just post a
v2 with a single patch or the entire series ?

> The missing code part seems to be the introduction of the main
> CONFIG_ARCH_R8A7742 symbol?
>
I was planning to post them once these patches were reviewed, just
didn't wanted to flood with too many patches.

for enabling r8a7742 SoC in multi_v7_defconfig should this be only
sent out wen its accepted in shmobile_defconfig or can it be part of
same series as below ?

05ba50a4cf99 ARM: multi_v7_defconfig: Enable r8a7742 SoC
99b69d08729a ARM: shmobile: defconfig: Enable r8a7742 SoC
6b7bcd6635c7 ARM: debug-ll: Add support for r8a7742
1cf4e52e3a0e soc: renesas: Add Renesas R8A7742 config option

> I assume you plan to submit the DTS for v5.8, too, so I'll have to be
> careful and apply the binding definitions to a separate shared branch?
>
Yes I do plan to submit the DTS changes for v5.8.

Cheers,
--Prabhakar

> Thanks again!
>
> > Lad Prabhakar (10):
> >   dt-bindings: power: rcar-sysc: Document r8a7742 SYSC binding
> >   dt-bindings: power: rcar-sysc: Add r8a7742 power domain index macros
> >   soc: renesas: rcar-sysc: add R8A7742 support
> >   dt-bindings: reset: rcar-rst: Document r8a7742 reset module
> >   soc: renesas: rcar-rst: Add support for RZ/G1H
> >   dt-bindings: clock: renesas: cpg-mssr: Document r8a7742 binding
> >   clk: renesas: Add r8a7742 CPG Core Clock Definitions
> >   clk: renesas: cpg-mssr: Add R8A7742 support
> >   ARM: shmobile: r8a7742: Basic SoC support
> >   cpufreq: dt: Add support for r8a7742
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
