Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8520045EC8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfFNNq0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 09:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfFNNqZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 09:46:25 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476B521773;
        Fri, 14 Jun 2019 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560519984;
        bh=C1QqzkSGsgW1tzZ2lxcc+e/a+M066ODx4f38vcKbNfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=INKAlwLlkoCsziy0QNv8NggxmsWgek3kA3LHo1N93hu/fHQGmv4cdLDP5g6wq0VIZ
         Ui0SwD/wUCJulHXKcPxZDzMp6935NhUtJNujh4gkAhx2n+0EKgkJmZeXDXtG+HWRBl
         k/HuhE/9XM6hD0wEcOvVhDXOb63diU+kLaLy9lT0=
Received: by mail-lj1-f169.google.com with SMTP id k18so2437440ljc.11;
        Fri, 14 Jun 2019 06:46:24 -0700 (PDT)
X-Gm-Message-State: APjAAAXwp1frcNESM/EgbAJJAA8s17lU6Cz5PJxmX9xeUaXqld0tSgo9
        10khlNbGKn2ErrBkbonzeTvaKpU7Xmb5YamVo+w=
X-Google-Smtp-Source: APXvYqxMnNY9t6ni23gqc8ErDGEd2aZymUgvy7IJa4NdtozaFp6o6xWF9vefa9r2soNzWOaylDjJUhVqSimw6/1rbvY=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr14338419ljw.13.1560519982531;
 Fri, 14 Jun 2019 06:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9@eucas1p1.samsung.com>
 <20190614095309.24100-1-l.luba@partner.samsung.com> <20190614095309.24100-9-l.luba@partner.samsung.com>
 <CAJKOXPehO2pKrTKMO4YRwDMaPPngmeWG9WF=kMuBG+=P1ix3NA@mail.gmail.com> <6f86228d-8409-a835-20ba-ad20464379dd@partner.samsung.com>
In-Reply-To: <6f86228d-8409-a835-20ba-ad20464379dd@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 Jun 2019 15:46:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcsNe+PEszGAS+YyGH3qqQdELXnwhD+x=+9POrZziCOpw@mail.gmail.com>
Message-ID: <CAJKOXPcsNe+PEszGAS+YyGH3qqQdELXnwhD+x=+9POrZziCOpw@mail.gmail.com>
Subject: Re: [PATCH v10 08/13] drivers: memory: add DMC driver for Exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Jun 2019 at 15:41, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 6/14/19 2:58 PM, Krzysztof Kozlowski wrote:
> > On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >> This patch adds driver for Exynos5422 Dynamic Memory Controller.
> >> The driver provides support for dynamic frequency and voltage scaling for
> >> DMC and DRAM. It supports changing timings of DRAM running with different
> >> frequency. There is also an algorithm to calculate timigns based on
> >> memory description provided in DT.
> >> The patch also contains needed MAINTAINERS file update.
> >>
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   MAINTAINERS                             |    8 +
> >>   drivers/memory/samsung/Kconfig          |   17 +
> >>   drivers/memory/samsung/Makefile         |    1 +
> >>   drivers/memory/samsung/exynos5422-dmc.c | 1262 +++++++++++++++++++++++
> >>   4 files changed, 1288 insertions(+)
> >>   create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 57f496cff999..6ffccfd95351 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -3470,6 +3470,14 @@ S:       Maintained
> >>   F:     drivers/devfreq/exynos-bus.c
> >>   F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> >>
> >> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
> >
> > Eh, more comments from my side.
> > "For the hard of thinking, this list is meant to remain in alphabetical order."
> OK
> >
> >> +M:     Lukasz Luba <l.luba@partner.samsung.com>
> >> +L:     linux-pm@vger.kernel.org
> >> +L:     linux-samsung-soc@vger.kernel.org
> >> +S:     Maintained
> >> +F:     drivers/memory/samsung/exynos5422-dmc.c
> >> +F:     Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> >> +
> >>   BUSLOGIC SCSI DRIVER
> >>   M:     Khalid Aziz <khalid@gonehiking.org>
> >>   L:     linux-scsi@vger.kernel.org
> >> diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
> >> index 79ce7ea58903..c93baa029654 100644
> >> --- a/drivers/memory/samsung/Kconfig
> >> +++ b/drivers/memory/samsung/Kconfig
> >> @@ -5,6 +5,23 @@ config SAMSUNG_MC
> >>            Support for the Memory Controller (MC) devices found on
> >>            Samsung Exynos SoCs.
> >>
> >> +config ARM_EXYNOS5422_DMC
> >
> > Why you added prefix of ARM to CONFIG think none of other Exynos
> > Kconfig options follow such convention (except devfreq).
> In the previous versions the driver was in drivers/devfreq/,
> that's why they have this prefix.
> >
> >> +       tristate "ARM EXYNOS5422 Dynamic Memory Controller driver"
> >> +       depends on ARCH_EXYNOS
> >> +       select DDR
> >
> > In general select should be used only for non-visible symbols and DDR
> > is visible. Use depends.
> OK
> >
> >> +       select PM_DEVFREQ
> >
> > This definitely cannot be select. You do not select entire subsystem
> > because some similar driver was chosen.
> So I will use depends int this case
> >
> >> +       select DEVFREQ_GOV_SIMPLE_ONDEMAND
> >> +       select DEVFREQ_GOV_USERSPACE
> >
> > I think only simple_ondemand is needed. Is userspace governor
> > necessary for working? Or actually maybe both could be skipped?
> >
> Actually we can skip both governors from here.
>
> >> +       select PM_DEVFREQ_EVENT
> >
> > Again, depends.
> OK
>
> There are these 4 options which the driver depends on:
>          depends on ARCH_EXYNOS
>          depends on DDR
>          depends on PM_DEVFREQ
>          depends on PM_DEVFREQ_EVENT
>
> Should I merged them into one, two lines? like below:
> a)
> depends on (ARCH_EXYNOS && DDR && PM_DEVFREQ && PM_DEVFREQ_EVENT)
> b) grouped into two sets
> depends on (ARCH_EXYNOS && DDR)
> depends on (PM_DEVFREQ && PM_DEVFREQ_EVENT)
> c) grouped by pm_devfreq only
> depends on ARCH_EXYNOS
> depends on DDR
> depends on (PM_DEVFREQ && PM_DEVFREQ_EVENT)

I like the third option... although I would be also happy to see
COMPILE_TEST (probably with IOMEM). You need to check which
dependencies are still necessary for COMPILE_TEST.

Best regards,
Krzysztof
