Return-Path: <linux-pm+bounces-4321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249B68612A5
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 14:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59749B215A0
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8652B7EF0A;
	Fri, 23 Feb 2024 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xwRkhhr+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A576C83
	for <linux-pm@vger.kernel.org>; Fri, 23 Feb 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694864; cv=none; b=i9gBsDVGH9mFaM/iulWLVflF8cBoEor0AWaX5FK5Rm04hZpS/iT1g1ikXCJri4geYwcDGC08BEKk5enaALwXhumIX3uePh/a61G4KOBxJMA0rx7ZIa9WG30LxY/eMLttLHVqaXvvEzcMIVJ3mEV1HdXFg4k/GJetfxTZ39TCgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694864; c=relaxed/simple;
	bh=vP8k20Ag1O076Uu/hwPXs6RI5WGURVuUjElcUfCfwMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ0Sp+5DUcS2Bj6HlCNfB/DiMb/eo1Iu8HOssOC0VzFNEF6sW7BEaFebMLTb/IrlCvqnWTgUlAH3ShUNvi4twJLmT6LyfwyTmfzmQ6RcxNmY7XaYgj6mGoBr0Uu8hvKjJvLufnHHSCjoIgShKoZlpMvochXszY4jQDLZp/tkvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=xwRkhhr+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2509c66daso11624501fa.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Feb 2024 05:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708694858; x=1709299658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ncctXod7EUhdZeRvIKR8JyC0fIDHtd7Zc9VFP5vKak=;
        b=xwRkhhr+N5ps8c3gtgLANKB4vJDSeXxAnJNDPYElg79Nu/oJ07XBQz6W9qcz3rqo5p
         XFyiH9ZO9MSOBA5MBD3sAgHf6JmhZFnN19J1963kSMWPEblpGisElSVKSXy0WAEed5/s
         aMAqpjlBs1Xr2xT1i5HQlNboip2m+AlFcgyJWf21JFsImu4rPKhJipzQLSsP0DlfaGfr
         vwRYyersVCn6PkI0rstJBSiI09vhPswOX3NfNlCXR+SnTjGYUQsJcBEOb+25U+ROFxJk
         FCUMYEU72nBSVRWBYQIZ1aET6k3Mp+/+Wioq813VJGduZDyFNNz+Q59FcJ1px7HYy2xd
         CkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694858; x=1709299658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ncctXod7EUhdZeRvIKR8JyC0fIDHtd7Zc9VFP5vKak=;
        b=WcBmw20aU5PzNfyuZsqrULAdvfHBWWt89Xin2fWn5P/3RqbAVMsqGvMpiKyGALnKA6
         4snDkkok1RJ/3qQ1Dwdw43/tL9ROG06m81yybv/EPGhLmB3D5T9G9zV7j656wJ7t0uDV
         u54KLI+e+xSrfOs0/GaKTLuJlIFaz/nXhYtr0KKWv4rSCpKw+c/rZT6ddfc/6sh11uCm
         JGPn2l1A6rt4K94PmW/g7o+xYEuK2klNY7lVnh92uXUf9z98EjUbQrVMcNOCZ86ze3yb
         IDLmuBzAlmjnNjUNjT4fjaCN2L8rQtbFwNwWPdTM7sneLU97FRFOCFrNd7gmcE5u/28v
         9omQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTZH0jxwxr2DpDZZZPKYsKZEPnLJ5T4a1JFgXH7Dqyo//xx8arQfqjHqWmzpimULVOsy++jADGgrwCAY14cqr71/36XXs1GsY=
X-Gm-Message-State: AOJu0Yw1YLi09UmMCgjUtGQwgZlONn/OnTLrEVcv8p8OsIszhmYxXe34
	0QVwYQA69rjSenzZAOSG4BX0RXuTgsO9aP56Oq+DSFGcd3le/4g496if908Cbf8=
X-Google-Smtp-Source: AGHT+IGHJQtc7/fhy/7PUeyUCJgrv+2MPR6+rU59HBCi8qFcbLzNLCKyqDFu48LBc4YqazWm6Sw1dA==
X-Received: by 2002:a05:6512:a90:b0:512:ed29:684 with SMTP id m16-20020a0565120a9000b00512ed290684mr124852lfu.54.1708694858420;
        Fri, 23 Feb 2024 05:27:38 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id d18-20020a50fe92000000b0056484c0eab8sm4391485edt.57.2024.02.23.05.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:27:37 -0800 (PST)
Date: Fri, 23 Feb 2024 13:27:36 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian.Loehle@arm.com
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240223132736.xp3c3k4k6y2a2ep7@airbuntu>
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <20240205074514.kiolurpounokalum@vireshk-i7>
 <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
 <ca000b2d-b552-43cb-8807-0a5f1450c6a2@arm.com>
 <20240220135037.qriyapwrznz2wdni@airbuntu>
 <d58de550-0ce1-4af9-9e2d-dedd5e73c797@arm.com>
 <20240222115557.blnm4uulkxnorrl4@airbuntu>
 <f4c3f028-b93e-4658-af28-ac2123203d68@arm.com>
 <20240222233947.sl435tvhhpe5iqzw@airbuntu>
 <fdd82ddb-82bc-4c8c-86ef-c80505881013@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdd82ddb-82bc-4c8c-86ef-c80505881013@arm.com>

On 02/23/24 10:48, Pierre Gondois wrote:

> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 66cef33c4ec7..668263c53810 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -576,8 +576,17 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> >          latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> >          if (latency) {
> > +               unsigned int max_delay_us = 2 * MSEC_PER_SEC;;
> > +
> > +               /*
> > +                * If the platform already has high transition_latency, use it
> > +                * as-is.
> > +                */
> > +               if (latency > max_delay_us)
> > +                       return latency;
> > +
> >                  /*
> > -                * For platforms that can change the frequency very fast (< 10
> > +                * For platforms that can change the frequency very fast (< 20
> 
> I think it should be 10->2us as we do:
>   min(latency * 1000, 2ms)

Yeah I meant 2, that was a typo

Thanks

-->8--

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66cef33c4ec7..de92a9912587 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -576,8 +576,17 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)

        latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
        if (latency) {
+               unsigned int max_delay_us = 2 * MSEC_PER_SEC;;
+
+               /*
+                * If the platform already has high transition_latency, use it
+                * as-is.
+                */
+               if (latency > max_delay_us)
+                       return latency;
+
                /*
-                * For platforms that can change the frequency very fast (< 10
+                * For platforms that can change the frequency very fast (< 2
                 * us), the above formula gives a decent transition delay. But
                 * for platforms where transition_latency is in milliseconds, it
                 * ends up giving unrealistic values.
@@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
                 * a reasonable amount of time after which we should reevaluate
                 * the frequency.
                 */
-               return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2 * MSEC_PER_SEC));
+               return min(latency * LATENCY_MULTIPLIER, max_delay_us);
        }

        return LATENCY_MULTIPLIER;

