Return-Path: <linux-pm+bounces-32704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBDAB2D835
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFF83A8780
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4FC2E22AE;
	Wed, 20 Aug 2025 09:22:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C742E1722;
	Wed, 20 Aug 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681765; cv=none; b=cONGtdCwajRSVkHIHcP3IW3QcY+M4aIPkVPBJibL9TpRt7ppqLHrOh7JnblOvqrfth9Ny83RIXvnt+7UoKWkzMVBS+Kq7nXWDRKhPr9r7Om49Wr5ucqDPabCGTgkvHmHnYyTFMlZHGfFzd84IuxMHbQTI6OiYnpjZOS//TAzLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681765; c=relaxed/simple;
	bh=CazIol/DD2JvuI17vFH2eK6mX+BI/Mm03xTR4gOpZEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBSwUs5t4wqmBXh/vEiKe0zT5w3u54XHwmkpjHTKZL1HW7pBWXQI08/Q80RL9sFcKUO6WjLnSKzTDqSUpUVSAQIZ1nfrAhoDU2OzE60ByiXk7nx4frA2y3t0fWBQgGLK5aLvd/WztC2NZ2xXgvtFtsQ/st6T770H3/XSZ6K+6eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AF9C152B;
	Wed, 20 Aug 2025 02:22:33 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA4553F58B;
	Wed, 20 Aug 2025 02:22:35 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:22:20 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org,
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com,
	linhongye@h-partners.com
Subject: Re: [PATCH v5 1/3] arm64: topology: Set scale freq source only for
 the CPUs that have not been set before
Message-ID: <aKWTzPl3bYPy-81e@arm.com>
References: <20250819072931.1647431-1-zhenglifeng1@huawei.com>
 <20250819072931.1647431-2-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819072931.1647431-2-zhenglifeng1@huawei.com>

I'd say it will apply across the series, but shorter commit message could be
used, like:

	arm64: topology: Skip already covered CPUs when setting freq source

Otherwise, once that's updated:
Reviewed-by: Beata Michalska <beata.michalska@arm.com>

---
BR
Beata


On Tue, Aug 19, 2025 at 03:29:29PM +0800, Lifeng Zheng wrote:
> The scale freq source of the CPUs in 'amu_fie_cpus' mask are already set to
> AMU tick before, so in amu_fie_setup(), only the CPUs in the 'cpus' mask
> should be set.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  arch/arm64/kernel/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 5d07ee85bdae..9317a618bb87 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -373,7 +373,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
>  
>  	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
>  
> -	topology_set_scale_freq_source(&amu_sfd, amu_fie_cpus);
> +	topology_set_scale_freq_source(&amu_sfd, cpus);
>  
>  	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
>  		 cpumask_pr_args(cpus));
> -- 
> 2.33.0
> 

