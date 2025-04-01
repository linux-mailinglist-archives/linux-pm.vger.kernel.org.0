Return-Path: <linux-pm+bounces-24683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4543DA77678
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02DD7A3B30
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C51EB19A;
	Tue,  1 Apr 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3T/FrSm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970471E9B32
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496355; cv=none; b=MLcbr7HRqA//a7MbXbsgF9e0DiC5MX8dS/FzaQRxwIK/82W3uwF6aTxIl2BB50gGI+rh/zDKnED14bSYb/+OZ4QPMU0xyefdVB0hcwwyxN73KG96yy+uPACkvI7xuE2k4GoUpzxMIN2Mk0UmHSWDeJUWVnQmtGeAJFSvQDyTPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496355; c=relaxed/simple;
	bh=+IeMsyYHgojZkFiAHUA5/qujZHsw48CXJaC75pqZO2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWRl4p5lfHHzubYsDDOotQnYnTPQYEhpPsTC0sx2mUTyjax6syMttt5YpbBt5uoOXbfOzP2ojCfHyMvmx7iarNhESft2/SiP7SykDQmmZJoAb8mTVivmRSzd3WdSaWjsSzKr+qghvfe6KJpFNwkW2WnJBLE1lmTvqcz6LUAeXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3T/FrSm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2243803b776so29069715ad.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743496353; x=1744101153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNRcQhgu6XyiZbmSNQ5S9+29mIU+LPTMUt4TXKg2XTs=;
        b=K3T/FrSmTGXdXSFF+ti1KI2wxm1biUjXefI2f4v6l6mI2bFRiAbcY3wI5uaX1bqjgy
         h5nuZPHnFwxP21abBa1z5NHXAg7lItcFqcMeJc2bkuheT2wwVGcqSyg5tC7exlt3RJnh
         +jtaGTPPAvD1UmTdUz0JWEnG0XAA0JBQcLMED8atqZ9WFJzl/8kvcqhIO/C2uBeLqpaN
         vYS2Yl81tP9dNjawAKpKP7PJz99J7BTmD4qeGQJFYtm4UrXrHdi9aoz0yyVa4x+pwlDW
         BrvXIYnjNmurImZ1cI3AJ/8qumDX4G3OnbxWIpM+VPnrmakJhtZEjOEp8Jo3W1H6Z+BM
         EDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743496353; x=1744101153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNRcQhgu6XyiZbmSNQ5S9+29mIU+LPTMUt4TXKg2XTs=;
        b=PiISKflH2DTFTyI3zKob4RMcmbMpd4CTIp+HCMrCTkUXqyO+ZZmxP3h7txFk67+8OH
         0FDz6yhPb6VBAigtBuJTS1YR04Pk8cbnzGOitZ4rke3h1JMJXFp7RaXHADV8IvrOlvGN
         3ZxmnZEbeK8IvG329ghX+fuVfbzOEMmq3xf+li1S0LfUkbnJoUg3gvoJvYZw87zupIU9
         dgmafVxIJNdwxaNIgFBMpz+arqCj6eHAAKK5U/I+Bjoje3GD+yrow9OOjoNG8zx9Z43b
         blc9+hvOL4duVRgCPchzkNx7MzjX6fKgJ9V27pTrC8I8Nzn2Juyc3qy7SQ6uE7aaMxGl
         dilw==
X-Gm-Message-State: AOJu0Yx+aGa7d8RLj5f2CYsLC7OsyxjI/Ealn6g+3ZOB5xBbXp5Vjw1F
	Ug7mAWcglAfMqiFyhB9B2wSfz7VbH6/Z+nqRKmR9xY0MK65fxUZQlB5QJVeVRzw=
X-Gm-Gg: ASbGncvlPoGDPfs0EWhXhOnt2iXRLaM6Ak/WSSCh7POIsFLddYHMqO9SBE+vhmVdIRK
	6H4JSE0iUbrnvoulUgMrgEzD7tjiMCKHvueBH0F03yQ3xAE76J1evu2aIhEN8qY7hPCzUy7aYDg
	dXe0Q/0xapAgjngU+bqmIs2vKtGcdDpjIpcH6BhNsVv7nhy77SEfFpVeZgSy8Ds3Q/h6No6juuF
	x/agi2YnRKvLii+vItUNJcmFqIVtSV1LXU1nhIT8n9M62RvDxdxC+wWBgNL5kgwodDlb/0893UM
	pF8zS1nyXhrqSXa25yfCN2ybBWzKVIcL3qQwYz9qpTEDMRHmF1dqe6HQ
X-Google-Smtp-Source: AGHT+IGgKUaL1ynzc20b9V1SBaeeBQH7RLhiudbNEW7GcnbbKKQ8W4iTXsHvc0b1mnlkIF4F16wd5w==
X-Received: by 2002:a05:6a20:d501:b0:1f5:889c:3cbd with SMTP id adf61e73a8af0-2009f7ee1e5mr21700143637.35.1743496352943;
        Tue, 01 Apr 2025 01:32:32 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93ba190f2sm7594922a12.70.2025.04.01.01.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:32:32 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:02:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 02/10] cpufreq: Consolidate some code in
 cpufreq_online()
Message-ID: <20250401083230.zkqy3i4uo3yeyw76@vireshk-i7>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <13741234.uLZWGnKmhe@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13741234.uLZWGnKmhe@rjwysocki.net>

On 28-03-25, 21:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the policy->cpu update in cpufreq_policy_alloc() can be
> moved to cpufreq_online() and then it can be carried out under the
> policy rwsem, along with the clearing of policy->governor (unnecessary
> in the "new policy" code branch, but also not harmful).  If this is
> done, the bottom parts of the "if (policy)" branches become identical
> and they can be collapsed and moved below the conditional.
> 
> Modify the code accordingly which makes it somewhat easier to follow.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1306,7 +1306,6 @@
>  	init_waitqueue_head(&policy->transition_wait);
>  	INIT_WORK(&policy->update, handle_update);
>  
> -	policy->cpu = cpu;
>  	return policy;
>  
>  err_min_qos_notifier:
> @@ -1394,17 +1393,18 @@
>  
>  		/* This is the only online CPU for the policy.  Start over. */
>  		new_policy = false;
> -		down_write(&policy->rwsem);
> -		policy->cpu = cpu;
> -		policy->governor = NULL;
>  	} else {
>  		new_policy = true;
>  		policy = cpufreq_policy_alloc(cpu);
>  		if (!policy)
>  			return -ENOMEM;
> -		down_write(&policy->rwsem);
>  	}
>  
> +	down_write(&policy->rwsem);
> +
> +	policy->cpu = cpu;
> +	policy->governor = NULL;
> +
>  	if (!new_policy && cpufreq_driver->online) {
>  		/* Recover policy->cpus using related_cpus */
>  		cpumask_copy(policy->cpus, policy->related_cpus);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

