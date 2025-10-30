Return-Path: <linux-pm+bounces-37145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F591C22375
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 21:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB57C4EB327
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE41C334C10;
	Thu, 30 Oct 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mHx5IcZ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952E34D3AB
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855185; cv=none; b=B+5K4lXoKpZK6RfLESnMV/BlwjX3bXC47mYZqN5/MEbkv5V/KN+U/7SCZiV2PWk/1CZW/orjes37oQinbH9JM7Az/Ir987uRPlc900sLTE2oU/JtIq1cUyWoj2V6IZZrwiaMH7qTZEDmta/HoCaH3/NA03VxkOJfqecQsDGXIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855185; c=relaxed/simple;
	bh=X8TAoqJnNj6KHpFGGb0JdVN2l77IDpbRZrCb+k7NcUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qLZWqbwJYQoZuCspHs/rytIDqY/drhn8U2wBS6AC35PL4ac85uV0cBJSDtAc7aGARjURtyIqiNol5/ZF6KClnYyyv3wdWmLm+ZvtSoa6ck/98pxDMnu4YfrnTGWDO9hSTwGWvrPUSKqxMcv+pk4i/QftDnVvd7ElYDqXM8xZ2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mHx5IcZ2; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251030201300euoutp01635c7687d14c2fcd7d2eab2ed300adfb~zXfOlZJ8j0086400864euoutp01Y
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 20:13:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251030201300euoutp01635c7687d14c2fcd7d2eab2ed300adfb~zXfOlZJ8j0086400864euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761855180;
	bh=aPKYrhN0h9lZ7e4uINlVO3+rklZ2bskVk9BKkD02NWo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mHx5IcZ2ASo5hCahLWuk0hvToLtzwBoq1hrH3bY3DTMVfZtBM7ySQ/1dpgjkzTsl0
	 ACEsC4K+DBrY8xb+NOrlgtfUJdsaHJZupv9M1+nk2TvR67bXf717+XALoqqorNCHui
	 /KLFB/5iBfm3DRv9yPEiukG0yIG7jhsj3g6qRKhw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251030201259eucas1p159917c525b575ccecaab2cc5f32b2285~zXfOMIINF1012410124eucas1p1i;
	Thu, 30 Oct 2025 20:12:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251030201258eusmtip2dda38e291c0a0eea3c42de8a3556ba08~zXfMpWucU2934129341eusmtip2e;
	Thu, 30 Oct 2025 20:12:58 +0000 (GMT)
Message-ID: <b02c8890-4568-4afe-8628-10b77e79bf44@samsung.com>
Date: Thu, 30 Oct 2025 21:12:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: RPi 4 deferred probe timeout of V3D PM domain
To: Stefan Wahren <wahrenst@gmx.net>, Mark Brown <broonie@kernel.org>, Ulf
	Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
	<florian.fainelli@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Ray
	Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Melissa Wen
	<mwen@igalia.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, Maxime
	Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	kernel-dev@igalia.com, kernel-list@raspberrypi.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "open
 list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <043f1702-52fc-4a83-82f7-683a26851623@gmx.net>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251030201259eucas1p159917c525b575ccecaab2cc5f32b2285
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251030191426eucas1p29ce063b538b60e4a998bcd32f925267c
X-EPHeader: CA
X-CMS-RootMailID: 20251030191426eucas1p29ce063b538b60e4a998bcd32f925267c
References: <20251005113816.6721-1-wahrenst@gmx.net>
	<9ebda74e-e700-4fbe-bca5-382f92417a9c@sirena.org.uk>
	<a5e1e279-7e20-458d-a75f-787e0adbc9fe@gmx.net>
	<ad07546f-0c2d-4bc2-b794-755b892c7328@sirena.org.uk>
	<a016e7e1-09f7-4056-a855-6cfaa8d51962@gmx.net>
	<10a4ef77-0e70-4ef2-b1df-535b476d256d@sirena.org.uk>
	<ecd75fd5-3131-4d10-ae3d-b6f608d9622a@gmx.net>
	<25e500c2-3dc1-476c-b6c1-ac4098a0501d@sirena.org.uk>
	<d6b14388-e0ab-44f0-b4d9-78adf74c2a7f@gmx.net>
	<d88f6420-5013-4856-99d6-da28f79bd7a5@sirena.org.uk>
	<CGME20251030191426eucas1p29ce063b538b60e4a998bcd32f925267c@eucas1p2.samsung.com>
	<043f1702-52fc-4a83-82f7-683a26851623@gmx.net>

On 30.10.2025 20:13, Stefan Wahren wrote:
>
> Am 30.10.25 um 13:59 schrieb Mark Brown:
>> On Wed, Oct 29, 2025 at 08:51:38PM +0100, Stefan Wahren wrote:
>>> Am 28.10.25 um 19:47 schrieb Mark Brown:
>>> Okay, here is my theory. The difference is about (boot) time. In my 
>>> setup
>>> the whole device boot from SD card and in your case the kernel 
>>> modules are
>>> stored via NFS.
>>> V3D requires two resources, a clock and a PM domain. Additionally 
>>> the PM
>>> domain itself depends on the very same clock. In arm64/defconfig the
>>> relevant clock driver is build as module, but the PM domain driver is
>>> builtin.
>>> During boot "driver_deferred_probe_timeout" (10 s) expires before 
>>> the clock
>>> driver could be loaded via NFS. So the PM domain core gave up:
>>> [   16.936547] v3d fec00000.gpu: deferred probe timeout, ignoring 
>>> dependency
>>> So this breaks probing of V3D driver in this case.
>> That seems buggy on the part of the core, particularly since userspace
>> isn't there yet so we might be missing some filesystems - I would have
>> expected the device to probe once the supply becomes available. But I
>> do agree with your analysis, it doesn't look like an issue with this
>> driver.
> recent changes to the Raspberry Pi 4 device tree revealed the issue 
> for the following corner case:
> V3D requires two resources, a clock and a PM domain. Additionally the 
> PM domain itself depends on the very same clock. In arm64/defconfig 
> the relevant clock driver clk-raspberrypi is build as module, but the 
> PM domain driver bcm2835-pmdomain is builtin.
>
> During boot "driver_deferred_probe_timeout" (10 s) expires before the 
> clock driver could be loaded via NFS. So the PM domain core gave up:
> [   16.936547] v3d fec00000.gpu: deferred probe timeout, ignoring 
> dependency
>
> Expected behavior would be that the pmdomain defers probing until the 
> clk-driver is loaded from NFS.
>
> I simulated Marks setup and replaced the dev_warn above with a 
> dev_WARN and got the following result:
>
> [   22.516225] v3d fec00000.gpu: __genpd_dev_pm_attach() failed to 
> find PM domain: -2
> [   22.516260] ------------[ cut here ]------------
> [   22.516268] v3d fec00000.gpu: deferred probe timeout, ignoring 
> dependency
> [   22.516355] WARNING: CPU: 0 PID: 75 at drivers/base/dd.c:297 
> driver_deferred_probe_check_state+0x64/0x80
> [   22.516401] Modules linked in: aes_neon_blk af_alg brcmfmac_wcc 
> qrtr vc4 brcmfmac snd_soc_hdmi_codec snd_soc_core brcmutil 
> snd_compress snd_pcm_dmaengine sha256 snd_bcm2835(C) cfg80211 drm_exec 
> hci_uart snd_pcm btqca snd_timer btbcm snd bluetooth soundcore 
> drm_display_helper ecdh_generic broadcom v3d ecc bcm_phy_lib cec 
> drm_shmem_helper drm_client_lib pcie_brcmstb gpu_sched drm_dma_helper 
> genet raspberrypi_hwmon rfkill bcm2711_thermal drm_kms_helper 
> irq_bcm2712_mip pwrseq_core i2c_bcm2835 nvmem_rmem vchiq(C) 
> pwm_bcm2835 i2c_mux_pinctrl reset_gpio drm fuse backlight dm_mod ipv6
> [   22.516721] CPU: 0 UID: 0 PID: 75 Comm: kworker/u16:3 Tainted: G   
>      C          6.18.0-rc3-dirty #7 PREEMPT
> [   22.516743] Tainted: [C]=CRAP
> [   22.516751] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
> [   22.516763] Workqueue: events_unbound deferred_probe_work_func
> [   22.516792] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [   22.516806] pc : driver_deferred_probe_check_state+0x64/0x80
> [   22.516828] lr : driver_deferred_probe_check_state+0x64/0x80
> [   22.516847] sp : ffff800080c7ba90
> [   22.516856] x29: ffff800080c7ba90 x28: 0000000000000000 x27: 
> 0000000000000000
> [   22.516884] x26: ffff00010001c028 x25: 0000000000000001 x24: 
> ffff000100136c10
> [   22.516910] x23: 0000000000000001 x22: fffffffffffffffe x21: 
> 0000000000000000
> [   22.516935] x20: ffff000100136c10 x19: ffff000100136c10 x18: 
> fffffffffffe71c8
> [   22.516958] x17: 616d6f64204d5020 x16: 646e6966206f7420 x15: 
> ffffb4b9255d6c70
> [   22.516982] x14: 0000000000000000 x13: ffffb4b9255d6cf8 x12: 
> 00000000000004c5
> [   22.517005] x11: 0000000000000197 x10: ffffb4b92562ecf8 x9 : 
> ffffb4b9255d6cf8
> [   22.517029] x8 : 00000000ffffefff x7 : ffffb4b92562ecf8 x6 : 
> 80000000fffff000
> [   22.517053] x5 : ffff0001fef97408 x4 : 0000000000000000 x3 : 
> 0000000000000027
> [   22.517076] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
> ffff000100806900
> [   22.517100] Call trace:
> [   22.517111]  driver_deferred_probe_check_state+0x64/0x80 (P)
> [   22.517135]  __genpd_dev_pm_attach+0x270/0x2c4
> [   22.517159]  genpd_dev_pm_attach+0x64/0x74
> [   22.517178]  dev_pm_domain_attach+0x78/0x7c
> [   22.517200]  platform_probe+0x48/0x98
> [   22.517215]  really_probe+0xbc/0x29c
> [   22.517228]  __driver_probe_device+0x78/0x12c
> [   22.517241]  driver_probe_device+0xd8/0x15c
> [   22.517254]  __device_attach_driver+0xb8/0x134
> [   22.517267]  bus_for_each_drv+0x88/0xe8
> [   22.517286]  __device_attach+0xa0/0x190
> [   22.517299]  device_initial_probe+0x14/0x20
> [   22.517312]  bus_probe_device+0xac/0xb0
> [   22.517331]  deferred_probe_work_func+0x88/0xc0
> [   22.517351]  process_one_work+0x148/0x28c
> [   22.517375]  worker_thread+0x2d0/0x3d8
> [   22.517394]  kthread+0x12c/0x204
> [   22.517413]  ret_from_fork+0x10/0x20
> [   22.517433] ---[ end trace 0000000000000000 ]---
> [   22.517450] v3d fec00000.gpu: probe with driver v3d failed with 
> error -110
> [   22.523164] platform fef05700.hdmi: deferred probe pending: (reason 
> unknown)
> [   22.523197] platform bcm2835-power: deferred probe pending: 
> bcm2835-power: Failed to get clock v3d
>
> Do you think issue is in bcm2835-pmdomain or in the pmdomain core?
> Any ideas how to solve this?

As I mentioned in the other thread, this is imho a configuration issue. 
If core modules are distributed on NFS rootfs, then one should increase 
deferred probe timeout by adding deferred_probe_timeout=60 to cmdline. 
On the other hand drivers built into the kernel should not depend on the 
resources provided by the drivers built as modules, so maybe it would 
make sense to change CONFIG_CLK_RASPBERRYPI from 'm' to 'y' in 
arch/arm64/configs/defconfig.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


