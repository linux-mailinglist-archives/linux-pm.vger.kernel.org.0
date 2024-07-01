Return-Path: <linux-pm+bounces-10274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13291D893
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 09:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFD61C20D8B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 07:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D059160;
	Mon,  1 Jul 2024 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fk7aQBLw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997895103F
	for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817663; cv=none; b=PgTO3QEYkmocYkRyMKM88Q8qnSrC5VSYYCgHs7lthrApniNBo+pmBfTGr2xQq4XBqpGppoMCLcqeVnNPiD3HJUc19Iw4rgDj8w3FYyakVtmqqNqRkZ9MJw8in0pzYD6mjzj7ObV++cDswVFnnXpBU6OG6QTDsZtT7N843dQIZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817663; c=relaxed/simple;
	bh=6GLrwiqUUvfAiuGqbKYXW7plhU4+iBHwt2pbKQcoVHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omh5eXdtMC/zwO3D9lSJfnqPqsWGRHFxBhN1aRZFy90vfJsCCLl9Ozfb2NVscf1xpM1eTbeKv4BF81k5kYoUWyflMW4T+TcXUMzEtCJgSj6jqgC/8IvoPXb6uOgTsDp7mG98xOAlOOPtiYguiR/AUT2s8xPZuO2h1XkLevjJ/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fk7aQBLw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa244db0b2so17309235ad.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2024 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719817661; x=1720422461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/30S+2Tputv7KJ/XNra2JpUqPnyt7NO1mISFsqN60c=;
        b=Fk7aQBLwydP9mHmyxd22dv95ZZ2ZiuFD+SqHJlYWp9iPG4cKCsydgcysLKN5IOyNYP
         2zX3gXyedwwH69b/7M3+bE99HJqo/KEOlpdHFWSuTXgDFdcMKh2uwKUtjbPnUNy0v+xR
         kv53tlNpNgJOAKifT2WW1LOfEjPZYFzMfR6hxvaY1cLgN6odmXrEb+YMVZOpGGdYqUA7
         gci5CNucNw69SbOsfX62PCcUG94yJfoEO8GURp4W5CCBLeJjKYheEnNVOzoXUuc6+hyq
         JksdSgnCqgi9jlhUMcvdCZtwoQpZa3hkc8I8wFDxNv9ojntyXjXZAQFkyksDjpxq3Zna
         955A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817661; x=1720422461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/30S+2Tputv7KJ/XNra2JpUqPnyt7NO1mISFsqN60c=;
        b=rFSPIUZVY0EE4NHByfg+0IQ2YT4FxW5omosyus1M2zACadYFUf8WK7b8xwdh8Ed/cZ
         vIzoSCle3nmNJOl2RHpIUt0Uz7mEtCouHAW55230C3Fh5/nHyufFgnxzKQHmCQLFqYQf
         6dur6h050GH3NficbSppFMtitcW+jb18a++nQvJ1XSD14bqsi1ImpNzqOWnp8Ima1E0V
         zJWJOIVKodkKkRvZuiRBe6T9Ws3FnVrOi+S/RknMabKt+YXztHIpME5d+EKWIIIkWHDQ
         5OLGF+6oOTgtmi9jVpP2WTxjx9mIIRt7UHD60z/mxaIObFGCYF/9Ce376dMl2XySqy/w
         Br+w==
X-Gm-Message-State: AOJu0YxkoLmIZtk198tk0H5kWe48/vvA21c04y8JCWmG9RVsD5AWic+V
	nIpuoA2vhrp1B4v3wz4DWop5SeU0BClEpUDmukJRI7RvW8rIYUvm1LIjapJPCnA=
X-Google-Smtp-Source: AGHT+IH2+L1Dd28f4CYmpe4yhDTFikkTK7jBxKF8hUYUypZWvA2zKrjmH3O7CISX2XMUohHBDi58sA==
X-Received: by 2002:a17:902:f709:b0:1f9:ada4:5907 with SMTP id d9443c01a7336-1fadbcaa754mr32263575ad.36.1719817660644;
        Mon, 01 Jul 2024 00:07:40 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad2d6dc43sm46457985ad.126.2024.07.01.00.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:07:39 -0700 (PDT)
Date: Mon, 1 Jul 2024 12:37:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] cpufreq: acpi: Mark boost policy as enabled when
 setting boost
Message-ID: <20240701070737.65escrs7c4gidxc5@vireshk-i7>
References: <20240626204723.6237-1-mario.limonciello@amd.com>
 <20240626204723.6237-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626204723.6237-2-mario.limonciello@amd.com>

On 26-06-24, 15:47, Mario Limonciello wrote:
> When boost is set for CPUs using acpi-cpufreq the policy is not
> updated which can cause boost to be incorrectly not reported.
> 
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The below version log needs to go ...

> v1->v2:
>  * Move to init as suggested by Viresh
> ---

... here.

>  drivers/cpufreq/acpi-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 2fc82831bddd..fa2664f9f259 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -888,8 +888,10 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
>  		pr_warn(FW_WARN "P-state 0 is not max freq\n");
>  
> -	if (acpi_cpufreq_driver.set_boost)
> +	if (acpi_cpufreq_driver.set_boost) {
>  		set_boost(policy, acpi_cpufreq_driver.boost_enabled);
> +		policy->boost_enabled = acpi_cpufreq_driver.boost_enabled;
> +	}
>  
>  	return result;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

