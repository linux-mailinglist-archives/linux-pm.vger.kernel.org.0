Return-Path: <linux-pm+bounces-8685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB1F8FE200
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC111B25FFC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B210F13D8BF;
	Thu,  6 Jun 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Okd0t8ai"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7E13A3F3
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664442; cv=none; b=nnjRnykEHEDsXgDsJa6/+WZdRWhAlbLKG5B0Y4ep9vIxdA/JQx3cHvfkXn94Dexm+OUd2tr6JvuiEx9oOKnyp6jq8tPmE/dYBajehTVGg22RjWqoYeOu5dnKw69GDu0SnycIhT1y+n/nj9EbKNkWjxS9S0XzaogGbYO91er5dBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664442; c=relaxed/simple;
	bh=Z2zgMXfJmu27DbOj5JrH6qEdmkT1Emg/49JfaZUY2TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD1yl8hRt5AIL4QT/4wc61ajKh9fvJU34JsPTuioFLXR4VyRAaEDCLHGLsSqf5GBQYAiRuANYDYHmvD5JhD7z022DUbbsb2nrrqa8At3NPq//psA9oXIdzOJ7M8MDMPLOfHftHPqNYWluofhxBL6utzLsTXRCtq1RXbpbxWDFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Okd0t8ai; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6b0a40721so5744035ad.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717664440; x=1718269240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34i9c6SrAxbvVIYSgNgR0QRNfSIYZYsCpLD0yBLi1hk=;
        b=Okd0t8aidCFhu1ENkKHcnWVHej+OywJtnjCaBg1cfxRlaItm0jN0YpKuoeh1cDV+Du
         7Klt5iU7VX5PqURvDKuDGSZh/Jhsgragbo6px1JalwRypQpSjuQ396Cy+xX/5ChYrNhO
         SYVSBfbNPvoBRGHTXUNuO+bPrdbXIpOmjqOzzPzH7nkXTH8GNSTN33thOSGqoGTzvGSZ
         PPj9uY+bCeW7yugn49g0IEj5BF6uNOf4e5F94WKY1VR1kzh48trunMcX6eXAHXFxVZ4j
         7uhdN36APGbchVdD+18WQ8HEtbZRsUjtH/H/I19JrxOifNX6i1Q3rEmxLEFEJkQvj2zo
         gbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664440; x=1718269240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34i9c6SrAxbvVIYSgNgR0QRNfSIYZYsCpLD0yBLi1hk=;
        b=Hs/6yxBrDJ2sXa9ySK4EGrOUKirHYIyjXx6qe8UHuSCW2Rpq6NYUqrneXidZfXVWoI
         hd898IvowTXuLXM4IZH09lAcG6AaVBcdATvfHA5KLfhK+ZoePKY/n2ruMrYyCBNwMTB8
         W4oN0daaeQwdM+is0sFzNB4SnCAjRzplsRUnliGXXSbAd1vdfjcn1YKakcZipqONtanN
         0+tfy5mlDYyRRPdS0m0cHQE2i6ISHUUSr02mG5hS8iqaMigLxWGZNegHmL2C6W1e97ZX
         3zH3FPEC1MRTQbIk7x9v3Pe7Wo+T358U0KdMA5Od+FsmTDWAXdoUNauVQ0Cs66i9tPzU
         CdgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcQb3tleIXIzuqG4h6dDVXpG/l8ITiFtUWwqkW039MVRoSzI2ZqoEkwldS1M7W7w3CtLzYOXl6uane1vppjMcgisnqF/SH61E=
X-Gm-Message-State: AOJu0YxO/nD5qwc6JzWF6jaPl6JhuajcwLPdvwX9V+45Xs0oYlsADcO8
	qwvu0glXtxg6hPIQXGwz8Jbn8xWeA7CsylSR9yehuSyYL5mL+tgwYe5ihd8NGsU=
X-Google-Smtp-Source: AGHT+IGBaWpCLLyQhhlMrvujsZHTasOuNlHy+sHQPl2a5na2b1UsqMVlY1JnEEXwTi19dHyzxOiSRw==
X-Received: by 2002:a17:90a:8c94:b0:2c2:8655:1742 with SMTP id 98e67ed59e1d1-2c28655180fmr3826407a91.11.1717664440343;
        Thu, 06 Jun 2024 02:00:40 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806d2936sm2943926a91.53.2024.06.06.02.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:00:39 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:30:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Handle deferred probe with
 dev_err_probe()
Message-ID: <20240606090037.2v3sl72rjfzzk4k7@vireshk-i7>
References: <20240606065847.3499145-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606065847.3499145-1-primoz.fiser@norik.com>

On 06-06-24, 08:58, Primoz Fiser wrote:
> Handle deferred probing gracefully by using dev_err_probe() to not
> spam console with unnecessary error messages.
> 
> Fixes: f88d152dc739 ("cpufreq: ti: Migrate to dev_pm_opp_set_config()")
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 714ed53753fa..5af85c4cbad0 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -417,7 +417,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  	ret = dev_pm_opp_set_config(opp_data->cpu_dev, &config);
>  	if (ret < 0) {
> -		dev_err(opp_data->cpu_dev, "Failed to set OPP config\n");
> +		dev_err_probe(opp_data->cpu_dev, ret, "Failed to set OPP config\n");
>  		goto fail_put_node;
>  	}

Applied. Thanks.

-- 
viresh

