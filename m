Return-Path: <linux-pm+bounces-13927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE54D972D26
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 11:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4561F26368
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27F187FE7;
	Tue, 10 Sep 2024 09:13:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CBE17BED6
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959628; cv=none; b=BQNs/Rvsqhzz4JHmhTLqs6mHLU+0N77pC1LLAAv34YaGI7F5qBaEv47XG1C0wRa2oek5Y4T9obHpA4Be6qFAhV83Fpc6Tekrn5JNXIGhATiOT7B2PQ7j8ou4+hvmU2WDTPq9kueTbSMfHt0whqjGT5UTd9gSf5gaIE4Ijwa7+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959628; c=relaxed/simple;
	bh=DJdS2SI42GcB9p0WPdnYzH+yL3DWxpEY2EutTKyiI7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpKGgWnyeUw/jo86hiT7tmgtGKSALptLjYHAjX3T8Dj1dkYSXfd4d3FKiHMdReiok6zIEB1BE+1EgX14+uiw6FOweqLozyn3dnczdvRntENiaC/xOoM1rPDTCCxc7ayvmFPsqVQm2MiYkERg2Oy8Qv1abFHMEJjzJDa/l7VYPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24F3B113E;
	Tue, 10 Sep 2024 02:14:15 -0700 (PDT)
Received: from [10.1.26.79] (e127648.arm.com [10.1.26.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6284D3F66E;
	Tue, 10 Sep 2024 02:13:45 -0700 (PDT)
Message-ID: <f4478146-88d3-445c-8676-7246bf477c50@arm.com>
Date: Tue, 10 Sep 2024 10:13:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PM: EM: Question Potential Issue with EM and OPP Table in cpufreq
 ondemand Governor
To: "chenshuo@eswincomputing.com" <chenshuo@eswincomputing.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <202409101046414978042@eswincomputing.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <202409101046414978042@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/24 03:46, chenshuo@eswincomputing.com wrote:
> Hi Rafael,

(+CC Lukasz)

> 
> I am encountering an issue related to the Energy Model (EM) when using cpufreq with the ondemand governor. Below is a detailed description:
> 
> 1. Problem Description:
>    When using cpufreq with the ondemand governor and enabling the energy model (EM), the CPU OPP table is configured with frequencies and voltages for each frequency point. Additionally, the `dynamic-power-coefficient` is configured in the DTS under the CPU node. However, I observe abnormal dynamic frequency scaling, where the CPU frequency always stays at the highest frequency point in the OPP table. Below is an example of the DTS configuration:
> ```
> cpu0: cpu@0 
> 	{ 
> 		...
> 		operating-points-v2 = <&d0_cpu_opp_table>; 

Do you mind sharing <&d0_cpu_opp_table>?

> 		#cooling-cells = <2>; dynamic-power-coefficient = <2000>; };
> 		...
> ```
> 2. Root Cause Analysis:
> When using the OPP table and configuring the "dynamic-power-coefficient," the `em_dev_register_perf_domain()` function in `kernel/power/energy_model.c` sets the flags to `EM_PERF_DOMAIN_MICROWATTS`. In the `em_create_perf_table()` function, `em_compute_costs()` includes the following code:
> ```
> if (table[i].cost >= prev_cost) {
>     table[i].flags = EM_PERF_STATE_INEFFICIENT;
>     dev_dbg(dev, "EM: OPP:%lu is inefficient\n", table[i].frequency);
> }
> ```
> Since the cost is calculated as power * max_frequency / frequency, the cost for each frequency point becomes a constant value. Consequently, except for nr_states - 1 (where prev_state is initialized as ULONG_MAX), all other frequency points' cost is equal to prev_cost. As a result, only the highest frequency point (table[nr_states - 1]) is not flagged as EM_PERF_STATE_INEFFICIENT in the EM performance table.
> 
> In the em_cpufreq_update_efficiencies() function, the following code is executed:
> ```
> for (i = 0; i < pd->nr_perf_states; i++) {
>     if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>         continue;
> 
>     if (!cpufreq_table_set_inefficient(policy, table[i].frequency))
>         found++;
> }
> ```
> As a result, all frequency points marked as EM_PERF_STATE_INEFFICIENT are flagged as CPUFREQ_INEFFICIENT_FREQ in the cpufreq_table_set_inefficient() function, causing these frequencies to be skipped during frequency scaling.
> 
> 3. Proposed Change and Testing: 
> On Linux 6.6, this behavior affects the normal operation of the cpufreq ondemand governor, which in turn causes passive cooling devices to malfunction when using the power allocator strategy in the thermal framework. I made a temporary fix by changing the condition from:
> 	if (table[i].cost >= prev_cost)
> to:
> 	if (table[i].cost > prev_cost)
> After this change, the issue seems resolved for now. However, I am concerned about potential side effects of this modification.

But this doesn't solve the actual issue, if cost == prev_cost for all
OPPs then all of them but one are indeed inefficient.


