Return-Path: <linux-pm+bounces-19358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6475C9F41BB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 05:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD3C16D6BD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 04:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB814831E;
	Tue, 17 Dec 2024 04:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GALa36JQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17322145346
	for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 04:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409651; cv=none; b=QYkllKHEu/HkMGWWLbcelhLc0hesFa/wr0R7BSV/aHF5k/iHnXOO6EAnyiS6NKnF8BgNjPt8PIFImOFK0YsxJyctGcTQa8ZdQECfEfzvuq8bPIi62XhjrxcbtpsflMkZNTmgaXTqjlT/UdbSHbSskSyOUfV0WM1KwGMXEI/JqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409651; c=relaxed/simple;
	bh=KGf3WEZUTgWBNJDe2xew7TkgY4CxKh65T66dzPPcwMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5cZzWmC+HpE1dzslRyQIjlTgB1SXipX0fPILqgCvdW8/n9kNX0HVQNEHhAHkvJRUx5APR1BOZzJo/caic/YMO2NSHwEGKrDSWTkJ+ZNu2qVoRZpdaELk/I+Y5P2nNUZ5235GBCFwTRFX8HxFTokMzMCk8d6y/BQYTq8zskZOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GALa36JQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso4376349a91.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 20:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734409649; x=1735014449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr3GeSntlHloZ4yayQx6BsNSKnwpryezH5Wr5AEdqz8=;
        b=GALa36JQf9P2udVWsBlKW83PFKRaM1xO+HG3eiFw7WlO1O0Wn4+oq8x6fbQKgDefNv
         XxQQYZxiuDM0ud9PEIyOF6SBGhx5QA/9M9nliQ5krmXOJnYGwDf34OlbAE6bAjXPbkzc
         3X9a7sbTgxbzGb40JBMlERxMGW80J9tLlm5b6M5q+cyd5favPWLXEvMwuztljLkaCn1T
         PSq2ANdZhssa/LoB+3FYIBteMGi/lV7uCeOX/UqnGprCPa7MHnJmDMBcI6vT60Fgftr6
         lsw6hky/0n3ikwns0s75tFAXnC+BwKbuA1AHHJ6nCWNtjIUM7rL4vGG9Odz+Yi5X/e0I
         nzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734409649; x=1735014449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr3GeSntlHloZ4yayQx6BsNSKnwpryezH5Wr5AEdqz8=;
        b=FCBz9v26EDgCZdw4erbeFtyR9C1ElDeA3nVMKyxfFErR1dIp/PHHOI32OpKnPOfbti
         uRTY7UsWdnvNzbYDNta/fONR93lew/evUu+m9MuC+qRaWzJOAirg5BbCQtD1W37qpTcW
         8aUYXAv2CCWHSczLiKg2MeAN4ZiOtLkfxsre4t+YtWH7xuEu0XE5a5ieBNT64MTXxpLc
         /rGZKpm0T9o/HPUbN3cO27Hr7sphF1ye+lU302l13tbl4BPiEC4aiiEktB7Aa9PGLhy5
         pJP9CwVmScT2KaUzLKx3Ih8spWKrkr9pWxhmBkiY46lvtkBOOH1PSl+toF/i7AOT/6NV
         0FeA==
X-Forwarded-Encrypted: i=1; AJvYcCXn3GDdI1jkHk4YPCVDsH7zuBpo01D+HhYvXg6xZFznpZM2lfZfaUr5ffiqaY9QCeeJ5tkt4H8ccQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDFex13F6p/Z7RrSUB4ubKnNJamSMackSuIOKka/yyKQo4Geis
	20kMXFtTu6k1gX8UbOubz+GX3g8NcybUSfb6R6UOaNVY+Z69yMsxnosfnJTYAUA=
X-Gm-Gg: ASbGncskRY55kFL7W4IillDugWIeW4BIUHJ0TOpO1DEzj6ARzEHNTi6FTZ+EpSRNVFG
	/f5zN9I2M7CIU4XHVoCfWSRoJmfQvB3Ze9GdEkNqvz2D+9/kf1oSaTnvniSpYaAE9hL5BRqyVO/
	UWU89oV4bO8PqYqyA7AN0dCTvYU9DYc1BH5WaGGdVa9vpS+IVs9e6pOs86E33HPQBFT0m3dSOnY
	zEYR0BTyByaWw7TSEkr54tpMBU56cpR68XyiFoWliNQnjZK1NLIvUnC/gg=
X-Google-Smtp-Source: AGHT+IE/JeMuR4dBQFhr2ewi062MYvFxM7gFUf/kYOjekW7K8q6et1llylqaVQeIxsiURZEwVjKeIQ==
X-Received: by 2002:a17:90b:2e48:b0:2ee:6736:8512 with SMTP id 98e67ed59e1d1-2f28fb6f983mr28756658a91.12.1734409649481;
        Mon, 16 Dec 2024 20:27:29 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d45sm9072765a91.11.2024.12.16.20.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 20:27:28 -0800 (PST)
Date: Tue, 17 Dec 2024 09:57:26 +0530
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
Message-ID: <20241217042726.isllh5bulpnwql7i@vireshk-i7>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
 <20241212065100.sjb7lrlmksbm2hdk@vireshk-i7>
 <Z2CmcelSy89NULtz@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2CmcelSy89NULtz@arm.com>

On 16-12-24, 23:15, Beata Michalska wrote:
> My bad as I must have misinterpreted that message. Although I am not entirely
> sure why this might be unacceptable as it is not such uncommon approach to use
> signed int space to cover both: expected positive value as well as potential
> error code case failure.

This part is fine. The problem is with handling frequency here. Signed int can
capture up to 2 GHz of freq, where as unsigned int can capture up to 4 GHz and
so we would really like to keep it at 4 GHz..

Maybe we need to move to 64 bits for frequency at some point of time, but at
least we should try to not break it for now.

> Enabling the new attribute for all is an option, tough not entirely compelling
> one as exposing a feature that is known not to be supported seems bit
> counterintuitive. On the other hand using cpufreq driver flags won't help much
> as the support for the new attrib is platform-specific, not driver-specific.

-- 
viresh

