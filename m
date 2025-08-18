Return-Path: <linux-pm+bounces-32492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1033B29994
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 08:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2717A921A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 06:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B27E273D8C;
	Mon, 18 Aug 2025 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DzPRt50w"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1432925CC58;
	Mon, 18 Aug 2025 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498083; cv=none; b=gTZ3sewgM6dcrpcU8kq4c+IMkWcXJwm8L4NF3+SkeFU0sqGDuuaeMJS+aqnzX14EldZjzPi6ivgWceE7PCL6XXRzGlqbkErlN+UUY9sZLZ7opmMcjaR6UFnpUxxm0Ag3q7AcSvc8yGDKeidD78/Me28m9PbctD+g06CXycZwpy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498083; c=relaxed/simple;
	bh=wWQWZYbnoRcL5oSUcWqBudDMOrlVVKErs4YSQvuoh2Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKWHQmwhiVQ7UOasV5KsirpqvLOsy5c0W5W8ILJ82VlEOqkomHbLVZCi5zqcLU9nSFi/C5g55wxSOIP08rq5GocJiXy0GAjYWTDWm1Wp0Pv/LWCjfl6u58aCCuugIIDVA/5ZX64GVbQToVIK+IUA+cXS08bZpmzHl+7X5vMDOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DzPRt50w; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57I6KkKV2653885;
	Mon, 18 Aug 2025 01:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755498046;
	bh=4oHV6eDv/jSipaBzI1+qlMqK2ITIVXOlUp3nua4gFpk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DzPRt50w+q2spgh7NxBisUjPt9yBaIOK1KzpkfMH7nGX2ebDA3XFXELuFwIfGBwEN
	 dguytTXvWx6sW4cZfckp/JVJmpwyvV945/yyVayTjzUxbQdOQBjAi0+QGn3YMU9PHB
	 83AlAMkY6fE96+U7n7LE1FKVTXTwKsGCtu2Vr1J8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57I6KkMj3594812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 01:20:46 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 01:20:46 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Mon, 18 Aug
 2025 01:20:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 01:20:45 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57I6Ki38544316;
	Mon, 18 Aug 2025 01:20:45 -0500
Date: Mon, 18 Aug 2025 11:50:44 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <sudeep.holla@arm.com>, <james.quinlan@broadcom.com>,
        <f.fainelli@gmail.com>, <vincent.guittot@linaro.org>,
        <quic_sibis@quicinc.com>, <dan.carpenter@linaro.org>,
        <johan+linaro@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <quic_mdtipton@quicinc.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>
Subject: Re: [PATCH 2/2] [NOT_FOR_UPSTREAM] cpufreq: scmi: Add quirk to
 disable checks in scmi_dev_used_by_cpus()
Message-ID: <20250818062044.zawqkalphvxjwt2w@lcpd911>
References: <20250815102736.81450-1-cristian.marussi@arm.com>
 <20250815102736.81450-2-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250815102736.81450-2-cristian.marussi@arm.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Aug 15, 2025 at 11:27:36 +0100, Cristian Marussi wrote:
> From: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Broadcom STB platforms were early adopters of the SCMI framework and as
> a result, not all deployed systems have a Device Tree entry where SCMI
> protocol 0x13 (PERFORMANCE) is declared as a clock provider, nor are the
> CPU Device Tree node(s) referencing protocol 0x13 as their clock
> provider.
> 
> Leverage the quirks framework recently introduce to match on the
> Broadcom SCMI vendor and in that case, disable the Device Tree
> properties checks being done by scmi_dev_used_by_cpus().
> 
> Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
> Fixes: 6c9bb8692272 ("cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> [Cristian: Moved quirk directly into scmi_dev_used_by_cpus]
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> ----
> @Florian: I reworked this minimally to avoid the global as I was mentioning.
> No change around the version match either...so the NOT_FOR_UPSTREAM tag.
> (also the if (true) i smaybe a bit idiotic...)
> Please check if it is fine and modify as you see fit.
> ---
>  drivers/cpufreq/scmi-cpufreq.c     | 9 +++++++++
>  drivers/firmware/arm_scmi/quirks.c | 2 ++
>  include/linux/scmi_quirks.h        | 1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index ef078426bfd5..9b7cbc4e87d9 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -19,6 +19,7 @@
>  #include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/scmi_protocol.h>
> +#include <linux/scmi_quirks.h>
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> @@ -393,6 +394,12 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
>  	.set_boost	= cpufreq_boost_set_sw,
>  };
>  
> +#define QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS			\
> +	({							\
> +		if (true)					\
> +			return true;				\
> +	})
> +

Probably another checkpatch warning to fix:
8<--------------------------------------------------------------------
WARNING: Macros with flow control statements should be avoided                                                                                                                                                     
#50: FILE: drivers/cpufreq/scmi-cpufreq.c:397:                                                                                                                                                                     
+#define QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS                      \                                        
+       ({                                                      \                                                                                                                                                  
+               if (true)                                       \                                        
+                       return true;                            \        
+       })                                                                                               
                                                                                                         
total: 0 errors, 1 warnings, 0 checks, 47 lines checked                                                  
-------------------------------------------------------------------->8


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

