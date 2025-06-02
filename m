Return-Path: <linux-pm+bounces-27954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B412AACAA54
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC81166E59
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151551A3175;
	Mon,  2 Jun 2025 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mieV56F1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D8A2C3273
	for <linux-pm@vger.kernel.org>; Mon,  2 Jun 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748851403; cv=none; b=oZZoijTf/7rX0UmAHkKPdPi2p/cBGhOhEK1/PGlJMqb2N3t0S+vUfXryPJUG/qf/c66lLctFZDZjCpH08xRtOtplkFySxhUpHK0OOjUC/nxCDLMqSjGfnn6dNSvQAr9DtKID86IKvamJDDQBaBBCmfqQUZJFeJFdCzzKiE+eMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748851403; c=relaxed/simple;
	bh=Zwca/qzHBg0SoTSTCgAQYiiwHAOK23dg4VpGTPHkY+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=IX2qM1/8JuAH/7ub5bDWYx7pvyGmaNZlOYu/db0LDTx/ri8cVH+3ogA2JLd4IO0KkGl+wyXCYCfw/N9+sZ3szJPKRDJemKArNlMOUOG9FmgTXkAaodOqbCzRueMxfEZQU6nLMi6pAXY8F5XHy/603lY2f9pd+p1NhNETY1BbchA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mieV56F1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250602080312euoutp01412cd8aacccddbda393d51f65e743f84~FKxNBffS_1129511295euoutp01C
	for <linux-pm@vger.kernel.org>; Mon,  2 Jun 2025 08:03:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250602080312euoutp01412cd8aacccddbda393d51f65e743f84~FKxNBffS_1129511295euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748851392;
	bh=yY1VEfuS50yeg4/M81P+3Gelb3X1t6c/xBU34vQDX40=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mieV56F1622O2nLn4M5BjRvKgZYFN1ZjztbNFsodyNrzW88cl7Pa4+crFxRk9YpEn
	 9OP9dH8Hu66jJVP6l8Y0Me3BvVD6rK6nOmzNduOa/75UPu+MO3BZh4lBB9cH+LC0Gk
	 5ddQtpGMOiA+UWt64e/QlxawFm0285kY1YoYp9zs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250602080311eucas1p2d93fc4c597da6631557641b8024ac0b8~FKxMYZzjI2836028360eucas1p2o;
	Mon,  2 Jun 2025 08:03:11 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250602080310eusmtip1eeb2c0854b4142c150186f84a2b9d948~FKxLYFBbH1907619076eusmtip1q;
	Mon,  2 Jun 2025 08:03:10 +0000 (GMT)
Message-ID: <d949f2b5-1351-4778-9716-eaec1e2b1ba7@samsung.com>
Date: Mon, 2 Jun 2025 10:03:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Add TH1520 GPU support with power sequencing
To: Drew Fustini <drew@pdp7.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel
	<p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, Matt Coster
	<matt.coster@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aDzcul5vBeQvP634@x1>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250602080311eucas1p2d93fc4c597da6631557641b8024ac0b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58
X-EPHeader: CA
X-CMS-RootMailID: 20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58
References: <CGME20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58@eucas1p1.samsung.com>
	<20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<aDzcul5vBeQvP634@x1>



On 6/2/25 01:05, Drew Fustini wrote:
> On Fri, May 30, 2025 at 12:23:47AM +0200, Michal Wilczynski wrote:
>> This patch series introduces support for the Imagination IMG BXM-4-64
>> GPU found on the T-HEAD TH1520 SoC. A key aspect of this support is
>> managing the GPU's complex power-up and power-down sequence, which
>> involves multiple clocks and resets.
>>
>> The TH1520 GPU requires a specific sequence to be followed for its
>> clocks and resets to ensure correct operation. Initial discussions and
>> an earlier version of this series explored managing this via the generic
>> power domain (genpd) framework. However, following further discussions
>> with kernel maintainers [1], the approach has been reworked to utilize
>> the dedicated power sequencing (pwrseq) framework.
>>
>> This revised series now employs a new pwrseq provider driver
>> (pwrseq-thead-gpu.c) specifically for the TH1520 GPU. This driver
>> encapsulates the SoC specific power sequence details. The Imagination
>> GPU driver (pvr_device.c) is updated to act as a consumer of this power
>> sequencer, requesting the "gpu-power" target. The sequencer driver,
>> during its match phase with the GPU device, acquires the necessary clock
>> and reset handles from the GPU device node to perform the full sequence.
>>
>> This approach aligns with the goal of abstracting SoC specific power
>> management details away from generic device drivers and leverages the
>> pwrseq framework as recommended.
>>
>> The series is structured as follows:
>>
>> Patch 1: Adds device tree bindings for the new T-HEAD TH1520 GPU
>>          power sequencer provider.
>> Patch 2: Introduces the pwrseq-thead-gpu driver to manage the GPU's
>>          power-on/off sequence.
>> Patch 3: Updates the Imagination DRM driver to utilize the pwrseq
>>          framework for TH1520 GPU power management.
>> Patch 4: Adds the TH1520 GPU compatible string to the Imagination
>>          GPU DT bindings.
>> Patch 5: Adds the missing reset controller header include in the
>>          TH1520 DTS include file.
>> Patch 6: Adds the device tree node for the GPU power sequencer to
>>          the TH1520 DTS include file.
>> Patch 7: Adds the GPU device tree node for the IMG BXM-4-64 GPU to
>>          the TH1520 DTS include file.
>> Patch 8: Enables compilation of the drm/imagination on the RISC-V
>>          architecture
>>
>> This patchset finishes the work started in bigger series [2] by adding
>> all the remaining GPU power sequencing piece. After this patchset the GPU
>> probes correctly.
>>
>> This series supersedes the previous genpd based approach. Testing on
>> T-HEAD TH1520 SoC indicates the new pwrseq based solution works
>> correctly.
>>
>> This time it's based on linux-next, as there are dependent patches not
>> yet merged, but present in linux-next like clock and reset patches.
>>
>> An open point in Patch 7/8 concerns the GPU memory clock (gpu_mem_clk),
>> defined as a fixed-clock. The specific hardware frequency for this clock
>> on the TH1520 could not be determined from available public
>> documentation. Consequently, clock-frequency = <0>; has been used as a
>> placeholder to enable driver functionality.
>>
>> Link to v2 of this series - [3].
>>
>> v3:
>>
>>  - re-worked cover letter completely
>>  - complete architectural rework from using extended genpd callbacks to a
>>    dedicated pwrseq provider driver
>>  - introduced pwrseq-thead-gpu.c and associated DT bindings
>>    (thead,th1520-gpu-pwrseq)
>>  - the Imagination driver now calls devm_pwrseq_get() and uses
>>    pwrseq_power_on() / pwrseq_power_off() for the TH1520 GPU
>>  - removed the platform_resources_managed flag from dev_pm_info and
>>    associated logic
>>  - the new pwrseq driver's match() function now acquires consumer-specific
>>    resources (GPU clocks, GPU core reset) directly from the consumer device
>>
>> v2:
>>
>> Extended the series by adding two new commits:
>>  - introduced a new platform_resources_managed flag in dev_pm_info along
>>    with helper functions, allowing drivers to detect when clocks and resets
>>    are managed by the platform
>>  - updated the DRM Imagination driver to skip claiming clocks when
>>    platform_resources_managed is set
>>
>> Split the original bindings update:
>>  - the AON firmware bindings now only add the GPU clkgen reset (the GPU
>>    core reset remains handled by the GPU node)
>>
>> Reworked the TH1520 PM domain driver to:
>>  - acquire GPU clocks and reset dynamically using attach_dev/detach_dev
>>    callbacks
>>  - handle clkgen reset internally, while GPU core reset is obtained from
>>    the consumer device node
>>  - added a check to enforce that only a single device can be attached to
>>    the GPU PM domain
>>
>> [1] - https://lore.kernel.org/all/CAPDyKFpi6_CD++a9sbGBvJCuBSQS6YcpNttkRQhQMTWy1yyrRg@mail.gmail.com/
>> [2] - https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/
>> [3] - https://lore.kernel.org/all/20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com/
>>
>> ---
>> Michal Wilczynski (8):
>>       dt-bindings: power: Add T-HEAD TH1520 GPU power sequencer
>>       power: sequencing: Add T-HEAD TH1520 GPU power sequencer driver
>>       drm/imagination: Use pwrseq for TH1520 GPU power management
>>       dt-bindings: gpu: Add TH1520 GPU compatible to Imagination bindings
>>       riscv: dts: thead: th1520: Add missing reset controller header include
>>       riscv: dts: thead: Add GPU power sequencer node
>>       riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node
>>       drm/imagination: Enable PowerVR driver for RISC-V
>>
>>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml |   9 +-
>>  .../bindings/power/thead,th1520-pwrseq.yaml        |  42 +++++
>>  MAINTAINERS                                        |   2 +
>>  arch/riscv/boot/dts/thead/th1520.dtsi              |  29 ++++
>>  drivers/gpu/drm/imagination/Kconfig                |   3 +-
>>  drivers/gpu/drm/imagination/pvr_device.c           |  33 +++-
>>  drivers/gpu/drm/imagination/pvr_device.h           |   6 +
>>  drivers/gpu/drm/imagination/pvr_power.c            |  82 +++++----
>>  drivers/power/sequencing/Kconfig                   |   8 +
>>  drivers/power/sequencing/Makefile                  |   1 +
>>  drivers/power/sequencing/pwrseq-thead-gpu.c        | 183 +++++++++++++++++++++
>>  11 files changed, 363 insertions(+), 35 deletions(-)
>> ---
>> base-commit: 49473fe7fdb5fbbe5bbfa51083792c17df63d317
>> change-id: 20250414-apr_14_for_sending-5b3917817acc
>>
>> Best regards,
>> -- 
>> Michal Wilczynski <m.wilczynski@samsung.com>
>>
> 
> Thank you for continuing to work on this series.
> 
> I applied it to next-20250530 and the boot hangs:
> 
> <snip>
> [    0.895622] mmc0: new HS400 MMC card at address 0001
> [    0.902638] mmcblk0: mmc0:0001 8GTF4R 7.28 GiB
> [    0.915454]  mmcblk0: p1 p2 p3
> [    0.916613] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
> [    0.920107] mmcblk0boot0: mmc0:0001 8GTF4R 4.00 MiB
> [    0.936592] mmcblk0boot1: mmc0:0001 8GTF4R 4.00 MiB
> [    0.944986] mmcblk0rpmb: mmc0:0001 8GTF4R 512 KiB, chardev (243:0)
> [    0.947700] mmc1: new UHS-I speed DDR50 SDHC card at address aaaa
> [    0.961368] mmcblk1: mmc1:aaaa SU16G 14.8 GiB
> [    0.969639]  mmcblk1: p1 p2 p3
> [    0.986688] printk: legacy console [ttyS0] disabled
> [    0.992468] ffe7014000.serial: ttyS0 at MMIO 0xffe7014000 (irq = 23, base_baud = 6250000) is a 16550A
> [    1.002085] printk: legacy console [ttyS0] enabled
> [    1.002085] printk: legacy console [ttyS0] enabled
> [    1.011784] printk: legacy bootconsole [uart0] disabled
> [    1.011784] printk: legacy bootconsole [uart0] disabled
> [    1.024633] stackdepot: allocating hash table of 524288 entries via kvcalloc
> <no more output>
> 
> I pasted the full boot log [1]. I have clk_ignore_unused in the kernel
> cmdline so I don't think it is related to disabling clocks. Boot does
> complete okay if I set the gpu node status to disabled.
> 
> Any ideas of what might fix the boot hang?
> 
> Thanks,
> Drew

Hi,
Thanks a lot for testing and promptly providing debug data. I think the
problem is with the fallback logic implemented in the pvr_device.c:
	/*
	 * Try to get a power sequencer. If successful, it will handle clocks
	 * and resets. Otherwise, we fall back to managing them ourselves.
	 */
	pvr_dev->pwrseq = devm_pwrseq_get(dev, "gpu-power");
	if (IS_ERR(pvr_dev->pwrseq)) {
		int pwrseq_err = PTR_ERR(pvr_dev->pwrseq);

		/*
		 * If the error is -EPROBE_DEFER, it's because the
		 * optional sequencer provider is not present
		 * and it's safe to fall back on manual power-up.
		 */
		if (pwrseq_err == -EPROBE_DEFER)
			pvr_dev->pwrseq = NULL;
		else
			return dev_err_probe(dev, pwrseq_err,
					     "Failed to get power sequencer\n");
	}


Since you have:
# CONFIG_POWER_SEQUENCING_THEAD_GPU is not set
The fallback logic assumes that there is no pwrseq provider for
'gpu-power' and falls back on generic driver to do the initial power
sequence. Obviously for TH1520 the generic driver fails to do that
correctly, and the register access hangs.

So the code seems to behave as designed.

By the way, there are quite a lot of Kconfig options added recently to
TH1520 SoC that haven't made it's way to defconfig for risc-v. Do you
think it's a good idea to add them there ?

> 
> [1] https://protect2.fireeye.com/v1/url?k=ac29f739-cda2e203-ac287c76-74fe4860008a-0bca62898bcc20b4&q=1&e=e86ea026-835e-453e-a61b-1d30c11073e1&u=https%3A%2F%2Fgist.github.com%2Fpdp7%2F44bd6de63fb9274a66a705ad807690b6
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

