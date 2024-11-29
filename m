Return-Path: <linux-pm+bounces-18217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D212F9DBEF1
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 05:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6AEB218F6
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 04:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018741531E3;
	Fri, 29 Nov 2024 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nRLLdXS7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3721537AC
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 04:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732852959; cv=none; b=lNMH11nGsY5Fjyc//vku3fP7FTRvWz6OihRRSnFPFRcNVBi3VHvNLBJpZfJmKJ8W40CqxALlVr+f7nafVa3+O2bXu2yyertpeZCOXtrV0Qk29iFEmWVZ5zxtRzKAcIi3tHloloDx6j1bGof1sAwyd+5fixEZW3axJ7x0d7R/FvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732852959; c=relaxed/simple;
	bh=swf3tvexmzGXcI+VvwStGrdUTjxkMIOjndPZHS6BChI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NScn1l91IZRjjZOYAwGaBL18rttZdFhokSYPt7cdQVGq1mtrhSsduqUizpQGhcPFIkZDIZ+PiIzW0dgEZ/qPKPhRXCmVGr5N/PIk+FLA0FZCZmHpOVp5MkEQX1QLLA4c1UY5SLfd+ZXJfzr8krTLQFm49ydMVY691vbOQ3EG7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nRLLdXS7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso966387b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 20:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732852957; x=1733457757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDKIA0yiYCe6asl+5icjBS253n4DcVUQRcHeWfLOnqQ=;
        b=nRLLdXS7F/kP72GrwBJek6prqTrUjOYrMI7ivY/W32G29oGZ3N/g8Kc3EJT6RU706Q
         HSVFDlraq9WtezN1CL+aT0Uv8vCnZQ2TArpDBl8xk5vEu09Tc7B5WtWcboUmN8KdpeqR
         9jtwPqIqH133iTzzcxgUTovv8YdR5kK87jAL63hrX1PDz5vvXADE9YqkB2kxlLqz3G2w
         CSxRw3qH7u4rsL2lBOMshw+pRXqpwPJqeSpYr3A20tp/owJGbHo5QoIEDKmO4qo0gspW
         3+178xxAwigS0IMQgWvwb+DVJL9nQaOSISNOE7XVna4kuBcfRy0x7i0AGlflHcvb4lel
         Rt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732852957; x=1733457757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDKIA0yiYCe6asl+5icjBS253n4DcVUQRcHeWfLOnqQ=;
        b=nP6vDYl1JuiF9pxtT7kDgpTo14QUmM1aErhAock1xBY4c57tZq2U/4q62v5Blpr7pw
         toCZY6Q2gb3YN2q92QWS1D2BE9B5JGfUwK0QGxFMhh0TD3nOzIb+/uxgsDxBq/OVdVN/
         8Xns2PO9M7O0OABe7A55C5FNS6cl1F94PVgHydm7Qzw1meqauRNu64nCrw8cyS5biY62
         QMo+wm509d7yGu6TBE5qOdIRQKLP+FkcMSqnuT1gqHv63Q/xuUKT7wzG0THU6Jv1pkEh
         WUxud29Y3ieT6l6MOym/2BPspWzLg8WIgURoAlay+dYpYvxlCSYZnsZAwxu6EgE5QANV
         WA6g==
X-Forwarded-Encrypted: i=1; AJvYcCUaC57viheMSvnjmDqZ5nrLQ9MW6miJtYfisQZ/lEt47jcWmTg+QLYyfibfGMxM7kAUj/FsD3DqYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFc82mb2ipB/103tqBLUyAQA8zE0ACVkCDPr6IdTSmEt1mcAHt
	CjXUVOHIresvAeHrGZRTRlBuQjCO4n9AlgDP3pNbGA3xeX9WYBN7Xjfmxl2eN09uvDvmq2qwntp
	b
X-Gm-Gg: ASbGncuKQHhw1g6dzGNeqizU9oMpDOCIuChzQcUzb19hNnmgXLATecnChT/Q/mN6vlU
	0Gk5Cv3hFdz3/h+DCn9baOt3O0dKHV2W57kgAsH+dMKRR8YGdN9wkRwV4UURNAZm81MZe3IcO28
	+SMgnasViifgcRh3yimZrPwYQXExjil7Uv2qTomWq8zNhm1ZHnqhcX/KOaJPn78IysxD6N7srZD
	7ofDS6DTuXEaVRlL1xRJZoStTw/Weu9fD7jxUruHk37JfCZZe0j
X-Google-Smtp-Source: AGHT+IEAhW/xPQsLV7GpQCQL+wp98x0Q6oXhlkxjQV5TPTO6tnakzR6fvonO4cnQqjJ0GvMZf0TIcQ==
X-Received: by 2002:a05:6a00:1d1e:b0:725:4301:ed5a with SMTP id d2e1a72fcca58-7254301edc7mr6822764b3a.2.1732852957427;
        Thu, 28 Nov 2024 20:02:37 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbab6sm2495237b3a.106.2024.11.28.20.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 20:02:36 -0800 (PST)
Date: Fri, 29 Nov 2024 09:32:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com, ulf.hansson@linaro.org
Subject: Re: [PATCH v2] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
Message-ID: <20241129040234.enfb2vpehpzhmtmc@vireshk-i7>
References: <20241017190809.16942-1-ansuelsmth@gmail.com>
 <20241119072054.64hi347qmv7ng3un@vireshk-i7>
 <673c549c.5d0a0220.3a3476.517a@mx.google.com>
 <20241119104421.hqsil2uvklxok7lz@vireshk-i7>
 <674470dc.5d0a0220.119e75.b012@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674470dc.5d0a0220.119e75.b012@mx.google.com>

On 25-11-24, 13:43, Christian Marangi wrote:
> sorry for the delay... I checked the example and other cpufreq driver
> that register a simple cpufreq-dt. None of the current driver implements
> a full clk provider internally

Yeah, that may be done from platform code for those drivers instead of the
cpufreq driver.

> and I have some fear it might be
> problematic to have mixed stuff, eventually I feel I should implement a
> small clk driver that implements determine_rate, set_rate, a compatible
> and all sort. And still we would have the double reference of OPP
> Index->Freq Clock->OPP index.

One way to avoid that would be to use performance-state stuff and model this as
a genpd. In that case, opp->level field (which you can set as index only in your
case) will be programmed as is by the genpd core. That's why I cc'd Ulf earlier
as it looked more suited to your case.

> I wonder if a much easier and better solution for this is (similar to
> how we do with suspend and resume) add entry in the struct
> cpufreq_dt_platform_data, to permit to define simple .target_index and
> .get and overwrite the default one cpufreq-dt.

Easier, sure. Better, I doubt that :(

The OPP core currently configures a lot of stuff from set-opp API, like clk,
regulators, genpd (performance state), bandwidth, etc and I really want to use
that infrastructure for everyone instead of starting to open code that in
drivers. The suspend/resume callbacks are special as the OPP core doesn't know
what to do in that case and so it was left for the drivers to handle that.

> This permits to both reduce greatly the airoha-cpufreq driver, register
> a simple cpufreq-dt and prevent any kind of overhead. After all the
> .target_index and .get doesn't do anything fancy, they just call the OPP
> set and clk get rate.

Yeah, clk-get is pretty simple but opp-set isn't and then there is scope of
further enhancements / improvements in the future which can be best handled if
we keep that code common for everyone.

> What do you think? Changes are really trivial since this is already
> implemented for suspend and resume.

I think you can model it as a performance state (which lot of platforms are
doing as well), and then you won't have the index->clk->index issue anymore.

-- 
viresh

