Return-Path: <linux-pm+bounces-8443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E948D5D55
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E865CB23547
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18AF224E8;
	Fri, 31 May 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tiKDy1B2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF52262B
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145863; cv=none; b=n4kPcuySZ/P4XKP+HI3qz0dQmkjsRerTypC40qqXR1sGqSPav1kX187Mk/ILsyqo/W27d8ctWyYEhiltonI9lnsnIEVVkCy0j2ysBWLLhmyetjSDl1WdkKr8G5asFtnICDeTQg/jnWW9NLQyfr1XJuH2ljA5+LkwTQCPp4+NCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145863; c=relaxed/simple;
	bh=jGp5xMVbjd0tUmykpevDlhzB7AOsvsUsk6fB4tAJBRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cm9G7rGbrc6yIxJwq3aBHs0ncXkVAvr7Zq68ziHEY4BiK7B9ipDr262Z/2XBS/Pvh21heaCK0x5tlyY389KjsUj3iY+i+CvzNyVE3rbSnrlyA7Ajt5035dAK3aRRfKGbee2dNS4p4LXXeRRcwkQ+hoWQSgNOkSwsRX1ihDcSs04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tiKDy1B2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c1b45206abso988374a91.1
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717145861; x=1717750661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nPlAccRu1ht0ugLS/YX5R85LXm4AvuNcIW8FJ60Xapc=;
        b=tiKDy1B2hwFCqw6xuI3fWATDtD3MomsjOn2FlwD1SnPrzBOdxV/w8s7Zb5rkAoR+C9
         7YgbN5QzrEkrWOToAQJ3XFjNPeYEk07Lqk8a12l6i7+W6C7u4jIOcaTlVXq2NhxwUCPg
         gFdfuPJ3eyJ0hxHZnfB0ro/3LLVoz7qSqUkVLDKGuM6rFqDRnNiZACt8sL1vclKQuLmf
         v3sBRq1bUyS6Ro5K8Yt0uyH4ObkjqiDkYXdcq0Bbs1ayXKXZSSlIhhr6lkS4kN7P44mf
         o7QdSvYXB5nw8GtvWQsUfaWi8Dboxt7J/7Ibgtw5rrNTnVQ8490QigWXFGuKeq4eCJPx
         hpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717145861; x=1717750661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPlAccRu1ht0ugLS/YX5R85LXm4AvuNcIW8FJ60Xapc=;
        b=DNDsr+QUg/zpNXp1oDo1X+Meg9XvbSEHJU4tlvBYlrwLRyA0p0tT1ZjMmzMqn0AyKZ
         Im3B/MNbdxdg5SuRtYQDrrg5Mqgb1UVIVBJrS1oTjn4y+Bsu+ggiCAOGvCnKwxUhIJpN
         WnLUT6WG424A4NWyf3OneMlKPjCPjxaVHGWloGiBrXMTQbPUF1hrkigxtT4kvt2+kHVc
         B19YElhWenXaYhkhKioOUIc3YHCUctl+6HxMqSjWhvP7mIMq/GBWrG1s0MWkLOgkdge4
         +HxbPzL9Bh7htliqjd5m/rGM7fDSFU8+N1rn9m8EJjkm+2QOuS3tbG8yFBj50a+8swMI
         EUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOs65sk5Go/Sk8mtdxeKq1migRUsTsSDI8NKFq0qrImc79kTGZlv0esN8zgNFakKJWbzmybrZJcDgYR6e9zY3F0NJ/goMco8s=
X-Gm-Message-State: AOJu0YwlZdZK6Qi7v4uL35r67eaglTg7a1k3xvPJpz/VC4s5DqEgjSyJ
	LglwXtrWUc109GJK9hJhdGfOXHbeM60ZximgNmKmmhNGocqsZZ8Zi2x1oha0NAcAaBJ+2vnfHIs
	71s1OkpcX35CGeAbngLTCJXjYZ5P3fGwWoZutkA==
X-Google-Smtp-Source: AGHT+IEk0xAq4H6amqfMwetzDZJPVGDcv7FZKBb2l9gcvP6xSw2q5lzmYnt2+a5eGjhW4z3tZcMHkEzVbz+bKslsKVY=
X-Received: by 2002:a17:90a:bf16:b0:2be:9547:41a8 with SMTP id
 98e67ed59e1d1-2c1dc5d9f17mr1081334a91.48.1717145860631; Fri, 31 May 2024
 01:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com> <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com> <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu> <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
 <d54d6115-a4d6-466b-a4a2-9c064194f06e@arm.com> <CAKfTPtB21aY9cgi5dSHB0jRp6pE85AfGcHrHjrcpMwi3fJL0FA@mail.gmail.com>
 <4cd905e8-594e-4858-89df-a501184ee521@arm.com>
In-Reply-To: <4cd905e8-594e-4858-89df-a501184ee521@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 31 May 2024 10:57:27 +0200
Message-ID: <CAKfTPtCUZfpunq1C9n=3tkjsSSdmd8jhf6kR523NONKvEcxOpQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Christian Loehle <christian.loehle@arm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org, 
	daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com, dsmythies@telus.net, 
	yu.chen.surf@gmail.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 15:09, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 5/28/24 15:07, Vincent Guittot wrote:
> > On Tue, 28 May 2024 at 11:59, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> Hi Vincent,
> >>
> >> On 5/28/24 10:29, Vincent Guittot wrote:
> >>> Hi All,
> >>>
> >>> I'm quite late on this thread but this patchset creates a major
> >>> regression for psci cpuidle driver when using the OSI mode (OS
> >>> initiated mode).  In such a case, cpuidle driver takes care only of
> >>> CPUs power state and the deeper C-states ,which includes cluster and
> >>> other power domains, are handled with power domain framework. In such
> >>> configuration ,cpuidle has only 2 c-states : WFI and cpu off states
> >>> and others states that include the clusters, are managed by genpd and
> >>> its governor.
> >>>
> >>> This patch selects cpuidle c-state N-1 as soon as the utilization is
> >>> above CPU capacity / 64 which means at most a level of 16 on the big
> >>> core but can be as low as 4 on little cores. These levels are very low
> >>> and the main result is that as soon as there is very little activity
> >>> on a CPU, cpuidle always selects WFI states whatever the estimated
> >>> sleep duration and which prevents any deeper states. Another effect is
> >>> that it also keeps the tick firing every 1ms in my case.
> >>
> >> Thanks for reporting this.
> >> Could you add what regression it's causing, please?
> >> Performance or higher power?
> >
> > It's not a perf but rather a power regression. I don't have a power
> > counter so it's difficult to give figures but I found it while running
> > a unitary test below on my rb5:
> > run 500us every 19457ms on medium core (uclamp_min: 600).
>
> Is that supposed to say 19.457ms?

Yes, it's a mistake.  it's 19.457ms I forgot to put the dot when
copying the value from the rt-app json file

> (Because below you say idle time is >18ms and total test time 5sec)
> Is the utilisation more like 1/20000 or 1/20?
> In any case what you describe is probably an issue, I'll try to reproduce.
> Note also my findings here:
> https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com/
>
> Kind Regards,
> Christian
>

