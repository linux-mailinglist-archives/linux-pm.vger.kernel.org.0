Return-Path: <linux-pm+bounces-39779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F22CD667C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36104301974A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9D2ECE97;
	Mon, 22 Dec 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfyDVB8y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4C17A30A;
	Mon, 22 Dec 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414629; cv=none; b=glg+n6a4uCQIpmCv5nZGmn+aEOCLL0BsDYHrSM7TqWiLLqAlfr8wt29YemGme6oq3lZesZ5iZop4N5s7oTo8Ij3CN9Hw0X+NAPp34UqPHHQiXtUv9vYqv85aQUnw+XecQyy9qkAYe9bD0eSgt4sR18OFjbmbA+i7lDnw3wOc7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414629; c=relaxed/simple;
	bh=w6xF0hMpR98bx2wAs/uVsbKsITXHoAWYUj597zVJW58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Afk6X8l7zheu+Ise2BIRnl3JED4OVWUELgwFEdYBZTq7XkP1ctKxqHAMhC3OqH0dTCFBFcVoIgLPNhSpHDUacmYDzvuFJ0TA2iYFBuxN6KtqM2Ho7QeBus9wQAzHv5XAmujFQ6tAlifzGHjEn/HOJR46PKQLxi1bLG8w4cYM+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfyDVB8y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766414628; x=1797950628;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=w6xF0hMpR98bx2wAs/uVsbKsITXHoAWYUj597zVJW58=;
  b=OfyDVB8yO8avgV4Cjd4BFcIWtIYjdF4z5SoCzotADNkamDctWOeBVlAb
   jg6NtXp9Sf/9h8ZOtKKdpVY1L5u8RxdqJn/M/Ds3vj37oXhW4KgHGp7Zs
   ENhaSEOJwQlyik7kfNJMG2YOxG7pqlkbAtk3C+lKY9kKE3BeePyCtdvHh
   o5yOdiBPHKNSo0rOU2rxf/vBqhh+XWI/ufqC/QS6SM7PHvA9sS2tthW0S
   Kl2s5EiSYQo1hvl0OOy9qubgFQixu3ltFs3NUDQnJ+OqhUmzGrmTu/wo9
   GgbS32Ue9zqhMYks4xizKvqGTenzAKRJdcGCD+NFOLs1JBd4cZ2c32PzY
   Q==;
X-CSE-ConnectionGUID: sNYhH1E8RLSPqWGqM+ALxg==
X-CSE-MsgGUID: XRZHO4Q1SHGXuD6TfxevdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79722226"
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="79722226"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 06:43:48 -0800
X-CSE-ConnectionGUID: 8FgINj+WQnKUYp3YSKganQ==
X-CSE-MsgGUID: 4FVxa3ViSWeCXBD3Nas8uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="204487799"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.117]) ([10.124.220.117])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 06:43:46 -0800
Message-ID: <1dd5045fbbb443fc12e602fc2803857401289294.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel: int340x: Use sysfs_emit{_at} in sysfs
 show functions
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, "Rafael J. Wysocki"	
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui	
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Ingo Molnar	
 <mingo@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Xin
 Li (Intel)" <xin@zytor.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Hansen
	 <dave.hansen@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 22 Dec 2025 06:43:45 -0800
In-Reply-To: <20251220223026.125678-1-thorsten.blum@linux.dev>
References: <20251220223026.125678-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-20 at 23:30 +0100, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show
> functions. sysfs_emit() and sysfs_emit_at() are preferred to format
> sysfs output as it provides better bounds checking.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0.../intel/int340x_thermal/processor_thermal_device.c=C2=A0=C2=A0=C2=
=A0=C2=A0 | 5 +++--
> =C2=A0.../intel/int340x_thermal/processor_thermal_rfim.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 9 +++++--
> --
> =C2=A0.../intel/int340x_thermal/processor_thermal_wt_req.c=C2=A0=C2=A0=C2=
=A0=C2=A0 | 7 ++++---
> =C2=A03 files changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 48e7849d4816..f80dbe2ca7e4 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pci.h>
> +#include <linux/sysfs.h>
> =C2=A0#include <linux/thermal.h>
> =C2=A0#include <asm/msr.h>
> =C2=A0#include "int340x_thermal_zone.h"
> @@ -23,7 +24,7 @@ static ssize_t
> power_limit_##index##_##suffix##_show(struct device *dev, \
> =C2=A0{ \
> =C2=A0	struct proc_thermal_device *proc_dev =3D dev_get_drvdata(dev);
> \
> =C2=A0	\
> -	return sprintf(buf, "%lu\n",\
> +	return sysfs_emit(buf, "%lu\n",\
> =C2=A0	(unsigned long)proc_dev->power_limits[index].suffix * 1000);
> \
> =C2=A0}
> =C2=A0
> @@ -143,7 +144,7 @@ static ssize_t
> tcc_offset_degree_celsius_show(struct device *dev,
> =C2=A0	if (offset < 0)
> =C2=A0		return offset;
> =C2=A0
> -	return sprintf(buf, "%d\n", offset);
> +	return sysfs_emit(buf, "%d\n", offset);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> index 589a3a71f0c4..bb9398dfa3c1 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> @@ -7,6 +7,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pci.h>
> +#include <linux/sysfs.h>
> =C2=A0#include "processor_thermal_device.h"
> =C2=A0
> =C2=A0MODULE_IMPORT_NS("INT340X_THERMAL");
> @@ -211,9 +212,9 @@ static ssize_t suffix##_show(struct device *dev,\
> =C2=A0	ret =3D (reg_val >> mmio_regs[ret].shift) &
> mmio_regs[ret].mask;\
> =C2=A0	err =3D get_mapped_string(mapping, attr->attr.name, ret,
> &str);\
> =C2=A0	if (!err)\
> -		return sprintf(buf, "%s\n", str);\
> +		return sysfs_emit(buf, "%s\n", str);\
> =C2=A0	if (err =3D=3D -EOPNOTSUPP)\
> -		return sprintf(buf, "%u\n", ret);\
> +		return sysfs_emit(buf, "%u\n", ret);\
> =C2=A0	return err;\
> =C2=A0}
> =C2=A0
> @@ -398,7 +399,7 @@ static ssize_t rfi_restriction_show(struct device
> *dev,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	return sprintf(buf, "%llu\n", resp);
> +	return sysfs_emit(buf, "%llu\n", resp);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t ddr_data_rate_show(struct device *dev,
> @@ -413,7 +414,7 @@ static ssize_t ddr_data_rate_show(struct device
> *dev,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	return sprintf(buf, "%llu\n", resp);
> +	return sysfs_emit(buf, "%llu\n", resp);
> =C2=A0}
> =C2=A0
> =C2=A0static DEVICE_ATTR_RW(rfi_restriction);
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
> index b95810f4a011..2372f5202019 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
> @@ -7,6 +7,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/pci.h>
> +#include <linux/sysfs.h>
> =C2=A0#include "processor_thermal_device.h"
> =C2=A0
> =C2=A0/* List of workload types */
> @@ -28,9 +29,9 @@ static ssize_t workload_available_types_show(struct
> device *dev,
> =C2=A0	int ret =3D 0;
> =C2=A0
> =C2=A0	while (workload_types[i] !=3D NULL)
> -		ret +=3D sprintf(&buf[ret], "%s ",
> workload_types[i++]);
> +		ret +=3D sysfs_emit_at(buf, ret, "%s ",
> workload_types[i++]);
> =C2=A0
> -	ret +=3D sprintf(&buf[ret], "\n");
> +	ret +=3D sysfs_emit_at(buf, ret, "\n");
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -85,7 +86,7 @@ static ssize_t workload_type_show(struct device
> *dev,
> =C2=A0	if (cmd_resp > ARRAY_SIZE(workload_types) - 1)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	return sprintf(buf, "%s\n", workload_types[cmd_resp]);
> +	return sysfs_emit(buf, "%s\n", workload_types[cmd_resp]);
> =C2=A0}
> =C2=A0
> =C2=A0static DEVICE_ATTR_RW(workload_type);

