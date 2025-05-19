Return-Path: <linux-pm+bounces-27337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A26AABBB40
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 12:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0BC3A5251
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA4226A081;
	Mon, 19 May 2025 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt+LUwQu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EADFBF6
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651074; cv=none; b=EK2eyhqAoAKFQ+bSb7DtGg3Hhar8hSN3G/gWE0GhifmTgTk0PFiFfABv7Mst6eVARv6lynIpzD8CTfgSRJb1RlJFesPpyECc7KFbgK3lVkYoO1WrbYwq5K8fbJu7QHY42mZqCecgprXEU26050gp/WGv88xVTTxv44PRvyeoK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651074; c=relaxed/simple;
	bh=CYlV9CLYvoive18TMEYVs7/LkzGvQsIdzdQVcJu7xe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTZDWokM/v556mkcnXyGJ3lhr5SmYR26n5LaIt1CViyYxL17efWB2UyInj4iSKzTAeTjZCaPdtn8TLhJRMup90MjV2IfS7lgRnL/FrnhXR5yIAX4wtn84VDjm/jsIyTJiCgYvIx1y8Xc5MossFst9NcHydkvdKJtPU+FlhImKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dt+LUwQu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2301ac32320so45419705ad.1
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747651072; x=1748255872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h32e2BQV69+h9ggyaurnDkl9qtPdiXdzx6cpgPcqSUw=;
        b=dt+LUwQuPNx7aElzMIalz7qXalngMYdmWslQMjO/1vlwILEwxBk7LvI8nYFnFIa+iT
         X4B5ePHs9Jmd9gjs33s4pD7PUQ8US0UXuXOA/OnCtCWHU0AyBN3lmypGsVsul03FvTzj
         wa/F4q3wnMzGgtIGODReknH40hzllOhmNXxl7ocizwULSTBNErW39HsYPnBu5j2asfi+
         QzUfG7sZxjPLDJHpfX4yAGJLZ7yIWauCOWixToPpbQv+fKIoVjovRQ4rh/7k9Wj7moZx
         ie9ZcvzVZbaeskTIyJ7ShL/deZ59xK/3wSo7h9LOjY8qHcxnB0a9zBmmp3xXfX6LHMbr
         AX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747651072; x=1748255872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h32e2BQV69+h9ggyaurnDkl9qtPdiXdzx6cpgPcqSUw=;
        b=heUjOR76GKWUPj/bhsdsuH3xo0rMETu1MIudwYlWmNSgHwhqum1vYADEPTVa+jCsET
         Jz/uxAe34yiNuRmyUqRY3U4kqtSwE2+p22pvED7pfw54wdbBPrd+vT7jfCRgy7yAQeFM
         OksX0FETtQ6oZWYLZ863FwP28VfG6WqCHRzTGGQZDjk/VdGpDl1aXaFJFQ1Pf2QKF5TU
         nBEpyWDOvao9okyGVkpcTQ06ojq2b7Y8PzK6GOjdfFYTSyS/3qNRicMUh131AwPrpaKC
         jUGwvC3KyP5RHNdCUQKPNacH6r2XupQGb/i+nYd0pOCHS08J6Hj070JUYc4kSGHca66D
         NQsA==
X-Forwarded-Encrypted: i=1; AJvYcCUWz54x5fPaRPBE4nSnUXeIPQ4p87VbcPI+ZLGOtIkKu7Cr/rZPlwnSonf0TEQSJXrk+SOaHzEOtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ5f4m3CDXnXctF+RehI2doSaXav78vK+5Nb8aagiDWnQX4eJ6
	lm10RVwcHEFoTEiOluTsydyzXItbk9Wsoxux310TwBMH7Nl8tiS6nmauhTfMePh5flg=
X-Gm-Gg: ASbGncsWts0WMZYNTJpUm/kljl/1b1HTcNPqVRLLa8Km4VI9J5w9Oik1RHAVB279VPT
	1W2rosGkDmp7zDK+QbPe4cXPDVBxFNq1NeA107o8VskkwNbqAVa7+Sp7NW7xrnDBHQPH2XkgnIM
	ECXwJNCr3uFwdAVleofqK3I2PlKX68gLujc7PrFWn63b8/hP0GW8yGvl3TcC5l0nOMd53dW/iR5
	+emPr0cJFV3eWt4DXiP7d9BiTO6NLGnUBhNpx29jCGPGt2YoJ+S6S0c5XLJECdgWp5paCEqFLhX
	E+nAO7Tze9rHnd/1+o9bW2LZhKbD5tgaBuGgsMt+30Zclwo3TX/q
X-Google-Smtp-Source: AGHT+IFb5F2zp+fI9VwhFVQAtomdvuqefNSzeKLT6FS4Ynv5xJ69Dqg7+OqDltzfck329MPnHK7hJg==
X-Received: by 2002:a17:903:124c:b0:22e:566f:bca7 with SMTP id d9443c01a7336-231d44e7e3bmr160367575ad.17.1747651071759;
        Mon, 19 May 2025 03:37:51 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba345sm56864325ad.166.2025.05.19.03.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:37:51 -0700 (PDT)
Date: Mon, 19 May 2025 16:07:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Aaron Kling <webgeek1234@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
Message-ID: <20250519103749.falgd64ikkwkfpg7@vireshk-i7>
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
 <cd801698-d7cf-4e9e-aa01-5525f8687ab0@nvidia.com>
 <CALHNRZ_9tMi5iihyTsEuU4T72=oTQM6-rVhqozzLf9DiB_TpcA@mail.gmail.com>
 <CALHNRZ-pu9HUzVyR3-U=XZKFFZPnn5-DNLWPqPx6CSoW0dHMrA@mail.gmail.com>
 <bc0a4c75-df5b-4b4d-9c9e-a2c99d3f4f6e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc0a4c75-df5b-4b4d-9c9e-a2c99d3f4f6e@nvidia.com>

On 15-05-25, 07:41, Jon Hunter wrote:
> Yes and that is understood. I see a few drivers calling ...
> 
>  platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> 
> One option, and I don't know if this would be acceptable, would be to add a
> new wrapper function in the cpufreq-dt driver for the above that other
> drivers could call and that would create the dependency you need.

Doing that won't be a problem, but I doubt if that is a better than
adding a soft dependency here. I personally felt that the soft
dependency may be the right way here. The cpufreq-dt file presents a
driver, a device can be added from any file and that doesn't require
the driver file to be inserted first. If the platform wants to
simplify and create a dependency, a soft dependency looks okay.

-- 
viresh

