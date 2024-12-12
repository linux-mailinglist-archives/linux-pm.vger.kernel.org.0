Return-Path: <linux-pm+bounces-19086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12339EDF99
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981132824E7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7F188701;
	Thu, 12 Dec 2024 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXFnks2q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A2186E27
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986266; cv=none; b=HXyqGvV316GSF72n3W6OlxAdi3p3kATM8dUiaau9ePEce5ddCyPkHRQ4uiUKetRIEV1XdAS6oVL6GSSKWdxfRVjlMEwNhuL0aO8M344fopRCu22BRP9khPJL7l7NLO2iIn44nRUFjChhNpXCIqR0ydAyUEU5IhMUYvXIpkJEJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986266; c=relaxed/simple;
	bh=J5qTMehS3VZ62nZjN03LGp8GqaYD+XZuK6SdZqnwox4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSjYCknQJOi+/wHunQMWdCB5TQQvviIdlqf7mrLMrh5z+RgywbieDCmlgDamabKIk1kKP53XA9iQEPZmyxg6Wl0GfCa5Hh7OaUxEKAoyU+gA5urc8NFQdgH+57rA8eeYhptCkjTdjQMQKg+IUBUIJ+qga2m+brAQAZF1qIIaCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AXFnks2q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725dbdf380aso235503b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 22:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733986263; x=1734591063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzE1O+wEcFJCWBuWQepSclrHJZ9pm/tyRfOt1u5cgLg=;
        b=AXFnks2qbV0MiA1bgTfCHENGufngpialPoAEaehB+J9DhSOEay/ENWfonPAaEAvk+Q
         VIhF/XgdWHCTr/WZlEdWzxDWKhFttJsL+GvOZKfrWPIJKbJMZSFqEi8hQv/Q0QM5cWgp
         l6UboFp5y7MddO6KU0x/pqrS3qQxpY7oehPbWTnmkCtvGacseg52O74GKjSnUXdfiSPs
         IwDDZl67d3j9U1/PXG+Yal7ZgN5tdfcv5ZOOOTNCVwnRsqlnaFZPeZoa//igP8MFRguF
         Hzr1zOsLycE43CquhBsGJkCcAB1Y4sZXXEtbHWL/17eFINWJe6U1+eMDLlFBw6M3g4f1
         G87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733986263; x=1734591063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzE1O+wEcFJCWBuWQepSclrHJZ9pm/tyRfOt1u5cgLg=;
        b=a6GzOcuIzMs3tsnkGo21G3wCpBm0pLe0CUCh9GsGwWUZt0X9ENh8HzijRvnQDmRGaw
         4dDMhxuivRabuqchdel3ZIWLOo+ITGVYoh/Ppcexah7KEGLJILXvU1Sf2MGCUm56ZlJI
         Qs8TQU2CHUgSY95b9QvuyyTyOLwydUK8UOAoGhUPA3YWc5wH3Wi2tQKPAIWpWW/LHp8A
         xrskDnF2hNb3l2AAm6BAFHBrHdrjc+kzG0JQ4Mj+Pgya7Ct6lDiSOqZFqY55f/WbN3tR
         SuqOD3RynYGL5pTEsSQRjqNp8bZ9tKRFeGEgF1nLbSEVd35D97KQPn/nVYhMwT1Ntrj0
         nTcw==
X-Forwarded-Encrypted: i=1; AJvYcCW8GBguQIX+OsxeGjKWVQPUJXzr59OUlQu/TtXTx+wugP+UgZxuTnTOKLs9hGEWq2tBGT0E1/VZ9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4QniL2EHCzGevQyrA6JosM3bZBBES4cdeU9N59eJy6RIIJxl
	ys9UOiWS4/8uplG3spNNcPVwN1wid5PioUTc3NW+ObG+QjSZh4g/j4PmmjoZrjo=
X-Gm-Gg: ASbGncunMnbfE0pY45coCcLp4KWRkkChvof8v/DsnIbi/s3k7t8Q5UinoA4Pf4bx8nz
	Tme00NwXuEQnn9arhE587Nn28sGP/+uOjSlvh20dUekv4lczlUro8rXZNe7d6GIwJZby/VQeru2
	RgcwjGCLasvY0XHfp/6MYMZltGMiR3wZ8dk6DRYQU+/1GPepq/uZ5pa1LVJ1ts2s90t9ntQTIUa
	H97fH/HCkuw8AMcLzCbxS0rd0HxPwxwJOM9rDKSWv1lm05v6XYbxrHbmTA=
X-Google-Smtp-Source: AGHT+IFE78oKDXfbnWAKipxIsGcsj9ziBXqvMJZisKuD8EuJoQLV1Ku/T9xLrtjkJtyJVpTFpdinxQ==
X-Received: by 2002:a05:6a00:9aa:b0:725:e325:ab3a with SMTP id d2e1a72fcca58-728faa1ce63mr3316269b3a.14.1733986263004;
        Wed, 11 Dec 2024 22:51:03 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e82197e4sm7131155b3a.72.2024.12.11.22.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:51:02 -0800 (PST)
Date: Thu, 12 Dec 2024 12:21:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <20241212065100.sjb7lrlmksbm2hdk@vireshk-i7>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206135600.4083965-2-beata.michalska@arm.com>

On 06-12-24, 13:55, Beata Michalska wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04fc786dd2c0..70df2a24437b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -747,9 +747,14 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
>  show_one(scaling_min_freq, min);
>  show_one(scaling_max_freq, max);
>  
> -__weak unsigned int arch_freq_get_on_cpu(int cpu)
> +__weak int arch_freq_get_on_cpu(int cpu)
>  {
> -	return 0;
> +	return -EOPNOTSUPP;

I did suggest not doing this as it may not be acceptable.

https://lore.kernel.org/all/CAKohpokFUpQyHYO017kOn-Jbt0CFZ1GuxoG3N-fenWJ_poW=4Q@mail.gmail.com/

-- 
viresh

