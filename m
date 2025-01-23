Return-Path: <linux-pm+bounces-20835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C568A1A2B1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A42A3A8683
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B24F20E032;
	Thu, 23 Jan 2025 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwyJVDmN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55620DD7F
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630742; cv=none; b=Z0ZywxY6hgIK/twiCKmyxUQuj86vIuAVyFi+SIxmzgocQ5CRKM96zsXTh7/QUU3xYxzyUMCL68IOhAqtUvBhqjoixmmPlh1L7eRJs/v1Uwsv4UMbvRHhFOOCbRmB9aU0jzmHk6jWEhRwwIXHb7NhhC+Pxr6dJGQ+ot/e511A1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630742; c=relaxed/simple;
	bh=4bqdqaqoRBmiz1tlNvw3LlwQw5yawGiciwSgedzynzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV5Q3Wva98aDdxFmNuXynK4IKvlAEHxFGukBtf4XuEiWSsJdy3xPbr0Vty3nvebRWg1F7dXvZH3PtfeJVCDTJa3lCOR6p517BYwsm1OPTLzTyiB1pLA+ixaBmJM58G7Pacb5Yu0Ifv9+ZoCzVdk3NJb7leZi3fixvD7/RDubpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KwyJVDmN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e3621518so365369f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737630739; x=1738235539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScXAOgZXW83Gqjl3thNs/+nZmT78yMbe9xCFOetszKo=;
        b=KwyJVDmNm4AacVP6TMbOUsbeGcp4gCVP4zdgaQZpolOLxtR5waTWLOtiOgx265H7DQ
         /4n+5egYc3zx/hslKLt2GMvPt6nNP52eAgm0KorfNmq8TxspdwVlHZNcYtXfh8plkIaI
         3fmg/t/Eu4/56Z9FzcU0L1p5audT5x7DEW7R4Kabq3JbgfII9dN9o52Z1excQMrIC/Hl
         u7YpYEOba97sojTXJJK4cb7USndOGOMEqW7JjFeS93YD2qZ3mm9pPXb3a1fYjeF3vvyp
         4z+AxrB+alT+C3IXXuyjTuR2lDXVn4tPi3Is+TWgiKow9VV6VropcZoGZYg7/u7rbxA3
         NrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737630739; x=1738235539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScXAOgZXW83Gqjl3thNs/+nZmT78yMbe9xCFOetszKo=;
        b=Dk5iiAREi32GBZCbyS6rGVP3Nr4DoVpjOI/hJ+zLgkMLCmTuLJXhHL3vlnvRcT214D
         FdXywU7L/9+YpI2djk78Q3EGMGAVUyI6sAUX4sRrU8nqw5FaIIBqYI5GKlTz9d4rJH02
         cgoEHkpX7wP6LeJim1btwOcsSB1RvEEbp2+juBEBO/mRCWiW5kQDbIlQlCSVornepiO5
         NgyjKaSvg09pNzlk+eXfnxqCAOG8XNZzTQesq4NIpPjJpxQORGlikEwjUALookYw/V2M
         78OTBIDIhxXWEwT+tq9YGF18sJWCH1ybGPMd1KFktya9Cja14aRU8lX6ew1EswQ7P5gD
         VQxg==
X-Forwarded-Encrypted: i=1; AJvYcCXy00s5xjn9BZemZtVZ0EYP15HsoP3tuvfkJu1BoY7FlW3DfD5UFyIfRhlXvXUsOYIy0ROpc1VtpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuP/io7YejcfIFe6Ykx5dX8oCg95ytrdNXSD9rC+KkMQJOp4e8
	USWrlvUwZXwVVP+VSTV2o189pGZWQW8pySUuiovH77lmEx+kAu24yC8n27Onvc8=
X-Gm-Gg: ASbGncshhUP+6/1RDPsXgkuw/5nM+a6xzyKKKsZK7TU0D8zvqSoVXUqQ3Vno1U/fc97
	6S0gcQ9t6T+Z49wScHyk1F9nDmhUzPr/9COIxdxIwTFI1rINhnCJKdEh5edgSUyBdE5SO4Kw9h+
	CJkD8dG41ld/qz+UBrWccGTQ9YcSJe+DakhC63WPhLDhO1IuHmM3CTWCy+V0TZfz6/VBiOuvr4i
	f1GqssQ+NvOcR2EsAZbCjJeTcBG0ju1ZO3JCY0INtRKtV7YYsI4azkZg7/WYzoPyF4NqqGoLqLO
	otaZ0+dKcQ==
X-Google-Smtp-Source: AGHT+IGTjg5cb3hrIHI+2Cx43xQLT48/6W5YSS8YYVdSRsOlyfnn/x4sEOrUIHztwV+B3Orib4yu3w==
X-Received: by 2002:a5d:5f4d:0:b0:38a:614b:8632 with SMTP id ffacd0b85a97d-38bf57a6969mr27614248f8f.39.1737630738817;
        Thu, 23 Jan 2025 03:12:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275595sm19117151f8f.67.2025.01.23.03.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:12:18 -0800 (PST)
Date: Thu, 23 Jan 2025 14:12:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: zuoqian <zuoqian113@gmail.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	cristian.marussi@arm.com, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scpi: compare against frequency instead of rate
Message-ID: <ad11dfc1-5e88-4421-b427-3955d4220133@stanley.mountain>
References: <20250123075321.4442-1-zuoqian113@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123075321.4442-1-zuoqian113@gmail.com>

On Thu, Jan 23, 2025 at 07:53:20AM +0000, zuoqian wrote:
> The CPU rate from clk_get_rate() may not be divisible by 1000
> (e.g., 133333333). But the rate calculated from frequency is always
> divisible by 1000 (e.g., 133333000).
> Comparing the rate causes a warning during CPU scaling:
> "cpufreq: __target_index: Failed to change cpu frequency: -5".
> When we choose to compare frequency here, the issue does not occur.
> 
> Signed-off-by: zuoqian <zuoqian113@gmail.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index cd89c1b9832c..3bff4bb5ab4a 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -39,8 +39,9 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
>  static int
>  scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
> -	u64 rate = policy->freq_table[index].frequency * 1000;

policy->freq_table[index].frequency is a u32 so in this original
calculation, even though "rate" is declared as a u64, it can't actually
be more than UINT_MAX.

> +	unsigned long freq = policy->freq_table[index].frequency;
>  	struct scpi_data *priv = policy->driver_data;
> +	u64 rate = freq * 1000;

So you've fixed this by casting policy->freq_table[index].frequency
to unsigned long, which fixes the problem on 64bit systems but it still
remains on 32bit systems.  It would be better to declare freq as a u64.

We keep fixing and then breaking this as undocumented parts of larger
patches.  :P  It should really be done by itself and the Fixes tag would
point to:
Fixes: 1a0419b0db46 ("cpufreq: move invariance setter calls in cpufreq core")

>  	int ret;
>  
>  	ret = clk_set_rate(priv->clk, rate);
> @@ -48,7 +49,7 @@ scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	if (ret)
>  		return ret;
>  
> -	if (clk_get_rate(priv->clk) != rate)
> +	if (clk_get_rate(priv->clk) / 1000 != freq)


Sure, I don't know this code well but your commit message seems reasonable.
Add a Fixes tag for this line.

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")

regards,
dan carpenter



