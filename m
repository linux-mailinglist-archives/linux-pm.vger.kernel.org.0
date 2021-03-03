Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BD732C2F2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347057AbhCDAAJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350426AbhCCLAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Mar 2021 06:00:37 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561FFC06178B;
        Wed,  3 Mar 2021 02:59:56 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Dr9qH5dqjz1rx7x;
        Wed,  3 Mar 2021 11:54:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Dr9qH326vz1qqkR;
        Wed,  3 Mar 2021 11:54:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id v6gy5bSX7M2G; Wed,  3 Mar 2021 11:54:16 +0100 (CET)
X-Auth-Info: roSn6tOU3w5pXrcc+IARpM25f0IDnV9/nFeCPIcD4aU=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  3 Mar 2021 11:54:16 +0100 (CET)
Subject: Re: [PATCH v5 00/14] Add BLK_CTL support for i.MX8MP
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, pete.zhang@nxp.com,
        Claudius Heine <ch@denx.de>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
 <20210303104719.74guq4bfm75dyzvj@fsr-ub1664-175>
From:   Marek Vasut <marex@denx.de>
Message-ID: <70bac3c5-4ccc-b9dd-05e8-a278a0650601@denx.de>
Date:   Wed, 3 Mar 2021 11:54:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303104719.74guq4bfm75dyzvj@fsr-ub1664-175>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/3/21 11:47 AM, Abel Vesa wrote:
> On 20-11-03 13:18:12, Abel Vesa wrote:
>> The BLK_CTL according to HW design is basically the wrapper of the entire
>> function specific group of IPs and holds GPRs that usually cannot be placed
>> into one specific IP from that group. Some of these GPRs are used to control
>> some clocks, other some resets, others some very specific function that does
>> not fit into clocks or resets. Since the clocks are registered using the i.MX
>> clock subsystem API, the driver is placed into the clock subsystem, but it
>> also registers the resets. For the other functionalities that other GPRs might
>> have, the syscon is used.
>>
> 
> This approach seems to be introducing a possible ABBA deadlock due to
> the core clock and genpd locking. Here is a backtrace I got from Pete
> Zhang (he reported the issue on the internal mailing list):
> 
> [   11.667711][  T108] -> #1 (&genpd->mlock){+.+.}-{3:3}:
> [   11.675041][  T108]        __lock_acquire+0xae4/0xef8
> [   11.680093][  T108]        lock_acquire+0xfc/0x2f8
> [   11.684888][  T108]        __mutex_lock+0x90/0x870
> [   11.689685][  T108]        mutex_lock_nested+0x44/0x50
> [   11.694826][  T108]        genpd_lock_mtx+0x18/0x24
> [   11.699706][  T108]        genpd_runtime_resume+0x90/0x214 (hold genpd->mlock)
> [   11.705194][  T108]        __rpm_callback+0x80/0x2c0
> [   11.710160][  T108]        rpm_resume+0x468/0x650
> [   11.714866][  T108]        __pm_runtime_resume+0x60/0x88
> [   11.720180][  T108]        clk_pm_runtime_get+0x28/0x9c
> [   11.725410][  T108]        clk_disable_unused_subtree+0x8c/0x144
> [   11.731420][  T108]        clk_disable_unused_subtree+0x124/0x144
> [   11.737518][  T108]        clk_disable_unused+0xa4/0x11c (hold prepare_lock)
> [   11.742833][  T108]        do_one_initcall+0x98/0x178
> [   11.747888][  T108]        do_initcall_level+0x9c/0xb8
> [   11.753028][  T108]        do_initcalls+0x54/0x94
> [   11.757736][  T108]        do_basic_setup+0x24/0x30
> [   11.762614][  T108]        kernel_init_freeable+0x70/0xa4
> [   11.768014][  T108]        kernel_init+0x14/0x18c
> [   11.772722][  T108]        ret_from_fork+0x10/0x18
> 
> [   11.777512][  T108] -> #0 (prepare_lock){+.+.}-{3:3}:
> [   11.784749][  T108]        check_noncircular+0x134/0x13c
> [   11.790064][  T108]        validate_chain+0x590/0x2a04
> [   11.795204][  T108]        __lock_acquire+0xae4/0xef8
> [   11.800258][  T108]        lock_acquire+0xfc/0x2f8
> [   11.805050][  T108]        __mutex_lock+0x90/0x870
> [   11.809841][  T108]        mutex_lock_nested+0x44/0x50
> [   11.814983][  T108]        clk_unprepare+0x5c/0x100 ((hold prepare_lock))
> [   11.819864][  T108]        imx8m_pd_power_off+0xac/0x110
> [   11.825179][  T108]        genpd_power_off+0x1b4/0x2dc
> [   11.830318][  T108]        genpd_power_off_work_fn+0x38/0x58 (hold genpd->mlock)
> [   11.835981][  T108]        process_one_work+0x270/0x444
> [   11.841208][  T108]        worker_thread+0x280/0x4e4
> [   11.846176][  T108]        kthread+0x13c/0x14
> [   11.850621][  T108]        ret_from_fork+0x10/0x18
> 
> Now, this has been reproduced only on the NXP internal tree, but I think
> it is pretty obvious this could happen in upstream too, with this
> patchset applied.
> 
> First, my thought was to change the prepare_lock/enable_lock in clock
> core, from a global approach to a per clock basis. But that doesn't
> actually fix the issue.
> 
> The usecase seen above is due to clk_disable_unused, but the same could
> happen when a clock consumer calls prepare/unprepare on a clock.
> 
> I guess the conclusion is that the current state of the clock core and
> genpd implementation does not support a usecase where a clock controller
> has a PD which in turn uses another clock (from another clock controller).
> 
> Jacky, Pete, did I miss anything here ?

Just for completeness, I have a feeling I already managed to trigger 
this and discussed this with Lucas before, so this concern is certainly 
valid.
