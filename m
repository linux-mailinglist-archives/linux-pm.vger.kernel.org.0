Return-Path: <linux-pm+bounces-37138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C626C21E3C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3AED34FAAE
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50027337BAE;
	Thu, 30 Oct 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="KDFD6KZT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1C3168E0;
	Thu, 30 Oct 2025 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851645; cv=none; b=a0GBVE54ocXAciIkUY+AwoaaYxoACbAdwP2ucyoBC5SCn+dMSuqy0NJQPHhKDMcsaJ7Rk6GLdQYuLTuuIYiRFObYV+GfiTirunKGGdHjws6RZN8Py5LlsZexjeyGt0JBsyCU8rMNOOkUaBYrHMZDH4Ww6IehA8PqGwGNTRGea4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851645; c=relaxed/simple;
	bh=xlBX27AoJ/hP5t0wFL5btIcR32ZG2hnkgOZb86b/tFA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=mzXNSzb2/ykhW01y/VNkh90gJdYzLaEuqLmSHPp6jvNkPKMzpCcF8an4mxQB01t6VbUQljFEKLIcBIhwZdFj3wkorERGkyRbjO/UXNLO+v6N+vHicCLgoe7nnYflkqm7zXPfenIfs0yQPb1WQtP9db5DFsoYlPIPSjB0vchXwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=KDFD6KZT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1761851641; x=1762456441; i=wahrenst@gmx.net;
	bh=hT3RDv8vLgbDNmpeCMHq+rdl+dhMymp/s0TglACeYuQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 From:Subject:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KDFD6KZTzTm2vqobFICG2IJyAKXm2NaLLrIrkwVLAJePsn0FbY8oqsoCVmC28gVz
	 c8TW/7pVbI2lW66DwufrbF7xcYv5aDsGsZUtd7avYvwvsNdGn2DNp2oxEmgRbT92x
	 1JKiR1vEGuxoiK4ZJS76B5ZtCa7PzYVFYyyiM9Fc4JBbFTDDYV5poY63Y6qviTKaQ
	 1B/OSOuwF9sA2H+qsg3cDfwJo0jqDJr4Of8/A1BX1uchIwpwRro/xgbgktmumKqiZ
	 EzjrHJKn/+tny3irDa4ZEIBgNTIpHVSjkmODDFQMVXv0qInyV/7NSJsRbVna8oHx6
	 Ch/gfXun3KfwjqY2Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([91.41.217.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHEP-1vtMQ72iCJ-00nfMR; Thu, 30
 Oct 2025 20:14:00 +0100
Message-ID: <043f1702-52fc-4a83-82f7-683a26851623@gmx.net>
Date: Thu, 30 Oct 2025 20:13:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd
 <sboyd@kernel.org>, kernel-dev@igalia.com, kernel-list@raspberrypi.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>
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
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Subject: RPi 4 deferred probe timeout of V3D PM domain
In-Reply-To: <d88f6420-5013-4856-99d6-da28f79bd7a5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0/eFafuar226L1GYx93DpxgO1YFnpgFExz5vrveQkeFPyKuI79l
 NsM0VjS8T0/RmDQ+lusuJ/SHlxyoKNFC0Scmxxogja4tB5dwivUGMIuA9LXn5JLfNRBhgeT
 BvRe2KnHDU67ssFT9ypFYXdLcDRnBbhrU6PftQHnTXUaudqJAT5vp1b/Iby5SFDN9VXZ36X
 2X/4WsouFcmJsBHq+P/1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+oWp0AaVadg=;C6ISs/RFgw1QlPTbv8gbNyQvsQK
 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
 AdVKQ==

Hi Ulf,

Am 30.10.25 um 13:59 schrieb Mark Brown:
> On Wed, Oct 29, 2025 at 08:51:38PM +0100, Stefan Wahren wrote:
>> Am 28.10.25 um 19:47 schrieb Mark Brown:
>> Okay, here is my theory. The difference is about (boot) time. In my set=
up
>> the whole device boot from SD card and in your case the kernel modules =
are
>> stored via NFS.
>> V3D requires two resources, a clock and a PM domain. Additionally the P=
M
>> domain itself depends on the very same clock. In arm64/defconfig the
>> relevant clock driver is build as module, but the PM domain driver is
>> builtin.
>> During boot "driver_deferred_probe_timeout" (10 s) expires before the c=
lock
>> driver could be loaded via NFS. So the PM domain core gave up:
>> [=C2=A0 =C2=A016.936547] v3d fec00000.gpu: deferred probe timeout, igno=
ring dependency
>> So this breaks probing of V3D driver in this case.
> That seems buggy on the part of the core, particularly since userspace
> isn't there yet so we might be missing some filesystems - I would have
> expected the device to probe once the supply becomes available.  But I
> do agree with your analysis, it doesn't look like an issue with this
> driver.
recent changes to the Raspberry Pi 4 device tree revealed the issue for=20
the following corner case:
V3D requires two resources, a clock and a PM domain. Additionally the PM=
=20
domain itself depends on the very same clock. In arm64/defconfig the=20
relevant clock driver clk-raspberrypi is build as module, but the PM=20
domain driver bcm2835-pmdomain is builtin.

During boot "driver_deferred_probe_timeout" (10 s) expires before the=20
clock driver could be loaded via NFS. So the PM domain core gave up:
[=C2=A0 =C2=A016.936547] v3d fec00000.gpu: deferred probe timeout, ignorin=
g dependency

Expected behavior would be that the pmdomain defers probing until the=20
clk-driver is loaded from NFS.

I simulated Marks setup and replaced the dev_warn above with a dev_WARN=20
and got the following result:

[=C2=A0 =C2=A022.516225] v3d fec00000.gpu: __genpd_dev_pm_attach() failed =
to find=20
PM domain: -2
[=C2=A0 =C2=A022.516260] ------------[ cut here ]------------
[=C2=A0 =C2=A022.516268] v3d fec00000.gpu: deferred probe timeout, ignorin=
g dependency
[=C2=A0 =C2=A022.516355] WARNING: CPU: 0 PID: 75 at drivers/base/dd.c:297=
=20
driver_deferred_probe_check_state+0x64/0x80
[=C2=A0 =C2=A022.516401] Modules linked in: aes_neon_blk af_alg brcmfmac_w=
cc qrtr=20
vc4 brcmfmac snd_soc_hdmi_codec snd_soc_core brcmutil snd_compress=20
snd_pcm_dmaengine sha256 snd_bcm2835(C) cfg80211 drm_exec hci_uart=20
snd_pcm btqca snd_timer btbcm snd bluetooth soundcore drm_display_helper=
=20
ecdh_generic broadcom v3d ecc bcm_phy_lib cec drm_shmem_helper=20
drm_client_lib pcie_brcmstb gpu_sched drm_dma_helper genet=20
raspberrypi_hwmon rfkill bcm2711_thermal drm_kms_helper irq_bcm2712_mip=20
pwrseq_core i2c_bcm2835 nvmem_rmem vchiq(C) pwm_bcm2835 i2c_mux_pinctrl=20
reset_gpio drm fuse backlight dm_mod ipv6
[=C2=A0 =C2=A022.516721] CPU: 0 UID: 0 PID: 75 Comm: kworker/u16:3 Tainted=
: G =C2=A0 =C2=A0=20
 =C2=A0 =C2=A0C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.18.0-rc3-dirty #7 PREE=
MPT
[=C2=A0 =C2=A022.516743] Tainted: [C]=3DCRAP
[=C2=A0 =C2=A022.516751] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT=
)
[=C2=A0 =C2=A022.516763] Workqueue: events_unbound deferred_probe_work_fun=
c
[=C2=A0 =C2=A022.516792] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -=
SSBS=20
BTYPE=3D--)
[=C2=A0 =C2=A022.516806] pc : driver_deferred_probe_check_state+0x64/0x80
[=C2=A0 =C2=A022.516828] lr : driver_deferred_probe_check_state+0x64/0x80
[=C2=A0 =C2=A022.516847] sp : ffff800080c7ba90
[=C2=A0 =C2=A022.516856] x29: ffff800080c7ba90 x28: 0000000000000000 x27:=
=20
0000000000000000
[=C2=A0 =C2=A022.516884] x26: ffff00010001c028 x25: 0000000000000001 x24:=
=20
ffff000100136c10
[=C2=A0 =C2=A022.516910] x23: 0000000000000001 x22: fffffffffffffffe x21:=
=20
0000000000000000
[=C2=A0 =C2=A022.516935] x20: ffff000100136c10 x19: ffff000100136c10 x18:=
=20
fffffffffffe71c8
[=C2=A0 =C2=A022.516958] x17: 616d6f64204d5020 x16: 646e6966206f7420 x15:=
=20
ffffb4b9255d6c70
[=C2=A0 =C2=A022.516982] x14: 0000000000000000 x13: ffffb4b9255d6cf8 x12:=
=20
00000000000004c5
[=C2=A0 =C2=A022.517005] x11: 0000000000000197 x10: ffffb4b92562ecf8 x9 :=
=20
ffffb4b9255d6cf8
[=C2=A0 =C2=A022.517029] x8 : 00000000ffffefff x7 : ffffb4b92562ecf8 x6 :=
=20
80000000fffff000
[=C2=A0 =C2=A022.517053] x5 : ffff0001fef97408 x4 : 0000000000000000 x3 :=
=20
0000000000000027
[=C2=A0 =C2=A022.517076] x2 : 0000000000000000 x1 : 0000000000000000 x0 :=
=20
ffff000100806900
[=C2=A0 =C2=A022.517100] Call trace:
[=C2=A0 =C2=A022.517111]=C2=A0 driver_deferred_probe_check_state+0x64/0x80=
 (P)
[=C2=A0 =C2=A022.517135]=C2=A0 __genpd_dev_pm_attach+0x270/0x2c4
[=C2=A0 =C2=A022.517159]=C2=A0 genpd_dev_pm_attach+0x64/0x74
[=C2=A0 =C2=A022.517178]=C2=A0 dev_pm_domain_attach+0x78/0x7c
[=C2=A0 =C2=A022.517200]=C2=A0 platform_probe+0x48/0x98
[=C2=A0 =C2=A022.517215]=C2=A0 really_probe+0xbc/0x29c
[=C2=A0 =C2=A022.517228]=C2=A0 __driver_probe_device+0x78/0x12c
[=C2=A0 =C2=A022.517241]=C2=A0 driver_probe_device+0xd8/0x15c
[=C2=A0 =C2=A022.517254]=C2=A0 __device_attach_driver+0xb8/0x134
[=C2=A0 =C2=A022.517267]=C2=A0 bus_for_each_drv+0x88/0xe8
[=C2=A0 =C2=A022.517286]=C2=A0 __device_attach+0xa0/0x190
[=C2=A0 =C2=A022.517299]=C2=A0 device_initial_probe+0x14/0x20
[=C2=A0 =C2=A022.517312]=C2=A0 bus_probe_device+0xac/0xb0
[=C2=A0 =C2=A022.517331]=C2=A0 deferred_probe_work_func+0x88/0xc0
[=C2=A0 =C2=A022.517351]=C2=A0 process_one_work+0x148/0x28c
[=C2=A0 =C2=A022.517375]=C2=A0 worker_thread+0x2d0/0x3d8
[=C2=A0 =C2=A022.517394]=C2=A0 kthread+0x12c/0x204
[=C2=A0 =C2=A022.517413]=C2=A0 ret_from_fork+0x10/0x20
[=C2=A0 =C2=A022.517433] ---[ end trace 0000000000000000 ]---
[=C2=A0 =C2=A022.517450] v3d fec00000.gpu: probe with driver v3d failed wi=
th error=20
-110
[=C2=A0 =C2=A022.523164] platform fef05700.hdmi: deferred probe pending: (=
reason=20
unknown)
[=C2=A0 =C2=A022.523197] platform bcm2835-power: deferred probe pending:=
=20
bcm2835-power: Failed to get clock v3d

Do you think issue is in bcm2835-pmdomain or in the pmdomain core?
Any ideas how to solve this?

Best regards


