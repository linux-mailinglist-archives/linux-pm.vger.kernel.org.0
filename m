Return-Path: <linux-pm+bounces-6302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AF28A26AD
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 08:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CE0287B43
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 06:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF53926ADB;
	Fri, 12 Apr 2024 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJlhg4+z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DFC1BDCF
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903634; cv=none; b=kct0ZXne8PpmGVr0OJKKGlueLWvvOwkVYdVDfZ5zregWFu5GztzAc9K7mO7BlBUSZCNVx1wcWFL88zlQGV1Wqi9FhFHKtzUvYeLrgXeJAjViAShwFlgkS9tRkxm71XZiczlDG6W7HgOIhKrhljP07Rp/P10TdEEgxpAwhpTc70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903634; c=relaxed/simple;
	bh=wjy0tCcDDFSFANGy5jt/fSLtKW8TEgDaYPXpMvKiAi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MppNz8uM5GKLZx/YWZh6Tg9aok8Hmchx4lpeAHri/bEl2VCL10QXiFJaN5U3To68aqIfOpDy79tqvwtsuaF4Nd5bCqW6Z7NfaVm1JHTFssQPgRscVFX2Gpp0spPfUssMymXmkKXiYeVHeWQs75uekZxFgwZqDE14aNjvON3o7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RJlhg4+z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e51398cc4eso5989655ad.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712903633; x=1713508433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLvptBdz/0pjB6K/QkOMOBUPaiviyAg/FmtjlBZbyCg=;
        b=RJlhg4+zuYqdxq7IoXkbOVJzTZfz4NYEmYNFda3Yn/EWQJnvgnjdOKOrhP8L+ShBx8
         h5IBybKjrhtLmAORpHZTEimyzebuonOqTjLXfrpddIUxwTm7n4LrKFjfSifoyvUlxu3B
         vWNgR3QrdPlvnsrytBzpDujs9bNoKit7XYOgkJs+Sd10aWvY0++G7or8D0Do8sDF0pmy
         lWSa9Wwfi17HB8XS/mBSIhEbtcG3aoo2S9gjIQy98lElhExplVGU90BBEoiLL4ZHIDiA
         cwa4+1KNzS/eHW2onxXRp6UAeVn8Z2VyPV8QsGhlZYpNLtR1aZ/Cbm7xcuPGVOJ/TzrY
         /CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712903633; x=1713508433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLvptBdz/0pjB6K/QkOMOBUPaiviyAg/FmtjlBZbyCg=;
        b=m9YEW6N0lKz6gjfWsRCnsTeFAqCIRwn+rirZ+L1ZOVfhtlM3b3YeqOCNFynsIOeE61
         Be13Y244M3VSsoejgD9GBu+NdY9PyfAI6HLHoJkyg0GN0dV+2TUS5Cuzep0KAbXxzPTh
         nX2oh4IGoAL3ZZumxugbwTE1OYydM4i29sYTuwLVWLEZ7XzP5CN7WY+I407I6KweLibp
         3r9q4BtbqmpC7DUho8Q8iTLjj6I3xzxtkJfD2xrYNk3yyjyMgFLT8XiU7cl3IpgeOo2q
         9MU0l410g3XFC1e7XciyyYuzLlLcdzEe4t3RRlZ5MhgvoOYGSh+TO47pwN+81dpYwtVy
         5bRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPt4aNVdK223QC5FpuSY1NnTWh5Codw8rAcuiYodKIgL51zjro86IR75izmPoUXiKBKFuOeJN6nO+uZUOu9L47sUrFq1Kz9AI=
X-Gm-Message-State: AOJu0YyloJxELdC9fTzxt7WWqRYX1LKKqjQEKs4oFB/WErFOcNLR+ca+
	ZquljlX8ODL54jvDIAeHNivQ23ti3RmTzNucuDRT32kP4C6Yf4PR8AnT26OI0Rk=
X-Google-Smtp-Source: AGHT+IE6jM9Et3yQ8yb1c9/7mBThsd5wLAGj5SfIUnGojPSeadsQQbg1tFSGX+qbEKoYAGWiHOtv5g==
X-Received: by 2002:a17:903:230b:b0:1e2:9676:c326 with SMTP id d11-20020a170903230b00b001e29676c326mr2096392plh.29.1712903632480;
        Thu, 11 Apr 2024 23:33:52 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b001dddcfca329sm2215394plg.148.2024.04.11.23.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:33:51 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:03:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lizhe <sensor1010@163.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fixed kernel crash caused by cpufreq issues
Message-ID: <20240412063350.oozcb3awzbkk5zdt@vireshk-i7>
References: <20240411231818.2471-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411231818.2471-1-sensor1010@163.com>

On 11-04-24, 16:18, Lizhe wrote:
> When the cpufreq_driver does not provide an exit() function.
> cpufreq offline operations can result in a kernel crash.
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04d349372de3..e8660bc7d232 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1739,7 +1739,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>  	}
>  
>  	/* We did light-weight exit earlier, do full tear down now */
> -	if (cpufreq_driver->offline)
> +	if (cpufreq_driver->offline && cpufreq_driver->exit)
>  		cpufreq_driver->exit(policy);
>  
>  	up_write(&policy->rwsem);

Hmm, saw this just now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

