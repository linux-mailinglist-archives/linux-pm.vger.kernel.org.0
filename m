Return-Path: <linux-pm+bounces-32622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9291B2BF72
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F8C54E394A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18204322DA6;
	Tue, 19 Aug 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSpf9Uxm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A92322C87
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600929; cv=none; b=mCe6ub6oHetKDWiKy39kDkXHq6VuvrjiX7II6X4gTTSzrARfItlqSfK/qNgz9SE9NAFCp9JXHLjbqSoigjKhIorQ28QBTKqN7yQttiCMzbIAMSJZ+elC/ZSJCTnhZYtl/1NFzVSf8UnNs0JlFMUxKF7RRvYtADn4PuzPinHZJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600929; c=relaxed/simple;
	bh=nuiHYEdT4SzyCZDKFC2g1kk23b+Yq+E2mszEFq+217Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6jlVbjeMQRG5/HPxf8FN0SWDJC7esgTobfbV6caZqii2xpCChMazO+GYyHQ8TQ4DDQleQXzG3Ds12w4c3lT3RWTgYhNbuVDdwwc9pyZsHw6fHUsCiea2n93JIhHYslcLqwToNL7hfpdZxFW1UlHGMDYwkYXZ2n4FFgbBGwVbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kSpf9Uxm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e7af160f1so834285b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755600927; x=1756205727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YwzkRnMfZVeEk+/7Wvw5WSR6O0I8sjCpbeLDEFgGJA=;
        b=kSpf9Uxm5W41FR3kE8VDOD/j7CzHia9I9b/aFNWgUjyRAEPTqv5ZDosN4dztDy0aSi
         yLuZY5i0gpHQ/kbUlMiXh7YVF9mwew1lH59Y0d25qjZUOcEwJ2vYoI2oYhpkMOQY1Vr1
         P8ovAU7mDKCpEYhSvl8yTywNscJLnEgHMNIousck3LLhM7EIuntpR5IDTXZSvYL+le/+
         bowqT/WqOLn7u5RkLOlI6IqDk8oW81k5/ZwhJiUS3+XqVm33kMw32PlVbkXStsesE+Ln
         Oqm6AcnKtTaF804x1xP0IWi7DgMmqngpHrDDIs0cdKgs0K+DfawdwjRJcspo1ZpkqpsY
         rH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600927; x=1756205727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YwzkRnMfZVeEk+/7Wvw5WSR6O0I8sjCpbeLDEFgGJA=;
        b=TojPuFxmY+fiegHcRKH1XoXFUWe/cLwUG++KzGNczdJTjtA9ouz3qGiYvBU0vvxbFx
         b/r9ISuOK3O56i/VtL0DVncPGUK9nchkCcaOJH9xZJyQYZP1SGrXHUqvqoE7rQYwWuno
         jwfPgP9DL5NB/0ySXBqbKt2LVFXiRJB+kxtGXiNxFjvGcL3s5dqnVFyfFrJ3EhgQwVbb
         jeVDcNLEBGmY+l6W4u04ZA+Jof9cvL7AUITD0XiuKM3T6ZhKFfucEPtnCd8j69DN1NTs
         Ti58NiTVjmv6NCAK+XJ92ulr0s5e6SUKXTKAmzLkHdNId3LGo7FFeDPz4TACtu7bnPNA
         wNqA==
X-Forwarded-Encrypted: i=1; AJvYcCVzr5aMJpyny1/RA906LhJRexQz/oywawHLH1UpvqcYJNGvu9kLNcx+10tvcBJ1m1tAWyxFO2GFvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OXO/Wm0j0Z1fd477K2iLHoMv8ETy70gJ0U4WKjqjHuFhUNjk
	ocI1qQpWcUT9tgRlZmH8jgN0YmDxcoyXGKpBwzPLCL0vBUOqHWNHFyYq0uvwzhPzQVI=
X-Gm-Gg: ASbGncv9eThSpJXcJh2+y6ib+ndajfwLHQR3+Fl7ajwxlOQD67KAI1WAjF/bTxh0pyo
	00xew1Atnmv4KRcXckPK0GUe4AMi7H/Nl5j1IWtnNWO/b1FbJtDPZXi2jGLTeTUv3tNs0AZ8qtj
	jVN8KKYSTkJw2NRCoQt0rXendOfaXDkXqpsTgviNqMTaF/GYzaRMnTTPurcL6U9xf2MQ6ni+sfP
	byJC+nLq1p7eknFFPcESdZSC2hiHksEUTFCCKKZFEchKvYYJ0qpzfQrhuv1R/sTK5WfNQMDSe7Y
	iCKDfRoLnnrLt9+EaC1Lg+m02oiub3/ILMKSjlhPevoZpcc8WygGuKdMDV363BLs5o0uHZqsIjY
	Y4SIhGjFFFry34FguK0jUjzdQ
X-Google-Smtp-Source: AGHT+IFaK9RKrxontcegpY0+M2PaHOjm3xrQx5EcdYPu8HX51IFFACknUu6tNWBen+MUCg8qKI/aUA==
X-Received: by 2002:a05:6a00:2e9c:b0:76b:e561:9e1b with SMTP id d2e1a72fcca58-76e80e90bbbmr2517917b3a.1.1755600926733;
        Tue, 19 Aug 2025 03:55:26 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d54e0cfsm2110954b3a.109.2025.08.19.03.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:55:26 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:25:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: use strlen() for governor name comparison
Message-ID: <20250819105524.qdkitat35fvnfmh2@vireshk-i7>
References: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
 <20250819103940.342774-2-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819103940.342774-2-zhangzihuan@kylinos.cn>

On 19-08-25, 18:39, Zihuan Zhang wrote:
> Most kernel code using strncasecmp()/strncmp() passes strlen("xxx")
> as the length argument. cpufreq_parse_policy() previously used
> CPUFREQ_NAME_LEN (16), which is longer than the actual strings
> ("performance" is 11 chars, "powersave" is 9 chars).
> 
> This patch switches to strlen() for the comparison, making the
> matching slightly more permissive (e.g., "powersavexxx" will now
> also match "powersave"). While this is unlikely to cause functional
> issues, it aligns cpufreq with common kernel style and makes the
> behavior more intuitive.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

