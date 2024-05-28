Return-Path: <linux-pm+bounces-8225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443588D14B6
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 08:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758701C21E79
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A41E6D1A6;
	Tue, 28 May 2024 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwOB9zC+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B075339B
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879192; cv=none; b=eT441EHWU6Vz8yRt9JuzKclY9OicJ/kjePzvXxAu9jFIUsIfgUJ5F2FUZmDdM1fn4uOJlRy63FICridIuylPn7qFc0EXmVd8iNhrTh2OlJG5L0gr/UZoA7ap411QJaSxpjENhD6n+XfV9UQjk5ZiHWRhtzKp62WfzKvxtGy1Nj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879192; c=relaxed/simple;
	bh=MFhs9/4/KnYhU7bixwTj8g8sHF+zGloFZrbHBdROFkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH7z3SRZBvUetT6+UoZx5WaFwzzFBmpziW5cDyugnmQpbJ7JXwJ2JfDIyMb4uC/2x7oOR0TaN59Wx3Rj1YeqAU/6G5NuPiwsi+nE9vjzrNE+5p40evobJNmCLj95O9dl9gjfNG/m1nNvNE/4Wd+QKzTvyJlIhKHJrVnLLy8vDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gwOB9zC+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-701e1eaa6cfso15176b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716879190; x=1717483990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlz29iodFOMw14RnZpFK2iit4WCC6vTwGm+tYGoGHKg=;
        b=gwOB9zC+VIQRIMdmzrbCsfQYxBmnPG7sW4VAMf9pdYKFfb7cuL+S6OdaSnNxuPkC16
         IoVGuyXESFMC5/OvO3q2ZwxCx58nMWwaLdfGuSYE4o5zIBabpXh+jFaMX3mGa38QQEAh
         m3Uhc3j3tYwHkmUcT4MIJlb6Q5U1cwdmxB7/TdhDcJSH9FgqpiY22dn41xq1cs/aW+fa
         kgE3VLJmjdX96Uy3P9ggzBKPErxIyvsswqzghxbSNPA9hIAJNP35AniiJWUptJ8vRjYF
         GA0hSQwaDCvVwoCP50hVGbHz/Ggw/LiwyCH6w5QEEP34neegwiPlJ6gKnWQTPG7Hj934
         DbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716879190; x=1717483990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlz29iodFOMw14RnZpFK2iit4WCC6vTwGm+tYGoGHKg=;
        b=FIQbfqBRW73JoQL9EQbW7ibYDVeoiIcViHT7BTk3xG5Bhn9WJUBa2LvJhK8tkkVIsV
         UZhuSrtp4CSUyiBMeROglYiwLt2jtselCE1eSPXuluKzmSgwkNucW0kNfdHgt4ikuiEo
         hcdsh/ziKbiD/2Cmz1USklGWIs1NAERw4oPFpPa38670fYlTU6RZkxavGyQzdGkThfHf
         j/6KsMlemsnQuKz1nihmc2v0WvRF0eKYMt7Pmv+Lj2q+hWKJCcrELv54zLkPY69mw7sL
         +ioq5evTcvwnhaR/hrjaeBkFU2Qn4GsarPiRrFpzmpVXjCVG6ZmQXcGEhz8kbcGb8VIp
         dkPA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Bmq6B8a5FCyKwnugqTiIsnKSJFkT7UwbaXyl39OZAh4sK1zw+RVWMt5F21Lr6WmydyicMR5x/fyJT1Z2lIkcQPZpDwI/Blk=
X-Gm-Message-State: AOJu0YxL2y+VIjPwcIwZWMGO1rrhDvi8/AlgBtXgzhNXZbTRndbr/9OK
	E++zN8SLxh5+wnS5mfCA+mpiLLMP3d038FBkt3EDlqvKiEUhOjn8W+BhoY1+YVI=
X-Google-Smtp-Source: AGHT+IEEdcuEvmK07i02IWiptZ0LaWC1/GpoVpyTFIkU2FpULvAsdQXvYWBWbq7M8iWbV7N5a7ZXrg==
X-Received: by 2002:a05:6a21:3398:b0:1af:a9ad:fbbe with SMTP id adf61e73a8af0-1b205cf89b4mr21796164637.27.1716879190257;
        Mon, 27 May 2024 23:53:10 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682271d78d7sm6977547a12.77.2024.05.27.23.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:53:09 -0700 (PDT)
Date: Tue, 28 May 2024 12:23:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: longhaul: Fix kernel-doc param for
 longhaul_setstate
Message-ID: <20240528065307.2gdau7dnfvjzwj2s@vireshk-i7>
References: <20240524092037.71666-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524092037.71666-1-yang.lee@linux.alibaba.com>

On 24-05-24, 17:20, Yang Li wrote:
> The patch updates the function documentation comment for
> longhaul_setstate to adhere to the kernel-doc specification.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/cpufreq/longhaul.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index 4c57c6725c13..bd6fe8638d39 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -236,8 +236,9 @@ static void do_powersaver(int cx_address, unsigned int mults_index,
>  }
>  
>  /**
> - * longhaul_set_cpu_frequency()
> - * @mults_index : bitpattern of the new multiplier.
> + * longhaul_setstate()
> + * @policy: cpufreq_policy structure containing the current policy.
> + * @table_index: index of the frequency within the cpufreq_frequency_table.
>   *
>   * Sets a new clock ratio.
>   */

Applied. Thanks.

-- 
viresh

