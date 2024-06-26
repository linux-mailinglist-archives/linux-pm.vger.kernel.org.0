Return-Path: <linux-pm+bounces-10007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E854F917771
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694501F221D5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF913AA3E;
	Wed, 26 Jun 2024 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHD5kVbu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD713AA3C
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376487; cv=none; b=ReJxhnwKi3ZFmOV3K8CFSz0LoLE8EO5cfU6R4Gxuhu/RB167A67nkcwR7RfQsOeQ9OUuNviTc6gNrUvy4TNpPUmeqLLUQc3GiKfFpxTZhVvb0AxZlZVtKmOHOBEwBYwBZcJocqEaUDelrqOouRVGS36vdrHfxiUcN/vxkAns9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376487; c=relaxed/simple;
	bh=M6WBnQVFtvyi2wfyjqjz4MRvXlMKTTXIHg+isqJ9GL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiBJjjshWOdGxtBu5t5CNHX3XsOi9gZyDpOTPQL6Sy7oslGDRAJZqhJ0pQdfd+mqxnncN+OvKbVfAeGmC4rpKtoTUcoG4gsP7Sg33xdbkHKh3bUpHIIcE8F0rlf6kobNnFQNK4dl48YoBzUsXW7kHSLURg+3nmp2in9SmEzWLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHD5kVbu; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d562882f4cso57944b6e.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 21:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719376484; x=1719981284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VG4jlRyCD+JGeMHjtnplqjiPI6rXDpxs/+8GzPHHLGY=;
        b=yHD5kVbuO2A82L6K6GK+HLCnGsu+Lt24iqX4+uJDybrdF1jnHR5qMtfVguz4jRVLN0
         R4rFReOdYqvIoBvZ7mRBK8k9TYk5ZjfQCV0p98qMhxG5AQLojTBdVQmulrkbRNimxBFK
         1mRbVJ0c9eZAjdN3XqhHjbAdExYH2YaryFuZoYsBhPIm21nSURxMJhgFdcMvPdg+4qDr
         fbzI5S0d5k2ycSczb5D7/xYH/9HHj4Olu0zkRL00M5qK9mTMgj90XlN2Y7IMaX6ATOb2
         1e1YuA3OxOWpgiNJUOO0SSQq63ugInM5A69VZjHuHMBl3iwExkm2JOdOIZrJfS05CABC
         AXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719376484; x=1719981284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG4jlRyCD+JGeMHjtnplqjiPI6rXDpxs/+8GzPHHLGY=;
        b=Au9n+QKuK0h/k6TGfad+86Pys7WeDUszfosla+QN+GPdhjS4MBIJoY6bWKL/yIaQTE
         SfIhY1E8IX26gLTubc64GvTmuIwe5rH8o3lUBAJgtLH4QZeh2o96CSN4c3OOonSw+C8F
         Bn5C/JcArgYe/0SpS0V85GVmmNqNjeolDNW7dnQVdOqcBKUCbA9L6MAJjucH6T/j8H6W
         dZfLzOrNf82RH0rtodJF+hfi9COIkWFCOANVAbAfnAvwa/6/LzUQ2clOV6otOeDc0yig
         4L2PTLE6uFb02pDG8c9ggZ2YHvlAHhsJOldt7KTQ82FRNn2wLYKh8SaGU/H3hIbl9Tgz
         5ICw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0AwwZgRCY7gqpnhKVVFDbCH06B0UMiZvU2ZJLnwcUjAECZJP7H5Kcijr4WFNZFkNZdlQy0zagUXzkwtzcDM6h12z7nuIhVI=
X-Gm-Message-State: AOJu0YwpvVBRPaWXFxMw4QnaHd/N4KRbgQ6m4GFb/NvekYHUlfnju1XZ
	FJCM5rEiKJy8MtinqO3vlINAFQcmSzqkg2zV11YcIfwY5YD7KdeP4MAjJgVOOqF3vHGCv8h1Ehj
	c
X-Google-Smtp-Source: AGHT+IF3TEvGQGK56opiow5WQuF34xaU6ta0N1F6/fCI9qz1DpGK6+xYltdN/QIwdgVNxBwrPte07w==
X-Received: by 2002:a05:6808:d4b:b0:3d5:1a20:e8d9 with SMTP id 5614622812f47-3d5459654c0mr10675896b6e.24.1719376484472;
        Tue, 25 Jun 2024 21:34:44 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7068af60b61sm4155236b3a.134.2024.06.25.21.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 21:34:43 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:04:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
Message-ID: <20240626043441.tsmvhzw4mmf6xjzj@vireshk-i7>
References: <20240612064205.2041548-1-chenhuacai@loongson.cn>
 <20240612064205.2041548-3-chenhuacai@loongson.cn>
 <20240625075645.m372bpbe7m2dozil@vireshk-i7>
 <CAAhV-H5wSzhD373L61Mxvu-7ZUSGh9LmC4yBoaHm_5rAxsu-5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5wSzhD373L61Mxvu-7ZUSGh9LmC4yBoaHm_5rAxsu-5w@mail.gmail.com>

On 26-06-24, 11:51, Huacai Chen wrote:
> On Tue, Jun 25, 2024 at 3:56 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 12-06-24, 14:42, Huacai Chen wrote:
> > > +struct loongson3_freq_data {
> > > +     unsigned int cur_cpu_freq;
> >
> > You never use it. Remove it.
> Emm, it is used in loongson3_cpufreq_get().

Yeah, you are just filling it there and reading immediately after
that, which can be done directly too. But you don't use it anywhere
else.

> > > +static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
> > > +{
> > > +     unsigned int cpu = policy->cpu;
> > > +     unsigned int package = cpu_data[cpu].package;
> > > +
> > > +     if (!cpu_online(cpu))
> > > +             return -ENODEV;
> > > +
> > > +     /* setting the cpu frequency */
> > > +     mutex_lock(&cpufreq_mutex[package]);
> >
> > No locking required here. Core doesn't call them in parallel.

s/Core/CPUFreq core/

> I'm a bit confused, I think different cores may call .target() in
> parallel.

Not for same policy, but for different yes.

> Cores in the same package share the same
> LOONGARCH_IOCSR_SMCMBX register, so I think the lock is required.

If that is the access you are protecting, then you better move the
lock to do_service_request() instead, which gets called from other
places too.

What exactly is a package here though ? A group of CPUs doing DVFS
together ? Governed by the same policy structure ? In that case, you
don't need a lock as the cpufreq core guarantees to not call multiple
target_index() routines in parallel for the same policy.

> > > +     msg.id          = cpu;
> > > +     msg.cmd         = CMD_GET_FREQ_LEVEL_NUM;
> > > +     msg.extra       = 0;
> > > +     msg.complete    = 0;
> > > +     ret = do_service_request(&msg);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     max_level = msg.val;
> > > +
> >
> >
> > > +     msg.id          = cpu;
> > > +     msg.cmd         = CMD_GET_FREQ_BOOST_LEVEL;
> > > +     msg.extra       = 0;
> > > +     msg.complete    = 0;
> > > +     ret = do_service_request(&msg);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     boost_level = msg.val;
> >
> > This stuff is repeated a lot, maybe create a generic function for this
> > ?
> Do you means move the msg filling into do_service_request()?

Yeah, the filling of the msg structure, the call to
do_service_request() and returning msg.val.

> > > +static int __init cpufreq_init(void)
> > > +{
> > > +     int i, ret;
> > > +
> > > +     ret = platform_driver_register(&loongson3_platform_driver);
> > > +     if (ret)
> > > +             return ret;
> >
> > What is the use of this platform driver ? I thought the whole purpose
> > of the platform device/driver in your case was to probe this driver.
> > In that case cpufreq_init() should only be doing above and not the
> > below part. The rest should be handled in the probe() function of the
> > driver.
> This driver file is now a very basic version, in future it will be a
> little like intel_pstate that has more than one cpufreq_drivers
> (active/passive, hwp/nohwp, etc.), so it will register different
> cpufreq_drivers depends on the result of configure_cpufreq_info().

At this moment we can only review the current version on its merit.
For the current version, the way things are done is simply wrong. We
can review later once you have more things to add to this. So simplify
it to the best of our understanding for now and make as many changes
later as you need.

> > > +     ret = cpufreq_register_driver(&loongson3_cpufreq_driver);
> > > +     if (ret)
> > > +             goto err;
> > > +
> > > +     pr_info("cpufreq: Loongson-3 CPU frequency driver.\n");
> >
> > Make this pr_debug if you want.. There is not much use of this for the
> > user.
> Emm, I just want to see a line in dmesg.

Yeah, a debug message is what you need then. We don't want to print
too much unnecessarily on the console, unless there is an error.

-- 
viresh

