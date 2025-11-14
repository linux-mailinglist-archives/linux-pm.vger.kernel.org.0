Return-Path: <linux-pm+bounces-38054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78AC5E54F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B204A4E2D80
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA791326D4A;
	Fri, 14 Nov 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/iCa4sS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629D2BCF41
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137633; cv=none; b=ajZf+mMQ+LNOzNF3DnnyYaMhSsP2LUyQLL40H/4BcTd2BADtB2OdqPPDgPT+4bIqL6/MTZuh1+RDodQlSFaRCmdwOAXlXUc2zSwio1yLXoHM5Av0hTFRH2hRhNuIThsYdyQ8767+QzUyeKfV9b6T2lDLJg0glCI5lwaq8kMk7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137633; c=relaxed/simple;
	bh=GH0x1p5xQyW0d5CtSpWUCrlFzhBbM9mKdVBB/jmQ7ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t95jWm21MuvoPO0v3VgqH9+JXDnYscMH1TB940UVLnBiTAFFBN/ZUCvjbrAWDd1wjnMq+IsDXuJMPyilwOGyJZJtnpstCop9jSC3uxrPmAb55ke7CjjpVIPfFmpTz9ILULHlHIzed7/soEn8EAmf/GAkYHUefw73uRdnaXUDTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/iCa4sS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C829C4AF09
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763137633;
	bh=GH0x1p5xQyW0d5CtSpWUCrlFzhBbM9mKdVBB/jmQ7ZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W/iCa4sSefsnzYgDqAOMmtLp12chNMXh3kIKB4IdEj/E7SY0Ozkbp++ti7ze3ql/d
	 biX8g0SmPqXbewbGOKWJDzkl/J9zFpO+Q1hdTPKg/4vMiUplSAaICqEjBcdF0I+q4S
	 wsVZRH5ZTJG8ypX1L/63t3X/MRTBAhF0/+4F/nZiOWhYpX3xmVYGdS/9GBpCpBfl0s
	 TpZebRHWuaHlQlsNXmpHl4xzxLizNQ7umbxbYs/2BSFd+SwvdZW46SVeaZfujPYCEQ
	 fW3+GO/SOFuEpzbaRPE7UleNhH/y02wnU1D+zOJC1qoAPdfyycQQ/cUmJmQOZVBw7T
	 s2lQBlkUp8j3Q==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45066bee74aso471832b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 08:27:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjN3NkL/Q3dxO6GJ3RQWUyr0NFwLONChvUFhTXE+ibzgyVeTjchnbA6zT2qsh2F5WFBu8c0fYs/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl/r2uZjVGEDcwg3bgQktS33zYhcsEP7NfnC4yQ+EH2yz/x9O
	u5cD3XKmQ9xAyGMagVwfsGN2gFVuoyz/QUB1htPPb6MrGfJGIcS6X1b/3Z/SSRvV4kDVwV1Wdve
	bwTxRu6RYasVDTyBwezw0kkep92TV2K8=
X-Google-Smtp-Source: AGHT+IFomwgz7FSOBRIAN3QEslw7mBsPmy1XN6i1/0rZfmHILpSWXrnEJRQjqLnYKsVCv0YrEcv43cb8VbaQsFB2NQc=
X-Received: by 2002:a05:6808:1a26:b0:44d:be59:27ea with SMTP id
 5614622812f47-450973f7945mr1654809b6e.17.1763137632619; Fri, 14 Nov 2025
 08:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113212104.221632-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20251113212104.221632-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 17:27:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i7fb58CUGwcPcbEXTqDeM5Hm7rRHVvgcr-W4ut8091gQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnDeEUlhuDdh6zmgjmWSGiGo8jiVXUZ75D8dvWMn9q_dFVXWM268RX16c4
Message-ID: <CAJZ5v0i7fb58CUGwcPcbEXTqDeM5Hm7rRHVvgcr-W4ut8091gQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: thermal: Add documentation for thermal throttle
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, corbet@lwn.net, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:21=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add documentation for Intel thermal throttling reporting events.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
>  - Addressed comments from Rafael
>  - Limit line lengths ~80 columns
>
>  Documentation/admin-guide/thermal/index.rst   |  1 +
>  .../admin-guide/thermal/thermal_throttle.rst  | 92 +++++++++++++++++++
>  2 files changed, 93 insertions(+)
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
> index 000000000000..cac2bc3176ce
> --- /dev/null
> +++ b/Documentation/admin-guide/thermal/thermal_throttle.rst
> @@ -0,0 +1,92 @@
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
> +Intel processors have built in automatic and adaptive thermal monitoring
> +mechanisms that force the processor to reduce its power consumption in o=
rder
> +to operate within predetermined temperature limits.
> +
> +Refer to section "THERMAL MONITORING AND PROTECTION" in the "Intel=C2=AE=
 64 and
> +IA-32 Architectures Software Developer=E2=80=99s Manual Volume 3 (3A, 3B=
, 3C, & 3D):
> +System Programming Guide" for more details.
> +
> +In general, there are two mechanisms to control the core temperature of =
the
> +processor. They are called "Thermal Monitor 1 (TM1) and Thermal Monitor =
2 (TM2)".
> +
> +The status of the temperature sensor that triggers the thermal monitor (=
TM1/TM2)
> +is indicated through the "thermal status flag" and "thermal status log f=
lag" in
> +the MSR_IA32_THERM_STATUS for core level and MSR_IA32_PACKAGE_THERM_STAT=
US for
> +package level.
> +
> +Thermal Status flag, bit 0 =E2=80=94 When set, indicates that the proces=
sor core
> +temperature is currently at the trip temperature of the thermal monitor =
and that
> +the processor power consumption is being reduced via either TM1 or TM2, =
depending
> +on which is enabled. When clear, the flag indicates that the core temper=
ature is
> +below the thermal monitor trip temperature. This flag is read only.
> +
> +Thermal Status Log flag, bit 1 =E2=80=94 When set, indicates that the th=
ermal sensor has
> +tripped since the last power-up or reset or since the last time that sof=
tware
> +cleared this flag. This flag is a sticky bit; once set it remains set un=
til
> +cleared by software or until a power-up or reset of the processor. The d=
efault
> +state is clear.
> +
> +It is possible that when user reads MSR_IA32_THERM_STATUS or
> +MSR_IA32_PACKAGE_THERM_STATUS, TM1/TM2 is not active. In this case,
> +"Thermal Status flag" will read "0" and the "Thermal Status Log flag" wi=
ll be set
> +to show any previous "TM1/TM2" activation. But since it needs to be clea=
red by
> +the software, it can't show the number of occurrences of "TM1/TM2" activ=
ations.
> +
> +Hence, Linux provides counters of how many times the "Thermal Status fla=
g" was
> +set. Also presents how long the "Thermal Status flag" was active in mill=
iseconds.
> +Using these counters, users can check if the performance was limited bec=
ause of
> +thermal events. It is recommended to read from sysfs instead of directly=
 reading
> +MSRs as the "Thermal Status Log flag" is reset by the driver to implemen=
t rate
> +control.
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
> +       This shows number of times "Thermal Status flag" changed from 0 t=
o 1 for this
> +       CPU since OS boot and thermal vector is initialized. This is a 64=
 bit counter.
> +
> +``package_throttle_count``
> +       This shows number of times "Thermal Status flag" changed from 0 t=
o 1 for the
> +       package containing this CPU since OS boot and thermal vector is i=
nitialized.
> +       Package status is broadcast to all CPUs; all CPUs in the package =
increment
> +       this count. This is a 64-bit counter.
> +
> +``core_throttle_max_time_ms``
> +       This shows the maximum amount of time for which "Thermal Status f=
lag"
> +       has been set to 1 for this CPU at the core level since OS boot an=
d thermal
> +       vector is initialized.
> +
> +``package_throttle_max_time_ms``
> +       This shows the maximum amount of time for which "Thermal Status f=
lag"
> +       has been set to 1 for the package containing this CPU since OS bo=
ot and
> +       thermal vector is initialized.
> +
> +``core_throttle_total_time_ms``
> +       This shows the cumulative time for which "Thermal Status flag" ha=
s been
> +       set to 1 for this CPU for core level since OS boot and thermal ve=
ctor
> +       is initialized.
> +
> +``package_throttle_total_time_ms``
> +       This shows the cumulative time for which "Thermal Status flag" ha=
s been set
> +       to 1 for the package containing this CPU since OS boot and therma=
l vector is
> +       initialized.
> +
> --

Applied as 6.19 material with some adjustments:
- The new file name is intel_thermal_throttle.rst
- The subject has been edited to mention Intel
- There are some minor edits in the document

Please check in the bleeding-edge branch if it still looks good.

Thanks!

