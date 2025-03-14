Return-Path: <linux-pm+bounces-24033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB651A61099
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4184A3BF528
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808D1D5CDE;
	Fri, 14 Mar 2025 12:03:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02EF3C6BA;
	Fri, 14 Mar 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953829; cv=none; b=dgbypyNmG8cOASnASNnnJHEsBvhQsmKDAzfX3qd2XNute2Kjjki14DwuwJyRvdz6xsQ9njuKlGZ89yOcW2ChuZYQsCLrHcdeU2qdkT93nG+Z/u3vdoHUUIm57jl46i+plTlHx7UEsVKygy+JiLl2GRunoUbGEBON6789+E+YZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953829; c=relaxed/simple;
	bh=qikDiJMLCpRtaCKE/Y1FmzQczfwxIVA7dOqYr3ldh4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssZm4wSGahdzRYFc67sleM/FyZjoEk+/ewiUDragmy1ZE5SwCbGqX2zb0i/Szrs0ZnezWCD9VMTd7UNxL6d2HgSVnYyBALT2l9dNKn9RV8OZDvMt2R0BHDiLD4sKW4SIq7FxR899ZuCU0A+3bBBKy4LP6NALwK32ALY6225ZQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39EDD1424;
	Fri, 14 Mar 2025 05:03:57 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28E3F3F5A1;
	Fri, 14 Mar 2025 05:03:46 -0700 (PDT)
Date: Fri, 14 Mar 2025 12:03:38 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Remove redundant state
 verification
Message-ID: <Z9QbGiuK9XTEpAdE@pluto>
References: <20250314095851.443979-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314095851.443979-1-sudeep.holla@arm.com>

On Fri, Mar 14, 2025 at 09:58:51AM +0000, Sudeep Holla wrote:
> Currently, scmi_pd_power() explicitly verifies whether the requested
> power state was applied by calling state_get(). While this check could
> detect failures where the state was not properly updated, ensuring
> correctness is the responsibility of the SCMI firmware.
> 
> Removing this redundant state_get() call eliminates an unnecessary
> round-trip to the firmware, improving efficiency. Any mismatches
> between the requested and actual states should be handled by the SCMI
> firmware, which must return a failure if state_set() is unsuccessful.
> 
> Additionally, in some cases, checking the state after powering off a
> domain may be unreliable or unsafe, depending on the firmware
> implementation.
> 
> This patch removes the redundant verification, simplifying the function
> without compromising correctness.
> 
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Reported-and-tested-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/pmdomain/arm/scmi_pm_domain.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> index 86b531e15b85..2a213c218126 100644
> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> @@ -24,8 +24,7 @@ struct scmi_pm_domain {
>  
>  static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
>  {
> -	int ret;
> -	u32 state, ret_state;
> +	u32 state;
>  	struct scmi_pm_domain *pd = to_scmi_pd(domain);
>  
>  	if (power_on)
> @@ -33,13 +32,7 @@ static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
>  	else
>  		state = SCMI_POWER_STATE_GENERIC_OFF;
>  
> -	ret = power_ops->state_set(pd->ph, pd->domain, state);
> -	if (!ret)
> -		ret = power_ops->state_get(pd->ph, pd->domain, &ret_state);
> -	if (!ret && state != ret_state)
> -		return -EIO;
> -
> -	return ret;
> +	return power_ops->state_set(pd->ph, pd->domain, state);
>  }

...not sure about the history of this but it would have also definitely
failed consistently on any systen where the SCMI Server exposes resources
physical states (an IMPDEF behaviour), so that after a successfull set_OFF
on a shared resource a subsequent get() could return that the resource is
still physically ON if it was still needed by the other agennts sharing it...

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

