Return-Path: <linux-pm+bounces-19119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A190B9EE62E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 13:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627411882746
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD9E2139A7;
	Thu, 12 Dec 2024 12:01:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B921148E;
	Thu, 12 Dec 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004873; cv=none; b=sk+i5adYk/AC9gMC77nWEa8KSdPcsq8cHdJQPFHujI9GD1SBk+g4ah+6LQ7mUqJZ5MSIu+hiRNJA+dDVWNTlnidvN939TQbXzeRpycdCG4wbChkxJkikK4dnhdp4zCbJsSOUpWNg83AWCIQ8hiIlPWIOtqh/M1yO6VGxtsAZerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004873; c=relaxed/simple;
	bh=oRKnZBLoKIqnGH9CpV9Mrk6QPMZVHbvlgIvNDD8MwEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJUtK5JZcQ0OoaHIvN9AT8c+w1CbYJSzQKdOdyy1cWps0JoWue6poDM42Jqwm4fyY8RSduGNzXgWoketFn58NsiH+CWzTtmrz33t9eu3QKUp7jTQanhr+3dklPqcm/Fw21sQ1KtFZ+nI8RXvlk+CDMCdhnupIOjRk+RBaeAmIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 07DA31F4D5;
	Thu, 12 Dec 2024 14:55:38 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu, 12 Dec 2024 14:55:37 +0300 (MSK)
Received: from [10.198.20.57] (unknown [10.198.20.57])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Y89s23mbzzkWxV;
	Thu, 12 Dec 2024 14:55:34 +0300 (MSK)
Message-ID: <1599fa5a-5507-4b9c-8b18-2d5e5c7fe694@astralinux.ru>
Date: Thu, 12 Dec 2024 14:55:27 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 1/1] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
Content-Language: ru
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
References: <20241106182000.40167-1-abelova@astralinux.ru>
 <20241106182000.40167-2-abelova@astralinux.ru>
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <20241106182000.40167-2-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44 5149b91aab9eaefa5f6630aab0c7a7210c633ab6, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 189792 [Dec 12 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/12/12 07:32:00 #26886604
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Just a friendly reminder.

Cc'ing Mario Limonciello and Gautham Ranjal Shenoy.

On 11/6/24 9:19 PM, Anastasia Belova wrote:
> From: Anastasia Belova <abelova@astralinux.ru>
>
> commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f upstream.
>
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
> and return in case of error.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8c16d67b98bf..0fc5495c935a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -579,9 +579,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	unsigned long max_perf, min_perf, des_perf,
>   		      cap_perf, lowest_nonlinear_perf, max_freq;
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
>   	unsigned int target_freq;
>   
> +	if (!policy)
> +		return;
> +
> +	cpudata = policy->driver_data;
> +
>   	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>   		amd_pstate_update_min_max_limit(policy);
>   

