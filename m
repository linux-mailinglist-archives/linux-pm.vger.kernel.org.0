Return-Path: <linux-pm+bounces-8604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69228FBDFF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 23:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8A41C20FBB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 21:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF06142900;
	Tue,  4 Jun 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=tbilles@gmx.com header.b="tyYiV8Tp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC8F1422AD
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536295; cv=none; b=lYblQ3yLQxpoXXQtAC35PcwPhs9+v4NXXeZ9CWLSpFsmk29NfQdf9XSmeLmemwAxDzaLtLIeWuHcQDvNVUZPf4QRK8xAPj56TZPT1js08rvKIy20pt8W1OjMrNZZ+bovXSTFj6lBC784ZTaffMKG7zWejutLmsTpIihp7FRYFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536295; c=relaxed/simple;
	bh=63ocqQ3deYlo+t6c96bg16rbOvMGf1eBgbvc4RNSxps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQq2gSkvv6t9lq1+qS/3PTsayd+z97yYvZUvhflpCcmV3GqWEMI+qftvs4QcJNkBKZLZOzwbvL6XFngTLIWrVrkHjI+tZL4KKdceSoklkoyX6efyZJB6DHHrUVwzzRk5rmndkXqIozbTPNilVyWb8TlR+6O1yxTHYkpEw3M9wEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=tbilles@gmx.com header.b=tyYiV8Tp; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717536285; x=1718141085; i=tbilles@gmx.com;
	bh=63ocqQ3deYlo+t6c96bg16rbOvMGf1eBgbvc4RNSxps=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tyYiV8TpYpyP0/MqnHOebxOcFjVut2970C+NeIlrrDaTqgkPqtN81aetX7/lcv0C
	 EICSEEj33nPkXMtgX/3xHeQCGaDlkPVksF44iEQHzesKOasgDFCwj7fSKspi7Uuw+
	 fwGTc0t9A+T42YKa/WD3iJtieZF2DinR7056XV4mUg6rFCenNJ5ZeKXtWsMHd/hcW
	 yJQUumzz+PJfKctl2kR4wgo8oyS1O+8cjhC9FgvFZ7ssLuO5dVO9Q/RgVWgTE0t4I
	 k05QhP+tqtXTtLqQkWyfDyrOXxcSUzPPN2AnGdCTjjsbVfHMs8jOcLLXL51yxAJC3
	 +mgjflLiAoPCZgpdPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.65.3] ([213.197.77.179]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC30Z-1sJs2q2d2b-00CO5n; Tue, 04
 Jun 2024 23:24:45 +0200
Message-ID: <86a9dbb4-6ee0-48f3-a5c3-52f2cec5ba15@gmx.com>
Date: Tue, 4 Jun 2024 23:24:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bisected regression, maximum frequency drops after sleep
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org
References: <3f71747b-f852-4ee0-b384-cf46b2aefa3f@gmx.com>
 <CAJZ5v0i2GHh6xYH14G0pX7kBsamEM6eyAKCCj26VxH9aqFthzw@mail.gmail.com>
 <ed3c5b1e-795c-48d4-8983-ce1620d10c3d@gmx.com>
 <CAJZ5v0g9DE=MrtJn12d9NJa1gdO7vqtMuatR924_iQu8ar8BQA@mail.gmail.com>
Content-Language: hu
From: Billes Tibor <tbilles@gmx.com>
In-Reply-To: <CAJZ5v0g9DE=MrtJn12d9NJa1gdO7vqtMuatR924_iQu8ar8BQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hXbyiIKiSotEqXEdX4B8gE/SC9UjWewNuMTR07qHwoWvSQ//GmX
 UmPeQ5rShIr6gxxyq/c6+6POlkUv9cY2mheVMpD8eAP0Glo5GPut1wUFTn/ZXhLSIhoe2N0
 S7MG7eCpHNJzPFh8XESSBh1okj5bhc8/HO2gmF4lWrI6lJz82BXTzFTmjYVEHdZx+NPGt2c
 aHzyd+eVRNjB12SEewTag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/TtOyCZqxiI=;g9zmXKUtpRV+rb9Y8b3xQx1C3Z9
 oVTlumtTO6TPiR2B4nbI/tJTAlUSPavpMTmgXqdIyE9QCfWXAg/psH504znYd5vFzzDDzn+Z7
 xr4vsA21ekNc9qfBf9+XIKWiuxTe2Q/59BrQ6a0cUJc7FUJ9cs2YFCXi2UH4tqVdX4XsKoyIl
 GKtgDe6uHHvMxxkUSFy3Q8dwIqgS8NILzlzqsVuORl7qX9J+AHRekgGc3S4mJRe6U2XBvD2BR
 O0KLqOXoJF3rbClb89nsqD7oT2H9d3y8UbPzKuP5CqkiWZs/6PYYTympwykuEoJQjf+syiPki
 9y+NzbLBzbp74CJDcrcNPJhEF3KJU8Elzo4AEQBEmOyIveAXKKU8kAR6yk2uimTo0wqqDn73Q
 NQxm3D7F0OwfaEJL0LkxjbIb3cv6udQA6rjNTNKuquAzwOpsswyGcvKtNvkVLw9eY+WUFtFdI
 U1EHbam502JNrtaxJFQeMyce8kkCQKt0igtCUF5IETCDdq72BwQ/JobGGre63WCQF2sDd9D0v
 W+ygCI6rQeOuaKvB+0zJK74wJi9Fzl+xpr5YkDsC8oD2Goz1McUpY3UkB/eVF9+J4F25XNyWK
 MBYm+XRx9gaYDrWDCioIQQL3sVj61szh9RB72rK5nIXWcUgxFTYk1TOHLWS/ZXD0VjMADDpK+
 Ape8DyJY1PnhjsONGpaaBsicA+NuMKye3ltAPLiHgL0mQErlSixWk2J9NswQzg+2a8+8autBo
 bdyTUcbfzqtSFNxB8v01BcS5SYeca7xIDDWvQMCD4oLq1AcA0aq2hjcIzLnvm4Rl7mXMGUSLh
 fch5TKSe9BleMr5CFT125q7s3uQnKwHN7EHfDsL37PYMY=

On 6/4/24 14:54, Rafael J. Wysocki wrote:

> On Mon, Jun 3, 2024 at 9:48=E2=80=AFPM Billes Tibor <tbilles@gmx.com> wr=
ote:
>>
>> On 6/3/24 19:39, Rafael J. Wysocki wrote:
>>> Hi,
>>>
>>> On Thu, May 30, 2024 at 9:40=E2=80=AFPM Billes Tibor <tbilles@gmx.com>=
 wrote:
>>>>
>>>> Hi,
>>>>
>>>> I noticed an issue, that with every sleep-wake cycle, the maximum fre=
quency of
>>>> the CPU drops further down. For example, my CPU has a maximum (turbo)=
 frequency
>>>> of 3.5 Ghz, on first boot, this is the case. I put the laptop to slee=
p, wake it
>>>> up later, and now it reports only 2.1 Ghz as maximum frequency. After=
 the next
>>>> cycle it reports 1.4 Ghz. A reboot restores the original maximum freq=
uency.
>>>>
>>>> Details:
>>>> My CPU is an Intel Core i7-4710HQ. On bootup the
>>>> "grep -H . /sys/devices/system/cpu/cpufreq/policy0/*" command tell me=
 this:
>>>> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
>>>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
>>>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
>>>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20=
000
>>>> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:c=
onservative ondemand userspace powersave performance schedutil
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:900000
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:3500000
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported=
>
>>>>
>>>> After sleep:
>>>> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
>>>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
>>>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
>>>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20=
000
>>>> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:c=
onservative ondemand userspace powersave performance schedutil
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:904557
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2100000
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported=
>
>>>>
>>>> Notice the scaling_max_freq file says different frequencies. I tried =
writing
>>>> the scaling_max_freq file, it allows me to lower the maximum availabl=
e
>>>> frequency, does not allow to raise back to 3.5 Ghz, it only raises ba=
ck to
>>>> 2.1 Ghz (in this case).
>>>>
>>>> If I keep repeating this sleep-wake cycle, the scaling_max_freq reach=
es its
>>>> minimum at 1.4 Ghz, but the actual available frequency continues to d=
rop, in
>>>> the following example to around 550 Mhz which is even below scaling_m=
in_freq.
>>>> This was taken under full load, notice the value of scaling_cur_freq:
>>>>
>>>> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
>>>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
>>>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
>>>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20=
000
>>>> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:c=
onservative ondemand userspace powersave performance schedutil
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:553861
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1400000
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
>>>> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported=
>
>>>>
>>>>
>>>> I first noticed this when updating my kernel from 6.6.12 to 6.7.1. Si=
nce then
>>>> I've been trying to bisecting it, after a few failed attempts I think=
 I came
>>>> reasonably close, this commit came out as the first bad one:
>>>>
>>>> commit 950210887670cbb7d2eb9af6fb743b70f1a1ebdc (refs/bisect/bad)
>>>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> Date:=C2=A0=C2=A0 Tue Sep 19 20:54:37 2023 +0200
>>>>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 thermal: core: Drop trips_disabled bitmask
>>>>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 After recent changes, thermal_zone_get_trip()=
 cannot fail, as invoked
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 from thermal_zone_device_register_with_trips(=
), so the only role of
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 the trips_disabled bitmask is struct thermal_=
zone_device is to make
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 handle_thermal_trip() skip trip points whose =
temperature was initially
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 zero.=C2=A0 However, since the unit of temper=
ature in the thermal core is
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 millicelsius, zero may very well be a valid t=
emperature value at least
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 in some usage scenarios and the trip temperat=
ure may as well change
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 later.=C2=A0 Thus there is no reason to perma=
nently disable trip points
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 with initial temperature equal to zero.
>>>>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 Accordingly, drop the trips_disabled bitmask =
along with the code
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 related to it.
>>>>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Rafael J. Wysocki <rafael.j.wy=
socki@intel.com>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 Tested-by: Ido Schimmel <idosch@nvidia.com>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0 Acked-by: Daniel Lezcano <daniel.lezcano@lina=
ro.org>
>>>>
>>>> I also tested a recent stable kernel, 6.9.2 and it is still dropping =
the maximum
>>>> frequency after sleep.
>>>>
>>>> Can someone help me find the cause of this issue? Is there something =
I can do to
>>>> help debug this?
>>>
>>> It looks like one of the thermal zones on this system has a trip point
>>> whose temperature is initialized to 0 which used to be disabled before
>>> the change above and now it is not and it is processed during resume
>>> from system sleep.
>>>
>>> If this is the case, the thermal zone in question needs to be
>>> identified and its driver adjusted to set the trip point's temperature
>>> to invalid to start with.
>>>
>>> Please send the output of the following two commands from your system:
>>>
>>> $ grep '.*' /sys/class/thermal/thermal_zone*/type
>>> $ grep '.*' /sys/class/thermal/thermal_zone*/trip_point_*
>>>
>>
>> Here it is:
>
> Thanks!
>
>> /sys/class/thermal/thermal_zone0/type:acpitz
>> /sys/class/thermal/thermal_zone1/type:x86_pkg_temp
>>
>> /sys/class/thermal/thermal_zone0/trip_point_0_hyst:0
>> /sys/class/thermal/thermal_zone0/trip_point_0_temp:127000
>> /sys/class/thermal/thermal_zone0/trip_point_0_type:critical
>> /sys/class/thermal/thermal_zone0/trip_point_1_hyst:0
>> /sys/class/thermal/thermal_zone0/trip_point_1_temp:127000
>> /sys/class/thermal/thermal_zone0/trip_point_1_type:hot
>> /sys/class/thermal/thermal_zone0/trip_point_2_hyst:0
>> /sys/class/thermal/thermal_zone0/trip_point_2_temp:0
>> /sys/class/thermal/thermal_zone0/trip_point_2_type:passive
>> /sys/class/thermal/thermal_zone1/trip_point_0_hyst:0
>> /sys/class/thermal/thermal_zone1/trip_point_0_temp:-274000
>> /sys/class/thermal/thermal_zone1/trip_point_0_type:passive
>> /sys/class/thermal/thermal_zone1/trip_point_1_hyst:0
>> /sys/class/thermal/thermal_zone1/trip_point_1_temp:-274000
>> /sys/class/thermal/thermal_zone1/trip_point_1_type:passive
>>
>> So are we looking for thermal_zone0/trip_point_2 from the acpitz driver=
?
>
> I think so.
>
> The attached patch should restore the previous behavior of disabling
> trip points with 0 temperature in the ACPI thermal zone driver.
> Please try it and let me know if it helps.
=C2=A0
Tested on top of v6.9.3, works as expected! thermal_zone0/trip_point_2_tem=
p now
says -274000, the others remained the same. And yes, after a sleep-resume =
I
still get my full 3.5 GHz frequency.
=C2=A0
Thank you for the patch, feel free to add my tested by tag:
Tested-by: Tibor Billes <tbilles@gmx.com>
=C2=A0
And Doug thank you as well for relaying between the mailing list and the U=
buntu
Forums!
=C2=A0
Tibor


