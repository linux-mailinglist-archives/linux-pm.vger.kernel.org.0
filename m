Return-Path: <linux-pm+bounces-8433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779298D526E
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 21:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19E51F24D63
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62540158877;
	Thu, 30 May 2024 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=tbilles@gmx.com header.b="kbspQmX4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7C12E6D
	for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098004; cv=none; b=NKF5bRJBUkA4zQ4rYhB8iaaIr0c2yhReo3zlaWyG6isyT1EQ6F9aKbI4Efb287rqUStvSA8i9iaDrYT3MXsupxkz0IIYNWlebGrk9taxvjlq26hJ4WeSc27EEficurnjtv1O2e62ulFoeet85nrMFrcP4OGQcjkHUJQdx2ByR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098004; c=relaxed/simple;
	bh=T6RZshGb9Lgr+8tu9xoUI4hsGaK9vFjMAODJB9W5YDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Y7SwaH2A8fDm8nuEBQyZF6kk3oiWwDxCL1lGrnh0cC4I6YB8YPebQxItAkXblASmo0u2Ri+k2rtRxtf4R5mjirgYw2+BeFKedtpP+g43UXz9U63XK4xFvCagsWakG42Z0BYGNjs1E+V0OxU7SMKceHV6rBi2w9Y2AgSUV8S9lpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=tbilles@gmx.com header.b=kbspQmX4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717097994; x=1717702794; i=tbilles@gmx.com;
	bh=T6RZshGb9Lgr+8tu9xoUI4hsGaK9vFjMAODJB9W5YDc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kbspQmX4n+Gixhe7MnQjbzBtpgxHa8sB2jjpIrtHreiAGJkUz9c9RsAqtIsgAAAJ
	 ly+tdh3GLxAKySc0T9Yn4FCA0IIV1ozRQOACVmuJiqJ/Br7OBW8vWNZVFo+G9sYrR
	 hNJtayTl2Y56JnoDOA56s+5+fmwcCDlpmDqSPnotipXsah7GTtb0JHYseFqeOAFZo
	 GtyQUyu1pNwcreBL8aRLoTgIN0Oyz7XGMl+poVrjQ584QMsgYwjRCnedM2/J2Ql+3
	 zwdaSLeA6WZet/u+oq80xz8ePpfdsftbZ9G3hyVa/W7OpRaI8MOeGmGl7btuMwpZO
	 SuPa3/zBFvBY4sgOow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.65.3] ([87.97.88.79]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhnN-1sQ1IB32af-00yk3m; Thu, 30
 May 2024 21:39:54 +0200
Message-ID: <3f71747b-f852-4ee0-b384-cf46b2aefa3f@gmx.com>
Date: Thu, 30 May 2024 21:39:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Billes Tibor <tbilles@gmx.com>
Subject: Bisected regression, maximum frequency drops after sleep
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z0wusFvLbNEjld2tXDKHAgx5itPufqHIxZpLCOYwJ66ErtTI4G6
 Jxy/EzAJcsgKR4b+Z+o2zIx6Ox/YAOe18kCNeEQEvNksXjA9w4BHeFbUCDd/y5xbwJMEipg
 sxBPUWZbcdVcSNiSS5XXBC6JKrVMgVIm0zBvc1vExnzc26/IvT9K5NAt8Yumt9K2br71HCj
 6Lgmah/Djoa3dqNs3DV2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:edsXomF+/bQ=;sukcwij+pwvaToao2fMPnfH/z21
 dZ0Ozbx+ZxaiSpMAuh2Ot4Z5qMOOQgMIJLcKxlDUJdZZyWvjufSo97JgRquss8yD7LPZaQrLB
 ltMR7Z0fTMrURAoQpln4tuSjgsa6+Njmqv0BLCmw7lEq9HBFkSXJ+Rt9eRE//qeWdpIbRB3te
 zWN0XlT3vpGd6Sx6ImCUWxNs01c2W9MODfAOZsWLZ+y+3vpgcqyljAqUgaTB+REjad0s+Mrq0
 WGZeOZL1tjtUrOpizdMGbLX7J97HZcEMAgpPP46UrrEqKWQeDo0po8wyHay1tkbW0fhXNRhNM
 ewwTnyrOxKC/QQVYjG4rzhJWm5oAtuHPdsCt8dedoI/I9xAj9HtUJ3wA4sQVSqjSrA+U4B31m
 ui9eEcHwcdzhMWUAogQPKJkQXtf0tRE0fWQrwqqLQ13U6YPlGeaYeyhjekuw5qWLP2Tg2Y0C0
 xUOX12MvH3/ZCe3an6HLHYzJvLE2pcPUHCBAiakXmmm9PnmG8AfaBV5EtL8wW7bfnNuMA7Wp6
 OSjLowXEZf0hXIOsj4vjiTqwrFvd80YX80q7ayYDiRYs1gpzFYbRQ4uwSrhNDdUIq/s4oe2px
 OHGM7o88qsjsV1KJq93uum+7pL5lzSms+5Nsl8qMdCscM0P08b7T9FTwqqRL0i1W7JqTcu3hP
 TzY/SnE66DeMbW4dRcZmSO2U8Q/x5lClf9YGPDBjYbk/OKR++NQ4D7eDdwZJX6ts9BDMJiSw/
 /yRjrscY7+Gt/nlqfn/uJazmxgxiP0sNYbzonarGMmSIcEvJqU4Hli9not0qfGubA0oXhSkcM
 NjnbTn8NJSSrS3R2IuZoTvqz148Qk49gI69uAvNYDA3dU=

Hi,

I noticed an issue, that with every sleep-wake cycle, the maximum frequenc=
y of
the CPU drops further down. For example, my CPU has a maximum (turbo) freq=
uency
of 3.5 Ghz, on first boot, this is the case. I put the laptop to sleep, wa=
ke it
up later, and now it reports only 2.1 Ghz as maximum frequency. After the =
next
cycle it reports 1.4 Ghz. A reboot restores the original maximum frequency=
.

Details:
My CPU is an Intel Core i7-4710HQ. On bootup the
"grep -H . /sys/devices/system/cpu/cpufreq/policy0/*" command tell me this=
:
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conser=
vative ondemand userspace powersave performance schedutil
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:900000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:3500000
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>

After sleep:
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conser=
vative ondemand userspace powersave performance schedutil
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:904557
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2100000
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>

Notice the scaling_max_freq file says different frequencies. I tried writi=
ng
the scaling_max_freq file, it allows me to lower the maximum available
frequency, does not allow to raise back to 3.5 Ghz, it only raises back to
2.1 Ghz (in this case).

If I keep repeating this sleep-wake cycle, the scaling_max_freq reaches it=
s
minimum at 1.4 Ghz, but the actual available frequency continues to drop, =
in
the following example to around 550 Mhz which is even below scaling_min_fr=
eq.
This was taken under full load, notice the value of scaling_cur_freq:

/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3500000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:800000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:conser=
vative ondemand userspace powersave performance schedutil
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:553861
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1400000
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:800000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>


I first noticed this when updating my kernel from 6.6.12 to 6.7.1. Since t=
hen
I've been trying to bisecting it, after a few failed attempts I think I ca=
me
reasonably close, this commit came out as the first bad one:

commit 950210887670cbb7d2eb9af6fb743b70f1a1ebdc (refs/bisect/bad)
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:=C2=A0=C2=A0 Tue Sep 19 20:54:37 2023 +0200

=C2=A0=C2=A0=C2=A0 thermal: core: Drop trips_disabled bitmask
=C2=A0=C2=A0 =C2=A0
=C2=A0=C2=A0=C2=A0 After recent changes, thermal_zone_get_trip() cannot fa=
il, as invoked
=C2=A0=C2=A0=C2=A0 from thermal_zone_device_register_with_trips(), so the =
only role of
=C2=A0=C2=A0=C2=A0 the trips_disabled bitmask is struct thermal_zone_devic=
e is to make
=C2=A0=C2=A0=C2=A0 handle_thermal_trip() skip trip points whose temperatur=
e was initially
=C2=A0=C2=A0=C2=A0 zero.=C2=A0 However, since the unit of temperature in t=
he thermal core is
=C2=A0=C2=A0=C2=A0 millicelsius, zero may very well be a valid temperature=
 value at least
=C2=A0=C2=A0=C2=A0 in some usage scenarios and the trip temperature may as=
 well change
=C2=A0=C2=A0=C2=A0 later.=C2=A0 Thus there is no reason to permanently dis=
able trip points
=C2=A0=C2=A0=C2=A0 with initial temperature equal to zero.
=C2=A0=C2=A0 =C2=A0
=C2=A0=C2=A0=C2=A0 Accordingly, drop the trips_disabled bitmask along with=
 the code
=C2=A0=C2=A0=C2=A0 related to it.
=C2=A0=C2=A0 =C2=A0
=C2=A0=C2=A0=C2=A0 Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@inte=
l.com>
=C2=A0=C2=A0=C2=A0 Tested-by: Ido Schimmel <idosch@nvidia.com>
=C2=A0=C2=A0=C2=A0 Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I also tested a recent stable kernel, 6.9.2 and it is still dropping the m=
aximum
frequency after sleep.

Can someone help me find the cause of this issue? Is there something I can=
 do to
help debug this?

Thanks in advance,
Tibor

