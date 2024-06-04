Return-Path: <linux-pm+bounces-8573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B28FB303
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 14:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F69283329
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3C14831F;
	Tue,  4 Jun 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXupZSJw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7514831E
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505700; cv=none; b=cRnKHOBdNHPQhmcMuYW3uZKCP13hFd2cf8oDzzk7jyIc9k0f92OvvPUlGavdJEPN6cd5LIMKmlu75mVS0R7799ouL4qr1BE7O+LIUex2kKAHz/xB4Q2/wwY2KzZVRcdMCQ4IxnU6j01rDxUmJr+mCzXtxBCHOsXTb5qqlXNn9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505700; c=relaxed/simple;
	bh=OiuQh70/YUd5XDug/IaAeE03hTuEO/69XY1qcgC57RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfft8ZP4J2Ue8H0vz+UdevPFL2KkC+MObf7A5YV0P0FfEHf+omjBgTh2uHHqnoze94gsHpuzCTG892Ne+YlR2EJwHmGmhzwz/TTsfyqzCztmsDRc0PntplHatfxWb8QcKeQphJrqYYAi2uy9qfOLHgUw+qdfW4SKzC4+hRA4xls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXupZSJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8CCC4AF09
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717505699;
	bh=OiuQh70/YUd5XDug/IaAeE03hTuEO/69XY1qcgC57RA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sXupZSJwUi7DY3tWU+ADft2HWl3+L321sPhxsKTix/XJJt33AtHCgu/gvTtm+AV8P
	 2j1uF6WYjXQFR0qqCdYfMhLTB7YuWnVDuknDnDtys0w1fppe4RDXLzVYvW+1R/2GcJ
	 5R/NVSvqCreUyA9m7rHYyVu2pmXqYedbTq58yoCHL84sTFBdC+8ixYHV1lKymVPXsL
	 8WaVS9nrPNgUzTOOeZ99LIhIITagPXaI/iDMqUGmhbSkhCMaY8QUaJFMsqN+1KdPD8
	 LnaeYzV7XIok8Bj7HmEgXf8QCo9lIUlzNH2y6byEyjTcz07yAWUZ5BTtQMQTQ49r9G
	 Vuc827NWcQdzA==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d1b8bacf67so511000b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 05:54:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI0OI5N1UwHqx5N2l9F+avamwCd/jQZyIjS2SCRsVtBDw6Pg76m9+JKsPLsXTh+qcn0Z8LNk21wWpa5yB7F2AL2AKllH82D7o=
X-Gm-Message-State: AOJu0YyeC4ORLkjyHdQUaU3BE75gk4mI5iIO/ayWd60hBZbVntGAzMlE
	MoX1EiNMDnOTri64rDkIUGUd4fHopWjcBT9icufOuWOdtmA1ExQfjCow7FMLc7Yyy/QAY+Am69a
	3f0A+x08I8HF/srCPjAMTPX6uJxo=
X-Google-Smtp-Source: AGHT+IFHTg7hdRV3SycqSlvBssI0xB6jAc6+4MYNGBOIjGME5ZqpFHNvGU9jzrYKfzqsCshdOtaVCJqF80piXmpfY9w=
X-Received: by 2002:a4a:e20a:0:b0:5b2:f29:93f0 with SMTP id
 006d021491bc7-5ba059614f9mr12774894eaf.0.1717505698655; Tue, 04 Jun 2024
 05:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f71747b-f852-4ee0-b384-cf46b2aefa3f@gmx.com> <CAJZ5v0i2GHh6xYH14G0pX7kBsamEM6eyAKCCj26VxH9aqFthzw@mail.gmail.com>
 <ed3c5b1e-795c-48d4-8983-ce1620d10c3d@gmx.com>
In-Reply-To: <ed3c5b1e-795c-48d4-8983-ce1620d10c3d@gmx.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Jun 2024 14:54:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9DE=MrtJn12d9NJa1gdO7vqtMuatR924_iQu8ar8BQA@mail.gmail.com>
Message-ID: <CAJZ5v0g9DE=MrtJn12d9NJa1gdO7vqtMuatR924_iQu8ar8BQA@mail.gmail.com>
Subject: Re: Bisected regression, maximum frequency drops after sleep
To: Billes Tibor <tbilles@gmx.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org
Content-Type: multipart/mixed; boundary="00000000000011d3b7061a0ff5ba"

--00000000000011d3b7061a0ff5ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 9:48=E2=80=AFPM Billes Tibor <tbilles@gmx.com> wrote=
:
>
> On 6/3/24 19:39, Rafael J. Wysocki wrote:
> >Hi,
> >
> >On Thu, May 30, 2024 at 9:40=E2=80=AFPM Billes Tibor <tbilles@gmx.com> w=
rote:
> >>
> >> Hi,
> >>
> >> I noticed an issue, that with every sleep-wake cycle, the maximum freq=
uency of
> >> the CPU drops further down. For example, my CPU has a maximum (turbo) =
frequency
> >> of 3.5 Ghz, on first boot, this is the case. I put the laptop to sleep=
, wake it
> >> up later, and now it reports only 2.1 Ghz as maximum frequency. After =
the next
> >> cycle it reports 1.4 Ghz. A reboot restores the original maximum frequ=
ency.
> >>
> >> Details:
> >> My CPU is an Intel Core i7-4710HQ. On bootup the
> >> "grep -H . /sys/devices/system/cpu/cpufreq/policy0/*" command tell me =
this:
> >> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> >> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
> >> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
> >> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:200=
00
> >> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:co=
nservative ondemand userspace powersave performance schedutil
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:900000
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:3500000
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> >>
> >> After sleep:
> >> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> >> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
> >> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
> >> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:200=
00
> >> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:co=
nservative ondemand userspace powersave performance schedutil
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:904557
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2100000
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> >>
> >> Notice the scaling_max_freq file says different frequencies. I tried w=
riting
> >> the scaling_max_freq file, it allows me to lower the maximum available
> >> frequency, does not allow to raise back to 3.5 Ghz, it only raises bac=
k to
> >> 2.1 Ghz (in this case).
> >>
> >> If I keep repeating this sleep-wake cycle, the scaling_max_freq reache=
s its
> >> minimum at 1.4 Ghz, but the actual available frequency continues to dr=
op, in
> >> the following example to around 550 Mhz which is even below scaling_mi=
n_freq.
> >> This was taken under full load, notice the value of scaling_cur_freq:
> >>
> >> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
> >> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
> >> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
> >> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:200=
00
> >> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:co=
nservative ondemand userspace powersave performance schedutil
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:553861
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1400000
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
> >> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> >>
> >>
> >> I first noticed this when updating my kernel from 6.6.12 to 6.7.1. Sin=
ce then
> >> I've been trying to bisecting it, after a few failed attempts I think =
I came
> >> reasonably close, this commit came out as the first bad one:
> >>
> >> commit 950210887670cbb7d2eb9af6fb743b70f1a1ebdc (refs/bisect/bad)
> >> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Date:   Tue Sep 19 20:54:37 2023 +0200
> >>
> >>     thermal: core: Drop trips_disabled bitmask
> >>
> >>     After recent changes, thermal_zone_get_trip() cannot fail, as invo=
ked
> >>     from thermal_zone_device_register_with_trips(), so the only role o=
f
> >>     the trips_disabled bitmask is struct thermal_zone_device is to mak=
e
> >>     handle_thermal_trip() skip trip points whose temperature was initi=
ally
> >>     zero.  However, since the unit of temperature in the thermal core =
is
> >>     millicelsius, zero may very well be a valid temperature value at l=
east
> >>     in some usage scenarios and the trip temperature may as well chang=
e
> >>     later.  Thus there is no reason to permanently disable trip points
> >>     with initial temperature equal to zero.
> >>
> >>     Accordingly, drop the trips_disabled bitmask along with the code
> >>     related to it.
> >>
> >>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>     Tested-by: Ido Schimmel <idosch@nvidia.com>
> >>     Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>
> >> I also tested a recent stable kernel, 6.9.2 and it is still dropping t=
he maximum
> >> frequency after sleep.
> >>
> >> Can someone help me find the cause of this issue? Is there something I=
 can do to
> >> help debug this?
> >
> >It looks like one of the thermal zones on this system has a trip point
> >whose temperature is initialized to 0 which used to be disabled before
> >the change above and now it is not and it is processed during resume
> >from system sleep.
> >
> >If this is the case, the thermal zone in question needs to be
> >identified and its driver adjusted to set the trip point's temperature
> >to invalid to start with.
> >
> >Please send the output of the following two commands from your system:
> >
> >$ grep '.*' /sys/class/thermal/thermal_zone*/type
> >$ grep '.*' /sys/class/thermal/thermal_zone*/trip_point_*
> >
>
> Here it is:

Thanks!

> /sys/class/thermal/thermal_zone0/type:acpitz
> /sys/class/thermal/thermal_zone1/type:x86_pkg_temp
>
> /sys/class/thermal/thermal_zone0/trip_point_0_hyst:0
> /sys/class/thermal/thermal_zone0/trip_point_0_temp:127000
> /sys/class/thermal/thermal_zone0/trip_point_0_type:critical
> /sys/class/thermal/thermal_zone0/trip_point_1_hyst:0
> /sys/class/thermal/thermal_zone0/trip_point_1_temp:127000
> /sys/class/thermal/thermal_zone0/trip_point_1_type:hot
> /sys/class/thermal/thermal_zone0/trip_point_2_hyst:0
> /sys/class/thermal/thermal_zone0/trip_point_2_temp:0
> /sys/class/thermal/thermal_zone0/trip_point_2_type:passive
> /sys/class/thermal/thermal_zone1/trip_point_0_hyst:0
> /sys/class/thermal/thermal_zone1/trip_point_0_temp:-274000
> /sys/class/thermal/thermal_zone1/trip_point_0_type:passive
> /sys/class/thermal/thermal_zone1/trip_point_1_hyst:0
> /sys/class/thermal/thermal_zone1/trip_point_1_temp:-274000
> /sys/class/thermal/thermal_zone1/trip_point_1_type:passive
>
> So are we looking for thermal_zone0/trip_point_2 from the acpitz driver?

I think so.

The attached patch should restore the previous behavior of disabling
trip points with 0 temperature in the ACPI thermal zone driver.
Please try it and let me know if it helps.

Thanks!

--00000000000011d3b7061a0ff5ba
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-thermal-temp-conv.patch"
Content-Disposition: attachment; filename="acpi-thermal-temp-conv.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lx0eh5ra0>
X-Attachment-Id: f_lx0eh5ra0

LS0tCiBkcml2ZXJzL2FjcGkvdGhlcm1hbC5jIHwgICAgOCArKysrKysrLQogMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZl
cnMvYWNwaS90aGVybWFsLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL2Fj
cGkvdGhlcm1hbC5jCisrKyBsaW51eC1wbS9kcml2ZXJzL2FjcGkvdGhlcm1hbC5jCkBAIC0xNjgs
MTEgKzE2OCwxNyBAQCBzdGF0aWMgaW50IGFjcGlfdGhlcm1hbF9nZXRfcG9sbGluZ19mcmVxCiAK
IHN0YXRpYyBpbnQgYWNwaV90aGVybWFsX3RlbXAoc3RydWN0IGFjcGlfdGhlcm1hbCAqdHosIGlu
dCB0ZW1wX2RlY2lfaykKIHsKKwlpbnQgdGVtcDsKKwogCWlmICh0ZW1wX2RlY2lfayA9PSBUSEVS
TUFMX1RFTVBfSU5WQUxJRCkKIAkJcmV0dXJuIFRIRVJNQUxfVEVNUF9JTlZBTElEOwogCi0JcmV0
dXJuIGRlY2lfa2VsdmluX3RvX21pbGxpY2Vsc2l1c193aXRoX29mZnNldCh0ZW1wX2RlY2lfaywK
Kwl0ZW1wID0gZGVjaV9rZWx2aW5fdG9fbWlsbGljZWxzaXVzX3dpdGhfb2Zmc2V0KHRlbXBfZGVj
aV9rLAogCQkJCQkJICAgICAgIHR6LT5rZWx2aW5fb2Zmc2V0KTsKKwlpZiAodGVtcCA8PSAwKQor
CQlyZXR1cm4gVEhFUk1BTF9URU1QX0lOVkFMSUQ7CisKKwlyZXR1cm4gdGVtcDsKIH0KIAogc3Rh
dGljIGJvb2wgYWNwaV90aGVybWFsX3RyaXBfdmFsaWQoc3RydWN0IGFjcGlfdGhlcm1hbF90cmlw
ICphY3BpX3RyaXApCg==
--00000000000011d3b7061a0ff5ba--

