Return-Path: <linux-pm+bounces-20485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D61A12428
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513833A9336
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F811E98FD;
	Wed, 15 Jan 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgdX4O6y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EC3DABFE;
	Wed, 15 Jan 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736945457; cv=none; b=GHRe7ZeI+6l/NBlYSPmIKyjcUYBLAo3fdrKPjRecbAfa72iv7oSRUqTEneOUBJl3sVQacKA39ppGZxCz9eqcdimR1uOaUQh0PzJ90Fqaw930NFA43jZaOMt7/o8kxdRRBfnTes2R5LlE+TDJYgBb6tMiZb4OqmaDcUQ7LjD+4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736945457; c=relaxed/simple;
	bh=hsM+3mjbJ/FLZ39Ng0XglGjOeLpsDOSBHFTEnGQ/cdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzuyTGYGPb1CIT2MfcfPKHt3lZGVgKnC1K4JTg4guTbp5+TvrpWvH64CAezFHLLsGhwa4VmE2YH256/Uvc1whXaMg/mO05dul762DorQrUFoHal9XW2Yrr4wy4SpGnBitAOB222d0oSGo+1+2nraUZBxZzo0si/Xxnpd4Hs7tr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgdX4O6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF86AC4CEDF;
	Wed, 15 Jan 2025 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736945456;
	bh=hsM+3mjbJ/FLZ39Ng0XglGjOeLpsDOSBHFTEnGQ/cdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kgdX4O6ypP2la5IE/6NaUCYX2pcC2IxyxycRS5xg6feSTsqDrUHpTcz2jRAgh25Fw
	 90W6AaWTzMVJcpcctQN2Xb6fhcPhcjDQZl/dvvDqn86gUYuFip2XFfF/sA/Z7bj2HL
	 F3Pg9cACpUK7WXJcOZeSXlBqOEquIHz7irTfzWUg5BfOxYksfoiIIoI6NXJpzWJ6tN
	 aeYT2GFlOhYSCbylc3osww8Bw0bqSUwg9Cg3HPDP7bHWXLWD9h3CojLRRA4tJsC2KY
	 KGg5EtcoMdgoLdl98abeExy9Yxcyt58wo9J2Zvz8oZEpwzZESRceZPeYkf25FVG7PS
	 /9Xy4qt1soS9g==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e3cbd0583so1696230a34.1;
        Wed, 15 Jan 2025 04:50:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU93xRojdeDDDh74zGIQtJMM14Mbd6PeHIzFI+NAvOqkJup+dm/LBFnOPazihEiEyJu4MHOitteVRDJqA4=@vger.kernel.org, AJvYcCVK64k37MC2hrDw7f02eTThPMRKvlZKEf0/edOM/lLYx75oUh7KOiRUsclFGh2skCiNmiIYFx9NyCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5K+UrfqV77yiHo+BOPvf2HSJzF6Q/wY3znMS3seivYT36caI
	GeN+Cw47C5gm6iRXt8V68BzvQHFdjoLPlqWhlD0cO1K1hyiq+X1nQMwxO0UMfUtlMKkYkvBXlkg
	v8eabfwHP3mtTnEQukXaxlJ/4L64=
X-Google-Smtp-Source: AGHT+IG+5mvxjOX5qljn2W+sfXqZQmihbNHVGBEDQchGVBqQhPCB8fr4EE4nWoDWtEhQNbR6gsD25FXfVDBe6LOtYAc=
X-Received: by 2002:a05:6808:14c3:b0:3eb:4137:53bb with SMTP id
 5614622812f47-3ef2ed64538mr20022830b6e.31.1736945456235; Wed, 15 Jan 2025
 04:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115100123.241110-1-zhenglifeng1@huawei.com>
 <20250115100123.241110-2-zhenglifeng1@huawei.com> <20250115111852.hluxcprc7cbrxqtc@vireshk-i7>
In-Reply-To: <20250115111852.hluxcprc7cbrxqtc@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jan 2025 13:50:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h9zb=_HTR-nraCZj18YcOSfkMm7WVZ4ePsziOzpV0ndg@mail.gmail.com>
X-Gm-Features: AbW1kvYyvrv9jML_MXu1Jp0AMMj2_gneJcvacYPRTSlP53Pqe1TqfD6x13CdYJE
Message-ID: <CAJZ5v0h9zb=_HTR-nraCZj18YcOSfkMm7WVZ4ePsziOzpV0ndg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Fix re-boost issue after hotplugging a cpu
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 12:18=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 15-01-25, 18:01, Lifeng Zheng wrote:
> > It turns out that cpuX will stay on the base frequency after performing
> > these operations:
> >
> > 1. boost all cpus: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> >
> > 2. offline the cpu: echo 0 > /sys/devices/system/cpu/cpuX/online
> >
> > 3. deboost all cpus: echo 0 > /sys/devices/system/cpu/cpufreq/boost
> >
> > 4. online the cpu: echo 1 > /sys/devices/system/cpu/cpuX/online
> >
> > 5. boost all cpus again: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> >
> > This is because max_freq_req of the policy is not updated during the
> > online process, and the value of max_freq_req before the last offline i=
s
> > retained. When the CPU is boosted again, freq_qos_update_request() will
> > do nothing because the old value is the same as the new one. This cause=
s
> > the CPU stay on the base frequency. Update max_freq_req (and
> > min_freq_req of course) in cpufreq_online() will solve this problem.
> >
> > Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 1a4cae54a01b..03ae879d50b9 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1475,6 +1475,13 @@ static int cpufreq_online(unsigned int cpu)
> >
> >               blocking_notifier_call_chain(&cpufreq_policy_notifier_lis=
t,
> >                               CPUFREQ_CREATE_POLICY, policy);
> > +     } else {
> > +             ret =3D freq_qos_update_request(policy->min_freq_req, pol=
icy->min);
>
> This may not be required, as min-freq-req is never updated.

It gets updated via scaling_min_freq AFAICS.  Doesn't this matter?

> > +             if (ret < 0)
> > +                     goto out_destroy_policy;
> > +             ret =3D freq_qos_update_request(policy->max_freq_req, pol=
icy->max);
> > +             if (ret < 0)
> > +                     goto out_destroy_policy;
> >       }
> >
> >       if (cpufreq_driver->get && has_target()) {
> > --

