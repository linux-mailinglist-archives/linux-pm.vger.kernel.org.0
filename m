Return-Path: <linux-pm+bounces-34122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2CFB483F2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 08:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EF0170AAE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B22221264;
	Mon,  8 Sep 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XE1EdX49"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E1BA42
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312018; cv=none; b=VFevvFMVQVILP0aznR4+dOgcY+HfLqbEqAsqdCBZDhADDa9P2jIv6/FBf/j7xisryuFQJFTfz2r/w3A/f8CSB3Ip2MZbv3mTNP/BdUwFkzTQXpYP5m/IdcN3RbBhJzhgU49A6mCta/JPkReNwjhCrX2D5w06Lj0C6O0N68LLPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312018; c=relaxed/simple;
	bh=bzc4qQuEEvgrgwrE2R9mbQf6DBRnuUtN62w99zNOguw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMjx1mmM/ZUmIW+jgLLiriiWAO2+y9e+CH+GWIYsZAU2ll944eRVPX2JDRziIofZFyC4//rY7QTvcMQ6YSQwzhtMxLIIgLBa+JONvnb3AYntumk5Th6Dy448HNaVB1EeDcdhonLvXq9rHkhsWAk+KuZOG2UwLGWHm19qoBPvwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XE1EdX49; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b476c67c5easo2636202a12.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Sep 2025 23:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757312017; x=1757916817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSpWzyyEZu+Bxd21h2rvWlPTRVpUiAP49N8nWNLhFfU=;
        b=XE1EdX49wqiDC3s+fRpfBhAWMKP/7n6EH8/tAvCx0UcqpmP1RL7mROAIK4G2ZAv70S
         UxG6Vn8sZeWyZ+LWtESy+4f3/aUCqHUvxD9luMUvt9dZVxinZSQzYl4Oy8r0/Wa3vRtI
         fdupl2Kps5Tl54vL5xfRQn4Xk34BIAdSSeAO88Zpcx76E7FJ0bZzMyMkHJugyJ5+0OCL
         e7ZDN3jVNeMPf+HkR5PsEZq9xdBWsyuuEKmCXamaTTdaxpC4KEyr3zhKm+wC9KrfZtYY
         jZt7fr1tcxF27p6baRY8flZRUoWlvyj+L9f0485BIG7e/9ztgnl2qyOFHDzfsUf7hhjv
         tZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757312017; x=1757916817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSpWzyyEZu+Bxd21h2rvWlPTRVpUiAP49N8nWNLhFfU=;
        b=ePQHF2NzBwfNhRcccGwj0iDqVzDJJeBf5vN2fg58SSnvakkcaJO4wHAU7mxG++JMhM
         iJdRxoDTGsVRtjn9vO+P3BIS7SO4nSrXKiXlTR6+JaP1/0QS656NvG5X6qcmJYmadK4K
         LtF2YdjHbVs7RYC5M1r8l/qUorVZseq/RzVqnISgbYnYnCOZAf31Rh8DER8QPu0xfhDU
         v2yTJjEyek61iwm7Fe87JHXPfM0D8VthZ0UxZ+zMknaA5x0UIA8FWIfTHsnTeSHMv+Sd
         QRMC3Q4XZHW/uyizTnGf6t2T/atm+OxAN5ACgrKeOcbg6/7EMjuL7A9aBZYPa3Lt3HnV
         bccA==
X-Forwarded-Encrypted: i=1; AJvYcCWsREPEbJ8uz2o+KjXyoYmVlw4mtM9akb6lVICnqNkV2AXVccVpyueZkPRsUmtd2LzCGxDFCfJ2yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMqu3eCGKiQQMP1wetV2ZFNOi9hxIvM9FHr/oYxPgeZ0hLYS4
	dzuA9cOqCzEoiA81k9F+eTLBvDDhkg1qbf4tdoPtGCJrJPwdLSLbJcgQVsgZCVL5YXQ=
X-Gm-Gg: ASbGncsY7gR4rP5lA30GCIA0qf61X0CXauIZfKf4qGxPzfkborB2RoQEv7a3/HKjasd
	gG8s+qGIfNigJVnL3RvtT9YItsWH8Fj/8Vo3XGqNh9pq4DCzinjYDgj3xzvzYcnHDPgDCTGTFHx
	RQzj59Mtfd1Vx4IUknYNclPcT/VTeMgRIG1+x6NT9goQRtVxWN0UPD6xPw+hQaORFWLK7CEwZLV
	DZvhFOaqUZvfrF1qpaGJeE3+KcGy6orClLXG8R2tNXdPLr4uS/p9suGur+yMvGg3lm+O45vF2KP
	na2ZaNb5XOM7hpsft7bLNZLX5ZX5FLmLrQFzpAGyK5L9QWGsisNZEwOAkfVJGkDREm8lXf4XXyD
	iNo4rtlhocEkgMq7FCCuU+N6I
X-Google-Smtp-Source: AGHT+IHdBfGAMTNAQaghtyqFNtIGW5Wx0vAdVoZp4XMlTkw8tyPs8PqBh9LaIqQl5x4IILpeatDJQg==
X-Received: by 2002:a17:902:fc4f:b0:248:aa0d:bb22 with SMTP id d9443c01a7336-2516e1be7a9mr86223805ad.0.1757312016597;
        Sun, 07 Sep 2025 23:13:36 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b14206426sm164265075ad.17.2025.09.07.23.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:13:35 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:43:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250908061333.rwzq5dj4nxlav6x5@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
 <20250904053700.abdkh23zwi5x65do@vireshk-i7>
 <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>

On 04-09-25, 13:48, Zihuan Zhang wrote:
> I understand your point about the potential duplicate call to
> cpufreq_verify_within_cpu_limits() for drivers with a valid freq-table.
> However, in the third patch of this series, we removed the call to
> cpufreq_generic_frequency_table_verify() from the table_verify path.

Yeah, I missed that.

-- 
viresh

