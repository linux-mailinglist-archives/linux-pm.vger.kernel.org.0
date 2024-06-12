Return-Path: <linux-pm+bounces-9003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F920904EBF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 11:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E54C1F24722
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659116B72E;
	Wed, 12 Jun 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUvT4dFo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732FA1649DB
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183080; cv=none; b=qLlCXEQTVptjQ2GPO1+c5OL0BHda2WquWHBo28nbj6ZDBZ7MlFVoc9coey1qrfVylvZzARat7S3rh4ykuV6WeJbz7D6wN/gVQ/q1dVlXAjuHD2p2B5/hPwyxbLeiApkFnQN0CCq0h909cs71yTu3HD88yX+25NtBWM+vgFWnD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183080; c=relaxed/simple;
	bh=KCTdHWjxcSbj0CbGUAMYO0DJrx9aXUjvKSjsWIPb264=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWWjgFZe7sfntpsXaWOHLmVfYyu4JRB1D1LmseVUYaBGkE8zc5OyfFTLriQ3SZQxc13kBMUrg1hQDCn1Rfp5+mJ4f76isQi9VRZ28g1y1a0icKDM5esBXKl7ftfug/q2+Lvw1xMUw9oYaFQvgaP1S5iCX/q/pglkjJ5CqSU5J4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JUvT4dFo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9a1so3090816a91.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718183078; x=1718787878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D2c+AHF5AjtrC8bNsb8AFd3OXBUEz9kIG1oPb2NfBAM=;
        b=JUvT4dFoH7fEBbKluHLRtA1d3ii3a2uNcB6uKv+SbCcQ8OmALCaaRBYwgPY2I2wCtP
         IblW94ndQSjSU75LiJlM33PrPNonnvfyR+mrG4iT85CzpNm4jxFdrHm0fOHTKGPiHaCP
         YDHjKtF8IthMoRFKiHHYB6sdlGawQAx3ujgwgnOdDkcoNuq8iy8wv5IJaLh8A0k78OlA
         mUnKbN/dyjMUGc2Jd8cGLW8gAmqd6ZVNF25NbzIeecixiuzikcqjN3bADEMXfUXFjJmF
         FXDl+P06zyN+gXxPLdL7nXQesGFKzDl1LfwXO78JXLCB/hcl+r4YWne16hbn8W94gGVP
         +Ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718183078; x=1718787878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2c+AHF5AjtrC8bNsb8AFd3OXBUEz9kIG1oPb2NfBAM=;
        b=P4cMDfL9ujpf7VU5ROSqweS418r8jkINqdm3kVvjpoD+kFzR0mWnyEgZ+3Eb6othcj
         vtzMD/GCjo+QWnqXj2WqRuM45ngWoKKZDWfN9sByXFUmdXeye62AbZ/PgYhIbEMfdnUL
         mBcXrJieVL6BYu0cW73Y/Boyh+N1UvTs2qR6Mh5TbgDSg/rOBCWex+2ZwbMly6d7FCks
         +z5ePXNavbOxcPPopZ2SruuV9pvw5BQFDTjIqkInFWPcFgzHexuTaHBpOXrfK/c3ErGM
         g33GJkWt4m8f9N6WY4nb1sOl+zX6QIaIPlFYHQmDt4rPpx90/aH+46AoD7AxkNm02N8H
         4rSg==
X-Forwarded-Encrypted: i=1; AJvYcCWof3H3I1mvOubndRg//pSjfkUvovas4vG6xwdiJUAOG39SJXC/8Xl5dkbY0OJSqaS+vr7kptQtDg94+G0idLs78vbvO2vVRgA=
X-Gm-Message-State: AOJu0YwpL5gfgkQBajXPqTYwtae/kEcus6m/YWMlSmoGYYz2Lb0t8VOR
	biSgCo6zlDdTt9EZKTE7ZWpskq6IVQ1E72ruaqY7OTZbuFjDgIlKfxVLdk/N5iwt+MHibExpWf+
	Wx2ENRMJ0uHsqQKJt3QNDuHErkBQzPwtUO7mGzA==
X-Google-Smtp-Source: AGHT+IEsM1OY43B01m+7YRNAMry97/lo7XEBvuJmAfjDuaVPnQeL9E6H3P1EUAfOk3JnYBSC4GDNsQSGEwImylEYkCI=
X-Received: by 2002:a17:90a:986:b0:2c2:7bbe:d6ba with SMTP id
 98e67ed59e1d1-2c4a7601665mr1276181a91.8.1718183077662; Wed, 12 Jun 2024
 02:04:37 -0700 (PDT)
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
 <286d4cf8-814b-41a2-8d5f-2673dc737f45@arm.com>
In-Reply-To: <286d4cf8-814b-41a2-8d5f-2673dc737f45@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 12 Jun 2024 11:04:26 +0200
Message-ID: <CAKfTPtBh6ZDv7=1Tst1kjQjD=UjDG1DAaQOUCXvzP4ZhD94iTg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	Dietmar.Eggemann@arm.com, dsmythies@telus.net, yu.chen.surf@gmail.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 09:25, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> My apologies for delay, I was on sick leave.
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
> Mid cores are built differently, they have low static power (leakage).
> Therefore, for them the residency in deeper idle state should be
> longer than for Big CPU. When you power off the CPU you loose your
> cache data/code. The data needs to be stored in the L3 or
> further memory. When the cpu is powered on again, it needs code & data.
> Thus, it will transfer that data/code from L3 or from DDR. That
> information transfer has energy cost (it's not for free). The cost
> of data from DDR is very high.
> Then we have to justify if the energy lost while sleeping in shallower
> idle state can be higher than loading data/code from outside.
> For different CPU it would be different.

I'm aware of these points and the residency time of an idle state is
set to reflect this cost. In my case, the idle time is far above the
residency time which means that we should get some energy saving.
cpu off 4.488ms
cluster off 9.987ms
vs
sleep duration 18.000ms

Also, the policy of selecting a shallower idle state than the final
selected one doesn't work with PSCI OSI because cpuidle is only aware
of per CPU idle states but it is not aware of the cluster or
deeper/wider idle states so cpuidle doesn't know what will be the
final selected idle state. This is a major problem, in addition to
keep the tick firing

>
> >
> > With this use case, the idle time is more than 18ms (the 500us becomes
> > 1ms as we don't run at max capacity) but the tick fires every 1ms
> > while the system is fully idle (all 8 cpus are idle) and as cpuidle
> > selects WFI, it prevents the full cluster power down. So even if WFI
> > is efficient, the power impact should be significant.
>
> I would say it's a problem of the right threshold. In this situation
> the tick would be bigger issue IMO.
>
> Because you don't have energy meter on that board, it's hard to say
> if the power impact is significant.
>
> Let's estimate something, when the system is not much loaded:
> Mig CPU often has low freq at ~300-400MHz and Energy Model power
> ~for that OPP is ~30mW.
> If you are loaded in e.g. 1% at lowest frequency than your
> avg power would be ~0.3mW, so ~1mW would be at ~3% load for
> that frequency. That's dynamic power if you need to serve some IRQ,
> like the tick.
> The static power would be ~5% of total power (for these low-power
> cells in Mid core) of this ~30mW, so something ~1.5mW.
> I wouldn't say it's significant, it's some small power which might
> be tackled.
>
> This is when the system is not much loaded. When it's loaded then
> we might pick higher OPP for the Mid cluster, but also quite often
> get tasks in those CPUs. Then the WFI is better in such situations.
>
> >
> > For a 5 sec test duration, the system doesn't spend any time in
> > cluster power down state with this patch but spent 3.9 sec in cluster
> > power down state without
>
> I think this can be achieved with just changing the thresholds.
>
> Regards,
> Lukasz

