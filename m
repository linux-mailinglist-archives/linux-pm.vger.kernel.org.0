Return-Path: <linux-pm+bounces-13209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1FE965A5B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB771F26B1D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAE51531E2;
	Fri, 30 Aug 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JhWXyjBV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012141531FC;
	Fri, 30 Aug 2024 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006660; cv=none; b=SCV0FG0JaIdgotuADv+nd5l++SNsseyArhGltb4UH3A/l3g677j1M8VrocTOUnkCUwD61J8RX8Zr4fhbcyPx0fLqbh1UjUs+EiMC27RG+0rfyn9Uj+3c9y4itpUopyYU6Mt8vDHB1FznxBdzbNmxhr28QluBB6xBMoo/wshNM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006660; c=relaxed/simple;
	bh=u5uHgC0EmSMlqRY96JwJkgnF/6XfOMDCloJGGj6hDnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1PazH0HANAbOGSIXj/HYKCqVzv6JljcK1vvylH5CCvq7ZcgOwYXksb0kCvH8cpWpy1vzXIVHWAFnUZJxlIlQ9aqoJ35QXPPl1QUq3UsD17oNg5PoXgvL+dB9plbXXGPr+FH40axUfQteufVTQFMjOCNemZ91wEnXAY07uJdOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JhWXyjBV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3ewrG010341;
	Fri, 30 Aug 2024 08:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=d
	w//9Q4kI10o5QwvEsOAODMUsSmDDkvgUrYDnLcsmfI=; b=JhWXyjBVoYEARBpXe
	U20jFIQd08/8SgreeHHvqYePNuupSxpNl+TtSn4XoQTzxwJk6tkQ49w3bK4u7a9f
	ZDS8O7ZqFWzZr3vfklWB+NBzbpTlmNyn/gPRZd0E5zIaXR3QTJtDIQkloLX2LBI7
	yHv0+HTub3SIUr2tnhJ6HF76A3eahdRWsLOpKzHp1xhXz9nRsAdrBGbEf7sPiewu
	GE3Zf4LJvSsBQ9gSpSeqr6QbJXKtHbYpm7jdvtXwMgwRaPQ/qev9yBoqu8ZMjuwj
	MuH+Rg5GcixvTG05dMSZl2A6jYGOvBgVoUSusnsg3AR+WEKhZtBt9eu7h1/yx3A5
	5JJ/A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8udn8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:30:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47U6DDtQ024673;
	Fri, 30 Aug 2024 08:30:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 417vj3t6uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:30:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47U8UPFC50463168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 08:30:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A48882004F;
	Fri, 30 Aug 2024 08:30:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B5672004B;
	Fri, 30 Aug 2024 08:30:22 +0000 (GMT)
Received: from [9.195.47.156] (unknown [9.195.47.156])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Aug 2024 08:30:21 +0000 (GMT)
Message-ID: <6961a047-979b-40c2-bfc6-d8eddd96694c@linux.ibm.com>
Date: Fri, 30 Aug 2024 14:00:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: intel_pstate: Set asymmetric CPU capacity
 on hybrid systems
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
References: <3310447.aeNJFYEL58@rjwysocki.net>
 <1979653.PYKUYFuaPT@rjwysocki.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <1979653.PYKUYFuaPT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2i3L1xT1w7HH9Hrd5cxiGo0LyzGYvlOJ
X-Proofpoint-ORIG-GUID: 2i3L1xT1w7HH9Hrd5cxiGo0LyzGYvlOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300059



On 8/28/24 17:18, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
[...]
>   
> +static void hybrid_update_capacity(struct cpudata *cpu)
> +{
> +	unsigned int max_cap_perf;
> +
> +	mutex_lock(&hybrid_capacity_lock);
> +
> +	if (!hybrid_max_perf_cpu)
> +		goto unlock;
> +
> +	/*
> +	 * The maximum performance of the CPU may have changed, but assume
> +	 * that the performance of the other CPUs has not changed.
> +	 */
> +	max_cap_perf = hybrid_max_perf_cpu->capacity_perf;
> +
> +	intel_pstate_get_hwp_cap(cpu);
> +
> +	hybrid_get_capacity_perf(cpu);
> +	/* Should hybrid_max_perf_cpu be replaced by this CPU? */
> +	if (cpu->capacity_perf > max_cap_perf) {
> +		hybrid_max_perf_cpu = cpu;
> +		hybrid_set_capacity_of_cpus();
> +		goto unlock;
> +	}
> +
> +	/* If this CPU is hybrid_max_perf_cpu, should it be replaced? */
> +	if (cpu == hybrid_max_perf_cpu && cpu->capacity_perf < max_cap_perf) {
> +		hybrid_update_cpu_scaling();
> +		goto unlock;
> +	}

I assume this CPU capacity is based on freq. It doesnt change based on 
irq, any upper scheduler classes such dl, rt right?

can capacity_perf change slightly or it can change such that it always 
changes to next possible level? The reason, if it can change slightly, 
but cpu is still hybrid_max_perf_cpu, it would end up accessing all the 
percpu structures and change it, that would be costly on larger systems.


> +
> +	hybrid_set_cpu_capacity(cpu);
> +
> +unlock:
> +	mutex_unlock(&hybrid_capacity_lock);
> +}
> +
>   static void intel_pstate_hwp_set(unsigned int cpu)
>   {
>   	struct cpudata *cpu_data = all_cpu_data[cpu];
> @@ -1070,6 +1240,22 @@ static void intel_pstate_hwp_offline(str
>   		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
>   
>   	wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
> +
> +	mutex_lock(&hybrid_capacity_lock);
> +
> +	if (!hybrid_max_perf_cpu) {
> +		mutex_unlock(&hybrid_capacity_lock);
> +
> +		return;
> +	}
> +
> +	if (hybrid_max_perf_cpu == cpu)
> +		hybrid_update_cpu_scaling();
> +
> +	mutex_unlock(&hybrid_capacity_lock);
> +
> +	/* Reset the capacity of the CPU going offline to the initial value. */
> +	hybrid_clear_cpu_capacity(cpu->cpu);
> 

