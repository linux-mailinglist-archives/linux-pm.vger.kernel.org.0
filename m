Return-Path: <linux-pm+bounces-10106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7B91A45C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F28B286BDE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B163B145323;
	Thu, 27 Jun 2024 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WDHzocm2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC613F441
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485665; cv=none; b=DMErw+4rhDAQNfpDFmM9tYgRhvJUCYkfVk23CnqrLPOZ3X9ZXEqXigUt2dJc0LTYCDPX8s0o/fkw7889a+dWWGDzsLjvWyXBCXLuaKZmICBBJN3/tEqIcKk4aiVh2FuvyvS0O34s8A0K/WrOBVDj/qKZADPQNNiJZqkIGYdVXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485665; c=relaxed/simple;
	bh=Eq9KxZOshMaF+nAhE+O0s+5R5LCamui8XH3ONS7WXdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuHXIILebwMk4Q2Cx0YoFBgtI11+aC2CHcmx2Il7CvpScwTmbg7QzaB1c73irkodFSSUgwOOFxYodv34RncNwQ48lJPiiLguFiOS9TGj2lSWoYsdlgg1+w783LSuIAmiyQRN0CbR9yRoMHDDAiIhxdOAkUyQ59p/6F1IdFgKKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WDHzocm2; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719485633; x=1720090433; i=wahrenst@gmx.net;
	bh=O2GYwYuNBunyFfTTOIFM7FkepsOv9vtJZZeApp+8S8g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WDHzocm2h7s1P4AlCNTsLO+Ev/VwSgglN9JDqPb9slJnNV3qRNikvO0gA0aqsbsG
	 3whXB65L1iCJCef8slJHz5RMKslEmtvA6Ab9nzfOQLhctLWoo0UNFiN+MEnX0wiKD
	 6vop+zV5NxSGjp+fatkw3FeZMP43JHqH/VNWGpkPqkdqDsxZbctMcvEZChwc7dHr5
	 0fwMe2TL28/zZvVIOGc42vOXrBVXnlxyXsW19j5ntzhQH45cRFEbGTQjIHIVZORhG
	 4HVQFcrK+zA4/4Py1kEIxetb2XjtLx5B58bWAtSGL7ClJltnw3QxQAvNt8kTntj+K
	 FIg4Vo+DWb1bJTv/vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1snuJn0vuk-00jALq; Thu, 27
 Jun 2024 12:53:53 +0200
Message-ID: <c2b0c16c-81e7-426b-895f-91a1c636a6a9@gmx.net>
Date: Thu, 27 Jun 2024 12:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: vc4: WARNING during suspend to idle of Raspberry Pi 3 Plus
To: Maxime Ripard <mripard@kernel.org>
Cc: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>,
 DRI Development <dri-devel@lists.freedesktop.org>, linux-pm@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <7003512d-7303-4f41-b0d6-a8af5bf8e497@gmx.net>
 <20240624-furry-kangaroo-of-flowers-85ecdf@houat>
 <26c16ecc-408a-4f7e-a98c-dc36adcc7ac6@gmx.net>
 <20240627-tentacled-dancing-ladybug-bbd004@houat>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240627-tentacled-dancing-ladybug-bbd004@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LHnZirjlmtAFntc1CLa5mGGgITI/G1hmZBz8dL3FUnwGdKcEISD
 vYttsDVPrwUN0pFjL8hOhLahe9EnP4QcfaXKwWhfxwdiLzhERGnmAsNhHB2D22I5MGNpN8i
 2Ts9g1DuFgS8wKEm7AAhUG8G8e2Wln97vtbT0dPLH8EsyEhDYi+SINasKuy/PgPcVbtKgA+
 sXC5rRzpiOEtTWMsLrbPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GyoWTD5WO6c=;2lsSHH15/1NJ21jh+0R3sg02Lhz
 PZ84nXnQUgcxOEUl4vBQOYI/5JCnbFsuGNajvIO4kCZG3DNcLtZNRZxbM2Ja1Pi0knsnTp09K
 6fQNMhN8X5bobJifu0e0uzvXHA5YX7o8ZmYjN5h1kLfEiXtO9q7bdGtxVWkVD9AJGK1WgnVcG
 StYb9xZntWiM0CQ6FgzAcFsjD+UbodxGlVjaRHskt311hnnSf0gv0uDWzCl9Rcp3cjEg8QF3p
 VX1yp/X+1EhAOWZR2ZPDeYQ/yn/OaXNXIQswBvk8O4AINPjC38HrzWrKi+nYBsONwKibv9bqd
 qWPDCVOZBCt5WKvLSu3AJ5cla3G6FFAxr5WCYMzFdtnmpi0JyWIja+reI0h31D8frQ79Nsy+5
 O1nWgIL4Sx/+uhNseuIUPKqjecl/F7q0LwmkSwp1LrzcQz6xzFI7HZ2m5fIX4mgmcErahqqtt
 brHtU91aowSgeqvCP3GAqWrwr6qNgTLZIB97AG8lKHOF62ngbwcyF7P632Vh2Hwvy5VqZqtWi
 JQ+oM716dpEs3vhCBVbD7DPv3A0plu8uNPHFIPQGwxoo4RXKEveb6iOafe4ZIxC085N4oGleX
 O/lUrfOetO+0aq0NxEdriVG2enrVdGBnSDcoxHpiPNxHchPmBQ/x1r6KON2wJSIzijhQX9/gz
 76cjgfDLXei/DhH4HOG/R0WeONbE8J6PKZhoPmla2nNrC/1uJpQoiBE0+tym8T5Hwy7vtt1db
 k7MTAxEctwXCk2Vunsw3WlozVdFRGHG5lSx6c7vN8CaVPf9rYt6UB5nyBkWv3BSYEZP5ZwF5V
 uRC3YvNJqBCOEEHI+d0WyUUx5Nd2MroZq+eUwQVrp+d7g=

Am 27.06.24 um 11:58 schrieb Maxime Ripard:
> On Tue, Jun 25, 2024 at 04:21:11PM GMT, Stefan Wahren wrote:
>> Am 24.06.24 um 14:57 schrieb Maxime Ripard:
>>> On Sun, Jun 16, 2024 at 11:27:08AM GMT, Stefan Wahren wrote:
>>>> Hi,
>>>> i'm currently experiment with suspend to idle on the Raspberry Pi [1]=
.
>>>>
>>>> During my tests, i noticed a WARNING of the vc4 during suspend incl.
>>>> Runtime PM usage count underflow. It would be nice if someone can loo=
k
>>>> at it. In case you want to reproduce it, i can prepare a branch with
>>>> some improvements/hacks. For example i disabled dwc2/USB because it
>>>> cause a lot of trouble during resume.
>>>>
>>>> Here are the steps to trigger this issue:
>>>> - make sure necessary kernel options are enabled ( CONFIG_SUSPEND,
>>>> CONFIG_PM_DEBUG, CONFIG_PM_ADVANCED_DEBUG )
>>>> - make sure no HDMI cable is connected to Raspberry Pi 3 Plus
>> sorry, i forgot the specific type of the Raspberry Pi 3 B Plus, but the
>> issue on Pi 3 A Plus is the same.
>>>> - Add "no_console_suspend" to cmdline.txt and reboot
>>>> - Connect via Debug UART:
>>>>
>>>> echo 1 > /sys/power/pm_debug_messages
>>>> echo platform > /sys/power/pm_test
>>>> echo freeze > /sys/power/state
>>>>
>>>> Here is the output:
>>>>
>>>> [=C2=A0=C2=A0 75.538497] PM: suspend entry (s2idle)
>>>> [=C2=A0=C2=A0 76.915786] Filesystems sync: 1.377 seconds
>>>> [=C2=A0=C2=A0 79.678262] rpi_firmware_set_power: Set HDMI to 1
>>>> [=C2=A0=C2=A0 79.678634] rpi_firmware_set_power: Set HDMI to 0
>>>> [=C2=A0=C2=A0 79.850949] Freezing user space processes
>>>> [=C2=A0=C2=A0 79.852460] Freezing user space processes completed (ela=
psed 0.001
>>>> seconds)
>>>> [=C2=A0=C2=A0 79.852484] OOM killer disabled.
>>>> [=C2=A0=C2=A0 79.852493] Freezing remaining freezable tasks
>>>> [=C2=A0=C2=A0 79.853684] Freezing remaining freezable tasks completed=
 (elapsed
>>>> 0.001 seconds)
>>>> [=C2=A0=C2=A0 80.892819] ieee80211 phy0: brcmf_fil_cmd_data: bus is d=
own. we have
>>>> nothing to do.
>>>> [=C2=A0=C2=A0 80.892843] ieee80211 phy0: brcmf_cfg80211_get_tx_power:=
 error (-5)
>>>> [=C2=A0=C2=A0 81.514053] PM: suspend of devices complete after 1659.3=
36 msecs
>>>> [=C2=A0=C2=A0 81.514089] PM: start suspend of devices complete after =
1660.386 msecs
>>>> [=C2=A0=C2=A0 81.515616] PM: late suspend of devices complete after 1=
.509 msecs
>>>> [=C2=A0=C2=A0 81.515938] rpi_firmware_set_power: Set VEC to 0
>>>> [=C2=A0=C2=A0 81.516010] rpi_firmware_set_power: Set V3D to 0
>>>> [=C2=A0=C2=A0 81.516998] PM: noirq suspend of devices complete after =
1.239 msecs
>>>> [=C2=A0=C2=A0 81.517016] PM: suspend debug: Waiting for 5 second(s).
>>>> [=C2=A0=C2=A0 89.598310] rpi_firmware_set_power: Set V3D to 1
>>>> [=C2=A0=C2=A0 90.078228] ------------[ cut here ]------------
>>>> [=C2=A0=C2=A0 90.078240] WARNING: CPU: 1 PID: 216 at
>>>> drivers/gpu/drm/vc4/vc4_hdmi.c:477
>>>> vc4_hdmi_connector_detect_ctx+0x2e4/0x34c [vc4]
>>>> [=C2=A0=C2=A0 90.078344] Modules linked in: aes_arm aes_generic cbc c=
rypto_simd
>>>> cryptd algif_skcipher af_alg brcmfmac_wcc brcmfmac vc4 brcmutil
>>>> snd_soc_hdmi_codec snd_soc_core ac97_bus sha256_generic
>>>> snd_pcm_dmaengine libsha256 snd_pcm sha256_arm snd_timer hci_uart
>>>> cfg80211 btbcm snd bluetooth soundcore drm_dma_helper crc32_arm_ce
>>>> ecdh_generic ecc raspberrypi_hwmon libaes bcm2835_thermal
>>>> [=C2=A0=C2=A0 90.078551] CPU: 1 PID: 216 Comm: kworker/1:2 Not tainte=
d 6.9.3-dirty #30
>>>> [=C2=A0=C2=A0 90.078568] Hardware name: BCM2835
>>>> [=C2=A0=C2=A0 90.078580] Workqueue: events output_poll_execute
>>>> [=C2=A0=C2=A0 90.078610] Call trace:
>>>> [=C2=A0=C2=A0 90.078624]=C2=A0 unwind_backtrace from show_stack+0x10/=
0x14
>>>> [=C2=A0=C2=A0 90.078660]=C2=A0 show_stack from dump_stack_lvl+0x50/0x=
64
>>>> [=C2=A0=C2=A0 90.078688]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
>>>> [=C2=A0=C2=A0 90.078723]=C2=A0 __warn from warn_slowpath_fmt+0x170/0x=
178
>>>> [=C2=A0=C2=A0 90.078760]=C2=A0 warn_slowpath_fmt from
>>>> vc4_hdmi_connector_detect_ctx+0x2e4/0x34c [vc4]
>>>> [=C2=A0=C2=A0 90.078862]=C2=A0 vc4_hdmi_connector_detect_ctx [vc4] fr=
om
>>>> drm_helper_probe_detect_ctx+0x40/0x120
>>>> [=C2=A0=C2=A0 90.078951]=C2=A0 drm_helper_probe_detect_ctx from
>>>> output_poll_execute+0x160/0x24c
>>>> [=C2=A0=C2=A0 90.078982]=C2=A0 output_poll_execute from process_one_w=
ork+0x16c/0x3b4
>>>> [=C2=A0=C2=A0 90.079012]=C2=A0 process_one_work from worker_thread+0x=
270/0x488
>>>> [=C2=A0=C2=A0 90.079036]=C2=A0 worker_thread from kthread+0xe0/0xfc
>>>> [=C2=A0=C2=A0 90.079060]=C2=A0 kthread from ret_from_fork+0x14/0x28
>>>> [=C2=A0=C2=A0 90.079080] Exception stack(0xf0af9fb0 to 0xf0af9ff8)
>>>> [=C2=A0=C2=A0 90.079096] 9fa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000
>>>> 00000000 00000000 00000000
>>>> [=C2=A0=C2=A0 90.079113] 9fc0: 00000000 00000000 00000000 00000000 00=
000000
>>>> 00000000 00000000 00000000
>>>> [=C2=A0=C2=A0 90.079129] 9fe0: 00000000 00000000 00000000 00000000 00=
000013 00000000
>>>> [=C2=A0=C2=A0 90.079141] ---[ end trace 0000000000000000 ]---
>>>> [=C2=A0=C2=A0 90.079155] vc4_hdmi 3f902000.hdmi: vc4_hdmi_connector_d=
etect_ctx:
>>>> pm_runtime_resume_and_get failed: -13
>>>> [=C2=A0=C2=A0 92.638262] rpi_firmware_set_power: Set HDMI to 1
>>>> [=C2=A0=C2=A0 95.678251] rpi_firmware_set_power: Set VEC to 1
>>>> [=C2=A0=C2=A0 95.678380] PM: noirq resume of devices complete after 9=
160.930 msecs
>>>> [=C2=A0=C2=A0 95.679604] PM: early resume of devices complete after 1=
.069 msecs
>>>> [=C2=A0=C2=A0 95.812230] brcmfmac: brcmf_fw_alloc_request: using
>>>> brcm/brcmfmac43455-sdio for chip BCM4345/6
>>>> [=C2=A0=C2=A0 95.812282] PM: resume of devices complete after 132.657=
 msecs
>>>> [=C2=A0=C2=A0 95.813246] vc4_hdmi 3f902000.hdmi: Runtime PM usage cou=
nt underflow!
>>>> [=C2=A0=C2=A0 95.814456] OOM killer enabled.
>>>> [=C2=A0=C2=A0 95.814466] Restarting tasks ... done.
>>>> [=C2=A0=C2=A0 95.817193] random: crng reseeded on system resumption
>>>> [=C2=A0=C2=A0 95.819813] rpi_firmware_set_power: Set HDMI to 0
>>>> [=C2=A0=C2=A0 95.827808] PM: suspend exit
>>>>
>>>> [1] - https://github.com/raspberrypi/firmware/issues/1894
>>> The code itself looks fine to me still, but It's not clear to me why i=
t
>>> getting called during suspend in the first place.
>> This is a good question. I don't have idea why this should be necessary=
.
>>
>> But according to the kernel docs the worker output_poll_execute can be
>> disabled with drm_kms_helper_poll_disable().
> Yeah, we might need to disable polling during suspend.

Agree. Yesterday i managed to get s2idle working on a old Raspberry Pi 1
B, so i will prepare a patch for this. It's not the only driver for
BCM2835, which need suspend patches.

> I must admit I
> don't have much experience with suspend, so I won't be of much help.
>
>> Btw do we need to use SET_SYSTEM_SLEEP_PM_OPS here?
>>>    IIRC, it's in the HPD
>>> interrupt handler path, could it be that the interrupt fires during
>>> suspend?
>> Based on the trace and my further investigations the function is called
>> vc4_hdmi_connector_detect_ctx every 10s while no HDMI connector is
>> plugged by output_poll_execute. This has the advantage that also the
>> GPIOs from the expander could be used as HPD. Since the suspend test is
>> 5 sec long, there is a high chance for this warning.
> That's slightly unrelated, but we can actually use that GPIO for HPD
> since it supports interrupts. I did a patch quite some time ago that was
> never merged for a good reason, but I can't remember what it was
> exactly:
>
> https://github.com/raspberrypi/linux/pull/4327
Yes, the commit "pinctrl: bcm2835: Disable interrupts for the banks > 0"
is not really acceptable. From my suspend investigations so far, i can
tell there some issues with the irqchip driver(s). So this commit looks
like a workaround.
>
>> Here is my current workaround:
>>
>> drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get
>>
>> The commit 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is
>> powered in detect") introduced the necessary power management handling
>> to avoid register access while controller is powered down.
>> Unfortunately it just print a warning if pm_runtime_resume_and_get()
>> fails and proceed anyway.
>>
>> This could happen during suspend to idle. So we must assume it is unsaf=
e
>> to access the HDMI register. So bail out properly.
>>
>> Fixes: 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is powere=
d
>> in detect")
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>  =C2=A0drivers/gpu/drm/vc4/vc4_hdmi.c | 7 ++++++-
>>  =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_h=
dmi.c
>> index d30f8e8e896717..2c1d59a181d833 100644
>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> @@ -462,6 +462,7 @@ static int vc4_hdmi_connector_detect_ctx(struct
>> drm_connector *connector,
>>  =C2=A0{
>>  =C2=A0=C2=A0=C2=A0=C2=A0 struct vc4_hdmi *vc4_hdmi =3D connector_to_vc=
4_hdmi(connector);
>>  =C2=A0=C2=A0=C2=A0=C2=A0 enum drm_connector_status status =3D connecto=
r_status_disconnected;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 /*
>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* NOTE: This function should really tak=
e vc4_hdmi->mutex, but
>> @@ -474,7 +475,11 @@ static int vc4_hdmi_connector_detect_ctx(struct
>> drm_connector *connector,
>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* the lock for now.
>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0*/
>>
>> - WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
>> +=C2=A0=C2=A0=C2=A0 ret =3D pm_runtime_resume_and_get(&vc4_hdmi->pdev->=
dev);
>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DRM_ERROR("Failed to retain HDMI=
 power domain: %d\n", ret);
>> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return status;
>> +=C2=A0=C2=A0=C2=A0 }
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (vc4_hdmi->hpd_gpio) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (gpiod_get_value_cansle=
ep(vc4_hdmi->hpd_gpio))
>>
> Yeah... I think we should really just fix the "why is detect even called
> in the first place" issue rather than merge something like that.
Yes, but i think the WARN_ON [1] and the missing error handling of
pm_runtime_resume_and_get is still an issue.

Best regards

[1] - https://lwn.net/Articles/969923/
>
> Maxime


