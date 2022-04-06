Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817834F5B26
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345694AbiDFKIf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 06:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354349AbiDFKIB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 06:08:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F6140DF2
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 19:26:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r10so983022eda.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 19:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0kN2mvmwQNNtvPp2RShdfNb1tA7tCIbp7VBq6LYez4=;
        b=iPWy6+0V6Z7cYgmmqI81g4OAUUB8MRCno8hqy8BW/l7BT+hJFxKv+kJ1Pp2pI2iqOi
         zZHGQFsQesezNZsU4vTt3FAJeWqK8SEJaV27yBct6SWfpbWOQyF5AlxEeWean9Zu1Mxe
         pQBKHHykj8FBi66czv7qJa4Lf7zoYv5WNgJc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0kN2mvmwQNNtvPp2RShdfNb1tA7tCIbp7VBq6LYez4=;
        b=EqJZWeXhatuvIAs4yRMCFBXM6F1jlSpjeQJYTpD9jb3g0p9EhgHEVBh750bUzPADb9
         EMeHs3qqszKSMJXvmR3tI9WVitxuFkaxF/0zLioC7Rq4rjOYoQ06ieRMX7BDcx+5BsDh
         w1cyv+RcKweqC35ed8Xb60oipWvmlgQ1a+B/wYP3C6R0lBPWtWVo22aNfGCwraK6iNJ/
         2T3O+71lGAJ0vqgW8E++YBSK/KPLt59O/Xk+K3S1hSstC6vvdR8th7vaMwl2IJLhuv2T
         bWlZdp7Lx8y9PD5nT6sI1WyeMsnf+YiLnrll+yzPGw6BPjonT5Q1j6BI8Po/SescJb76
         QvmA==
X-Gm-Message-State: AOAM532o7VjIyyhQh45+iu8CviaPmViw4+v/gM/cH0Ov9T6+7+CUh+xc
        t+C2oRQZ6czwOpXsI+E23UMW/r/kdzJvyR1huwY=
X-Google-Smtp-Source: ABdhPJwcUxiq1bB/EQTK1Fao0wjMP39hD0j+yPoPA4FGyOVzUQhmGZunqIekRF4OgdbfC4KE/EFHcg==
X-Received: by 2002:aa7:d1d0:0:b0:41c:c19e:a0d6 with SMTP id g16-20020aa7d1d0000000b0041cc19ea0d6mr6489768edp.179.1649211996867;
        Tue, 05 Apr 2022 19:26:36 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906769200b006e7fc91251esm2301500ejm.215.2022.04.05.19.26.35
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 19:26:35 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id r11-20020a1c440b000000b0038ccb70e239so2735010wma.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 19:26:35 -0700 (PDT)
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id
 o24-20020a1c7518000000b0037c07ebf255mr5314285wmc.29.1649211994685; Tue, 05
 Apr 2022 19:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220406014842.2771799-1-briannorris@chromium.org> <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid>
In-Reply-To: <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Apr 2022 19:26:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xz+KLySeUBHe1CXEbMrjeT97HvCOdiRRG7wGcwbjQX8A@mail.gmail.com>
Message-ID: <CAD=FV=Xz+KLySeUBHe1CXEbMrjeT97HvCOdiRRG7wGcwbjQX8A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] soc: rockchip: power-domain: Manage resource
 conflicts with firmware
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Apr 5, 2022 at 6:49 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On RK3399 platforms, power domains are managed mostly by the kernel
> (drivers/soc/rockchip/pm_domains.c), but there are a few exceptions
> where ARM Trusted Firmware has to be involved:
>
> (1) system suspend/resume
> (2) DRAM DVFS (a.k.a., "ddrfreq")
>
> Exception (1) does not cause much conflict, since the kernel has
> quiesced itself by the time we make the relevant PSCI call.
>
> Exception (2) can cause conflict, because of two actions:
>
> (a) ARM Trusted Firmware needs to read/modify/write the PMU_BUS_IDLE_REQ
>     register to idle the memory controller domain; the kernel driver
>     also has to touch this register for other domains.
> (b) ARM Trusted Firmware needs to manage the clocks associated with
>     these domains.
>
> To elaborate on (b): idling a power domain has always required ungating
> an array of clocks; see this old explanation from Rockchip:
> https://lore.kernel.org/linux-arm-kernel/54503C19.9060607@rock-chips.com/
>
> Historically, ARM Trusted Firmware has avoided this issue by using a
> special PMU_CRU_GATEDIS_CON0 register -- this register ungates all the
> necessary clocks -- when idling the memory controller. Unfortunately,
> we've found that this register is not 100% sufficient; it does not turn
> the relevant PLLs on [0].
>
> So it's possible to trigger issues with something like the following:
>
> 1. enable a power domain (e.g., RK3399_PD_VDU) -- kernel will
>    temporarily enable relevant clocks/PLLs, then turn them back off
>    2. a PLL (e.g., PLL_NPLL) is part of the clock tree for
>       RK3399_PD_VDU's clocks but otherwise unused; NPLL is disabled
> 3. perform a ddrfreq transition (rk3399_dmcfreq_target() -> ...
>    drivers/clk/rockchip/clk-ddr.c / ROCKCHIP_SIP_DRAM_FREQ)
>    4. ARM Trusted Firmware unagates VDU clocks (via PMU_CRU_GATEDIS_CON0)
>    5. ARM Trusted firmware idles the memory controller domain
>    6. Step 5 waits on the VDU domain/clocks, but NPLL is still off
>
> i.e., we hang the system.
>
> So for (b), we need to at a minimum manage the relevant PLLs on behalf
> of firmware. It's easier to simply manage the whole clock tree, in a
> similar way we do in rockchip_pd_power().
>
> For (a), we need to provide mutual exclusion betwen rockchip_pd_power()
> and firmware. To resolve that, we simply grab the PMU mutex and release
> it when ddrfreq is done.
>
> The Chromium OS kernel has been carrying versions of part of this hack
> for a while, based on some new custom notifiers [1]. I've rewritten as a
> simple function call between the drivers, which is OK because:
>
>  * the PMU driver isn't enabled, and we don't have this problem at all
>    (the firmware should have left us in an OK state, and there are no
>    runtime conflicts); or
>  * the PMU driver is present, and is a single instance.
>
> And the power-domain driver cannot be removed, so there's no lifetime
> management to worry about.
>
> For completeness, there's a 'dmc_pmu_mutex' to guard (likely
> theoretical?) probe()-time races. It's OK for the memory controller
> driver to start running before the PMU, because the PMU will avoid any
> critical actions during the block() sequence.
>
> [0] The RK3399 TRM for PMU_CRU_GATEDIS_CON0 only talks about ungating
>     clocks. Based on experimentation, we've found that it does not power
>     up the necessary PLLs.
>
> [1] CHROMIUM: soc: rockchip: power-domain: Add notifier to dmc driver
>     https://chromium-review.googlesource.com/q/I242dbd706d352f74ff706f5cbf42ebb92f9bcc60
>     Notably, the Chromium solution only handled conflict (a), not (b).
>     In practice, item (b) wasn't a problem in many cases because we
>     never managed to fully power off PLLs. Now that the (upstream) video
>     decoder driver performs runtime clock management, we often power off
>     NPLL.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/soc/rockchip/pm_domains.c | 118 ++++++++++++++++++++++++++++++
>  include/soc/rockchip/pm_domains.h |  25 +++++++
>  2 files changed, 143 insertions(+)

I've already done several pre-review of a few versions of this, so at
this point I'm pretty happy with where things are. Feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
