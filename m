Return-Path: <linux-pm+bounces-8542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D361C8D8A75
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 21:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEA81F2504E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B940877;
	Mon,  3 Jun 2024 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=tbilles@gmx.com header.b="ooQGOZOU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15913A876
	for <linux-pm@vger.kernel.org>; Mon,  3 Jun 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444108; cv=none; b=qTkUXGi2/686wQYxU/8lQ6v9hKHrZmL/jpjAMi5ro4gL7NIrQxlEi+FVFkca2oNktPwabhySjNQBNjVSkWYAf9L3dqO2G+sLIkmK63Vcs76s9gZ/jvM2BYROJrQ0c3ntroEttPwFOMLB1yOZ9C0gUqPz9TwRnAXgcaNoFHe7/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444108; c=relaxed/simple;
	bh=Oc7UHY5PnsYItx7LzHUGxXx642WOSeY8Q5+QB48Tl78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBDv3Ac4U835kB5G5vT+sjKD4YVRmma30rSEN3cGk/7T1IjbU19CSeyk5iJ2jrnqBZ2C8SRzf6To5Lma8eZQPkgliShdRV4+/EnnejrjeFQcSL4HJpS3vVFOteBHQAfee5Izb5PFvD6UOwqeCFI+P+WthVjbQGdjcbMuArO8TJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=tbilles@gmx.com header.b=ooQGOZOU; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717444099; x=1718048899; i=tbilles@gmx.com;
	bh=Oc7UHY5PnsYItx7LzHUGxXx642WOSeY8Q5+QB48Tl78=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ooQGOZOUvuXyz7Mim6ywdHOpQ5qRnHLHBazEJnyH4cdnH2l1vh4Rwh+anVmJRvmv
	 4J3dJ96STVnAqpFaS8ysidJeAEIBOWXmFds1ofqBmdyPUfOfaZvy8ognMZtlI9Fa9
	 Ind2Km2Znoc8VBXl79g0a7RK0kL4XC9dCDfpaDsOJV8IGATfZS8aUp30oE0YdHEE8
	 nxWF4ilurwuawKSL3Y7TMojDIKobkURBKESPDig4NZcHzp3NJ2+IO2x8lzccvcP+q
	 N6ZEAak1LCKiFpmdwYgMB7d0RtaqM41Mj96guMxRdkoA+lbqfolN7wQtXmV2qD/Bz
	 YLPGev6U9+Ch2IAZhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.65.3] ([213.197.77.179]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7K3i-1s6URC40gG-007lNq; Mon, 03
 Jun 2024 21:48:19 +0200
Message-ID: <ed3c5b1e-795c-48d4-8983-ce1620d10c3d@gmx.com>
Date: Mon, 3 Jun 2024 21:48:18 +0200
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
Content-Language: hu
From: Billes Tibor <tbilles@gmx.com>
In-Reply-To: <CAJZ5v0i2GHh6xYH14G0pX7kBsamEM6eyAKCCj26VxH9aqFthzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iw6MuSoNb5lYmr79HPY9hbKB363J9qDrkaBTHlFaQ0ahOqFUIdl
 fir+Ipm/5On+PvkcM7t14/2U+Na7xqMu9MRF+B5bBWqKPuPbKUX4C/AyedwwWakM58mcqgH
 tJo/f+/JqHFADI/Ng8QxrJgIhdWbZ3d8GTg0VNuNM5aecz9vCPYFguJ2YxTud6Lp8heqo64
 7aB53RVJe460hKBEjbPYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H1RCd4Hq89g=;oueRp1TSijnQZ8xMkTxGK4tebog
 7cnVo3goZfUHRfomdidOKYWKvT/uZqXl0fqvQoRpLarmeES033abnlAf0xTRNaEEnhFisWA8Q
 mQJMGUsJQpoOOeGFAHtMCUbDGXEd8zBQWiQgdpVpW53GQo5DSRuNVqAKW93otjqD7ULjnb1W2
 YrsnnqYkcVUgnjfPUS/TOh/WJ5fhhqGgLzpLtS2Ii+1e8GQ7C7HjWwGTXL+7wMOqmy9Hlo7xc
 rwH1y7aU0j8Go+JZjUkfxHh/5aFYcpguZbh6PaU6V0SRH+wAPdir3KSAybTSdeE7tQn1NX+hn
 u/AZEUyLKj40FjMXpCV5dySqi18X4cMwVfFLaohn3YYaID5D+kdshdEgfC7Voe9iNxICr+ASd
 /T5+1+mB0dN1XULKOnpkvNhdeAfSYI1DcALoO+58Yu67ahwCehrnQJqFPZbA7VpO2hc5BxkPL
 QIme4w24A8l3KL07z/bm6OW66it55sUyDvakzuNGRY/bXHsn385+A0Qs349NDU9YTyhCgCpyS
 rrHaPuKrrmc/d4IqUduSJWWJ+qRR9VNba36L6GIkr1l+Rs3hweDYcn5DgTRGW9/U/1Rri0+hj
 u5gc6lunY+U2qqOjIzTJBBPDib+C6rZz6oxegqGV476JHeb5ggWWdt7Ca0hPsDZ1L6iggdZlB
 30enKIlRvoRi1/GN0W0i+B+iFa45k2O7oqybB9AHfPP95GjagCmksKRLPnSTugMfcw1YTLqAl
 tWgZ4X15zkQ/CjFJuICyrV/OtF31VTMH1VzOCoBfR4KylTtDPBGKu11b4N0j4sPagaZ7TUJiu
 veMYn9d+kkopj65sI088cznU2CrRgsTnIlbf6dlkHPIZ4=

On 6/3/24 19:39, Rafael J. Wysocki wrote:
>Hi,
>
>On Thu, May 30, 2024 at 9:40=E2=80=AFPM Billes Tibor <tbilles@gmx.com> wr=
ote:
>>
>> Hi,
>>
>> I noticed an issue, that with every sleep-wake cycle, the maximum frequ=
ency of
>> the CPU drops further down. For example, my CPU has a maximum (turbo) f=
requency
>> of 3.5 Ghz, on first boot, this is the case. I put the laptop to sleep,=
 wake it
>> up later, and now it reports only 2.1 Ghz as maximum frequency. After t=
he next
>> cycle it reports 1.4 Ghz. A reboot restores the original maximum freque=
ncy.
>>
>> Details:
>> My CPU is an Intel Core i7-4710HQ. On bootup the
>> "grep -H . /sys/devices/system/cpu/cpufreq/policy0/*" command tell me t=
his:
>> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:2000=
0
>> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:con=
servative ondemand userspace powersave performance schedutil
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:900000
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:3500000
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
>>
>> After sleep:
>> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:2000=
0
>> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:con=
servative ondemand userspace powersave performance schedutil
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:904557
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2100000
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
>>
>> Notice the scaling_max_freq file says different frequencies. I tried wr=
iting
>> the scaling_max_freq file, it allows me to lower the maximum available
>> frequency, does not allow to raise back to 3.5 Ghz, it only raises back=
 to
>> 2.1 Ghz (in this case).
>>
>> If I keep repeating this sleep-wake cycle, the scaling_max_freq reaches=
 its
>> minimum at 1.4 Ghz, but the actual available frequency continues to dro=
p, in
>> the following example to around 550 Mhz which is even below scaling_min=
_freq.
>> This was taken under full load, notice the value of scaling_cur_freq:
>>
>> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
>> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:2000=
0
>> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:con=
servative ondemand userspace powersave performance schedutil
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:553861
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1400000
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
>> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
>>
>>
>> I first noticed this when updating my kernel from 6.6.12 to 6.7.1. Sinc=
e then
>> I've been trying to bisecting it, after a few failed attempts I think I=
 came
>> reasonably close, this commit came out as the first bad one:
>>
>> commit 950210887670cbb7d2eb9af6fb743b70f1a1ebdc (refs/bisect/bad)
>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Date:=C2=A0=C2=A0 Tue Sep 19 20:54:37 2023 +0200
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0 thermal: core: Drop trips_disabled bitmask
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0 After recent changes, thermal_zone_get_trip() c=
annot fail, as invoked
>>=C2=A0=C2=A0=C2=A0=C2=A0 from thermal_zone_device_register_with_trips(),=
 so the only role of
>>=C2=A0=C2=A0=C2=A0=C2=A0 the trips_disabled bitmask is struct thermal_zo=
ne_device is to make
>>=C2=A0=C2=A0=C2=A0=C2=A0 handle_thermal_trip() skip trip points whose te=
mperature was initially
>>=C2=A0=C2=A0=C2=A0=C2=A0 zero.=C2=A0 However, since the unit of temperat=
ure in the thermal core is
>>=C2=A0=C2=A0=C2=A0=C2=A0 millicelsius, zero may very well be a valid tem=
perature value at least
>>=C2=A0=C2=A0=C2=A0=C2=A0 in some usage scenarios and the trip temperatur=
e may as well change
>>=C2=A0=C2=A0=C2=A0=C2=A0 later.=C2=A0 Thus there is no reason to permane=
ntly disable trip points
>>=C2=A0=C2=A0=C2=A0=C2=A0 with initial temperature equal to zero.
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0 Accordingly, drop the trips_disabled bitmask al=
ong with the code
>>=C2=A0=C2=A0=C2=A0=C2=A0 related to it.
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Rafael J. Wysocki <rafael.j.wyso=
cki@intel.com>
>>=C2=A0=C2=A0=C2=A0=C2=A0 Tested-by: Ido Schimmel <idosch@nvidia.com>
>>=C2=A0=C2=A0=C2=A0=C2=A0 Acked-by: Daniel Lezcano <daniel.lezcano@linaro=
.org>
>>
>> I also tested a recent stable kernel, 6.9.2 and it is still dropping th=
e maximum
>> frequency after sleep.
>>
>> Can someone help me find the cause of this issue? Is there something I =
can do to
>> help debug this?
>
>It looks like one of the thermal zones on this system has a trip point
>whose temperature is initialized to 0 which used to be disabled before
>the change above and now it is not and it is processed during resume
>from system sleep.
>
>If this is the case, the thermal zone in question needs to be
>identified and its driver adjusted to set the trip point's temperature
>to invalid to start with.
>
>Please send the output of the following two commands from your system:
>
>$ grep '.*' /sys/class/thermal/thermal_zone*/type
>$ grep '.*' /sys/class/thermal/thermal_zone*/trip_point_*
>

Here it is:

/sys/class/thermal/thermal_zone0/type:acpitz
/sys/class/thermal/thermal_zone1/type:x86_pkg_temp

/sys/class/thermal/thermal_zone0/trip_point_0_hyst:0
/sys/class/thermal/thermal_zone0/trip_point_0_temp:127000
/sys/class/thermal/thermal_zone0/trip_point_0_type:critical
/sys/class/thermal/thermal_zone0/trip_point_1_hyst:0
/sys/class/thermal/thermal_zone0/trip_point_1_temp:127000
/sys/class/thermal/thermal_zone0/trip_point_1_type:hot
/sys/class/thermal/thermal_zone0/trip_point_2_hyst:0
/sys/class/thermal/thermal_zone0/trip_point_2_temp:0
/sys/class/thermal/thermal_zone0/trip_point_2_type:passive
/sys/class/thermal/thermal_zone1/trip_point_0_hyst:0
/sys/class/thermal/thermal_zone1/trip_point_0_temp:-274000
/sys/class/thermal/thermal_zone1/trip_point_0_type:passive
/sys/class/thermal/thermal_zone1/trip_point_1_hyst:0
/sys/class/thermal/thermal_zone1/trip_point_1_temp:-274000
/sys/class/thermal/thermal_zone1/trip_point_1_type:passive

So are we looking for thermal_zone0/trip_point_2 from the acpitz driver?


