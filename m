Return-Path: <linux-pm+bounces-10500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B9E925614
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CAA1C222CE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2A13440A;
	Wed,  3 Jul 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ygyqeGpu"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D308F58;
	Wed,  3 Jul 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997415; cv=none; b=LG2RwhDyDJP1QZ7CM2kt99pp7coLnGelerPWBjQ+4R/9efhF8+2+iQt0DAR1MgW6LypWzekfxEZ2ZqQrR/Qf6p/eFb8iSXnWCaRxFQFN3n4O1jRNidqH7/QAdovJDDSHNM0eBgszdKrZ8QoJvuRW8rt6UNu9T7sCz4r1o3OjrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997415; c=relaxed/simple;
	bh=qXenZ0csaX6SeJadkS72uSPMTmyTGhj6/K07F9HFwdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCwwEypL6h+IVBHSGVbpLNh+5RK9J5ieS6bNOHF62iaZIV8o6InyAC5Y6FxU2HkefkWjiQzghCNoGFGwSREGyseZXsi6/phDffhDBmq07QgLdipCn3JiBrlgxmy9PDBQEZ7UJiRHdhzpiVECeUV+gMzPLR+6nGY8s1Fi72G1GbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ygyqeGpu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719997405;
	bh=qXenZ0csaX6SeJadkS72uSPMTmyTGhj6/K07F9HFwdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ygyqeGpuS+Hc1+IKhvCf444jnZzx3TiXCp7eRWY5N+iPWp8m00hnde20To/T1Yjj1
	 RyH16vE9iPW8tVOlt1ode3zK0wzgjYwQz1oi293Mg6rPMseC67lk9zHkF9UMGMvJN2
	 eyZsAs4QlcAq+HRKEMqBoLwM1Z1yUqSpOgf8/nB1LFC9s+S4aAz6mMNEaehXbqh4pf
	 2BVcGqJCmoeOU2qujOl3k4PVASzJXtTEHmLtTbfXnjc+wIpyN1DrQEJ/wvmhj9Tb0p
	 1VtAXvycu3PR3Rm4JgPgkJUi3r4XzXXcd0JZq8B1nqKlcY7TNgbPEkcRXivCXREe+y
	 Pn620zfXNbI6w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E137837821CD;
	Wed,  3 Jul 2024 09:03:24 +0000 (UTC)
Message-ID: <18b1724c-9bab-4501-b956-278896324e55@collabora.com>
Date: Wed, 3 Jul 2024 11:03:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Return early in manage if
 trip_max is null
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Nikita Travkin <nikita@trvn.ru>
Cc: kernel@collabora.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240702-power-allocator-null-trip-max-v1-1-47a60dc55414@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240702-power-allocator-null-trip-max-v1-1-47a60dc55414@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/07/24 23:24, Nícolas F. R. A. Prado ha scritto:
> Commit da781936e7c3 ("thermal: gov_power_allocator: Allow binding
> without trip points") allowed the governor to bind even when trip_max
> is null. This allows a null pointer dereference to happen in the manage
> callback. Add an early return to prevent it, since the governor is
> expected to not do anything in this case.
> 
> Fixes: da781936e7c3 ("thermal: gov_power_allocator: Allow binding without trip points")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> This issue was noticed by KernelCI during a boot test on the
> mt8195-cherry-tomato-r2 platform with the config in [1]. The stack trace
> is attached below.
> 
> [1] http://0x0.st/XaON.txt
> 
> [    4.015786] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    4.015791] Mem abort info:
> [    4.015793]   ESR = 0x0000000096000004
> [    4.015796]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    4.015799]   SET = 0, FnV = 0
> [    4.015802]   EA = 0, S1PTW = 0
> [    4.015804]   FSC = 0x04: level 0 translation fault
> [    4.015807] Data abort info:
> [    4.015809]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    4.015811]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    4.015814]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    4.015818] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109809000
> [    4.015821] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [    4.015835] Modules linked in: mt8195_mt6359(+) mt6577_auxadc snd_soc_mt8195_afe mtk_scp_ipi snd_sof_utils mtk_wdt(+)
> [    4.015852] CPU: 2 PID: 13 Comm: kworker/u32:1 Not tainted 6.10.0-rc6 #1 c5d519ae8e7fec6bbe67cb8c50bfebcb89dfa54e
> [    4.015859] Hardware name: Acer Tomato (rev2) board (DT)
> [    4.015862] Workqueue: events_unbound deferred_probe_work_func
> [    4.015875] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.015880] pc : power_allocator_manage+0x110/0x6a0
> [    4.015888] lr : __thermal_zone_device_update+0x1dc/0x400
> [    4.015893] sp : ffff8000800eb800
> [    4.015895] x29: ffff8000800eb810 x28: 0000000000000001 x27: 0000000000000001
> [    4.015903] x26: aaaaaaaaaaaaaaab x25: ffff07a0461c15a0 x24: ffffb58530ca67c0
> [    4.015911] x23: 0000000000000000 x22: ffff07a04098fcc0 x21: ffffb58532eec848
> [    4.015918] x20: ffff8000800eb920 x19: ffff07a0461c1000 x18: 0000000000000b4b
> [    4.015926] x17: 5359534255530031 x16: ffffb585310352e4 x15: 0000000000000020
> [    4.015933] x14: 0000000000000000 x13: ffffffff00000000 x12: 0000000000000040
> [    4.015940] x11: 0101010101010101 x10: ffffffffffffffff x9 : ffffb58530ca8d78
> [    4.015948] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : 0000000000001388
> [    4.015955] x5 : 0000000000000000 x4 : 0000000000000384 x3 : 0000000000000000
> [    4.015962] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [    4.015970] Call trace:
> [    4.015972]  power_allocator_manage+0x110/0x6a0
> [    4.015978]  __thermal_zone_device_update+0x1dc/0x400
> [    4.015983]  thermal_zone_device_set_mode+0x7c/0xa0
> [    4.015987]  thermal_zone_device_enable+0x1c/0x28
> [    4.015991]  thermal_of_zone_register+0x43c/0x498
> [    4.015996]  devm_thermal_of_zone_register+0x6c/0xb8
> [    4.016001]  gadc_thermal_probe+0x140/0x214
> [    4.016007]  platform_probe+0x70/0xc4
> [    4.016012]  really_probe+0x140/0x270
> [    4.016018]  __driver_probe_device+0xfc/0x114
> [    4.016024]  driver_probe_device+0x44/0x100
> [    4.016029]  __device_attach_driver+0x64/0xdc
> [    4.016035]  bus_for_each_drv+0xb4/0xdc
> [    4.016041]  __device_attach+0xdc/0x16c
> [    4.016046]  device_initial_probe+0x1c/0x28
> [    4.016052]  bus_probe_device+0x44/0xac
> [    4.016057]  deferred_probe_work_func+0xb0/0xc4
> [    4.016063]  process_scheduled_works+0x114/0x330
> [    4.016070]  worker_thread+0x1c0/0x20c
> [    4.016076]  kthread+0xf8/0x108
> [    4.016081]  ret_from_fork+0x10/0x20
> [    4.016090] Code: d1030294 17ffffdd f94012c0 f9401ed7 (b9400000)
> [    4.016095] ---[ end trace 0000000000000000 ]---
> ---
>   drivers/thermal/gov_power_allocator.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 45f04a25255a..1b2345a697c5 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -759,6 +759,9 @@ static void power_allocator_manage(struct thermal_zone_device *tz)
>   		return;
>   	}
>   
> +	if (!params->trip_max)
> +		return;
> +

I'm not sure that this is the right thing to do.

If you do that, allocate_power() will never be called, so the entire algo doesn't
work, making binding this completely useless (as it's going to be a noop..!).

Check what get_governor_trips() says in the documentation:

  * If there is only one trip point, then that's considered to be the
  * "maximum desired temperature" trip point and the governor is always
  * on.  If there are no passive or active trip points, then the
  * governor won't do anything.  In fact, its throttle function
  * won't be called at all.

....and it looks like you're aware of that, as you said that in the commit
description as well.

Now, I don't have time to dig too much into the documentation and the workings
of this governor, but I'll throw a doubt.

In get_governor_trips(), this driver looks for either a TRIP_PASSIVE or a
TRIP_ACTIVE thermal_trip - ignoring everything else, including HOT and CRITICAL.

Keeping in mind the "usual" meanings of those two types:
   - CRITICAL: "bad things are about to happen - shut me down NOOOOOOOWWWWW!!!"
   - HOT: "I'm about to reach Tj, cool me down aggressively please"

I believe that, unless I got something wrong, this governor should contribute
to the decisions in the HOT state/trip point, setting a relatively low power
budget to the target HW, throttling it and avoiding to get to CRITICAL state.

I am therefore proposing to add THERMAL_TRIP_HOT to the mix in get_governor_trips()
so that
  if (!first_passive, && !last_passive && !last_active)
    trip_max = hot_trip;

...where hot_trip might get treated as passive instead of having special treatment,
but anyway the special treatment would be local to that function in this case, so
it's not really important (just readability choices).


Thermal maintainers, please, ideas? Considerations?

Cheers,
Angelo

>   	allocate_power(tz, params->trip_max->temperature);
>   	params->update_cdevs = true;
>   }
> 
> ---
> base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
> change-id: 20240702-power-allocator-null-trip-max-bc82c8d7eaec
> 
> Best regards,




