Return-Path: <linux-pm+bounces-36942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3CDC12E9C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 06:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFE9A350F23
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 05:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511CF279DA6;
	Tue, 28 Oct 2025 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDOBR5lU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051A224234
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 05:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628241; cv=none; b=TpS4Sg29REyM0RSuE8ZbdXys8w7qcot+v0+JGGLBcWgg/2kkaYbDrUJfP/IxiidQRkfoGMvmCSDkgez523zJlvcRvadPcPLsGz7zsiatmI7DUQ7NPDhNT1bvwuH6wVl+McIZw3TafdGra/5FvsVUBTwGzzWtmsoH6I9g+Xp+cMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628241; c=relaxed/simple;
	bh=40O++wB2FKhQIcXBoArSMvDK9vuoqAHsWfkqxR3yAi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXKkXa8jfCdetQKBNuw+OM1L9dhiKwQY071mBic6v9MCMiyDwQfoD9z+1VF8HXIzoiItEoiTAsBy+9a3VTggKNgTN151r/Q7Nfk1aZ28qwq9zNAhSl/nPmM+bzSPdZUZiFa9x1rL0E4S4z7HZ/hR+S5ZTAQGh+NIWiUbXpr6FXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDOBR5lU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so4180554b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761628239; x=1762233039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCqr2A4tFWO56+nsiAFj8w8uU6z9HieZzNnrp5Dee6U=;
        b=TDOBR5lU1ufdTYooxd9Ha74HfkaaW81VQmvSjh8DAV16BTqYQ6X8VSliOU+XbUzjpo
         PFzFWQUcsK1XXwRLYBfnyySZuftIT7nth+xsGUgHoAJ6sHFXeFlQ56fsbp7cHI4G1Jch
         Sm+BlyxGJJqBOljD3kgMAeX/53rcUSmZyMJ4ogfa4HKTfvFBL+r0SjXYyMQ/kjwHeAu3
         I1DoiaASQBd2pi7iq23gKR/IiVe04ndGV3Vu5Bc9+HCXWgtdhi4DqRp3QEPObQFx12iV
         0pywAVwcmAIIS/CniwI5QaxtXA4OXuEYh6e1KR8pr7VjqKcyJh2DjJpkagJTgbUBE6yV
         LBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761628239; x=1762233039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCqr2A4tFWO56+nsiAFj8w8uU6z9HieZzNnrp5Dee6U=;
        b=RtJ61N9Gs/ECabs9iI0fqVCPU/fio7yQLPHFOhnD9XHtYha9DkyxQosjFoCY8uGO9G
         Mt5lgLTUz5GO/xcQTfyl2aoFYAPmNkySEdQfAc6GetGo1jPwfUnDJ0uAEAPA9tG2wkmn
         azpmK3nh9dO5hSycLcN19/SkOHctG757OFH8D3xvFd/9HF+5gd9rXORgbaCv95HT83uu
         wieOCL7AkbLOOQZvUnM/uy0ys2ZXBtH8d3DyPt5oXrn9faSxKTpCqJctZywnL8ZcdVtM
         ldq08PVgHZ2Nc2Tmzh13WIXfbaUNpiea6va9MIeRdK2ckJtZcHDI9l6CqeAt+VHawA82
         xTHw==
X-Forwarded-Encrypted: i=1; AJvYcCV7CWXV1g/WBEooVXiEfKxDuYb6owHwLtmGIw9RNiyUrhOg4wcAofvIw0+DvEruVLoN3LF/dU5AAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmSPc/CInDOeRSyDMlOmywZTvzehb/Ds2ChsvR3D32vQZsit0
	rcEvjxXFhz5P3eYin1Lx/tSXXEjTpCLtJhfcdhFTJKIKs8tXZvOERTzli0OWvWGYz6g=
X-Gm-Gg: ASbGnctOkWhe+E3tegnHnB8WUdYhhwkvndWng1CgVMcnT9wLQgcdIaw953rMpBrils4
	BkDmJ6AO3edih21LkheKYszIUogWfhLIUJD8Tw3+USnQtA4Or9D2/OlL1MEcYnhArnQPR0VBWb9
	W3fB7dF24zxZ5Ezv1eN2utAfFJsTmaq3wQ4nnChCYkorO9OUZyxFB1NufysuFQO8LfAAko34VGN
	VSctASIYobEbkkgxBw1AM9dgbDcpyCDZMisDjqwstbtj21KpTKWJ90dsq2glbrWED1DhQh5W0n0
	V5gUwEp7Z5K4jg+8JS9Iy8Zmu44pY4ktLW2RDXiIuxp07+yU0sa3IL6pPgax3kDwIq+D3AtQN/F
	y3qRLTJP2kk5RDQnZ8ZikQyn4D/bPuETxf29zUt5mnWHs4lj+rRn1zbH8a6eD4lLd7Mq+U3n+QV
	0IZw==
X-Google-Smtp-Source: AGHT+IH3PzOT/Gzd4Jq84gD+JDZaE7asS8taydUlJ6e8s64E1mDRpk69qEQv1J7IkKuekdlAsY/POA==
X-Received: by 2002:a05:6a00:4f93:b0:7a2:7157:6d95 with SMTP id d2e1a72fcca58-7a441bde05dmr3061529b3a.14.1761628238847;
        Mon, 27 Oct 2025 22:10:38 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408e617sm10106630b3a.67.2025.10.27.22.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:10:37 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:40:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: rafael@kernel.org, ionela.voinescu@arm.com, beata.michalska@arm.com, 
	zhenglifeng1@huawei.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, jonathan.cameron@huawei.com
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: Don't warn if FIE init fails to
 read counters
Message-ID: <h2k4enovkvyasxkf3s6ceslpdnhhuvems3jmmv6a2q2zg4nsap@tlsqppgiszwo>
References: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
 <20250828110212.2108653-2-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828110212.2108653-2-zhanjie9@hisilicon.com>

On 28-08-25, 19:02, Jie Zhan wrote:
> During the CPPC FIE initialization, reading perf counters on offline cpus
> should be expected to fail.  Don't warn on this case.
> 
> Also, change the error log level to debug since FIE is optional.
> 
> Co-developed-by: Bowen Yu <yubowen8@huawei.com>
> Signed-off-by: Bowen Yu <yubowen8@huawei.com> # Changing loglevel to debug
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 4a17162a392d..7724318b3415 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -144,16 +144,10 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>  		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
>  
>  		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
> -		if (ret) {
> -			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
> +		if (ret && cpu_online(cpu)) {
> +			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>  				__func__, cpu, ret);
> -
> -			/*
> -			 * Don't abort if the CPU was offline while the driver
> -			 * was getting registered.
> -			 */
> -			if (cpu_online(cpu))
> -				return;
> +			return;

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7724318b3415..5a30c1ec0cdd 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -144,6 +144,11 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
                init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
 
                ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
+
+               /*
+                * Don't abort as the CPU was offline while the driver was
+                * getting registered.
+                */
                if (ret && cpu_online(cpu)) {
                        pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
                                __func__, cpu, ret);

Applied with this diff.

-- 
viresh

