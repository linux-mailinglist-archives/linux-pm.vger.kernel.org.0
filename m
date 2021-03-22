Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E378B345339
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 00:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhCVXuJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhCVXth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 19:49:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C131AC061574;
        Mon, 22 Mar 2021 16:49:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h3so12361182pfr.12;
        Mon, 22 Mar 2021 16:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAW23pOlFd6G1R31KXhdmo+M3x4sElgSsTjqu9afCA8=;
        b=p0NNrcETXf702Qtkp6QnLQIchdUKZgC4Lk8oIVry9qBZho2fle60KNPzLq5UGGg9dw
         Hob5LuwkVDBWLQI7p2LcUNzYWTOjfEilrFVNh3fl8C0jX33AWJRKWIN3N/C45juI/Lo2
         lkBwoFKDkEr+Fmg6YnMlFdjOmI5hy+b8pj99fZOjfJUntCVIwK87GCPaSaatpswejbxX
         RtFnshvwzqOUP2SdR3IGWTbZ1MtErrdxZdgoGZRZ/avio/chmCUzxJoMbfgQGBR8+mMI
         mDVtxZ49dk2fxmcFgHA+kQpyG3245GezRgAidYYw6iDQ8tDNnm4rJZXFgxTlTy/p2zMr
         7Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAW23pOlFd6G1R31KXhdmo+M3x4sElgSsTjqu9afCA8=;
        b=Ecd0FSZU7cYFIEcdLfwlXzH1MTTr09RFixu5yug9gpMMip3sAiTquoy5oJ2k0aRYiY
         MJMKTMF1ob6VtlVUBApuWD6SjR1yS/ijB3AdyzJ0uAHAy+wV2jZUO6XHSlALA938lHao
         FDf4kR6qIOwRwraBTwbuejB8tc+txl0y5rvIuL+TlO/n6/vvD1Vr0NRRMpstzHPVQGAZ
         P+wqBVdXhPu7W8xe1F1Q7/B9ALXwqec3FBfWpVubdpIvOS5ZX2SrGJcwWwVn2bvpe4m1
         qQuSgvMysVo8DDPpnC23NJz/9EYHpvA2bFsU+UjJa+ItasqxYyIPE+Gxp5Dz45qNNMGv
         VxPA==
X-Gm-Message-State: AOAM530QGYJgDLD6w2q50DJMgdVzWPWoL8KduWEUNDDMMctqlD6tbW0G
        C1EfenxlxAf4fLT6eUQQ0hC4mJs+WJvUOGJHMco=
X-Google-Smtp-Source: ABdhPJxFMX9Ks7Wouc0oQRH37P8AAsS2xuiTTanNZoX7goIhlirlpVMQPlYgV2LiGUOugMA/xEyKt0ec1CFNxbMXCD0=
X-Received: by 2002:a63:4413:: with SMTP id r19mr781044pga.75.1616456976101;
 Mon, 22 Mar 2021 16:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
 <20210303104719.74guq4bfm75dyzvj@fsr-ub1664-175> <70bac3c5-4ccc-b9dd-05e8-a278a0650601@denx.de>
In-Reply-To: <70bac3c5-4ccc-b9dd-05e8-a278a0650601@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 22 Mar 2021 18:49:25 -0500
Message-ID: <CAHCN7xK0b7eYpb5H2ZtnzJyS3d2fHJi1q_Bf0CzYTO2Wh1rkzA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Add BLK_CTL support for i.MX8MP
To:     Marek Vasut <marex@denx.de>
Cc:     Abel Vesa <abel.vesa@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, pete.zhang@nxp.com,
        Claudius Heine <ch@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 3, 2021 at 4:54 AM Marek Vasut <marex@denx.de> wrote:
>
> On 3/3/21 11:47 AM, Abel Vesa wrote:
> > On 20-11-03 13:18:12, Abel Vesa wrote:
> >> The BLK_CTL according to HW design is basically the wrapper of the entire
> >> function specific group of IPs and holds GPRs that usually cannot be placed
> >> into one specific IP from that group. Some of these GPRs are used to control
> >> some clocks, other some resets, others some very specific function that does
> >> not fit into clocks or resets. Since the clocks are registered using the i.MX
> >> clock subsystem API, the driver is placed into the clock subsystem, but it
> >> also registers the resets. For the other functionalities that other GPRs might
> >> have, the syscon is used.
> >>
> >
> > This approach seems to be introducing a possible ABBA deadlock due to
> > the core clock and genpd locking. Here is a backtrace I got from Pete
> > Zhang (he reported the issue on the internal mailing list):
> >
> > [   11.667711][  T108] -> #1 (&genpd->mlock){+.+.}-{3:3}:
> > [   11.675041][  T108]        __lock_acquire+0xae4/0xef8
> > [   11.680093][  T108]        lock_acquire+0xfc/0x2f8
> > [   11.684888][  T108]        __mutex_lock+0x90/0x870
> > [   11.689685][  T108]        mutex_lock_nested+0x44/0x50
> > [   11.694826][  T108]        genpd_lock_mtx+0x18/0x24
> > [   11.699706][  T108]        genpd_runtime_resume+0x90/0x214 (hold genpd->mlock)
> > [   11.705194][  T108]        __rpm_callback+0x80/0x2c0
> > [   11.710160][  T108]        rpm_resume+0x468/0x650
> > [   11.714866][  T108]        __pm_runtime_resume+0x60/0x88
> > [   11.720180][  T108]        clk_pm_runtime_get+0x28/0x9c
> > [   11.725410][  T108]        clk_disable_unused_subtree+0x8c/0x144
> > [   11.731420][  T108]        clk_disable_unused_subtree+0x124/0x144
> > [   11.737518][  T108]        clk_disable_unused+0xa4/0x11c (hold prepare_lock)
> > [   11.742833][  T108]        do_one_initcall+0x98/0x178
> > [   11.747888][  T108]        do_initcall_level+0x9c/0xb8
> > [   11.753028][  T108]        do_initcalls+0x54/0x94
> > [   11.757736][  T108]        do_basic_setup+0x24/0x30
> > [   11.762614][  T108]        kernel_init_freeable+0x70/0xa4
> > [   11.768014][  T108]        kernel_init+0x14/0x18c
> > [   11.772722][  T108]        ret_from_fork+0x10/0x18
> >
> > [   11.777512][  T108] -> #0 (prepare_lock){+.+.}-{3:3}:
> > [   11.784749][  T108]        check_noncircular+0x134/0x13c
> > [   11.790064][  T108]        validate_chain+0x590/0x2a04
> > [   11.795204][  T108]        __lock_acquire+0xae4/0xef8
> > [   11.800258][  T108]        lock_acquire+0xfc/0x2f8
> > [   11.805050][  T108]        __mutex_lock+0x90/0x870
> > [   11.809841][  T108]        mutex_lock_nested+0x44/0x50
> > [   11.814983][  T108]        clk_unprepare+0x5c/0x100 ((hold prepare_lock))
> > [   11.819864][  T108]        imx8m_pd_power_off+0xac/0x110
> > [   11.825179][  T108]        genpd_power_off+0x1b4/0x2dc
> > [   11.830318][  T108]        genpd_power_off_work_fn+0x38/0x58 (hold genpd->mlock)
> > [   11.835981][  T108]        process_one_work+0x270/0x444
> > [   11.841208][  T108]        worker_thread+0x280/0x4e4
> > [   11.846176][  T108]        kthread+0x13c/0x14
> > [   11.850621][  T108]        ret_from_fork+0x10/0x18
> >
> > Now, this has been reproduced only on the NXP internal tree, but I think
> > it is pretty obvious this could happen in upstream too, with this
> > patchset applied.
> >
> > First, my thought was to change the prepare_lock/enable_lock in clock
> > core, from a global approach to a per clock basis. But that doesn't
> > actually fix the issue.
> >
> > The usecase seen above is due to clk_disable_unused, but the same could
> > happen when a clock consumer calls prepare/unprepare on a clock.
> >
> > I guess the conclusion is that the current state of the clock core and
> > genpd implementation does not support a usecase where a clock controller
> > has a PD which in turn uses another clock (from another clock controller).
> >
> > Jacky, Pete, did I miss anything here ?
>
> Just for completeness, I have a feeling I already managed to trigger
> this and discussed this with Lucas before, so this concern is certainly
> valid.

I know it may not be ideal, someone tied a soft-reset and soft-enable
to the driver of the Hantro VPU on the IMXMQ [1], and I wonder if
something similar could be done for the drivers who are consumers of
the clocks.

For example:

lcdif could request the power domain.
The power domain soft-resets and enables bus clock (vis syscon)
After successful enabling of power-domain, the LCDIF requests the soft
reset and respective clock bits (also via syscon) similar to how [1]
and [2] do it for the Hantro VPU.

The syscon node could be a common node similar to what was done in
[2], and multiple consumers could control when each soft-reset and
clock-enable get activated.  I know it's probably more of an abuse of
the syscon system, but having the individual drivers control the order
of operations might be safer than trying to create a one-size-fits-all
driver.

adam
[1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210318082046.51546-4-benjamin.gaignard@collabora.com/
[2] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210318082046.51546-14-benjamin.gaignard@collabora.com/
