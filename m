Return-Path: <linux-pm+bounces-18093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503DD9D8A60
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 17:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F9AB2A476
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67821B4123;
	Mon, 25 Nov 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFn18wbN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7B1AC448;
	Mon, 25 Nov 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549358; cv=none; b=UdxYc72GF+3Rp1+aIfsYsHkqEdiN/s1p8DkSRn4NloPEssbn2yJpBpFix8evKi/i+n3I6+CEAFfBODa6+4Ub344yTAvNNhYsRARxB8aTT3leMzmMFsnE0K8xpOVf4zeCF0nwllag7fv3ZtpKre45FRCkOH1XhyTjue1quXLBYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549358; c=relaxed/simple;
	bh=1uGaURJFL+k5ljmFzecqQ8yWrYUK0nMYqG+LAJjeIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUz8L5ni7cWQXlWfuH+HgzqxP8XCJPxXIIHNVIaWeA+7kkca1CYXOAzkzEepoO4sYMl1rzCdxnyg0Q2DU/miXu5z7mb9b7Ka8ySlihYTObZep1qwBgIjnV0XOmC0xONOQuhYKisufL3ZOSIQnPHBcYZOyb0sZNYHL0eYFrtBvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFn18wbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7527FC4CECF;
	Mon, 25 Nov 2024 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732549358;
	bh=1uGaURJFL+k5ljmFzecqQ8yWrYUK0nMYqG+LAJjeIHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFn18wbNBs9mU22Xhw9Zgov43fj3pg71n5DMdBZHf6WRMLk/8lF5sqU+d0szP/hAW
	 NoL865FCb3Y1lP7w0x/8DHaUtmdmI/u2ITwf/35eRs49f7BVgkRGx1efszV2AaEW+v
	 3wZ0/+grTY09h3Koc2ZB94MmOHL/Xgd/Xu1L4J1dJ/iUz7c3L4ZV8t0+O2h68T0wWe
	 SF2Z86cBkS5reM9Ycfn8yqiGC8LN7SfgYamIf7KMj4i3KrMwoXkThoxM0ncvoKCytR
	 YB6uyXHgPBFX8AA6clWyVCRw2Hvf3xT18MJ4Y/RtbDDKGzNG3/JKR3i29I9qdNlJLM
	 ZRTuaIm0+B9Pw==
Date: Mon, 25 Nov 2024 08:42:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Georgi Djakov <djakov@kernel.org>, konradybcio@kernel.org,
	quic_okukatla@quicinc.com, quic_rlaggysh@quicinc.com,
	quic_jjohnson@quicinc.com
Subject: Re: pc : qnoc_probe (drivers/interconnect/qcom/icc-rpmh.c:269) :
 Dragonboard 410c - arm64 - boot failed
Message-ID: <20241125154235.GC2067874@thelio-3990X>
References: <CA+G9fYs+2mBz1y2dAzxkj9-oiBJ2Acm1Sf1h2YQ3VmBqj_VX2g@mail.gmail.com>
 <CA+G9fYvh8n=CTCmcCdLViH=o-UXH1Euncn+7YuYkvt5O-k8NMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvh8n=CTCmcCdLViH=o-UXH1Euncn+7YuYkvt5O-k8NMg@mail.gmail.com>

On Mon, Nov 25, 2024 at 08:43:44PM +0530, Naresh Kamboju wrote:
> [Small correction]
> 
> On Mon, 25 Nov 2024 at 20:33, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > The arm64 Dragonboard 410c has failed with the Linux next, mainline
> > and the Linux stable. Please find boot log and build links.
> 
> This boot regression is noticed only on Dragonboard 845c.
> Linux next-20241125 tag.
> 
> Good: next-20241122
> Bad: next-20241125

Can you bisect to see what change introduced this?

> >
> > Device: Dragonboard 410c - arm64
> > Boot failed: clang-19
> > Configs: korg-clang-19-lkftconfig-hardening
> > Boot pass: qemu-arm64 (Additional info)
> >
> > This is always reproducible.
> >
> > Dragonboard 410c - arm64:
> > boot:
> >  * clang-nightly-lkftconfig-hardening
> >  * korg-clang-19-lkftconfig-hardening
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Log details:
> > ------------
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd030]
> > [    0.000000] Linux version 6.12.0-next-20241125 (tuxmake@tuxmake)
> > (ClangBuiltLinux clang version 19.1.4
> > (https://github.com/llvm/llvm-project.git
> > aadaa00de76ed0c4987b97450dd638f63a385bed), ClangBuiltLinux LLD 19.1.4
> > (https://github.com/llvm/llvm-project.git
> > aadaa00de76ed0c4987b97450dd638f63a385bed)) #1 SMP PREEMPT @1732509632
> > [    0.000000] KASLR disabled due to lack of seed
> > [    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
> > <Trim>
> > [    8.983574] videodev: Linux video capture interface: v2.00
> > [    8.990308] Internal error: UBSAN: array index out of bounds:
> > 00000000f2005512 [#1] PREEMPT SMP
> > [    8.990374] Modules linked in: qcom_rng drm_client_lib qcom_stats
> > qnoc_msm8916(+) videodev videobuf2_memops videobuf2_common mc
> > rpmsg_ctrl rpmsg_char display_connector phy_qcom_usb_hs drm_kms_helper
> > ramoops reed_solomon socinfo rmtfs_mem fuse drm backlight ip_tables
> > x_tables ipv6
> > [    9.000620] CPU: 0 UID: 0 PID: 199 Comm: (udev-worker) Not tainted
> > 6.12.0-next-20241125 #1
> > [    9.022836] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [    9.030902] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    9.037760] pc : qnoc_probe (drivers/interconnect/qcom/icc-rpmh.c:269)
> > [    9.044439] lr : qnoc_probe (drivers/interconnect/qcom/icc-rpmh.c:0)
> > [    9.048258] sp : ffff800083b93470
> > [    9.052075] x29: ffff800083b93480 x28: ffff000002c2ae80 x27: ffff80007ac3d3e0
> > [    9.055554] x26: ffff000002c2ae88 x25: 0000000000000000 x24: ffff000009bb7400
> > [    9.062671] x23: 0000000000000000 x22: 0000000000000001 x21: ffff000004931400
> > [    9.069788] x20: ffff000004931410 x19: ffff0000048e0c80 x18: ffff800083a7d0a8
> > [    9.076907] x17: fffffffffffc23a2 x16: 0000000000000001 x15: 000000000000026c
> > [    9.084027] x14: fffffffffffffffd x13: 0000000000000000 x12: ffff7fffba293000
> > [    9.091145] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000001
> > [    9.098262] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
> > [    9.105381] x5 : 0000000000000040 x4 : ffff00003c75d9e0 x3 : 0000000000199400
> > [    9.112497] x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
> > [    9.119617] Call trace:
> > [    9.126727] qnoc_probe+0x4c8/0x4d0 P
> > [    9.128987] qnoc_probe+0x354/0x4d0 L
> > [    9.132805] platform_probe (drivers/base/platform.c:1405)
> > [    9.136624] really_probe (drivers/base/dd.c:581 drivers/base/dd.c:658)
> > [    9.140443] __driver_probe_device (drivers/base/dd.c:800)
> > [    9.144089] driver_probe_device (drivers/base/dd.c:830)
> > [    9.148429] __driver_attach (drivers/base/dd.c:1217)
> > [    9.152422] bus_for_each_dev (drivers/base/bus.c:369)
> > [    9.156590] driver_attach (drivers/base/dd.c:1234)
> > [    9.160495] bus_add_driver (drivers/base/bus.c:676)
> > [    9.164140] driver_register (drivers/base/driver.c:247)
> > [    9.167700] __platform_driver_register (drivers/base/platform.c:867)
> > [    9.171520] init_module+0x20/0xfbc qnoc_msm8916
> > [    9.176383] do_one_initcall (init/main.c:1250 init/main.c:1267)
> > [    9.181068] do_init_module (kernel/module/main.c:2910)
> > [    9.184800] load_module (kernel/module/main.c:3376)
> > [    9.188618] __arm64_sys_finit_module (kernel/module/main.c:3565
> > kernel/module/main.c:3577 kernel/module/main.c:3603
> > kernel/module/main.c:3587 kernel/module/main.c:3587)
> > [    9.192353] invoke_syscall (arch/arm64/kernel/syscall.c:50)
> > [    9.197127] el0_svc_common (arch/arm64/kernel/syscall.c:139)
> > [    9.200771] do_el0_svc (arch/arm64/kernel/syscall.c:152)
> > [    9.204503] el0_svc (arch/arm64/kernel/entry-common.c:165
> > arch/arm64/kernel/entry-common.c:178
> > arch/arm64/kernel/entry-common.c:745)
> > [    9.207802] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:797)
> > [    9.210756] el0t_64_sync (arch/arm64/kernel/entry.S:600)
> > [ 9.215189] Code: aa1303e0 97fff41c 17ffff79 d4200020 (d42aa240)
> > All code
> > ========
> >
> > Code starting with the faulting instruction
> > ===========================================
> > [    9.218752] ---[ end trace 0000000000000000 ]---
> > [    9.233047] note: (udev-worker)[199] exited with irqs disabled
> > [    9.233245] note: (udev-worker)[199] exited with preempt_count 1
> > [    9.243434] ------------[ cut here ]------------
> > <trim>
> > [    9.243951] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:128
> > ct_kernel_exit (kernel/context_tracking.c:153)
> > [    9.248555] Modules linked in: videobuf2_v4l2 qcom_rng
> > drm_client_lib qcom_stats qnoc_msm8916(+) videodev videobuf2_memops
> > videobuf2_common mc rpmsg_ctrl rpmsg_char display_connector
> > phy_qcom_usb_hs drm_kms_helper ramoops reed_solomon socinfo rmtfs_mem
> > fuse drm backlight ip_tables x_tables ipv6
> > [    9.260538] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G      D
> >           6.12.0-next-20241125 #1
> > [    9.282755] Tainted: [D]=DIE
> > [    9.292113] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [    9.292888] Unable to handle kernel read from unreadable memory at
> > virtual address 0000ffffa3c44d20
> > [    9.295061] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    9.295071] pc : ct_kernel_exit (kernel/context_tracking.c:153)
> > [    9.295088] lr : ct_kernel_exit (kernel/context_tracking.c:126)
> > [    9.301765] Mem abort info:
> > [    9.310514] sp : ffff800082503d10
> > [    9.310519] x29: ffff800082503d10 x28: ffff8000824c4ff0 x27: ffff800082509000
> > [    9.310536] x26: 0000000000000000 x25: ffff0000041f9898
> > [    9.317463]   ESR = 0x0000000096000004
> > [    9.321618]  x24: ffff0000041f9898
> > [    9.321625] x23: 0000000226f30819 x22: 0000000000000000
> > [    9.325621]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    9.328214]  x21: ffff00003c757ff8
> > [    9.328221] x20: ffff8000824c2350 x19: ffff00003c755350
> > [    9.331701]   SET = 0, FnV = 0
> > [    9.338806]  x18: ffff800082514880
> > [    9.338813] x17: 00000000529c6ef0 x16: 00000000529c6ef0 x15: 000000000000007e
> > [    9.343850]   EA = 0, S1PTW = 0
> > [    9.347659]
> > [    9.347662] x14: 00000000000000c8 x13: 0000000000000004 x12: 000000000a929b85
> > [    9.351058]   FSC = 0x04: level 0 translation fault
> > [    9.356167]
> > [    9.356171] x11: 0000000000000015 x10: 000000000682aaab x9 : 4000000000000000
> > [    9.361732] Data abort info:
> > [    9.364935] x8 : 4000000000000002 x7 : 0000000000005221 x6 : 0000000000055ad0
> > [    9.370064]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > [    9.373179] x5 : 0000000000005469 x4 : 0000000000000093 x3 : 0000000000000006
> > [    9.376580]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [    9.383768] x2 : 0000000000000000 x1 : ffff0000041f9880 x0 : ffff7fffba293000
> > [    9.386730]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [    9.388462] Call trace:
> > [    9.395502] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000856aa000
> > [    9.400175] ct_kernel_exit+0x80/0x8c P
> > [    9.401918] [0000ffffa3c44d20] pgd=0000000000000000
> > [    9.408943] ct_kernel_exit+0x14/0x8c L
> > [    9.408958] ct_idle_enter (kernel/context_tracking.c:321)
> > [    9.411910] , p4d=0800000089bb0403
> > [    9.418929] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:268)
> > [    9.418943] cpuidle_enter (drivers/cpuidle/cpuidle.c:391)
> > [    9.418953] do_idle (kernel/sched/idle.c:155
> > kernel/sched/idle.c:230 kernel/sched/idle.c:325)
> > [    9.424326] , pud=080000008943e403
> > [    9.431516] cpu_startup_entry (kernel/sched/idle.c:422)
> > [    9.431527] rest_init+0xe0/0xe4
> > [    9.436563] , pmd=0800000089bac403
> > [    9.443668] start_kernel (init/main.c:1040)
> > [    9.443681] __primary_switched (arch/arm64/kernel/head.S:247)
> > [    9.449057] , pte=00200000910f9fc3
> > [    9.451224] ---[ end trace 0000000000000000 ]---
> >
> > Links:
> > ------
> > - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241125/testrun/26040307/suite/boot/test/korg-clang-19-lkftconfig-hardening/log
> > - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241125/testrun/26040307/suite/boot/test/korg-clang-19-lkftconfig-hardening/details/
> > - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241125/testrun/26040307/suite/boot/test/korg-clang-19-lkftconfig-hardening/history/
> > - https://lkft.validation.linaro.org/scheduler/job/8004888#L2200
> > - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2pKKSWo1tVldooGuq0fBz0nRD07/
> >
> > Build image:
> > -----------
> > - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2pKKSWo1tVldooGuq0fBz0nRD07/
> >
> > Steps to reproduce:
> > ------------
> > - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2pKKSWo1tVldooGuq0fBz0nRD07/reproducer
> > - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2pKKSWo1tVldooGuq0fBz0nRD07/tux_plan
> >
> > metadata:
> > ----
> 
> git repo:  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git sha: 85a2dd7d7c8152cb125712a1ecae1d0a6ccac250
> 
> > kernel config:
> > https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2pKKSWo1tVldooGuq0fBz0nRD07/config
> > build url: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2pKKSWo1tVldooGuq0fBz0nRD07/
> > toolchain: clang-19 and clang-nightly
> > config:  korg-clang-19-lkftconfig-hardening
> > arch: arm64
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> 
> - Naresh
> 

