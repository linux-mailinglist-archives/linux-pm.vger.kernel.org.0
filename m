Return-Path: <linux-pm+bounces-33783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA02EB430FB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AB35817CE
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 04:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E21237713;
	Thu,  4 Sep 2025 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmQesyCT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8D922C32D
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959314; cv=none; b=iCMpJSavtyWLWL4nbIaHLKz/a24/5p3NfRMVHJgrf+vY9JVcLCFh46UvhlrHi9w2JRkOqqAP+yOBHICCDDs1spBSqlcEafcEoJO5LIgIlD7zkokapAhfyq+VCpEWPZfYwJSbrONTstJ8xqiipmXwDGboCCwSZsXAoDBad5OAado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959314; c=relaxed/simple;
	bh=7w4cLow4zoTj3t3VFgU+EAKFpZeDQOwq+3I8t8BGIJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMBO8r3SBTZ4emxOF/eqp/ADltHTYKY2X17tXGPoi/Aqeh/UgNLihcqcqtCbZmms7m2kmGE1IRsRhe4iHNEyFOCj8R2jClegBusZh3ZnJaSx64E1VwS3ACc5dD0KRtaWnV57IlyoTMAqswXpaAnETjdZon7l6FaiUZeP2baKZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pmQesyCT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24cbd9d9f09so8005125ad.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756959311; x=1757564111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S43g/iM9x7KG2QXyDYYbjoHBOM2uDSh9d3OO0kWMQhw=;
        b=pmQesyCT4kQ3bjSG43CVD0s+PVAEHjCH9foyg4bRnbcrXjzzDIwVFKQzIQilV3JZfg
         Etej/qVQsU2VnYq79Ovhos5CmqGnEg8Mld/8TzNZ3yCCIs7F0Nrt1pONUlZPaLtQOULI
         qV2vH5OgdysJuiN99hpgh+xxSoo9w46VQ6VviR+Fhjq2Ez6FCX2e7oxWqGKWoZhCuKn5
         PYOknBz6xuli+5QeFmKqIz1tN3bnA+kpCq6RIjNTCi8Mrn8Ai6HPjHBAuS+YLF5d/7QJ
         DxQYhZdqtgWiOFa3zgZNLV3cx7S3nMIqGLHbli1728dQkm9X7uKvN/NILOiVMyq6bcfK
         mvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756959311; x=1757564111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S43g/iM9x7KG2QXyDYYbjoHBOM2uDSh9d3OO0kWMQhw=;
        b=HGJ7bsH96k/GUEskMmDUD5zFiDvZuuerhckqQ8dqhA6O3pRtcPrPLrCKEU70I3GBaM
         yw1FVvd8bZP5BCrixLcZ+XTquZzbySwZYojMOnStMSjwh8mzHgASh0P8oXecxsMypyUD
         inl0/tjOoxLGg36l0/rxV4COuvz2SVUuU1k5Du9cmgg9/hSkA17Q5sahSa/cs9tOVcY7
         Iex+8POke4q/Eb1aGZs5crHdVH7Fkm40gjOjvsXrilix4JLEzP7XQ7q6JeyH3xHVIuqe
         pj+rUOVtdIYvEwEbJsN9HvR478Sb67dmEeocMvqNVMRGtsmEvajIz12WXX/ijXWqiAC7
         KemA==
X-Gm-Message-State: AOJu0Yysv+971U3ohgq4WtsuDSUs1hwtxLpuBb03ZuejH3vsXt3jb+KD
	KZamltELDo7JnFNuATxWAoy2S7nDCE+2k3amNPohtU0Fq2jKqRvC8bUDj/f7vg4c0nc=
X-Gm-Gg: ASbGncvcoUsTlE6br+52NjLv8+Wyx1ExhddX4NcWBkARb5OOez5V9FGaygAm3hDR5pf
	bx8yesl7468keYFp+sN1CQvcgkyWqDzgzBte8rVlwZ4iM7gFOdwox/SubjiyUKjP3KC/4MEB0/S
	1JPrJkIZ30fB/A1eV7jgawcioDQdKJiv60Zfg7W2SPmJ/6oKkLV/ROh9Vhy5c6c8yokRkn3iF4r
	0ZyNAtW9GdeuxWZQTen8lXBS8qglMsYBs2cMr29b7oiHdKNyIWFSVaqPyODTSjV7TXpPEBhNTTt
	Q2V1T2FI/U4dkZc724Dq1NC65nqYDdcwxQnXo0hHUfcLsFk46U+QcyHrXA9ukz5P3+C1M/eCxaO
	mK2s1r3sJxKOusIpAOXHbcZHd+jRgDM1TDawZlbbOHij41g==
X-Google-Smtp-Source: AGHT+IE3j8/7JmxRYMrFCkc+SleGi42PqTbqK6XvQkwoGiztnAW0oV/bspfky6fJCoeKLSS9D4mPdg==
X-Received: by 2002:a17:902:d50c:b0:245:f771:4232 with SMTP id d9443c01a7336-249448cfbb0mr229747055ad.14.1756959311119;
        Wed, 03 Sep 2025 21:15:11 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af8ab7e7bsm75847965ad.138.2025.09.03.21.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:15:10 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:45:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Zihuan Zhang <zhangzihuan@kylinos.cn>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Rearrange variable declaration
 involving __free()
Message-ID: <20250904041508.z5546b6a4usk5go2@vireshk-i7>
References: <2251447.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2251447.irdbgypaU6@rafael.j.wysocki>

On 03-09-25, 16:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Follow cleanup.h recommendations and define and assign a variable
> in one statement when __free() is used.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Zhang, I said the code structure here was intentional, but that was before
> the cleanup.h recommendation was pointed out to me.
> 
> ---
>  drivers/cpufreq/intel_pstate.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1502,9 +1502,7 @@ static void __intel_pstate_update_max_fr
>  
>  static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
>  {
> -	struct cpufreq_policy *policy __free(put_cpufreq_policy);
> -
> -	policy = cpufreq_cpu_get(cpudata->cpu);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
>  	if (!policy)
>  		return false;
>  
> 
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

