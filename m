Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AEB1FCB87
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 12:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFQK6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 06:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFQK6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 06:58:03 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A985C061573;
        Wed, 17 Jun 2020 03:58:03 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so2236467ioe.2;
        Wed, 17 Jun 2020 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMiSyPVInJQRoT6fLFwnryiJhqxToOM1NO8PNE6msJo=;
        b=L1VQaMVlmrOZgULfTCWPMCYLpDDHM4ZSarJw84Oc8JwzTX9G9VTK3OQNwcJ6qL5a25
         iKDU96CV1RiNVVrY/eVWJ8aztQi3GbN1rYSp9lmcyOML4OoslwIiKSiPITLADEZeq4Q8
         gyFZR6rg+BA2owmtUg8x8cLa7N214bIbh6PQBh07BKmr3hNootriMqAGC7M/gtzLTOhS
         88TO+hTbiRxomYMt+bi//CsaEShIPS+TI7cJDpjTrciI7t9U+irByTPc5ydBOIxjalWT
         bha6cWFMSZrqnJ4krwTMXYR3QztRFqRhUX1iiJ7FtT6v7RC5H9MSqUUsf+QW6IuWcQhn
         cZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMiSyPVInJQRoT6fLFwnryiJhqxToOM1NO8PNE6msJo=;
        b=fdfG75t++ckz3BEDHAKLS91HUTkczAEJoxQSK+VS1AXSo8B8MGBMqfRIDGCEjzro/H
         RXM/hZ0UCczGpK1aph+dgDsp8cTw+VkmC/mFZn3npm8AxXl7+Mz0wAWaoPH4hWngeoDO
         oliFGWVEqCMluwrC3vUKeXrfmzsZQ7pFtRwsO1oZ8J7s79Og7914KroZzNS2gfevGS8d
         qTxQaw55EtdUbnvkQNqL1nj4jfTyMwZCXxHVRuuHzgUIZeMc5gFPFCeLOiQJHb4apSTx
         Hu87tC86ff3yqj2yAPpL4UyC77OOV6Rhl6JEH0RFGasLjHutY4WvjGXlVwiO3dl2Hk52
         BHfg==
X-Gm-Message-State: AOAM533BmCX51hx+QhwijO/OG00BpMiyfUM0faz5u/7Sj6l01CPWs4OU
        GX4yG6iByTQbyMwLptYFnIVl51W53d834oTnTGo=
X-Google-Smtp-Source: ABdhPJyq7fw2XXwLJfk3fsu0fT46sa8BXmL96PRwsE0LD1hGltiXnd+hLRjlWlDnkImUvYwybAHDQr8LCW67Ze4QoUQ=
X-Received: by 2002:a05:6602:2dd5:: with SMTP id l21mr7612508iow.173.1592391482585;
 Wed, 17 Jun 2020 03:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c@eucas1p1.samsung.com>
 <20200616081230.31198-1-m.szyprowski@samsung.com> <CANAwSgStsYP5fBB7z7-Reo2BP4ZQPT6RN4s8QdLGVGhKCDA_Ng@mail.gmail.com>
 <3e6b5dbb-a8a2-e3db-d740-53e13676455c@samsung.com>
In-Reply-To: <3e6b5dbb-a8a2-e3db-d740-53e13676455c@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 17 Jun 2020 16:27:54 +0530
Message-ID: <CANAwSgSgvOSMQbvZG0kFe3YHQh5ZeCbDjMHCRt-fb=dmTwA-EQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Restore big.LITTLE cpuidle driver for Exynos
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On Wed, 17 Jun 2020 at 15:18, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Anand,
>
> On 16.06.2020 22:58, Anand Moon wrote:
> > On Tue, 16 Jun 2020 at 13:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> The ARM big.LITTLE cpuidle driver has been enabled and tested on Samsung
> >> Exynos 5420/5800 based Peach Pit/Pi Chromebooks and in fact it worked
> >> only on those boards.
> >>
> >> However, support for it was broken by the commit 833b5794e330 ("ARM:
> >> EXYNOS: reset Little cores when cpu is up") and then never enabled in the
> >> exynos_defconfig. This patchset provides the needed fix to the common
> >> code and restores support for it. Thanks to Lukasz Luba who motivated me
> >> to take a look into this issue.
> >>
> > Thanks for this updates.
> >
> > But I feel some DTS changes are missing for example
> > d2e5c871ed8a drivers: cpuidle: initialize big.LITTLE driver through DT
>
> This is not strictly needed. The bl-cpuidle matches also to the A7/A15
> CPU product ids and it is properly instantiated on the Peach Pit/Pi
> Chromebooks. Those CPU DT properties were added as a future-proof
> generic solution. I won't hurt to add them though.
>
Ok Thanks.

> > But I feel that this feature is not working as desired since
> > still some missing code changes for cluster idle states are missing.
> > like clock  PWR_CTR and PWR_CTRL2.
>
> I cannot judge now. All I can test now is a that the boards enters those
> idle states and system works stable. I cannot measure power consumption,
> because currently I have only remote access to the boards.
>
Ok, Thanks.

What I meant was in order to cpu cluster to enter into IDLE states,
it's controlled by the EXYNOS5422_PWR_CTRL and EXYNOS5422_PWR_CTRL2 clk fields
See below example from the Exynos5422 cpu idle driver.

[0] https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/arch/arm/mach-exynos/cpuidle-exynos5422.c#L319-L379

Just link Exynos5250 clk driver we need to Initialize PWR_CTRL and
PWR_CTRL2 for Exynos542x clocks

[1] https://github.com/torvalds/linux/blob/master/drivers/clk/samsung/clk-exynos5250.c#L828-L846

which will help support cpu idle drivers.

-Anand
