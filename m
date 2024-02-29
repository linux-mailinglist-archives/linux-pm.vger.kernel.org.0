Return-Path: <linux-pm+bounces-4542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B186C45C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 09:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA307B217AE
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6C756740;
	Thu, 29 Feb 2024 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3q4lffA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5A54FAF
	for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197105; cv=none; b=KRFalhSLNo+Hr4dSI2kEaBUbTLP51JkT7wl2EcUpcm2bE/D15OMTIn3iKLxotKCA093XDkWKZmKcEGLGyyn6AbHeTT1HWZxtB3hgTddfkx4VfS1kqRthSPrJYVB/KNqacCcOciNMGly0pkdmmUojDUA5AGtsvjPneVNmZRq+PDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197105; c=relaxed/simple;
	bh=dcewNBcHXpRd6zux831H86oXW4KGVXl8SnfiHvFNgPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cU99a/9f1tuy7OKOkGlfc5jAgOHb8ffyKVmp1MMtuw9MVvaMVSclipWpspS8lZB1tLmQGVgb6ML7oQNnkbuNZqQSl0hKtGoNV02ZLSNRC5fZDRPMrl9T87D7EbwJOBGh7tlR16GcMmXXUQMkT/6W/U9KCj3hKW3GxYRkESLbqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T3q4lffA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d118a181fso409910f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 00:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709197102; x=1709801902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlHKEZ3ifp/CFJVO7AU+vAHFrWFd5vKO5TXizCzFcrc=;
        b=T3q4lffAqHlvdwXL2Z3TXmx4qga2BkIT/sIXrCNpJFsV+M29mQRS7lKaUM9DAdikkt
         +1YI2G/cdUcbGLwyzYXrc1Uto2wK88NlKFZO3DMD4ec8v/gqC1RIVltSrnt2JmW9SALu
         Lvp1dlMRU7PDwb0ooYr7psHKtY+A0PmomCY/ohk6IKPMdlioc4QA95sEieVeflUwEU5a
         zXKkKhrNwq2ODuNBMC+rIJBWWOP7Cqcqy/vI4HQzxmZPshbxYiWrTI1IO1vkPqposPRD
         OEtyKbSnSvx7siUTa8lF51ipvkGLkhX3g7ZVEUJ6PeoN84voRj2Sn3B6yaQUxnx7Bdo4
         Vbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709197102; x=1709801902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlHKEZ3ifp/CFJVO7AU+vAHFrWFd5vKO5TXizCzFcrc=;
        b=oa8pISAIpwg/fa0HL0CHA05U3dX5eCpdRZ77SAs1v/RVio9t/nOAmIfHXl6dnD8Mbr
         xezmfyhEmX75cYs3meGGRHFRDRo8a0sgAOlLiOIqjt9m8YQi7zZqRhOZvnsOD9IcwkUc
         2iwqIeiLCXBRCKRMUi6w+5vo69brYTymUYFcScLPI9zZa+9bTYc0TGZ7vU5h8GSAYHgB
         Riue2//fozkKnOWua+KiWaIOEg/UrOVyxaAERnvoyBYQHsyQffgjIeZX6LJ9nblFnTTk
         pHtNAC24BgokhumvB+a1nSmaclpyqpiU6EZZKcnk3gij0l0xzNEkIyf34+mwws7JSeHT
         v3RA==
X-Gm-Message-State: AOJu0YzFefLcN9Tm9lCPh5Qxd+6yHMdesauQX7pkSZ7YcIcyN5tV8c6z
	/fyCCjJ6n0BjQsn9jhAICX6d7ugWjB+QR4kZmR96tpFFSIXdqQcRnpQQNio8DD0=
X-Google-Smtp-Source: AGHT+IG20z3I+TowGmydWizwQ2Dl/Erw5xkSQW1aH5Ji987jq+i0teNqpfyGjvkTg7MDZW2rsJTKzg==
X-Received: by 2002:adf:f205:0:b0:33d:d2bc:bf41 with SMTP id p5-20020adff205000000b0033dd2bcbf41mr916069wro.31.1709197102137;
        Thu, 29 Feb 2024 00:58:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q14-20020adf9dce000000b0033df49c9d00sm881065wre.17.2024.02.29.00.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 00:58:21 -0800 (PST)
Message-ID: <9fe4d309-4ff7-49e8-ad19-ab362bdc6b4c@linaro.org>
Date: Thu, 29 Feb 2024 09:58:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Don't unregister cpufreq cooling on CPU hotplug
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, linux-kernel@vger.kernel.org
References: <1333a397b93e0e15cb7cb358e21a289bc7d71a63.1709193295.git.viresh.kumar@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1333a397b93e0e15cb7cb358e21a289bc7d71a63.1709193295.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/02/2024 09:12, Viresh Kumar wrote:
> Offlining a CPU and bringing it back online is a common operation and it
> happens frequently during system suspend/resume, where the non-boot CPUs
> are hotplugged out during suspend and brought back at resume.
> 
> The cpufreq core already tries to make this path as fast as possible as
> the changes are only temporary in nature and full cleanup of resources
> isn't required in this case. For example the drivers can implement
> online()/offline() callbacks to avoid a lot of tear down of resources.
> 
> On similar lines, there is no need to unregister the cpufreq cooling
> device during suspend / resume, but only while the policy is getting
> removed.
> 
> Moreover, unregistering the cpufreq cooling device is resulting in an
> unwanted outcome, where the system suspend is eventually aborted in the
> process.  Currently, during system suspend the cpufreq core unregisters
> the cooling device, which in turn removes a kobject using device_del()
> and that generates a notification to the userspace via uevent broadcast.
> This causes system suspend to abort in some setups.
> 
> This was also earlier reported (indirectly) by Roman [1]. Maybe there is
> another way around to fixing that problem properly, but this change
> makes sense anyways.
> 
> Move the registering and unregistering of the cooling device to policy
> creation and removal times onlyy.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218521

> Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
> Link: https://patchwork.kernel.org/project/linux-pm/patch/20220710164026.541466-1-r.stratiienko@gmail.com/ [1]
> Tested-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..4133c606dacb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1571,7 +1571,8 @@ static int cpufreq_online(unsigned int cpu)
>   	if (cpufreq_driver->ready)
>   		cpufreq_driver->ready(policy);
>   
> -	if (cpufreq_thermal_control_enabled(cpufreq_driver))
> +	/* Register cpufreq cooling only for a new policy */
> +	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
>   		policy->cdev = of_cpufreq_cooling_register(policy);
>   
>   	pr_debug("initialization complete\n");
> @@ -1655,11 +1656,6 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
>   	else
>   		policy->last_policy = policy->policy;
>   
> -	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
> -		cpufreq_cooling_unregister(policy->cdev);
> -		policy->cdev = NULL;
> -	}
> -
>   	if (has_target())
>   		cpufreq_exit_governor(policy);
>   
> @@ -1720,6 +1716,15 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>   		return;
>   	}
>   
> +	/*
> +	 * Unregister cpufreq cooling once all the CPUs of the policy are
> +	 * removed.
> +	 */
> +	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
> +		cpufreq_cooling_unregister(policy->cdev);
> +		policy->cdev = NULL;
> +	}
> +
>   	/* We did light-weight exit earlier, do full tear down now */
>   	if (cpufreq_driver->offline)
>   		cpufreq_driver->exit(policy);

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


