Return-Path: <linux-pm+bounces-8246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4A8D1DF3
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 16:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEE1283DBC
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D8C16F8FA;
	Tue, 28 May 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHI6j8fB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4016D9C7
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905268; cv=none; b=Nf/HtQt+BaBR+ISHZncrgwaRjCVIDlkzvkDOrpNWFcQ+IKZ7KQtOM6+v6BtkxvR7gg62PHq561QgkRnooLcfk/OixgKzEyldqEhvV0iuHWkGd0nIFrnZXB3+ppNcF5EnQ8xJkOgJmliNkWHM27pOPwgyQG+yYcrJKw/yTSgPMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905268; c=relaxed/simple;
	bh=jdjdppB75uoAt13BI5M5/Jjmnh9buSmpCU+OTqJ0D1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+9at6JuMwBQyQ0Gi0pmscCi5CrE3KUGRmNRdYsHIHg7WQNE0qPYQSmc+jUL8HJo1pXTSNYNHlzqGicS33xSXyH67I4Av3ZdXtu9/s0D9zHGB/4LUDTW0QajXmp3jeONoJCrrn8t/PbAfYoa/v/oLYPYFsHwPiXScNWX+mT4xyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHI6j8fB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f850ff30c0so684642b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716905266; x=1717510066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KwJrJJBUm5Uf3A9xKcODYfkmrzU5XrykNEQneC58gf8=;
        b=IHI6j8fBZu0S6hYIvQbK6wSIdMb5m6jpNfbQ/U7MLlW5VdcoqYeYmOsGsgdj61iY4/
         FqoVb5r4K6p1pf4mfWV5bfr+yqV4VLCtiQ3L7iOOXl3nNh1upzQgaBceSRs5uQy8hkV+
         k4XzfxGNfMLPTl/shOhGg5nrH3+a0ogCAJ6ab9xzNCoTe3D3D+1srupHacVLVuRWU7MK
         WUVLnr0srG7WPh51HS6Ubjr6WAuvWue4k+VUPqJKteWoYl0Y5NHx2zRLn9HsGoGlu9Zs
         iWJ8GYfbmzOw3uY+Vkxc05zEs6eD3uLAHG/8cx1JJKhiGv+5pbhFLDjV3hMO+Zqq9lwA
         zePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905266; x=1717510066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwJrJJBUm5Uf3A9xKcODYfkmrzU5XrykNEQneC58gf8=;
        b=N1RCqAmeQnv/bQtY1HwDl9UiwQQgjrsNhGs2kzJVv2ab3ERytCG2qMOwkbT8ScG2cJ
         +pU37UReYARC8PhOweMgoN0Ot4cgYx3cvgm1Q70FmWT1ayvexlv4ULVb2ls5+JurNWm9
         JrgEGzSjzZTs36cNJiSPb7QEk7TK7NCGIMGBqLF9vYXGe4xMHeho6LROzAnYpIIE3GJ1
         0K/175AeYuhhGJ7Yv0MkSWsifPw97T5NqXztrdfECSfmpKCVxw0T8F6xiBGpnGiHaxhk
         iuTaon5/vzeuVTq600gVWEjCdTLuOJW8ebOTMbtJ5kCE0JiQp6b823eSYnk+JH+D1sd/
         H3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXxWceT/VjRnVah5SeXjWVj2t0GgeEgYbEfML/8lHBspScR28wZO/fSvQUIhT9q3Xx+1mcgV20Ulow3RaCctFbN8UvIdaG2xIY=
X-Gm-Message-State: AOJu0YzzmLSubWsqRLJcbGux4mR0BAJlPwi6YO5VQZzoTA+1ckRCzUki
	RxzHq29++37Wvnf7fzILCSbOG2kFe+wLPnokJ7kL15DRcYPsyUK67SF6t4ZEvKLUnyUVv0OhzW3
	RkgngNBUjikCg60yAgYNFuHf6FVHj82pDp0G2pA==
X-Google-Smtp-Source: AGHT+IEfwlmpC2oQXwwC97Lmjwd4sJMzx+QH6X//LGVcOb6JZk1p/eCzTzAhxtmSsjQTHOqzJmFdujAdomBQnJrwjPk=
X-Received: by 2002:a17:90b:3641:b0:2bf:5730:1f54 with SMTP id
 98e67ed59e1d1-2bf5e14b627mr11482907a91.15.1716905266207; Tue, 28 May 2024
 07:07:46 -0700 (PDT)
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
 <d54d6115-a4d6-466b-a4a2-9c064194f06e@arm.com>
In-Reply-To: <d54d6115-a4d6-466b-a4a2-9c064194f06e@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 28 May 2024 16:07:35 +0200
Message-ID: <CAKfTPtB21aY9cgi5dSHB0jRp6pE85AfGcHrHjrcpMwi3fJL0FA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	Dietmar.Eggemann@arm.com, dsmythies@telus.net, yu.chen.surf@gmail.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 11:59, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> On 5/28/24 10:29, Vincent Guittot wrote:
> > Hi All,
> >
> > I'm quite late on this thread but this patchset creates a major
> > regression for psci cpuidle driver when using the OSI mode (OS
> > initiated mode).  In such a case, cpuidle driver takes care only of
> > CPUs power state and the deeper C-states ,which includes cluster and
> > other power domains, are handled with power domain framework. In such
> > configuration ,cpuidle has only 2 c-states : WFI and cpu off states
> > and others states that include the clusters, are managed by genpd and
> > its governor.
> >
> > This patch selects cpuidle c-state N-1 as soon as the utilization is
> > above CPU capacity / 64 which means at most a level of 16 on the big
> > core but can be as low as 4 on little cores. These levels are very low
> > and the main result is that as soon as there is very little activity
> > on a CPU, cpuidle always selects WFI states whatever the estimated
> > sleep duration and which prevents any deeper states. Another effect is
> > that it also keeps the tick firing every 1ms in my case.
>
> Thanks for reporting this.
> Could you add what regression it's causing, please?
> Performance or higher power?

It's not a perf but rather a power regression. I don't have a power
counter so it's difficult to give figures but I found it while running
a unitary test below on my rb5:
run 500us every 19457ms on medium core (uclamp_min: 600).

With this use case, the idle time is more than 18ms (the 500us becomes
1ms as we don't run at max capacity) but the tick fires every 1ms
while the system is fully idle (all 8 cpus are idle) and as cpuidle
selects WFI, it prevents the full cluster power down. So even if WFI
is efficient, the power impact should be significant.

For a 5 sec test duration, the system doesn't spend any time in
cluster power down state with this patch but spent 3.9 sec in cluster
power down state without


> Do you have some handy numbers, so we can see the problem size?
>
> >
> > IMO, we should at least increase the utilization level
>
> Something worth to discuss, or make it configurable even.
>
> Regards,
> Lukasz
>
> >
> > Regards,
> > Vincent

