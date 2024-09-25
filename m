Return-Path: <linux-pm+bounces-14657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A69855F2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA791C237D2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83A15AAC6;
	Wed, 25 Sep 2024 08:58:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843ED139579;
	Wed, 25 Sep 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254724; cv=none; b=CtfyoN0k9ua21lHF/fJro1HxRAM/11gpjCz6kiprBbwmzUBSE6UCTNXuQ708st0PK+cGpOnx54Pk/WgX2MX8E+yfe/m6wnXAc09LbGxLjcXRrjdOe6rD8Nnvx5o2d9ZWSmz+5BXQ+3VcXdgmnATHgcVOCrgEJ+F4qC+IIZc0uIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254724; c=relaxed/simple;
	bh=77TYbhk3FEQDvRMc1aKR+Jy7UbmeKedsMaovZa0q+Dw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=gol1XSicyEfjehcbjqq+oYdaxvBtx+F5oJAHpBYEh01A4gqMsW2kQcPYl1XxVgkhpZihg/msMrAxuAlv/uTMc+sEs+uImc6pbELNBO94N1GwmHf4Kj4eimbVs/0lpUOE+YmGUE9dykJyaMFQL4cAfFbBZ/RqwZqXCrILIrVkopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XD9bD1h8Pz1T7y2;
	Wed, 25 Sep 2024 16:57:12 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E814180087;
	Wed, 25 Sep 2024 16:58:37 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 16:58:36 +0800
Message-ID: <09887c82-2813-59c3-2ff2-0b7223b37b9e@hisilicon.com>
Date: Wed, 25 Sep 2024 16:58:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
From: Jie Zhan <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v7 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
To: Beata Michalska <beata.michalska@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <sumitg@nvidia.com>, <yang@os.amperecomputing.com>,
	<vanshikonda@os.amperecomputing.com>, <lihuisong@huawei.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-2-beata.michalska@arm.com>
In-Reply-To: <20240913132944.1880703-2-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)

Hi Beata,

Great thanks for the update.

On 13/09/2024 21:29, Beata Michalska wrote:
> Currently the CPUFreq core exposes two sysfs attributes that can be used
> to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> and scaling_cur_freq. Both provide slightly different view on the
> subject and they do come with their own drawbacks.
> 
> cpuinfo_cur_freq provides higher precision though at a cost of being
> rather expensive. Moreover, the information retrieved via this attribute
> is somewhat short lived as frequency can change at any point of time
> making it difficult to reason from.
> 
> scaling_cur_freq, on the other hand, tends to be less accurate but then
> the actual level of precision (and source of information) varies between
> architectures making it a bit ambiguous.
> 
> The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> distinct interface, exposing an average frequency of a given CPU(s), as
> reported by the hardware, over a time frame spanning no more than a few
> milliseconds. As it requires appropriate hardware support, this
> interface is optional.
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst | 10 ++++++++
>  drivers/cpufreq/cpufreq.c                | 31 ++++++++++++++++++++++++
>  include/linux/cpufreq.h                  |  1 +
>  3 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index fe1be4ad88cb..2204d6132c05 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -248,6 +248,16 @@ are the following:
>  	If that frequency cannot be determined, this attribute should not
>  	be present.
>  
> +``cpuinfo_avg_freq``
> +        An average frequency (in KHz) of all CPUs belonging to a given policy,
> +        derived from a hardware provided feedback and reported on a time frame
> +        spanning at most few milliseconds.

I don't think it's necessary to put the 'at most few milliseconds'
limitation on.

It's supposed to be fine for other platforms to implement the interface
with a longer time period, e.g. a few seconds, in the future.  Otherwise,
this would probably force the implementation of 'cpuinfo_avg_freq' to be
binded with the 'scale freq tick' stuff.

> +
> +        This is expected to be based on the frequency the hardware actually runs
> +        at and, as such, might require specialised hardware support (such as AMU
> +        extension on ARM). If one cannot be determined, this attribute should
> +        not be present.
> +
>  ``cpuinfo_max_freq``
>  	Maximum possible operating frequency the CPUs belonging to this policy
>  	can run at (in kHz).

...

> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d4d2f4d1d7cb..48262073707e 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1195,6 +1195,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>  #endif
>  
>  extern unsigned int arch_freq_get_on_cpu(int cpu);
> +extern int arch_freq_avg_get_on_cpu(int cpu);

It's werid to have two different functions with mostly the same behaviour,
i.e. arch_freq_get_on_cpu() and arch_freq_avg_get_on_cpu().

Appreciated that there would be some capatibility work with x86 at the
moment if merging them, e.g. return type, default implementation, impact on
some userspace tools, etc.

Anyhow, are they supposed to be merged in the near future?


Thanks,
Jie
>  
>  #ifndef arch_set_freq_scale
>  static __always_inline

