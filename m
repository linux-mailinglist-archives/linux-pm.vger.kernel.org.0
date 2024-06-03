Return-Path: <linux-pm+bounces-8533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF28D881A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 19:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6F82848FD
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D198137748;
	Mon,  3 Jun 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn/afc5o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E012EBE9
	for <linux-pm@vger.kernel.org>; Mon,  3 Jun 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436392; cv=none; b=s+bub3iAluc+Lgmqyrpx48zq0p/nxfkeIY/eM8d8JJIcDSltScJPIOtkicqAw2uUDix8GQVnji0XnjCI3bG22eRIGBt21ST5dhMXmQavWupnIzTzjEZrpPZUu0V4TTwYWWaR11Xm58Yq7q87Yy0daewofw+x5bvayTh4WUMj+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436392; c=relaxed/simple;
	bh=FvlMxv0T/LBnYjqL54nk2EuJ+zFycq5NUOh/EHY0N5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq/BFV2jochg0NRPv8V4Lk+L9nyghfdhrox86LiUNXqRFvo06cLCm1roJvur0h6QisFIL1tKrh/rgDejX1zPKU/0WFoJFzCzTQ5d38vu2VKe6xt0IrxGlLlYXxXf+jw0y7hpaC+TpWbRXu0o60XtnTl53SDlKZy5kbF1AIl/oVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn/afc5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8805C2BD10
	for <linux-pm@vger.kernel.org>; Mon,  3 Jun 2024 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717436391;
	bh=FvlMxv0T/LBnYjqL54nk2EuJ+zFycq5NUOh/EHY0N5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gn/afc5owtsF2DJZPZ+sZz32KnL9d11T07tMsrsD9jhxUMbqsp+uBKpMh2Hk8GcHa
	 4GKRQWKAIY2NmK/KPOhVK8UnAzPPnCiw2AWb4RaOVsQWmQy3mKABddGeb5XBeF6Lbe
	 bHLwHDItFOYPXotNI37HHktW1Y/e4AbvDRvLoEo9VUMhwQw64085bIKInhNxl5tltx
	 NO6RXRTBE9nXg0roCZ8RkK05I0tL18XiZGMsJ0bFsvx2o/wASUJ5h2b0xZIrljnve5
	 bMUqXZRNIMX9uIOU6StLRhl2cSc0lIuklfkpKfZdgBzR1EPl97H23To2uKYVj8RByR
	 8xuK/rPMrGZrQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b99ba97d89so438565eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2024 10:39:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcpCzPOlXZmGcDMFeUbAw4vk+TNrHkIfgyw5zfBuadbJuSRm554rcMrodH+jQggtjK0Nt08sOGTTyP0VvJGBwAOKJ5VFcSsNk=
X-Gm-Message-State: AOJu0Yy5S0TCoCCW2XwUbNk17b9Br3oY8b7WUXzqQfUx5ltTPKoItH0b
	KlE7whfrQK1rcKDvKbSaHgf4IIBPN6ljnfpzK+PZRHsa0oPVFSZ5k8JacKsPca3UQQv0A02LXV5
	cD+9MMmnHAZUxJIGFOhhHZiWKgjI=
X-Google-Smtp-Source: AGHT+IGayJoPYxqAZ84PFMYp7FcW9iF8VmPyrILvv9KozQhd084EFLirjoKAXf95/uXi1pmo/womXUbS5O8/DmZE5oM=
X-Received: by 2002:a05:6870:36d5:b0:24f:ee85:2c9e with SMTP id
 586e51a60fabf-2508bde6735mr11537572fac.5.1717436390900; Mon, 03 Jun 2024
 10:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f71747b-f852-4ee0-b384-cf46b2aefa3f@gmx.com>
In-Reply-To: <3f71747b-f852-4ee0-b384-cf46b2aefa3f@gmx.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Jun 2024 19:39:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2GHh6xYH14G0pX7kBsamEM6eyAKCCj26VxH9aqFthzw@mail.gmail.com>
Message-ID: <CAJZ5v0i2GHh6xYH14G0pX7kBsamEM6eyAKCCj26VxH9aqFthzw@mail.gmail.com>
Subject: Re: Bisected regression, maximum frequency drops after sleep
To: Billes Tibor <tbilles@gmx.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 30, 2024 at 9:40=E2=80=AFPM Billes Tibor <tbilles@gmx.com> wrot=
e:
>
> Hi,
>
> I noticed an issue, that with every sleep-wake cycle, the maximum frequen=
cy of
> the CPU drops further down. For example, my CPU has a maximum (turbo) fre=
quency
> of 3.5 Ghz, on first boot, this is the case. I put the laptop to sleep, w=
ake it
> up later, and now it reports only 2.1 Ghz as maximum frequency. After the=
 next
> cycle it reports 1.4 Ghz. A reboot restores the original maximum frequenc=
y.
>
> Details:
> My CPU is an Intel Core i7-4710HQ. On bootup the
> "grep -H . /sys/devices/system/cpu/cpufreq/policy0/*" command tell me thi=
s:
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conse=
rvative ondemand userspace powersave performance schedutil
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:900000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:3500000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
>
> After sleep:
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conse=
rvative ondemand userspace powersave performance schedutil
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:904557
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2100000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
>
> Notice the scaling_max_freq file says different frequencies. I tried writ=
ing
> the scaling_max_freq file, it allows me to lower the maximum available
> frequency, does not allow to raise back to 3.5 Ghz, it only raises back t=
o
> 2.1 Ghz (in this case).
>
> If I keep repeating this sleep-wake cycle, the scaling_max_freq reaches i=
ts
> minimum at 1.4 Ghz, but the actual available frequency continues to drop,=
 in
> the following example to around 550 Mhz which is even below scaling_min_f=
req.
> This was taken under full load, notice the value of scaling_cur_freq:
>
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conse=
rvative ondemand userspace powersave performance schedutil
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:553861
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1400000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
>
>
> I first noticed this when updating my kernel from 6.6.12 to 6.7.1. Since =
then
> I've been trying to bisecting it, after a few failed attempts I think I c=
ame
> reasonably close, this commit came out as the first bad one:
>
> commit 950210887670cbb7d2eb9af6fb743b70f1a1ebdc (refs/bisect/bad)
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Tue Sep 19 20:54:37 2023 +0200
>
>     thermal: core: Drop trips_disabled bitmask
>
>     After recent changes, thermal_zone_get_trip() cannot fail, as invoked
>     from thermal_zone_device_register_with_trips(), so the only role of
>     the trips_disabled bitmask is struct thermal_zone_device is to make
>     handle_thermal_trip() skip trip points whose temperature was initiall=
y
>     zero.  However, since the unit of temperature in the thermal core is
>     millicelsius, zero may very well be a valid temperature value at leas=
t
>     in some usage scenarios and the trip temperature may as well change
>     later.  Thus there is no reason to permanently disable trip points
>     with initial temperature equal to zero.
>
>     Accordingly, drop the trips_disabled bitmask along with the code
>     related to it.
>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Tested-by: Ido Schimmel <idosch@nvidia.com>
>     Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> I also tested a recent stable kernel, 6.9.2 and it is still dropping the =
maximum
> frequency after sleep.
>
> Can someone help me find the cause of this issue? Is there something I ca=
n do to
> help debug this?

It looks like one of the thermal zones on this system has a trip point
whose temperature is initialized to 0 which used to be disabled before
the change above and now it is not and it is processed during resume
from system sleep.

If this is the case, the thermal zone in question needs to be
identified and its driver adjusted to set the trip point's temperature
to invalid to start with.

Please send the output of the following two commands from your system:

$ grep '.*' /sys/class/thermal/thermal_zone*/type
$ grep '.*' /sys/class/thermal/thermal_zone*/trip_point_*

