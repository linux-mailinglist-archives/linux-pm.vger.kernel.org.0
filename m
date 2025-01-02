Return-Path: <linux-pm+bounces-19879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A769FF626
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 06:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7875D7A1260
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 05:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657918C018;
	Thu,  2 Jan 2025 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ut4qRH38"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946F149C69
	for <linux-pm@vger.kernel.org>; Thu,  2 Jan 2025 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735794017; cv=none; b=U8XKuJR+QTKVqWIJrvixDXfv1DbtxcBdds0ysjy/FP8IXdys+3FyZxIl3Tu6Q9Nx9EN6F4j+b1evyEF/yY9WnOBTqpuDkh9Zo2ZSvHqtlPypKv83TLFJITLhOqXkLE8KkSCmMQ89+hT8ULpzL1bKlIFqNFwuMN3toCqPm+1wgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735794017; c=relaxed/simple;
	bh=PUPDyZt8sb+oTvcqxQxTqbwlTwIcia/v4J4Ku2kpjJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbPS4LxU6cD9TtudsBZcfkuvGPd2J1xq8bz8m9OOhXbk8HVkoT4dA3xAXkUEd7oaiHvpHfrYF6xoJFxB2f7dDmFrNqBAi2sO9HmNelG0uSAQRXbs1g7sMARZ5nAk3WMXdXVqXo02tkC1CQbS8aiwhxCesw9RYUBUA3tCpuha+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ut4qRH38; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163b0c09afso145913745ad.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Jan 2025 21:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735794013; x=1736398813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/1bp2PcKf40TQFroshO2jGmCGJEJGNa02FuKdy+K6Y=;
        b=ut4qRH38FQyX7SgfJXIKJnUgmMG/Kr2ifjXBRtErJvubD77m5zB7eKvbfpxmbtAheW
         QPl5PeSko/GL3zAZ6fzDq/LFv3/ETui6j/A2C4ErYwsSClvXLykxRLxaFEKzSriqGzBs
         esFsnLvRRe/wP/cthykEbqGhRxXbhjAMMyxjFL9c25jr7b9uvXMEHimbyWRL7Ge4VXwt
         gkzUVAj4OdyV3zSQ1hAobgbVIGc2N1uX7+4l0jxkLc/p8or/xGcESka1hp3Zhir/4L1x
         CmxuasaGXh5335wLt+lVnLm+C9/ioD922SakNkR8XVypbmHcQzH+BcK4J6c1FiecjS2+
         b9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735794013; x=1736398813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/1bp2PcKf40TQFroshO2jGmCGJEJGNa02FuKdy+K6Y=;
        b=Tn5m+DsS+Hz+I3rIv8imEWnT/0NyovXD0Ol4znNAZAk5mYzu0XdCmOHba+AXMuwyTr
         23tiKpKVAI1R1fl9aXXFjLztLYy7Va461AFDMS33+uLpWRncsaedxn6yLrk5aqdZP3qH
         jKvhQJtPvx2Mf6edE5ntbNxei8p9xQqT77F1fOBfRapuHhnU9KNGItT1ZvQCKGaWIlSJ
         41toK5bVmEEeI8n++IYPzglAw7cd7PDHYRnLbo64BAO2X//JFD3WMLoZB36VQQ8oNWH1
         iM2JzEWWtLVs3kGzQHURUiXB9a+3DgOBphMpHLqNN7sya8T0+FqmGW772Wrxu2Gkon9T
         8zvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHBjDkWtfvF/YnZT9eMxlveysvzQMzAWRlKHft2Cc7wgWSA5G69+IQI86j/dnkTVrYLi/hG8cAMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZQxME+rdFqFte+Jg55inJqi5AQBYSm5VpLhZqYC3BaUTwvIT
	HSbZ+95P+DAxzmRQt/0vKQzyZytuvGK+QsuxXNh445bZAYlpGaRhXApUGh0IeUw=
X-Gm-Gg: ASbGnctDgPFPVn9uAMrss14pVJHQaw9vl4NFkk6miAyx9wKhuLu3o1g2k9oBgdAydMq
	PjDsPg/QKj39u+Z6hpcreIag2aOr3j/5UljszEWmQ3SVkEbwIQ2rPr8fJe70joRtYGaHDCxUPjn
	UZqmQBjd/xIc9rBeK3urh7aZd+t01dg/YbwQTPGUzDNfkOiQF++qnlmHQZRSmXseBxNUIqtj2Mp
	7ii9Jct0kMRHZU9ZPUS3Lqd4ewUpFO8St+pWDtEP10EqZHTOx6n5vMCquU=
X-Google-Smtp-Source: AGHT+IGwZt2JFNHPzwT3nkSeMpu8p2mdONKKDTn9PLQBRw9qGtDV66wcfRl5C8C59VP/9aAWObVl+g==
X-Received: by 2002:a05:6a20:7f8a:b0:1e3:e6f3:6372 with SMTP id adf61e73a8af0-1e5e07bc390mr63987273637.27.1735794013408;
        Wed, 01 Jan 2025 21:00:13 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da93sm17980901a12.38.2025.01.01.21.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 21:00:12 -0800 (PST)
Date: Thu, 2 Jan 2025 10:30:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scpi: Prevent null pointer dereference in
 scpi_cpufreq_get_rate()
Message-ID: <20250102050010.gnvf42r3v2ey7mww@vireshk-i7>
References: <20241230093159.258813-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230093159.258813-1-hanchunchao@inspur.com>

On 30-12-24, 17:31, Charles Han wrote:
> cpufreq_cpu_get_raw() may return NULL if the cpu is not in
> policy->cpus cpu mask and it will cause null pointer dereference.
> Prevent null pointer dereference in scpi_cpufreq_get_rate().
> 
> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index cd89c1b9832c..c888ed3a0de9 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -30,6 +30,9 @@ static struct scpi_ops *scpi_ops;
>  static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> +	if (unlikely(!policy))
> +		return 0;
> +
>  	struct scpi_data *priv = policy->driver_data;
>  	unsigned long rate = clk_get_rate(priv->clk);

The check needs to be made after all the variable definitions.

-- 
viresh

