Return-Path: <linux-pm+bounces-32490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1264DB298EF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 07:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694311639C2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 05:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA90232369;
	Mon, 18 Aug 2025 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IJ39ERdw"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55071DF987;
	Mon, 18 Aug 2025 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755495368; cv=none; b=K20XW88dUroj8BNr4aP7XcIZDk9ZUHdE+pCPDyS7SIYmo6FiXVK9phvHDuAMx+EHE+4Dau26MGxKs9/5yr/SjF/KWgggUAQkc1y31UFNfMTSxpGJK6b9eHFApeBtF0AFNWBpABfgEta7LiI6rysud/jMeF9NefB8EfuAOsS/+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755495368; c=relaxed/simple;
	bh=31lpmXSQBLbLvXIsubVmRCNxts4TizAbzGQOWrRINLo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o84sJEkkLwV3lpUhWKDvi33bdX0WBiG7XqlVZ9UKoMG6paPuV8ZM8vSpYQC04rL6jNIX+ONZIrbLEYhodZMqjFnS+E3naGHFme5EMttqzYCcfInOOnD+2cBDzN1b1ElNuKry2dW5DwPEWes2+vT8+YtbV4HaCmcKvK/PU6ev3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IJ39ERdw; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57I5ZbsT2585902;
	Mon, 18 Aug 2025 00:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755495337;
	bh=ZQqJLxn/uck2ZUWoChhjcCs9bxIpI9w0PlNK/2siEoQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IJ39ERdw/bmMCyb6LoyfEhp83XHLt5GQ1RmUr4GyGOYmkf4+NvTL8FMpFMAb0oqEd
	 Tdu51zKveZLvXWZB2EMLqBlnXPUy6TNTzdlPxkIG1SAZqNMrBz7WkmqdhHxTgtK0s5
	 7+Sww05vkrrhX6fmV170nVv2rsJRx5Foh+Go9KfM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57I5ZbUW069851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 00:35:37 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 00:35:37 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Mon, 18 Aug
 2025 00:35:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 00:35:36 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57I5ZZQc478080;
	Mon, 18 Aug 2025 00:35:36 -0500
Date: Mon, 18 Aug 2025 11:05:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <sudeep.holla@arm.com>, <james.quinlan@broadcom.com>,
        <f.fainelli@gmail.com>, <vincent.guittot@linaro.org>,
        <quic_sibis@quicinc.com>, <dan.carpenter@linaro.org>,
        <johan+linaro@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Rework quirks framework header
Message-ID: <20250818053535.owst4ilq2oxfgqnq@lcpd911>
References: <20250815102736.81450-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250815102736.81450-1-cristian.marussi@arm.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

On Aug 15, 2025 at 11:27:35 +0100, Cristian Marussi wrote:
> Split and relocate the quirks framework header so as to be usable also by
> SCMI Drivers and not only by the core.

Could you elaborate a bit more on this reasoning? I am not fully
convinced as to why I shouldn't just include quirks.h in the other scmi
drivers as well?

Oh or perhaps you mean to say scmi driver like scmi cpufreq / clk-scmi
etc.. which lie outside the firmware/arm_scmi folder? If so then that's
not coming out clearly in this patch commit message.

> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/clock.c  |  2 +-
>  drivers/firmware/arm_scmi/driver.c |  1 +
>  drivers/firmware/arm_scmi/quirks.h | 33 +++-------------------
>  include/linux/scmi_quirks.h        | 44 ++++++++++++++++++++++++++++++
>  4 files changed, 50 insertions(+), 30 deletions(-)
>  create mode 100644 include/linux/scmi_quirks.h
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index afa7981efe82..5599697de37a 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -7,11 +7,11 @@
>  
>  #include <linux/module.h>
>  #include <linux/limits.h>
> +#include <linux/scmi_quirks.h>
>  #include <linux/sort.h>
>  
>  #include "protocols.h"
>  #include "notify.h"
> -#include "quirks.h"
>  
>  /* Updated only after ALL the mandatory features for that version are merged */
>  #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index bd56a877fdfc..6f5934cd3a65 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -34,6 +34,7 @@
>  #include <linux/processor.h>
>  #include <linux/refcount.h>
>  #include <linux/slab.h>
> +#include <linux/scmi_quirks.h>
>  #include <linux/xarray.h>
>  
>  #include "common.h"
> diff --git a/drivers/firmware/arm_scmi/quirks.h b/drivers/firmware/arm_scmi/quirks.h
> index a71fde85a527..260ae38d617b 100644
> --- a/drivers/firmware/arm_scmi/quirks.h
> +++ b/drivers/firmware/arm_scmi/quirks.h
> @@ -4,49 +4,24 @@
>   *
>   * Copyright (C) 2025 ARM Ltd.
>   */
> -#ifndef _SCMI_QUIRKS_H
> -#define _SCMI_QUIRKS_H
> +#ifndef _SCMI_QUIRKS_INTERNAL_H
> +#define _SCMI_QUIRKS_INTERNAL_H

Or as per your commit message wording, better to call it
_SCMI_QUIRKS_CORE_H ?

>  
> -#include <linux/static_key.h>
> +#include <linux/device.h>
>  #include <linux/types.h>
>  
>  #ifdef CONFIG_ARM_SCMI_QUIRKS
>  
> -#define DECLARE_SCMI_QUIRK(_qn)						\
> -	DECLARE_STATIC_KEY_FALSE(scmi_quirk_ ## _qn)
> -
> -/*
> - * A helper to associate the actual code snippet to use as a quirk
> - * named as _qn.
> - */
> -#define SCMI_QUIRK(_qn, _blk)						\
> -	do {								\
> -		if (static_branch_unlikely(&(scmi_quirk_ ## _qn)))	\
> -			(_blk);						\
> -	} while (0)
> -
>  void scmi_quirks_initialize(void);
>  void scmi_quirks_enable(struct device *dev, const char *vend,
>  			const char *subv, const u32 impl);
>  
>  #else
>  
> -#define DECLARE_SCMI_QUIRK(_qn)
> -/* Force quirks compilation even when SCMI Quirks are disabled */
> -#define SCMI_QUIRK(_qn, _blk)						\
> -	do {								\
> -		if (0)							\
> -			(_blk);						\
> -	} while (0)
> -
>  static inline void scmi_quirks_initialize(void) { }
>  static inline void scmi_quirks_enable(struct device *dev, const char *vend,
>  				      const char *sub_vend, const u32 impl) { }
>  
>  #endif /* CONFIG_ARM_SCMI_QUIRKS */
>  
> -/* Quirk delarations */
> -DECLARE_SCMI_QUIRK(clock_rates_triplet_out_of_spec);
> -DECLARE_SCMI_QUIRK(perf_level_get_fc_force);
> -
> -#endif /* _SCMI_QUIRKS_H */
> +#endif /* _SCMI_QUIRKS_INTERNAL_H */
> diff --git a/include/linux/scmi_quirks.h b/include/linux/scmi_quirks.h
> new file mode 100644
> index 000000000000..11657bd91ffc
> --- /dev/null
> +++ b/include/linux/scmi_quirks.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * System Control and Management Interface (SCMI) Message Protocol Quirks
> + *
> + * Copyright (C) 2025 ARM Ltd.
> + */
> +#ifndef _SCMI_QUIRKS_H
> +#define _SCMI_QUIRKS_H
> +
> +#include <linux/static_key.h>
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_ARM_SCMI_QUIRKS
> +
> +#define DECLARE_SCMI_QUIRK(_qn)						\
> +	DECLARE_STATIC_KEY_FALSE(scmi_quirk_ ## _qn)
> +
> +/*
> + * A helper to associate the actual code snippet to use as a quirk
> + * named as _qn.
> + */
> +#define SCMI_QUIRK(_qn, _blk)						\
> +	do {								\
> +		if (static_branch_unlikely(&(scmi_quirk_ ## _qn)))	\
> +			(_blk);						\
> +	} while (0)
> +
> +#else
> +
> +#define DECLARE_SCMI_QUIRK(_qn)
> +/* Force quirks compilation even when SCMI Quirks are disabled */
> +#define SCMI_QUIRK(_qn, _blk)						\
> +	do {								\
> +		if (0)							\
> +			(_blk);						\
> +	} while (0)

Did you happen to run checkpatch on this?
8<---------------------------------------------------------------------------
WARNING: Argument '_qn' is not used in function-like macro
#142: FILE: include/linux/scmi_quirks.h:32:
+#define SCMI_QUIRK(_qn, _blk)                                          \
+       do {                                                            \
+               if (0)                                                  \
+                       (_blk);                                         \
+       } while (0)

total: 0 errors, 2 warnings, 0 checks, 116 lines checked
--------------------------------------------------------------------------->8


> +
> +#endif /* CONFIG_ARM_SCMI_QUIRKS */
> +
> +/* Quirk delarations */
> +DECLARE_SCMI_QUIRK(clock_rates_triplet_out_of_spec);
> +DECLARE_SCMI_QUIRK(perf_level_get_fc_force);
> +
> +#endif /* _SCMI_QUIRKS_H */
> -- 
> 2.50.1
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

