Return-Path: <linux-pm+bounces-25882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F3A964B2
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68076162F4B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B31F4C97;
	Tue, 22 Apr 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkA6dICB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D791EFF80
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314893; cv=none; b=K6CUc4RAEe7I0KdJcq1NALb8ENq2RM8qhaYm8uAWTCwoEBhVd3EcS1n4H39Zit5DAgUs4E1KIc71fzLFh3ltb8wNHz/KvTlnGEzUJEzx1QI9lxQ2uTRH/h5UdR+JJcqF66r0bCThPxTnYfFRlOxVrV1MLGmcFOFncKbF8yV2PeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314893; c=relaxed/simple;
	bh=FDCbQIG4nzJdOzbeDf3nsAxlO1rpl49HJhh01o/nW3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=focksBQA4K04ajaZ53tvbHHsfssuFCgQycFsEx2c4ZSub71Vuyv24qO5vacyKQgDk3ggFuqXNvWHCjcsV51R5tzTYa9L+9SpECw7V9V1NaiLVTK1RtUj525cegVJa8e8H+ZMtV5PU9GX9JXV4obMFioLOcOfGls6iWwjGVBozUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkA6dICB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22409077c06so66887535ad.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745314891; x=1745919691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXRzhbYyDHmbRdYlaED25foCdIcIJL7J6LQhOxR63lY=;
        b=UkA6dICBrNgkxkwUn99TvLrXKIBWvG7o05Qb/giWKC9kLh/utvfIKwJoio2STLjrNJ
         p1orsHNBd96kTkcDomJUp+BMxoiUAMBwBQ/AfgekBI6WnCkJTevOjkJ6ST9h/FAj2aYx
         p8uSpiaKwCEMgtTuLhFK5aEHO1JsB8FHMeHQGcOHNXUA2Rao5MVCOslBP2GLjVQSKeiK
         QezcwJ1HlBAeLrKMhm0LDax3qBH9FcBzsxMpD48dGSUsuMYMPWqSTxiC7cFzg7slAsTL
         cUKn1QFnIy+Z+yFkzxQOItSo2MurXH6iEAN0wPG/4qxFBTgsO47x7j1hzyDAT+HNJtP1
         iCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745314891; x=1745919691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXRzhbYyDHmbRdYlaED25foCdIcIJL7J6LQhOxR63lY=;
        b=mtZnbxx2d+Uo/WSJxJ0qJCZQ8/T7F/Splaatk4q1/tPZLI/DXmO7zZzFueUiGy+LoN
         YwK6EKQdWA/cQ/BMHrsyvF1g5J/jtlCD+BoJc9gkp/O2qLp9mSiqrPi75bdtjg8D5+xP
         H8JB95AtJq+ZQKhw358RZv7yvUuYFHMDeQOK1pO/u1q+/kogDk0HqMXacwrJIQENgf0c
         q2UViZGbibvFLs4ZHVK1akpXn0dLVxSLCt4DqVcK+QXlEFARrn33ZBKhpDa9A2wwymc9
         ipJ+kUe43AxWuvK7XfnVr/twY1rrkO+Lvutj/C3eDw/V4iWU8THCofd/mhpvy6eDNDZk
         ZMUw==
X-Forwarded-Encrypted: i=1; AJvYcCXO2UBTN9yogMjF+Bi0VqVSn0iGDRBaALxCaaOuXrLAXas9vtEWx7zPbERERc3Ehs8448KF0a5v6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzesFW3IpGMSgLuyeZWhCbENltf0VfRpOYyX3qvuxOz5Xa4Kvxb
	03mF41evxMk+03BUOx0xXrui6R1GA1v5UWq2p2roEz8l9BJspvEqbLVNNj4Xvqs=
X-Gm-Gg: ASbGncsTFGVwc5pN8K13ptUZR06OcfuQDNKz0tlqQD7cWFbmOcEJhwxMZg69yDnlUVx
	bQLgRm07AUBkaaijYlwRBqDGlrw/X/eD8HH5eQDsPqN5M+emMFVaSHqnLl241dbaDiSw0swOviY
	Qq2ecdKAZ9x72MJpnaNnztS3zXXsAbM6hnvlsJExkgrhOmJ65uPIVhXN17LkiYA+jeiXPnUccwG
	xEcGR1RnWGowiTUjbcsrBzg8cIKl1Q8oP42ryXpAmEcSkK5JI8qJYehy3qjpmO6W4dpUtka6DIR
	RpJKaPu6l4v6Upb95sfTA8EUIFhm0tdnBhyGP4MjNg==
X-Google-Smtp-Source: AGHT+IGBF+5OwSQ0xaVM3VR4U/ZR2uMJTt7hmTU2nIb0u4RG5nAie9Fq77O6RWaG86mfMjUNxmXGGQ==
X-Received: by 2002:a17:903:1b67:b0:223:377f:9795 with SMTP id d9443c01a7336-22c530bbe9emr220184655ad.0.1745314890998;
        Tue, 22 Apr 2025 02:41:30 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdb21asm80630065ad.5.2025.04.22.02.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:41:30 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:11:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nicholas Chin <nic.c3.14@gmail.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
	vincent.guittot@linaro.org
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
Message-ID: <20250422094128.wlmr7u4qitwxiniz@vireshk-i7>
References: <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
 <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
 <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
 <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
 <CAKohponCr6pwgmK+J0WnvY_VZdDhA738JF18L518A2MKJVQLmw@mail.gmail.com>
 <c704850d-1fdd-4f25-8251-5bab03f055bb@huawei.com>
 <20250421113753.lwukxhi45bnmqbpq@vireshk-i7>
 <794278e8-633d-4fd7-affa-9e89ba9719bd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794278e8-633d-4fd7-affa-9e89ba9719bd@huawei.com>

On 21-04-25, 21:36, zhenglifeng (A) wrote:
> On 2025/4/21 19:37, Viresh Kumar wrote:
> > +static int policy_set_boost(struct cpufreq_policy *policy, bool enable, bool forced)
> > +{
> > +       if (!forced && (policy->boost_enabled == enable))
> > +               return 0;
> > +
> > +       policy->boost_enabled = enable;
> > +
> > +       ret = cpufreq_driver->set_boost(policy, enable);
> > +       if (ret)
> > +               policy->boost_enabled = !policy->boost_enabled;
> 
> This may cause boost_enabled becomes false but actually boosted when forced
> is true and trying to set boost_enabled from true to true.

Can't do much in case of failure. And this is the current behavior
anyway. This was just some code cleanup, doesn't change the behavior
of the code.

> >  static struct freq_attr local_boost = __ATTR(boost, 0644, show_local_boost, store_local_boost);
> > @@ -1617,16 +1624,17 @@ static int cpufreq_online(unsigned int cpu)
> >         if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
> >                 policy->cdev = of_cpufreq_cooling_register(policy);
> > 
> > -       /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> > +       /*
> > +        * Let the per-policy boost flag mirror the cpufreq_driver boost during
> > +        * initialization for a new policy. For an existing policy, maintain the
> > +        * previous boost value unless global boost is disabled now.
> > +        */
> >         if (cpufreq_driver->set_boost && policy->boost_supported &&
> > -           policy->boost_enabled != cpufreq_boost_enabled()) {
> > -               policy->boost_enabled = cpufreq_boost_enabled();
> > -               ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
> > +           (new_policy || !cpufreq_boost_enabled())) {
> > +               ret = policy_set_boost(policy, cpufreq_boost_enabled(), false);
> 
> I think forced here should be true. If new_policy and
> !cpufreq_boost_enabled() but the cpu is actually boosted by some other
> reason (like what we met in acpi-cpufreq), set_boost() should be forcibly
> executed to make the cpu unboost.

The problem is that setting boost may be time consuming for some
platforms and we may not want to do that unnecessarily. ACPI cpufreq
should be fixed separately for that.

I am sending a series now to fix them all, please review that.

-- 
viresh

