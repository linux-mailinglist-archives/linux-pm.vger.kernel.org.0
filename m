Return-Path: <linux-pm+bounces-10011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1019177F8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312CA2838C3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A713C81C;
	Wed, 26 Jun 2024 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gaih5Zrq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAF28DDF
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 05:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379118; cv=none; b=Y4Uc9D6vH90BpqaVbp95stWL/QIgGc60/bvqzHEoK7ossQyfYi3UQNFqSJ4Wqb94Hlfgi0jCR7hq+eEiBl8eEyzxzPcTaUC4ULBh38MMaXXBd8jGgNfa+6mcEW1FV6z5R90hGz/1Rs2YFejGLTTFaJ2PRH6r2fSby+V6t5n+D4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379118; c=relaxed/simple;
	bh=WbDjqLAOn5sOArr0i1ujzs7YvI6qD2WfYDY4w3ZUNQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqeqJ/fCwLwWW5DCpavjpKutWIlYyexh8ll7MpXkWxrJcn9o5eGbOeKHhCiTKme3c3Z/O11k8n/a7PVAjPCnoErLKemqliNMCRgrM5Tf7p63tirGilfLcOCKdAZR6Wu/KJ+LWXIVHshhisN9/sxlAFZl6JKckafxZzB2X+ShUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gaih5Zrq; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d55f198f1eso309854b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719379116; x=1719983916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oH6p6Eb6RGw/BoHyf/PfG0a4PQGNgd8fK0uUA4qTBJo=;
        b=Gaih5Zrq8+17HBE5cDCBP828l1qPs5azpaSWf93ztmMzALpitMCEsFnkNyBdUPSmW2
         U9CtWVGigUwNLpE/i/G4598Xvw5jNrKhq7Wsn042PIa2aT6doPEkNCxGbxUF51lX3tp0
         RYjF87QNaVf349lNHHP03xtvKXUoOD4zwp1vXtGOAmopAmrRRD6VsNofqAf1Ypyec27H
         KeJqoRIb2mAyeO/qxDVcNP63U5okWVJjGgbBOZTXtXLQZzzhKFwMAICkxyEcmMYMrZvb
         Lydji87iGOnx9UPi8L03TYWa3Cw4gcIuWr3IXrVs9im2v6azb7skgR492virVvESp66x
         BC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719379116; x=1719983916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH6p6Eb6RGw/BoHyf/PfG0a4PQGNgd8fK0uUA4qTBJo=;
        b=r74Y4blP9XTfPkIeVA6FENh5ZaToUqkeaFyJF1rJEhvdRccb+g66g6d/bhyIYKUFRa
         qYXQXTYMrYnkzmQftvogNFsopjssWzoLpcEC+VnP3e1bsJZU1vr0CFHJ+lbntdoilHoG
         2YmQk5+pmXZVFXQSO6vGivdM2kkA5tcyAJgIlq8+LpFGggoB+oXokCOba3Um+Oci6jWm
         gORv8IYFEgE5jvfz/tzdxtijEgQhpgA1FPzWUH1IuKz1McP3y0K723tGRGdURNGiwGUJ
         t7V7PwQvwBy+I7tXaBC/jK42ZVKciCSD2ep4oA2ldO0sSXbv7z2N/OTtc/t4PRwPM0EN
         kGsw==
X-Gm-Message-State: AOJu0Yw+y2d0DGA32XRv8ZrusSyAPB96xvAGsPFQVNt5jpOid1uuy9J4
	SgRPW1JOBMT65SzE6WkB1kh6y3Vv+2+Ovs2ip+NqDNu9ytNT0TFXfQ4bodkxFl8=
X-Google-Smtp-Source: AGHT+IHRrWWSSq7Cutl++Xa6sp2ep8K0Mwc5ypiAb15SuYI+AKn4BtZsjO9Ikv+qJKnZX28O96FR+w==
X-Received: by 2002:a05:6808:3093:b0:3d5:4213:82a0 with SMTP id 5614622812f47-3d542139021mr13215883b6e.45.1719379115486;
        Tue, 25 Jun 2024 22:18:35 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706863876ebsm4752202b3a.142.2024.06.25.22.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:18:34 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:48:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] cpufreq: Allow drivers to advertise boost enabled
Message-ID: <20240626051832.axsmudzfkqvc5pb5@vireshk-i7>
References: <20240626041135.1559-1-mario.limonciello@amd.com>
 <20240626041135.1559-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626041135.1559-2-mario.limonciello@amd.com>

On 25-06-24, 23:11, Mario Limonciello wrote:
> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
> policy incorrectly when boost has been enabled by the platform firmware
> initially even if a driver sets the policy up.
> 
> This is because policy_has_boost_freq() assumes that there is a frequency
> table set up by the driver and that the boost frequencies are advertised
> in that table. This assumption doesn't work for acpi-cpufreq or
> amd-pstate. Only use this check to enable boost if it's not already
> enabled instead of also disabling it if alreayd enabled.
> 
> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
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
> v14->v15:
>  * Use Viresh's suggestion
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..270ea04fb616 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>  		}
>  
>  		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
> +			policy->boost_enabled = true;
>  
>  		/*
>  		 * The initialization has succeeded and the policy is online.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Rafael, this can go in to the next rc I believe (along with patch to
acpi-cpufreq).

-- 
viresh

