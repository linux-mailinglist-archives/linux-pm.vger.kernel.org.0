Return-Path: <linux-pm+bounces-3369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF268494A2
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 08:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E9A284FED
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 07:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F110A01;
	Mon,  5 Feb 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8c9ZoTf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5BFD51B
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118699; cv=none; b=cmM9Dsj+TtFr01cgLU2fpnGMkTuoXm17NJ740CFRDD2/tqJqCGrEysne21BG80T8/Dt8jaGxEMk+4sGeK/wzm0KUYeqV4Mko8JwIBeGmYBzBs3etYzyR5U4hln/NyHSSJsXoEt4DP51+tKMBfpoCiBWATXFbVhQ/VG7i/EtKVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118699; c=relaxed/simple;
	bh=52y/CrfpzJ3Xh30bgq6eajaZLuq7UfJcxxjBggUsG+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2eNfSagNOVn2E46Vmpgn+jMgHO6j+8+m+jJPiQELmRrFUd08xOuDSeF93ly+MQLwDhuq3QtwPSgFCe88StOaKiBK64nUVrcVMW5GpmVn7YL/i3n2aacRq89UL4JmEH3NP2iFAXPT5ICB/3ev7uO2PAGGPJBjfO9bZzUIpFwIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8c9ZoTf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d93edfa76dso34773285ad.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Feb 2024 23:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707118697; x=1707723497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEP2pmkNFzZnlqpvEHga5Kb4ynnO9XIEBYA3Oat6G1g=;
        b=c8c9ZoTfkp7/7v8b0UowSFGyT7hPEunpHvJL+fbuB4T6G/8Zz5iwBytFbyyRfI4T11
         N2bMLZYo1Ty7OdAsuzVjS/BhEsJUCTBIfLnE3IQvwB9hR2OSu2M2wNS9cOtAQTq6fU9a
         AiwbnmRCvUQOSSjNHeH6+zQqATmTmguT82uwWVLHchXNhC/4TsABhfhBZzFnZJzB1CnG
         ZTCMrZPNs8lLed9xV7tAJgly2msuR/KM+7H5+64pjH7UpDAbpeOesvpj5WEDKacdKLgr
         NDqC5A1mbpHbpBz3pVcOVrkzAbOpTZZ25eKwUPG23+umddcIXQWnc8Vw7/l+OkVgNutB
         FQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707118697; x=1707723497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEP2pmkNFzZnlqpvEHga5Kb4ynnO9XIEBYA3Oat6G1g=;
        b=bbDfi1SahhAWOzWGy/fIxQr4DKyftmDEQa9ui0B0a4+9NazckVYfrgYGL/2mwUdW7y
         mXP7z8QSFtUJ5eh5ARRZYWW97VqhlZhvAqdTapTp7AvxyKWumiZhTgXVWG23qSwBkoZN
         sBHNQjWXtrmlgvTpB9hN89+WyXRmGSxFqxZgDRLSG9V7hJEpv6dgQKt5J4sB2Aa4SXXJ
         KqcG7lcEmxVuEF5pYZplSpLck1X3DnTX87XGXlAoWNxHjVISgTP+wuWadT4EKmTTZINO
         rICfqeuauWvgNvB3ex2q44EO45eGYEG1uavGMpYwkFCDw3GuZnRZCDJR5uw5arI8/IkU
         w6tg==
X-Gm-Message-State: AOJu0YymK72lXQ8egZEhB03b41A4/A1RjT7E9E4H5MFB21lS8pWoJgll
	wqk4jxqPLn0yBIByPXnBJmAe3XDsEW/NLplUCSix9EpC3aNmcH5tvtOAi2fJaU4=
X-Google-Smtp-Source: AGHT+IHIPMxdkut02CAeD0jpy2G42WzXmDaMBa0KY2Mu+pdsw6s9EHy2Q/pScdWZ2g+Hh1b2riVbVg==
X-Received: by 2002:a17:902:c40c:b0:1d9:a6e8:1c8c with SMTP id k12-20020a170902c40c00b001d9a6e81c8cmr5425593plk.15.1707118696685;
        Sun, 04 Feb 2024 23:38:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYMMz6O7wshNnmmwb2g2UtuxwSEDKB8eA+JcSYIcn3qzxC3tKql8LoCrB5F01xUl96QuYhs7WYRdN+wWwKYzVDl4eoa+Kt7RMluv0C6fPHf2d+9Vnwup9YNhFdQfKA3XR6o+9/nX6kZavO1Sw2MXhz2mKFGn0kCQswpApauvEdSrKnZTZIQ26okCh0UmrHFMCFM86u3qNdZa5eFwbwLhB7vyIudVmMeSZoJKwiZqj1hRM=
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001d7610fdb7csm5608811plj.226.2024.02.04.23.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:38:16 -0800 (PST)
Date: Mon, 5 Feb 2024 13:08:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lizhe <sensor1010@163.com>
Cc: vincent.guittot@linaro.org, ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq/schedutil: When updating limitations, frequency
 modulation interval not become invalid.
Message-ID: <20240205073814.s656yzrv56tecji3@vireshk-i7>
References: <20240204140928.2865-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204140928.2865-1-sensor1010@163.com>

On 04-02-24, 06:09, Lizhe wrote:
> If the current frequency scaling policy is schedutil.
> echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> This would result in an invalid frequency modulation interval.
> In sugov_limit(), sg_policy->limits_changed is set to true.

That will only make us do an extra freq change. What's the problem with that ?

> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..a0af38fcb7e2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2631,7 +2631,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  
>  	if (new_gov == policy->governor) {
>  		pr_debug("governor limits update\n");
> -		cpufreq_governor_limits(policy);
> +		cpufreq_policy_apply_limits(policy);
>  		return 0;
>  	}

-- 
viresh

