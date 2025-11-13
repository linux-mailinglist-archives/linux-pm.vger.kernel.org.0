Return-Path: <linux-pm+bounces-37942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F51EC571A5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CAC634C048
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965683346BA;
	Thu, 13 Nov 2025 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs4L0cWg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1A1FF7B3
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031866; cv=none; b=bWmbGgkGG4IHrKgglu2PZQ7h8AXgejbr3how2tvMWWu7B0f4ll9O0ibblzkWM7yosiI2GHKCqn89tGAWX7gyKtXfh/tzvDVDZTITj1q9XEA65nq6+idnsqjOrJNCjallMTplz2uGd33gUd4u8sDbVxo83TOdwL+1q5jx0TIyffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031866; c=relaxed/simple;
	bh=SEc1U/IsU8n/IpLp6bGxD1QXscyC1CjSPywxkyanvdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOXg69S/L1z7mtOkucGe3FSWGI+gommZXDO6rmYf+VUBQRanyuD6WDDqH83A0BIyUPMKbjONrel6hxohJ3ZKOlOKqWrFhQGpPtcPtMZuTtewn9ZeAZk7iNDApTsIKvHA/gwOfQ9SyQJYe6HwwCwJRxLt5eClymWoDdl3uz/XbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs4L0cWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51747C4AF0B
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031866;
	bh=SEc1U/IsU8n/IpLp6bGxD1QXscyC1CjSPywxkyanvdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fs4L0cWg/qobFFx1P3/JEU0OEml0cjLkBqtwuEANjZGtd7UtN6XhWd5oyQC3UoWSS
	 rtumyAStMeJCVsg0dpZy+FqqqaxLo6N+YcKQFPmmzZKPyGODU6re/1KHbmT/EDM3Jf
	 3Fu95XlYt+7+wnfLpIhX4ctopMSzzgirA8cXOGWXGRxtXvVBe/rDKkPoT6qnazT74K
	 PpzBhBaidRlVpXLEWhVnNTp627/HOHM9LgBxKBpuO/nIty5V3m6bAccgbXRGq+NL4j
	 7nInEX83aoJIIixU0eYHLR+VcLx3HKuTHVp74CWfMyhEaW7mfK97bJ9xDvMd8ojBUX
	 bu5aC+/y7OMrw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-656b1f906e4so274523eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 03:04:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkLREh7D8r0LPTlhHEyILyPeoUe56o0OoZ+fJuGhxDb6QEHH/twsBX+onH3L2RVpd+YGWtdxV+Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxafFXNLgvUsa8WO0pbg0o6690aYRpUET1FNarau4dl99qYT7
	+waiq53NUaHuD4CuSkVIJkTsh7wInAWZ+Sgxu+24QnQnabuZ22IwJnm25/WwxF3hdLZxEVJ5FaL
	fFogiVJk8J8cpqproFBwbqJJvOKZPNiE=
X-Google-Smtp-Source: AGHT+IF2ULWHUJGEWlRG50n+yg7mnDekrYpftDO7lfwZMtO0rXsv5PQZbv1PiolBljsVlXo2mP61/qQo/N/qC+El+KM=
X-Received: by 2002:a05:6820:178e:b0:656:8548:d866 with SMTP id
 006d021491bc7-657161c211cmr3013911eaf.1.1763031865608; Thu, 13 Nov 2025
 03:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113014116.196638-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20251113014116.196638-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 12:04:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gPTKDYpze-ejhA3ySJB0dHXQQ4uZfXQFed=PrsWh=aqw@mail.gmail.com>
X-Gm-Features: AWmQ_bmsvWz8HwvP8E4sLNGMPsFBoo72dIfDUG-30i-CSGH6IP8wMWKhQ1kqPGQ
Message-ID: <CAJZ5v0gPTKDYpze-ejhA3ySJB0dHXQQ4uZfXQFed=PrsWh=aqw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: thermal: Add documentation for thermal throttle
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, corbet@lwn.net, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:41=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add documentation for Intel thermal throttling reporting events.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/admin-guide/thermal/index.rst   |  1 +
>  .../admin-guide/thermal/thermal_throttle.rst  | 84 +++++++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/admin-guide/thermal/thermal_throttle.rs=
t
>
> diff --git a/Documentation/admin-guide/thermal/index.rst b/Documentation/=
admin-guide/thermal/index.rst
> index 193b7b01a87d..2e0cafd19f6b 100644
> --- a/Documentation/admin-guide/thermal/index.rst
> +++ b/Documentation/admin-guide/thermal/index.rst
> @@ -6,3 +6,4 @@ Thermal Subsystem
>     :maxdepth: 1
>
>     intel_powerclamp
> +   thermal_throttle
> diff --git a/Documentation/admin-guide/thermal/thermal_throttle.rst b/Doc=
umentation/admin-guide/thermal/thermal_throttle.rst
> new file mode 100644
> index 000000000000..ab146ffdffca
> --- /dev/null
> +++ b/Documentation/admin-guide/thermal/thermal_throttle.rst
> @@ -0,0 +1,84 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Intel thermal throttle events reporting
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> +
> +Introduction
> +------------
> +
> +Intel processors have built in automatic and adaptive thermal monitoring=
 mechanisms
> +that force the processor to reduce its power consumption in order to ope=
rate within
> +predetermined temperature limits.
> +
> +Refer to section "THERMAL MONITORING AND PROTECTION" in the "Intel=C2=AE=
 64 and IA-32
> +Architectures Software Developer=E2=80=99s Manual Volume 3 (3A, 3B, 3C, =
& 3D): System
> +Programming Guide" for more details.
> +
> +In general, there are two mechanisms to control the core temperature of =
the processor.
> +They are called "Thermal Monitor 1 (TM1) and Thermal Monitor 2 (TM2)".
> +
> +The status of the temperature sensor that triggers the thermal monitor (=
TM1/TM2) is
> +indicated through the "thermal status flag" and "thermal status log flag=
" in the
> +IA32_THERM_STATUS MSR for core level and IA32_PACKAGE_THERM_STATUS for p=
ackage level.

I would use the MSR names from the code, that is MSR_IA32_THERM_STATUS
and MSR_IA32_PACKAGE_THERM_STATUS, respectively, here and below.

> +
> +Thermal Status flag, bit 0 =E2=80=94 When set, indicates that the proces=
sor core temperature
> +is currently at the trip temperature of the thermal monitor and that the=
 processor power
> +consumption is being reduced via either TM1 or TM2, depending on which i=
s enabled. When
> +clear, the flag indicates that the core temperature is below the thermal=
 monitor trip
> +temperature. This flag is read only.
> +
> +Thermal Status Log flag, bit 1 =E2=80=94 When set, indicates that the th=
ermal sensor has tripped
> +since the last power-up or reset or since the last time that software cl=
eared this flag.
> +This flag is a sticky bit; once set it remains set until cleared by soft=
ware or until a
> +power-up or reset of the processor. The default state is clear.
> +
> +It is possible that when user reads IA32_THERM_STATUS or IA32_PACKAGE_TH=
ERM_STATUS,
> +TM1/TM2 is not active. In this case, "Thermal Status flag" will read "0"=
 and the
> +"Thermal Status Log flag" will be set to show any previous "TM1/TM2" act=
ivation. But
> +since it needs to be cleared by software, it can't show the number of oc=
currences of
> +"TM1/TM2" activations.
> +
> +Hence, Linux provides counters of how many times the "Thermal Status fla=
g" was set. Also
> +presents how long the "Thermal Status flag" was active in milliseconds. =
Using these counters,
> +users can check if the performance was limited because of thermal events=
. It is recommended
> +to read from sysfs instead of directly reading MSRs as the "Thermal Stat=
us Log flag" is reset
> +by the driver to implement rate control.
> +
> +Sysfs Interface
> +---------------
> +
> +Thermal throttling events are presented for each CPU under
> +"/sys/devices/system/cpu/cpuX/thermal_throttle/", where "X" is the CPU n=
umber.
> +
> +All these counters are read-only. They can't be reset to 0. So, they can=
 potentially
> +overflow after reaching the maximum 64 bit unsigned integer.
> +
> +``core_throttle_count``
> +       This shows how many times "Thermal Status flag" changed from 0 to=
 1
> +       for this CPU. This is a 64 bit counter.

I would say "Number of times "Thermal Status flag" has changed from 0
to 1 since ...."

> +
> +``package_throttle_count``
> +       This shows how many times "Thermal Status flag" changed from 0 to=
 1
> +       for this package. Package status is broadcast to all CPUs; all CP=
Us in
> +       the package increment this count. This is a 64-bit counter.

I would say "Number of times "Thermal Status flag" has changed from 0
to 1 for the package containing this CPU since ..."

> +
> +``core_throttle_max_time_ms``
> +       This shows the maximum amount of time "Thermal Status flag" was s=
et to 1
> +       for this CPU for core level flag.

I would say "Maximum amount of time for which "Thermal Status flag"
has been set to 1 for this CPU at the core level since ...".

And analogously below.

> +
> +``package_throttle_max_time_ms``
> +       This shows the maximum amount of time "Thermal Status flag" was s=
et to 1
> +       for this CPU for package level flag.
> +
> +``core_throttle_total_time_ms``
> +       This shows the cumulative time "Thermal Status flag" was set to 1=
 for this
> +       CPU for core level flag.
> +
> +``package_throttle_total_time_ms``
> +       This shows the cumulative time "Thermal Status flag" was set to 1=
 for this
> +       CPU for package level flag.
> +
> --

