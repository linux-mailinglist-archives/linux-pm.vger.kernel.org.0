Return-Path: <linux-pm+bounces-19314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B19F338E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0731888192
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA382C7E;
	Mon, 16 Dec 2024 14:49:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2013A3F3;
	Mon, 16 Dec 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360559; cv=none; b=fUR8us6aix+xfnMiY2q4dsqT6qWMShHDWcr8guVTkf/gmo16WpEP8q9OB6Vvp5Kz/szV/c0zCURlfW/NnT0StQPf4BVNmo74VYFCiClb11Aw0QeweNmeJPFbI2IMmxFTxNIobPvKL91F+B99FGPrd/mnaDKG8di0W3dh7URHPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360559; c=relaxed/simple;
	bh=hNjco/wbw36qp3JDWKD81CWFYpyZSRI27bhTCmPiMvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZtu3kbN1DJkcVLVpJEhQgOQ6DXsag3wuv6s0X/qaHyF90G4m+2RIZpg90hI3mVjqj2ISruszReZFKDDKpXlfGDtt/H/tLIOio552FwAUoZGZ5HSL7tKI4nk3x6Aa6zeAF9teFhH03kJqlR7P9oNZL9hzUxgY9bLjNo/le8tc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C849C113E;
	Mon, 16 Dec 2024 06:49:44 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 457673F58B;
	Mon, 16 Dec 2024 06:49:15 -0800 (PST)
Message-ID: <7ca98023-df18-4973-8c4f-18ab381b7aba@arm.com>
Date: Mon, 16 Dec 2024 15:49:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for
 EAS
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
 <2989520.e9J7NaK4W3@rjwysocki.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <2989520.e9J7NaK4W3@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2024 17:00, Rafael J. Wysocki wrote:

[...]

> @@ -261,11 +262,14 @@ static bool sched_is_eas_possible(const
>  			}
>  			return false;
>  		}
> +		/* Require schedutil or a "setpolicy" driver */
>  		gov = policy->governor;
> +		cpufreq_ok = gov == &schedutil_gov ||
> +				(!gov && policy->policy != CPUFREQ_POLICY_UNKNOWN);
>  		cpufreq_cpu_put(policy);
> -		if (gov != &schedutil_gov) {
> +		if (!cpufreq_ok) {
>  			if (sched_debug()) {
> -				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
> +				pr_info("rd %*pbl: Checking EAS, unsuitable cpufreq governor\n",
>  					cpumask_pr_args(cpu_mask));
>  			}
>  			return false;

build_perf_domains() which calls sched_is_eas_possible() has schedutil
(4) mentioned in the function header as well:

/*
 * EAS can be used on a root domain if it meets all the following
conditions:
 *    1. an Energy Model (EM) is available;
 *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
 *    3. no SMT is detected.
 *    4. schedutil is driving the frequency of all CPUs of the rd; <-- !
 *    5. frequency invariance support is present;
 */

IMHO, his patch should remove the function header since the conditions
in sched_is_eas_possible() have comments already or are self-explanatory.


