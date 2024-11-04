Return-Path: <linux-pm+bounces-16918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C90C9BAD82
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 08:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FB4281DF0
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769141917C4;
	Mon,  4 Nov 2024 07:57:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6D3199E8D
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707045; cv=none; b=uHNeiBc3TeEDh0fqzgIoM2UdhcStYMi+YbW4O00vc56gYbpAJ1QIcKuDeWGqdUn0K0R8Ix/VkdUSB9r8dACi4FmDD22KdXhATf0pTd5cAsSSt7XZFaEHYBtX8gqs8lBb4fFbVsFuVDXFBUXPJcfMirXHyuQRzx0/CW2EuAKCn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707045; c=relaxed/simple;
	bh=0d7bW0iYX686nfE5ti3ZdjwL8hzoJrz6AjCRfvcakDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tAfAMvpS4wbVWdMbCl2cYyjPRfTna5Jizk58v8qW9eiVlLuAM2wrg2S1COaihvndfBtGUeltjToNoad1VXLVt22Yg3huY4e64ehE0H4nGAylN1jigGm60Fsj6L44bNDfGzllFp3y/FVFHODxqDRZ1zSCCB9Xu+CwHISKdIaj7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XhkK12wCmz10PWc;
	Mon,  4 Nov 2024 15:55:01 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id DFA21180106;
	Mon,  4 Nov 2024 15:57:18 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Nov 2024 15:57:18 +0800
Message-ID: <ac7c7590-fb93-06cd-2f1e-cb5bf0c9deee@huawei.com>
Date: Mon, 4 Nov 2024 15:57:17 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [bug report] cpufreq: CPPC: Fix possible null-ptr-deref for
 cppc_get_cpu_cost()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <linux-pm@vger.kernel.org>
References: <c4765377-7830-44c2-84fa-706b6e304e10@stanley.mountain>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <c4765377-7830-44c2-84fa-706b6e304e10@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/11/1 19:23, Dan Carpenter wrote:
> Hello Jinjie Ruan,
> 
> Commit 1a1374bb8c59 ("cpufreq: CPPC: Fix possible null-ptr-deref for
> cppc_get_cpu_cost()") from Oct 30, 2024 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	kernel/power/energy_model.c:254 em_compute_costs()
> 	error: uninitialized symbol 'cost'.

Thank you, will fix it.

> 
> kernel/power/energy_model.c
>     241 static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>     242                             struct em_data_callback *cb, int nr_states,
>     243                             unsigned long flags)
>     244 {
>     245         unsigned long prev_cost = ULONG_MAX;
>     246         int i, ret;
>     247 
>     248         /* Compute the cost of each performance state. */
>     249         for (i = nr_states - 1; i >= 0; i--) {
>     250                 unsigned long power_res, cost;
>     251 
>     252                 if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
>     253                         ret = cb->get_cost(dev, table[i].frequency, &cost);
> --> 254                         if (ret || !cost || cost > EM_MAX_POWER) {
>                                             ^^^^
> cost can be uninitialized.
> 
>     255                                 dev_err(dev, "EM: invalid cost %lu %d\n",
>     256                                         cost, ret);
>     257                                 return -EINVAL;
>     258                         }
>     259                 } else {
>     260                         /* increase resolution of 'cost' precision */
>     261                         power_res = table[i].power * 10;
>     262                         cost = power_res / table[i].performance;
>     263                 }
>     264 
>     265                 table[i].cost = cost;
>     266 
>     267                 if (table[i].cost >= prev_cost) {
>     268                         table[i].flags = EM_PERF_STATE_INEFFICIENT;
>     269                         dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
>     270                                 table[i].frequency);
>     271                 } else {
>     272                         prev_cost = table[i].cost;
>     273                 }
>     274         }
>     275 
>     276         return 0;
>     277 }
> 
> The commit added a new success path:
> 
> commit 1a1374bb8c5926674973d849feed500bc61ad535
> Author: Jinjie Ruan <ruanjinjie@huawei.com>
> Date:   Wed Oct 30 16:24:49 2024 +0800
> 
>     cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()
>     
>     cpufreq_cpu_get_raw() may return NULL if the cpu is not in
>     policy->cpus cpu mask and it will cause null pointer dereference,
>     so check NULL for cppc_get_cpu_cost().
>     
>     Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
>     Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 309cca11b239..956d672c6d57 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -474,6 +474,9 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
>  	int step;
>  
>  	policy = cpufreq_cpu_get_raw(cpu_dev->id);
> +	if (!policy)
> +		return 0;
> +
>  	cpu_data = policy->driver_data;
>  	perf_caps = &cpu_data->perf_caps;
>  	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
> 
> regards,
> dan carpenter

