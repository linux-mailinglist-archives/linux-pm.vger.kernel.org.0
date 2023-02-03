Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6E68913B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 08:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjBCHtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 02:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBCHtX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 02:49:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AF293AF9
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 23:49:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B829E61DDF
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 07:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C68C433D2;
        Fri,  3 Feb 2023 07:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675410561;
        bh=U3c0QYSANZ4vc+8j+UZKY9GGwG+pDcBwpIOemLMgQls=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mH3/fmZG6koY9vBLfTRxCahPMz5HB9du+WmP26i2YPZVfO9gLmaypv16PHHkQwbJD
         LWtGssxzGbwAInvr6OiyvSGi2hYmRtyE6iZ6sjJX1ByNpaK+A5E3ErAX77eFbOopka
         OxUUbVplpPE0pncB/wlj2bepegHBFUH7FUrfKjuS8ChZPX8c2+STNr6iMS9yIUYgVA
         3eLTWMyiTTVe4MfiSBiwKkK7uYTkaVKNiSq+75G9KB7/ZQDJkGKSvvaWAr/Hy0WtYo
         xXNzUYrP9YYS7mzb0Z5/VozbWaD03S0NT7M/ivwZEB6cV2CedZjzeZ6KVTOsPZEFjp
         /M3DTV4d8TAKA==
Message-ID: <e5a272f7-6098-d2e8-7cba-9abcb0f9dbf6@kernel.org>
Date:   Fri, 3 Feb 2023 09:49:16 +0200
MIME-Version: 1.0
Subject: Re: i.MX8 NULL pointer dereference on interconnect instantiation
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>
References: <20230202175525.3dba79a7@booty>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230202175525.3dba79a7@booty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Luca,

On 2.02.23 18:55, Luca Ceresoli wrote:
> Hello,
> 
> I just met an oops on i.MX8MP that appears sporadically but quite often
> with my current config (~20%). It seems related to the concurrency of
> instantiaton between an interconnect and peripherals using it.
> 
> I haven't found any existing similar report.
> 
> Kernel: v6.2-rc5-20-g7bf70dbb1882 + the audio patches at
>          https://lore.kernel.org/all/20220625013235.710346-1-marex@denx.de/
> HW: Avnet MSC SM2-MB-EP1 Carrier Board
> 
> A log of the relevant section follows. Lines starting with ">>>" were
> added by me and show the relevant code lines being executed and some
> variable values.
> 
> ------------------------------8<------------------------------
> 
> [   15.170236] at24 0-0050: supply vcc not found, using dummy regulator
> [   15.181143] at24 0-0050: 8192 byte 24c64 EEPROM, writable, 32 bytes/write
> [   15.272681] >>> of_icc_get_from_provider:383 START, spec: np </soc@0/interconnect@32700000>
> [   15.281519] >>> of_icc_get_from_provider:405 RETURN -EPROBE_DEFER
> [   15.296345] >>> of_icc_get_from_provider:383 START, spec: np </soc@0/interconnect@32700000>
> [   15.305136] >>> of_icc_get_from_provider:405 RETURN -EPROBE_DEFER
> [   15.317576] >>> of_icc_get_from_provider:383 START, spec: np </soc@0/interconnect@32700000>
> [   15.326715] >>> of_icc_get_from_provider:405 RETURN -EPROBE_DEFER
> [   15.338297] input: 30370000.snvs:snvs-powerkey as /devices/platform/soc@0/30000000.bus/30370000.snvs/30370000.snvs:snvs-powerkey/input/input0
> [   15.359831] >>> of_icc_get_from_provider:383 START, spec: np </soc@0/interconnect@32700000>
> [   15.368372] >>> of_icc_get_from_provider:405 RETURN -EPROBE_DEFER
> [   15.381942] >>> of_icc_get_from_provider:383 START, spec: np </soc@0/interconnect@32700000>
> [   15.383139] imx-bus-devfreq 32700000.interconnect: interconnect provider added to topology
> [   15.387956] snvs_rtc 30370000.snvs:snvs-rtc-lp: registered as rtc1
> [   15.390482] >>> of_icc_xlate_onecell:352 START
> [   15.401380] >>> of_icc_xlate_onecell:359 RETURN icc_data->nodes[37] = 0000000000000000
> [   15.409421] >>> of_icc_get_from_provider:416 RETURN data->node 0000000000000000
> [   15.416865] >>> of_icc_get_from_provider:383 START, spec: np </soc@0/interconnect@32700000>
> [   15.425391] >>> of_icc_xlate_onecell:352 START
> [   15.429996] >>> of_icc_xlate_onecell:359 RETURN icc_data->nodes[36] = ffff000005fe9e00
> [   15.434640] i.mx8mm_thermal 30260000.tmu: No OCOTP nvmem reference found, SoC-specific calibration not loaded. Please update your DT.
> [   15.438012] >>> of_icc_get_from_provider:416 RETURN data->node ffff000005fe9e00
> [   15.457502] >>> path_find:197 src 0000000000000000
> [   15.462430] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [   15.471339] Mem abort info:
> [   15.473249] imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 7 mkt segment 2 supported-hw 0x80 0x4
> [   15.474253]   ESR = 0x0000000096000004
> [   15.486891]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   15.492315]   SET = 0, FnV = 0
> [   15.495407]   EA = 0, S1PTW = 0
> [   15.498704]   FSC = 0x04: level 0 translation fault
> [   15.503725] Data abort info:
> [   15.506646]   ISV = 0, ISS = 0x00000004
> [   15.510728]   CM = 0, WnR = 0
> [   15.513796] user pgtable: 4k pages, 48-bit VAs, pgdp=000000004611a000
> [   15.520354] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [   15.527450] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [   15.533737] Modules linked in: imx_cpufreq_dt imx8mm_thermal imx8mp_interconnect rtc_snvs imx_interconnect snvs_pwrkey governor_userspace imx_bus at24 fsl_imx8_ddr_perf caam error crct10dif_ce
> [   15.550925] CPU: 2 PID: 68 Comm: kworker/u8:4 Not tainted 6.2.0-rc5-00040-ged7bb521b8fe-dirty #70
> [   15.559809] Hardware name: MSC SM2-MB-EP1 Carrier Board with SM2S-IMX8PLUS-QC6-14N0600E SoM (DT)
> [   15.568602] Workqueue: events_unbound deferred_probe_work_func
> [   15.577666] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   15.584637] pc : path_find+0x94/0x374
> [   15.588314] lr : path_find+0x94/0x374
> [   15.591988] sp : ffff80000a78b730
> [   15.595305] x29: ffff80000a78b730 x28: 0000000000000000 x27: ffff80000a78b7c8
> [   15.602787] x26: ffff800009161988 x25: 0000000000000001 x24: 0000000000000000
> [   15.611498] x23: ffff800008e535c8 x22: ffff800008e53250 x21: ffff000005fe9e00
> [   15.618804] x20: ffff80000a78b7b8 x19: ffff80000a78b7a8 x18: 0000000000000030
> [   15.625956] x17: 3965663530303030 x16: 3066666666206564 x15: ffffffffffffffff
> [   15.633112] x14: 0000000000000000 x13: 3030303030303030 x12: 000000000004034f
> [   15.640265] x11: ffff8000095af930 x10: 000000000000011b x9 : 00000000ffffefff
> [   15.647418] x8 : ffff800009607930 x7 : 0000000000017fe8 x6 : 0000000000000000
> [   15.654571] x5 : 80000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
> [   15.661726] x2 : 0000000000000000 x1 : ffff000003516100 x0 : 0000000000000026
> [   15.668877] Call trace:
> [   15.671326]  path_find+0x94/0x374
> [   15.674653]  of_icc_get_by_index+0x1b0/0x290
> [   15.678932]  of_icc_get+0x70/0xa0
> [   15.682252]  of_icc_bulk_get+0x54/0xf0
> [   15.686007]  devm_of_icc_bulk_get+0x5c/0xc0
> [   15.690196]  imx8m_blk_ctrl_probe+0x22c/0x540
> [   15.694562]  platform_probe+0x68/0xe0
> [   15.698231]  really_probe+0xc0/0x3e0
> [   15.701820]  __driver_probe_device+0x7c/0x190
> [   15.706182]  driver_probe_device+0x3c/0x110
> [   15.710374]  __device_attach_driver+0xbc/0x160
> [   15.714827]  bus_for_each_drv+0x78/0xd0
> [   15.718670]  __device_attach+0xa8/0x1f0
> [   15.722513]  device_initial_probe+0x14/0x20
> [   15.726705]  bus_probe_device+0x9c/0xb0
> [   15.730549]  deferred_probe_work_func+0xa4/0x100
> [   15.735174]  process_one_work+0x288/0x6b0
> [   15.739193]  worker_thread+0x74/0x450
> [   15.742862]  kthread+0x10c/0x110
> [   15.746095]  ret_from_fork+0x10/0x20
> [   15.749683] Code: 90002480 91250000 f90053fb 97ffc398 (b8438783)
> [   15.755783] ---[ end trace 0000000000000000 ]---
> [   23.343608] random: crng init done
> 
> 
> ------------------------------8<------------------------------
> 
> The relevant line is line "B" in this snippet:
> 
>    A [   15.381942] >>> of_icc_get_from_provider:383 START, spec: np </soc@0/interconnect@32700000>
>    B [   15.383139] imx-bus-devfreq 32700000.interconnect: interconnect provider added to topology
>    C [   15.387956] snvs_rtc 30370000.snvs:snvs-rtc-lp: registered as rtc1
>    D [   15.390482] >>> of_icc_xlate_onecell:352 START
>    E [   15.401380] >>> of_icc_xlate_onecell:359 RETURN icc_data->nodes[37] = 0000000000000000
>    F [   15.409421] >>> of_icc_get_from_provider:416 RETURN data->node 0000000000000000
> 
> Here 32700000.interconnect is added during the execution of
> of_icc_get_from_provider(), which in turn calls of_icc_xlate_onecell()
> to find the interconnect node, failing and thus returning NULL. This
> NULL pointer is propagated up to of_icc_get_by_index() which passes it
> to path_find() where the pointer is dereferenced and the kernel oopses.
> 
> In successful runs, line B always appears outside of the execution of
> of_icc_get_from_provider(), i.e. either before line A or after line F, so
> it seems to me that the interconnect is being looked for while it is
> being added and the state is inconsistent.
> 
> That's all on my side at the moment. I haven't looked at how this
> could be fixed but I think the problem is pretty focused now.
> 
> I am of course available to provide more details.

Thanks for the report! Could you please try this patchset and see if it helps:
https://lore.kernel.org/all/20230201101559.15529-1-johan+linaro@kernel.org/

Thanks,
Georgi
