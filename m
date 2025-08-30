Return-Path: <linux-pm+bounces-33442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8AB3C7C2
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 06:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1559B5A1049
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 04:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838E2765DF;
	Sat, 30 Aug 2025 04:08:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CADB2773D1;
	Sat, 30 Aug 2025 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756526913; cv=none; b=LlA6Gpk8rY7zoC0L0rrjzZlh5HZDnBJ3HypxJQ+GtiJ8K8QS5ctUf68or/rPAQgi0+OAoEVfpFXaymsf0neookFrz3oGNTfdDkpzeoW/YNmUjpbnzNK9tEZL9luHCWZ980m+1xC03c+rWZQiUi8+Mhb29yE2hOispuSJJX/T2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756526913; c=relaxed/simple;
	bh=xa/ihByyPWPDDyOMjq6GAOGQPFD8WpBXBfKTIhm5NaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TaIUiJxym8mrz9WxQj7RrFc22/698+vITJiif0GtdlO8WO4ncUCq0G3jmdYDiknTi6XPA9vNHklyINQ9+4QFoeHrLR6UE93g4DEA8hjU4TmEPfarg7jrYzupy8iLYKvFY/ZFVj+OJuoCBLqUYIvnmiyqG5WPbplJbJnjzktufD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cDM442X76z1R8gt;
	Sat, 30 Aug 2025 12:05:24 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id C9A9418001B;
	Sat, 30 Aug 2025 12:08:21 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 30 Aug
 2025 12:08:20 +0800
Message-ID: <c64d1999-9070-0d1d-35a7-9f2c55f39fc8@hisilicon.com>
Date: Sat, 30 Aug 2025 12:08:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 1/3] arm64: topology: Set scale freq source only for
 the CPUs that have not been set before
To: Lifeng Zheng <zhenglifeng1@huawei.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<beata.michalska@arm.com>, <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <linhongye@h-partners.com>
References: <20250819072931.1647431-1-zhenglifeng1@huawei.com>
 <20250819072931.1647431-2-zhenglifeng1@huawei.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20250819072931.1647431-2-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 19/08/2025 15:29, Lifeng Zheng wrote:
> The scale freq source of the CPUs in 'amu_fie_cpus' mask are already set to
> AMU tick before, so in amu_fie_setup(), only the CPUs in the 'cpus' mask
> should be set.
> 
LGTM.

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
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

