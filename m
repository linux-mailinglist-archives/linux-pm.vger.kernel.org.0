Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290163AF734
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFUVLH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 17:11:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:18400 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVLH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 17:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624309728;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oxz7h+/TEcgmnrt744cP2MjTzDc1ypkt9xTmuDMy3zY=;
    b=PtuZlE5A39Eth2FWxfvegLjF8NQlSpL/xZ/dI/Ams3Bm2a8GAzjI4fAWAJGnxqXZ1o
    CsgcF2Rm/g5M4XRMLaEOqH6plAXmVn66vVrkkeWrTXk71gkXutDRjLK3Qwjd3rfDO/vs
    AWZsr6N5OZDGtw98K5thHZrCtnairAYrJNyaBNTO6FXnnHdBimMI3FTs9A1fPnaBC/om
    uvhk4syuBWGuqX6RIqOXpxuaBD/vs6oKF4a7TvHYns/2HKr+4HuuqcZM/33ZbbdVfuAt
    SE6GowKGnOsUv0mJf3pDtHvFiJbVeKG86usOCan6S+cb1GpKKn3la6qwb2FN4+LEMYdd
    izEw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8f5IczAaIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5LL8lMKt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 21 Jun 2021 23:08:47 +0200 (CEST)
Date:   Mon, 21 Jun 2021 23:08:42 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 1/5] cpuidle: qcom_spm: Detach state machine from main
 SPM handling
Message-ID: <YND/2qJhUB1Iwk1X@gerhold.net>
References: <20210621181016.365009-1-angelogioacchino.delregno@somainline.org>
 <20210621181016.365009-2-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621181016.365009-2-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 21, 2021 at 08:10:12PM +0200, AngeloGioacchino Del Regno wrote:
> In commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic
> CPUidle driver") the SPM driver has been converted to a
> generic CPUidle driver: that was mainly made to simplify the
> driver and that was a great accomplishment;
> Though, it was ignored that the SPM driver is not used only
> on the ARM architecture.
> 

I don't really understand why you insist on writing that I deliberately
"ignored" your use case when converting the driver. This is not true.
Perhaps that's not actually what you meant but that's how it sounds to
me.

> In preparation for the enablement of SPM features on AArch64/ARM64,
> split the cpuidle-qcom-spm driver in two: the CPUIdle related
> state machine (currently used only on ARM SoCs) stays there, while
> the SPM communication handling lands back in soc/qcom/spm.c and
> also making sure to not discard the simplifications that were
> introduced in the aforementioned commit.
> 
> Since now the "two drivers" are split, the SCM dependency in the
> main SPM handling is gone and for this reason it was also possible
> to move the SPM initialization early: this will also make sure that
> whenever the SAW CPUIdle driver is getting initialized, the SPM
> driver will be ready to do the job.
> 
> Please note that the anticipation of the SPM initialization was
> also done to optimize the boot times on platforms that have their
> CPU/L2 idle states managed by other means (such as PSCI), while
> needing SAW initialization for other purposes, like AVS control.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/cpuidle/Kconfig.arm        |   1 +
>  drivers/cpuidle/cpuidle-qcom-spm.c | 324 +++++++----------------------
>  drivers/soc/qcom/Kconfig           |   9 +
>  drivers/soc/qcom/Makefile          |   1 +
>  drivers/soc/qcom/spm.c             | 198 ++++++++++++++++++
>  include/soc/qcom/spm.h             |  41 ++++
>  6 files changed, 325 insertions(+), 249 deletions(-)
>  create mode 100644 drivers/soc/qcom/spm.c
>  create mode 100644 include/soc/qcom/spm.h
> 
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index adf91a6e4d7d..091453135ea6 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> [...]
> +static int spm_cpuidle_register(int cpu)
>  {
> +	struct platform_device *pdev = NULL;
> +	struct device_node *cpu_node, *saw_node;
> +	struct cpuidle_qcom_spm_data data = {
> +		.cpuidle_driver = {
> +			.name = "qcom_spm",
> +			.owner = THIS_MODULE,
> +			.cpumask = (struct cpumask *)cpumask_of(cpu),
> +			.states[0] = {
> +				.enter			= spm_enter_idle_state,
> +				.exit_latency		= 1,
> +				.target_residency	= 1,
> +				.power_usage		= UINT_MAX,
> +				.name			= "WFI",
> +				.desc			= "ARM WFI",
> +			}
> +		}
> +	};

The stack is gone after the function returns.

Stephan

[    0.756176] 8<--- cut here ---
[    0.756222] ledtrig-cpu: registered to indicate activity on CPUs
[    0.756566] 8<--- cut here ---
[    0.756567] 8<--- cut here ---
[    0.756570] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.756571] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.756577] pgd = (ptrval)
[    0.756578] pgd = (ptrval)
[    0.756583] [00000000] *pgd=00000000
[    0.756583] [00000000] *pgd=00000000
[    0.756588] 
[    0.756597] Internal error: Oops: 80000005 [#1] PREEMPT SMP ARM
[    0.756605] Modules linked in:
[    0.756613] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.13.0-rc7 #9
[    0.756622] Hardware name: Generic DT based system
[    0.756626] PC is at 0x0
[    0.756634] LR is at cpuidle_enter_state+0x12c/0x358
[    0.756650] pc : [<00000000>]    lr : [<c0609c6c>]    psr: 60000093
[    0.756656] sp : c1085f68  ip : 017dc905  fp : 00000000
[    0.756662] r10: 00000000  r9 : c1059b28  r8 : ef000a30
[    0.756668] r7 : c1059938  r6 : 2d183b16  r5 : c1059b18  r4 : 00000005
[    0.756675] r3 : 00000000  r2 : 00000005  r1 : c1059938  r0 : ef000a30
[    0.756682] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    0.756691] Control: 10c5383d  Table: 8000406a  DAC: 00000051
[    0.756696] Register r0 information: non-slab/vmalloc memory
[    0.756705] Register r1 information: non-slab/vmalloc memory
[    0.756713] Register r2 information: non-paged memory
[    0.756719] Register r3 information: NULL pointer
[    0.756726] Register r4 information: non-paged memory
[    0.756732] Register r5 information: non-slab/vmalloc memory
[    0.756739] Register r6 information: non-paged memory
[    0.756746] Register r7 information: non-slab/vmalloc memory
[    0.756753] Register r8 information: non-slab/vmalloc memory
[    0.756760] Register r9 information: non-slab/vmalloc memory
[    0.756767] Register r10 information: NULL pointer
[    0.756773] Register r11 information: NULL pointer
[    0.756780] Register r12 information: non-paged memory
[    0.756787] Process swapper/3 (pid: 0, stack limit = 0x(ptrval))
[    0.756794] Stack: (0xc1085f68 to 0xc1086000)
[    0.756804] 5f60:                   00000000 c1084000 c1085fc3 ef000a30 c1059938 00000005
[    0.756815] 5f80: c0c06090 2719c400 00000000 c1084000 c1059938 c0609edc 00000003 c1084000
[    0.756826] 5fa0: c0c0604c ef000a30 c0b4ea28 c015d0f8 c1085fb0 00000005 00000093 c0cb2cc2
[    0.756837] 5fc0: 00000051 b02e84c1 c1085ff8 00000093 00000051 10c0387d c1085ff8 8000406a
[    0.756848] 5fe0: 410fd030 00000000 00000000 c015d51c 8107806a 801015d0 00000000 00000000
[    0.756861] [<c0609c6c>] (cpuidle_enter_state) from [<c0609edc>] (cpuidle_enter+0x30/0x40)
[    0.756883] [<c0609edc>] (cpuidle_enter) from [<c015d0f8>] (do_idle+0x210/0x2e8)
[    0.756904] [<c015d0f8>] (do_idle) from [<c015d51c>] (cpu_startup_entry+0x18/0x1c)
[    0.756920] [<c015d51c>] (cpu_startup_entry) from [<801015d0>] (0x801015d0)
[    0.756937] Code: bad PC value
[    0.756950] Internal error: Oops: 80000005 [#2] PREEMPT SMP ARM
[    0.756952] ---[ end trace 9857663ab4add8af ]---
[    0.756957] Modules linked in:
[    0.756958] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.756960] 
[    0.756963] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           5.13.0-rc7 #9
[    0.756972] Hardware name: Generic DT based system
[    0.756976] PC is at 0x0
[    0.756982] LR is at cpuidle_enter_state+0x12c/0x358
[    0.756993] pc : [<00000000>]    lr : [<c0609c6c>]    psr: 60000093
[    0.756999] sp : c1081f68  ip : 017dc905  fp : 00000000
[    0.757005] r10: 00000000  r9 : c1059b28  r8 : eefe0a30
[    0.757011] r7 : c1059938  r6 : 2d1844da  r5 : c1059b18  r4 : 00000005
[    0.757018] r3 : 00000000  r2 : 00000005  r1 : c1059938  r0 : eefe0a30
[    0.757025] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    0.757033] Control: 10c5383d  Table: 8000406a  DAC: 00000051
[    0.757038] Register r0 information: non-slab/vmalloc memory
[    0.757047] Register r1 information: non-slab/vmalloc memory
[    0.757054] Register r2 information: non-paged memory
[    0.757061] Register r3 information: NULL pointer
[    0.757067] Register r4 information: non-paged memory
[    0.757074] Register r5 information: non-slab/vmalloc memory
[    0.757080] Register r6 information: non-paged memory
[    0.757087] Register r7 information: non-slab/vmalloc memory
[    0.757094] Register r8 information: non-slab/vmalloc memory
[    0.757101] Register r9 information: non-slab/vmalloc memory
[    0.757108] Register r10 information: NULL pointer
[    0.757114] Register r11 information: NULL pointer
[    0.757121] Register r12 information: non-paged memory
[    0.757128] Process swapper/1 (pid: 0, stack limit = 0x(ptrval))
[    0.757134] Stack: (0xc1081f68 to 0xc1082000)
[    0.757144] 1f60:                   00000000 c1080000 c1081fc3 eefe0a30 c1059938 00000005
[    0.757155] 1f80: c0c06090 2719c400 00000000 c1080000 c1059938 c0609edc 00000001 c1080000
[    0.757167] 1fa0: c0c0604c eefe0a30 c0b4ea28 c015d0f8 c1081fb0 00000005 00000093 c0cb2cc2
[    0.757178] 1fc0: 00000051 cf41e4d1 c1081ff8 00000093 00000051 10c0387d c1081ff8 8000406a
[    0.757189] 1fe0: 410fd030 00000000 00000000 c015d51c 8107806a 801015d0 00000000 00000000
[    0.757197] [<c0609c6c>] (cpuidle_enter_state) from [<c0609edc>] (cpuidle_enter+0x30/0x40)
[    0.757218] [<c0609edc>] (cpuidle_enter) from [<c015d0f8>] (do_idle+0x210/0x2e8)
[    0.757236] [<c015d0f8>] (do_idle) from [<c015d51c>] (cpu_startup_entry+0x18/0x1c)
[    0.757251] [<c015d51c>] (cpu_startup_entry) from [<801015d0>] (0x801015d0)
[    0.757267] Code: bad PC value
[    0.757271] ---[ end trace 9857663ab4add8b0 ]---
[    0.761255] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.761256] CPU2: stopping
[    0.761261] pgd = (ptrval)
[    0.761261] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G      D           5.13.0-rc7 #9
[    0.761265] [00000000] *pgd=00000000
[    0.761271] Hardware name: Generic DT based system
[    0.761275] Internal error: Oops: 80000005 [#3] PREEMPT SMP ARM
[    0.761281] Modules linked in:
[    0.761278] [<c010ee70>] (unwind_backtrace) from [<c010ac80>] (show_stack+0x10/0x14)
[    0.761287] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D           5.13.0-rc7 #9
[    0.761296] Hardware name: Generic DT based system
[    0.761300] PC is at 0x0
[    0.761299] [<c010ac80>] (show_stack) from [<c07bcbb0>] (dump_stack+0x94/0xa8)
[    0.761306] LR is at cpuidle_enter_state+0x12c/0x358
[    0.761317] pc : [<00000000>]    lr : [<c0609c6c>]    psr: 60000093
[    0.761323] sp : c0c01f28  ip : 017dc905  fp : 00000000
[    0.761318] [<c07bcbb0>] (dump_stack) from [<c010ccbc>] (do_handle_IPI+0xf4/0x11c)
[    0.761329] r10: 00000000  r9 : c1059b28  r8 : eefd0a30
[    0.761335] r7 : c1059938  r6 : 2d12399c  r5 : c1059b18  r4 : 00000005
[    0.761335] [<c010ccbc>] (do_handle_IPI) from [<c010ccfc>] (ipi_handler+0x18/0x20)
[    0.761341] r3 : 00000000  r2 : 00000005  r1 : c1059938  r0 : eefd0a30
[    0.761348] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    0.761356] Control: 10c5383d  Table: 8000406a  DAC: 00000051
[    0.761350] [<c010ccfc>] (ipi_handler) from [<c018c898>] (handle_percpu_devid_irq+0x78/0x150)
[    0.761360] Register r0 information: non-slab/vmalloc memory
[    0.761369] Register r1 information: non-slab/vmalloc memory
[    0.761376] Register r2 information:
[    0.761368] [<c018c898>] (handle_percpu_devid_irq) from [<c01865d8>] (__handle_domain_irq+0x7c/0xd0)
[    0.761379]  non-paged memory
[    0.761382] Register r3 information: NULL pointer
[    0.761389] Register r4 information: non-paged memory
[    0.761395] Register r5 information:
[    0.761389] [<c01865d8>] (__handle_domain_irq) from [<c04879f4>] (gic_handle_irq+0x70/0x84)
[    0.761398]  non-slab/vmalloc memory
[    0.761402] Register r6 information: non-paged memory
[    0.761408] Register r7 information: non-slab/vmalloc memory
[    0.761415] Register r8 information:
[    0.761411] [<c04879f4>] (gic_handle_irq) from [<c0100b4c>] (__irq_svc+0x6c/0xa8)
[    0.761419]  non-slab/vmalloc memory
[    0.761422] Register r9 information: non-slab/vmalloc memory
[    0.761427] Exception stack(0xc1059e28 to 0xc1059e70)
[    0.761429] Register r10 information: NULL pointer
[    0.761435] Register r11 information:
[    0.761437] 9e20:                   60000093 2e4a2000 00000000 c0b48458 c0c060a8 00000034
[    0.761440]  NULL pointer
[    0.761443] Register r12 information: non-paged memory
[    0.761448] 9e40: c0cc8628 c1058000 60000013 00000000 c09fb5bc c0a614d4 00000143 c1059e78
[    0.761449] Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
[    0.761456] 9e60: c0183ccc c0183cd0 60000013 ffffffff
[    0.761456] Stack: (0xc0c01f28 to 0xc0c02000)
[    0.761466] 1f20:                   00000000 c0c00000 c0c01f83 eefd0a30 c1059938 00000005
[    0.761462] [<c0100b4c>] (__irq_svc) from [<c0183cd0>] (vprintk_emit+0x17c/0x1d4)
[    0.761477] 1f40: c0c06090 26dcbb00 00000000 c0c00000 c1059938 c0609edc 00000000 c0c00000
[    0.761479] [<c0183cd0>] (vprintk_emit) from [<c0183d4c>] (vprintk_default+0x24/0x2c)
[    0.761488] 1f60: c0c0604c eefd0a30 c0b4ea28 c015d0f8 c0c01f70 00000005 ef00cbc0 c0cb2cc2
[    0.761498] 1f80: 00c00000 11feb622 c0b39a54 000000e1 c0c00000 00000001 c0b39a54 00000000
[    0.761497] [<c0183d4c>] (vprintk_default) from [<c07ba87c>] (printk+0x30/0x54)
[    0.761509] 1fa0: ef00cbc0 c0b39a54 00000000 c015d51c c0cc6040 c0b00e34 ffffffff ffffffff
[    0.761520] 1fc0: 00000000 c0b00590 00000000 c0b39a54 11fbbb22 00000000 c0b00330 00000051
[    0.761514] [<c07ba87c>] (printk) from [<c0b264a0>] (ledtrig_cpu_init+0xf0/0xfc)
[    0.761530] 1fe0: 10c0387d 00000000 81e00000 410fd030 10c5387d 00000000 00000000 00000000
[    0.761534] [<c0b264a0>] (ledtrig_cpu_init) from [<c01017a4>] (do_one_initcall+0x50/0x1c4)
[    0.761537] [<c0609c6c>] (cpuidle_enter_state) from [<c0609edc>] (cpuidle_enter+0x30/0x40)
[    0.761552] [<c01017a4>] (do_one_initcall) from [<c0b010e0>] (kernel_init_freeable+0x22c/0x290)
[    0.761558] [<c0609edc>] (cpuidle_enter) from [<c015d0f8>] (do_idle+0x210/0x2e8)
[    0.761569] [<c0b010e0>] (kernel_init_freeable) from [<c07c014c>] (kernel_init+0x8/0x118)
[    0.761575] [<c015d0f8>] (do_idle) from [<c015d51c>] (cpu_startup_entry+0x18/0x1c)
[    0.761588] [<c07c014c>] (kernel_init) from [<c0100150>] (ret_from_fork+0x14/0x24)
[    0.761591] [<c015d51c>] (cpu_startup_entry) from [<c0b00e34>] (start_kernel+0x4e4/0x510)
[    0.761605] Exception stack(0xc1059fb0 to 0xc1059ff8)
[    0.761606] [<c0b00e34>] (start_kernel) from [<00000000>] (0x0)
[    0.761613] 9fa0:                                     00000000 00000000 00000000 00000000
[    0.761620] Code: bad PC value
[    0.761623] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.761625] ---[ end trace 9857663ab4add8b1 ]---
[    0.761632] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.740778] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
