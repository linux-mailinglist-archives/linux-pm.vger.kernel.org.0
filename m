Return-Path: <linux-pm+bounces-25540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F578A8B788
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 13:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238D53BFE86
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F87E22D785;
	Wed, 16 Apr 2025 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlvqvbNl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502BA14F9D9
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744802420; cv=none; b=Xjpx3185QlhWTlzndeljbgX4lyMKvGca8P8Bqv2ihnLqPjIz1c3hQUoI8iEhGFK9KJ4tlLD4JApoZXgC80o02aRIEX97/GPE7WzxjTgIzYXVf4MkomqqaK5IlP+oXZIDuIEcVe5GkkGXsisXFvK7GHubMWyfKTIm8YXV10QHJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744802420; c=relaxed/simple;
	bh=4XgOlEIzNO2AM7vIJI6U/s1ivXfrl9U7KAS2noVwbdg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5ielk19aVg7C/DfXiZ4X1r05DzHykojGzkgX4+FslnwdF/NaoTGc++Pv93xInEVdD1BSnufe9AhqZ7bZe56ZC4QTKAmP009I4rrc89R103zwZyfETqqEO1mWyLydz2dfJFvZ17F42mO0eCyua0EjpFyxKZaU+/jaR/MQ8IxQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlvqvbNl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac29fd22163so1063601166b.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744802416; x=1745407216; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tdQXvPCbiDgoqxYNwyAMCDatea8mQL3oATakNHMA+I=;
        b=IlvqvbNlY7byYN77Mw5qsv6liuV+W8rJRd0i5nL/K8I7AzNL+3OzI6CnjARbIQmS8a
         5qoZrqxc8gxSkhKQ14UqGeRKxResVMVyeAo0ETaY6Rd7VftXPUx0lkXHDf41kbd++Lol
         gKijWDUamo4vdwKDPnnotwtylhQWorekOsie2gOGzAElb2Fn05WSWtUtkbJYR7mfKltQ
         OHv2lv/LvW6OV7J3++0EjdA7dj6oQRHPLaAVnIlgQIsI5B+F9xdR2Wq2BggcHfIGfifu
         AneZnLXXEf46u5WzkLM2ft6/ahtaon8ezdMimDGVnBCs96WxzSb8s91N7/YKOOnxBBo3
         yFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744802416; x=1745407216;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tdQXvPCbiDgoqxYNwyAMCDatea8mQL3oATakNHMA+I=;
        b=KjQz+RxgHIOtzfVDnmsAq9oO0/EcSTw2G2OfvKLnYan30fsEI0BJRI1fMJ5BJBw8ct
         2UDMQq9csEr2hMqKPpxi1ZjhLgEnv5l4Xojv65LeoZAjMKBNy5ZNiCNI1sgBRzfai6GP
         XmkdWu1+yc7idoAaq478x13ANxCPV2sDH/SnsAXPASv4ORk/gE02Iq9TLSTzCdTAbnEe
         YqhjHU0n13Kl9fKWX44EjYBEBRIFlgtQqwK3eOpmjogGsJ6lqHPCcSJARgkUYIw/qK73
         mnKEz/IA6jgt6J4iSUoSoSbUyJAKru8LVu+1SYImyE2N+F+KMN3NrEnP37Nzpx4WrFXq
         jr0g==
X-Gm-Message-State: AOJu0Yw/g2j6kl8QzW4Y07OumCS7H0gDNn2TrHLeMEfB+vyv9YC7aUCg
	woRvveA+9KMDbhwUr2QIlqJzBcmSA/U69oet3AxW9pFWMPZvL8+WeV0z3+B1hpk=
X-Gm-Gg: ASbGncv2YYcYRaTRGsOab9rqKN04lwv71XEpxeIfTumnmnpy7mJE7jEu8uAe61gQrsx
	LGBIOL7Gq+aqdPyDM7q39oarzD5HYMmqP35QMc17+PKPH/YfthQLeTc1GypxVa9PTGk0cH1Tzlg
	GleV49AN2+omlunddyUPqZXh/CTKjbxYX9/+r0XkPEFd/1URzStcKWFT4g0jJtqxfPKvEgu/kav
	LPMDkrHOaTeQbgdzWQeqp11+ZvrOHBYKb0UbHLH9eq06zp1hcEAC69HCmWRVfm6wl99CseZEwXB
	SjBDvYZttA087S2OxRAkbj6F4/LyjtySIA0Aogjy1KfEdP+slEpV3Eq7TkjeZ2p+FLs1Mw==
X-Google-Smtp-Source: AGHT+IE5zLB7CSvbZ9vBaU6KXImcx27mm71YZqpAuJV3bD57CEtL1eh1ZOKjXAMPrdcjEP8nZTEf0g==
X-Received: by 2002:a17:907:94c1:b0:aca:e2d9:41f with SMTP id a640c23a62f3a-acb42c750aamr109218666b.60.1744802415814;
        Wed, 16 Apr 2025 04:20:15 -0700 (PDT)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb40b43377sm84439566b.171.2025.04.16.04.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 04:20:15 -0700 (PDT)
Message-ID: <bef2b554e81e60f9c88c25699989840f2ef0254b.camel@gmail.com>
Subject: Re: [RFC PATCH v2 1/1] x86: msr: add 'msr_pkg_cst_config_control.h'
 header
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Date: Wed, 16 Apr 2025 14:20:12 +0300
In-Reply-To: <20250317145430.2153013-2-dedekind1@gmail.com>
References: <20250317145430.2153013-1-dedekind1@gmail.com>
	 <20250317145430.2153013-2-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rafael,

I was thinking to send this to the x86 mailing list as an RFC, but I have
some doubts still. May be you could comment.

I keep the entire patch in the reply for convenience (did not strip the e-m=
ail).

On Mon, 2025-03-17 at 16:54 +0200, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>=20
> There are now two places where the C1 demotion feature gets
> enabled/disabled using the read-modify-write semantics:
> 1. The Intel PMC framework (cnp.c).
> 2. The intel_idle.c driver.
>=20
> Introduce a common helper function enabling/disabling C1 demotion bit of
> the MSR_PKG_CST_CONFIG_CONTROL register.
>=20
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
> =C2=A0.../include/asm/msr_pkg_cst_config_control.h=C2=A0 | 41 +++++++++++=
++++++++
> =C2=A0drivers/idle/intel_idle.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 +----
> =C2=A0drivers/platform/x86/intel/pmc/cnp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++--
> =C2=A03 files changed, 46 insertions(+), 12 deletions(-)
> =C2=A0create mode 100644 arch/x86/include/asm/msr_pkg_cst_config_control.=
h
>=20
> diff --git a/arch/x86/include/asm/msr_pkg_cst_config_control.h
> b/arch/x86/include/asm/msr_pkg_cst_config_control.h
> new file mode 100644
> index 0000000000000..3593e0fe650a7
> --- /dev/null
> +++ b/arch/x86/include/asm/msr_pkg_cst_config_control.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Accessor functions for the MSR_PKG_CST_CONFIG_CONTROL (0xE2) MSR, fou=
nd on
> + * some Intel processors.
> + */
> +
> +#ifndef _MSR_PKG_CST_CONFIG_CONTROL_H
> +#define _MSR_PKG_CST_CONFIG_CONTROL_H
> +
> +#include <asm/msr-index.h>
> +#include <asm/msr.h>
> +
> +/**
> + * msr_pkg_cst_config_set_c1_demotion - Enable/disable C1 demotion.

Doubt #1: on some platforms C1 demotion is enabled/disabled using a
different MSR. For example, see

https://github.com/torvalds/linux/blob/1a1d569a75f3ab2923cb62daf356d102e4df=
2b86/drivers/idle/intel_idle.c#L2083

for Bay Trail and Cherry Trail platforms.

> + * @set: Enable C1 demotion if true, disable it if false.

Doubt #2: OK, so here we have a boolean - feature enable/disable. No assump=
tion
if enabled =3D some bit set or if enabled =3D some bit cleared.

In general, not specific for C1 demotion: sometimes feature enabled =3D som=
e bit
set, sometimes feature enabled =3D some bit cleared.

So far so good.

> + * @other_bits: Additional bits to set or clear in the register.

But here:
  * if set =3D=3D True, other_bits will be set
  * if set =3D=3D False, other_bits will be cleared.

So if we happen to have a "FEATURE_X_DISABLE" bit in the same MSR, this new
helper function becomes not-so-helpful: we cannot enable/disable C1 demotio=
n and
FEATURE_X using one function call.

And also it is just a subtle assumption, reducing the value of this functio=
n.

> + *
> + * Read-modify-write the MSR_PKG_CST_CONFIG_CONTROL register to enable o=
r
> + * disable C1 demotion. The caller should take care of locking if necess=
ary.
> + *
> + * Return: The new value of the MSR_PKG_CST_CONFIG_CONTROL register afte=
r
> + * modification.
> + */
> +static inline unsigned long long
> +msr_pkg_cst_config_set_c1_demotion(bool set, unsigned long long other_bi=
ts)
> +{
> +	unsigned long long val;
> +
> +	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +
> +	if (set)
> +		val |=3D NHM_C1_AUTO_DEMOTE | other_bits;
> +	else
> +		val &=3D ~(NHM_C1_AUTO_DEMOTE | other_bits);
> +
> +	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +
> +	return val;
> +}
> +
> +#endif /* _MSR_PKG_CST_CONFIG_CONTROL_H */
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index da9da7cb27656..0dee44b489064 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -60,6 +60,7 @@
> =C2=A0#include <asm/spec-ctrl.h>
> =C2=A0#include <asm/tsc.h>
> =C2=A0#include <asm/fpu/api.h>
> +#include <asm/msr_pkg_cst_config_control.h>
> =C2=A0
> =C2=A0#define INTEL_IDLE_VERSION "0.5.1"
> =C2=A0
> @@ -2325,18 +2326,11 @@ static void __init
> intel_idle_cpuidle_devices_uninit(void)
> =C2=A0
> =C2=A0static void intel_c1_demotion_toggle(void *enable)
> =C2=A0{
> -	unsigned long long msr_val;
> -
> -	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> =C2=A0	/*
> =C2=A0	 * Enable/disable C1 undemotion along with C1 demotion, as this is
> the
> =C2=A0	 * most sensible configuration in general.
> =C2=A0	 */
> -	if (enable)
> -		msr_val |=3D NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE;
> -	else
> -		msr_val &=3D ~(NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE);
> -	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +	msr_pkg_cst_config_set_c1_demotion(!!enable, SNB_C1_AUTO_UNDEMOTE);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t intel_c1_demotion_store(struct device *dev,
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c
> b/drivers/platform/x86/intel/pmc/cnp.c
> index fc5193fdf8a88..d4e0d02a690ff 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -10,6 +10,7 @@
> =C2=A0
> =C2=A0#include <linux/smp.h>
> =C2=A0#include <linux/suspend.h>
> +#include <asm/msr_pkg_cst_config_control.h>
> =C2=A0#include "core.h"
> =C2=A0
> =C2=A0/* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
> @@ -227,10 +228,8 @@ static void disable_c1_auto_demote(void *unused)
> =C2=A0	int cpunum =3D smp_processor_id();
> =C2=A0	u64 val;
> =C2=A0
> -	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> -	per_cpu(pkg_cst_config, cpunum) =3D val;
> -	val &=3D ~NHM_C1_AUTO_DEMOTE;
> -	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +	val =3D msr_pkg_cst_config_set_c1_demotion(false, 0)
> +	per_cpu(pkg_cst_config, cpunum) =3D val
> =C2=A0
> =C2=A0	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
> =C2=A0}


