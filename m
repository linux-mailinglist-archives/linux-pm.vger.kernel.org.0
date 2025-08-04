Return-Path: <linux-pm+bounces-31893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25033B1A2B1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D74B18A1C50
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BB27146B;
	Mon,  4 Aug 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUI68mo1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155926E6F2
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312485; cv=none; b=m7P/KJvFucApUf5biVYEvzDAKF5oqE2V8FdK8dCXNO8v3D8DjhR1WRoxsRDuc1Cxotnc5EK0RDkPyMK0XeiqzGoOMd9AETxhURfzW7aXOv7jqJUN9D/v4O066B1Ioc5bRsOGhNnhX68PVECwWSQkfYtL9hDMfWamykZpIVqtyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312485; c=relaxed/simple;
	bh=Gq4bjo9pvlohmfqH9sKBGJwHI28+I5G2Ms9mahNJlI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4Dt6gGxgyvjx4zbMmU/szoqvEBldPkJg1iiWz/7Lu99YpLxySzIcR2xG7bR3xzscH2UM+XwpOSQSWILbzk8wXfw1VOQTI+4HXPdUvAbnNYVdiv8fELVBDVAJRYW9rFielefNxAKOx92Ep38X5HQRLvblQdij1F+WehLWQ6EK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yUI68mo1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61592ff5df8so5359858a12.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754312482; x=1754917282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbfx/91eHfdIqQWmqlgfC8DYVnaVR+jy+kR00RDJwp4=;
        b=yUI68mo1+22TkcUhh8AjxjSgnh00MTILnVEAmnhF84heMcc3MrpX4DmNdFK7xGZu7N
         Y/OIvH19SVPkFscip++vlEVVM4aarL9wdiHZxPNscfcHT6bxXRpsKklzHtVH0M2GnINU
         HxNhbo6LEiVwmTOtB/myWv4l/Ojupz7BqGe3kyFnF0+XB9rN/29jooUDVnxe07f774Ca
         Et9Sr4gh3rq7kEFMQxqXSqJWt3leED/JeUSqKgNAExIa6sWIHdij+k7eFK03QagpvbIx
         +OsvmYglR6fNGJNEV9os9wKLXOWFNYF+MjakijlJKOUajteBpnW79hAz8b6KZoUGvd/N
         xRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754312482; x=1754917282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cbfx/91eHfdIqQWmqlgfC8DYVnaVR+jy+kR00RDJwp4=;
        b=dNbCFccsEO2jwWOi8ftia9QFKsWRLyGMvl+phyFplz59sg5xJMx7PqQlytjN5EbZjn
         HxX7VWZS3VK+ti4b7J6DRuXUlIXFsV+8W3NGr3xvVK0XU3KQbEe58lUUCemTR0BT4oHb
         kSAV9UIaDi/wFxz5JbKIi+KgqYFSlUCyxWXBMmXZH8tG+xXBDfuhmLEOxPUm/zPV6ioq
         xxOrOEAEFf7sX6F/W0ZGgDvWR1GyNeMMRzm8qQBLsnPHDcDJHIPgAk4pDbWKesLoCQ6X
         mapYzlm13fqwB9/yup7K/+w/fROvW4jC4bqIQnObl/4Kzl3NPrdeyzGT2Z3xTf0R/ofT
         mn1w==
X-Forwarded-Encrypted: i=1; AJvYcCUYRgSOZiDtAYZV5XR39EF0mwkwmbk25D1VeQrazn8eRR/tuHdQwyiXhIi5RUWoH70xZQxHvGMgXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0j23BpwIOTbHAW8mcT00JucdZ4JYchArSoihm/1z+XSg3G6eM
	RpXLtARKSEm4tgvDVyQ1VyC01Ttu6xPNY8rr/gdsYCMZQubVtBm0S9hq8XPQ/zzPs04JxIfbrSg
	1T3EzbBL78qs69+21682N2VJlA13o6DGt09TLwp36wA==
X-Gm-Gg: ASbGncs/E8VwD8+J7on3e1/NfvTu67hGft86TC1EQQzlEkb9Rx+hPYcqz05rWsou+kz
	KxyPlHuU1SvEi/xGHwSKMAAioJRtG0mtTYMazZZ0OrLsD25esOQUEzDwo09sh4UOt4s/qhqhAFI
	RUFaLmmt02eegHmYfqXxYS1NLuPZ9Nsd7+KHZBAMVWyw4vhOXIu6l1hnT0TZN1CrSctj9o5DWAA
	KES0ip5DJYGXU2v65xX+VthGA+KkzGYSaH+
X-Google-Smtp-Source: AGHT+IHtPmr160uViLMui5PNuhNDtK1DNT0kjGf5E+umImR/6E4QJZe8IgTdNp7ToyiKqsu8RhM1G3jHn1A9FaF7soU=
X-Received: by 2002:a17:907:3fa3:b0:ae0:635c:a400 with SMTP id
 a640c23a62f3a-af94022f990mr883506466b.51.1754312481888; Mon, 04 Aug 2025
 06:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626093018.106265-1-dietmar.eggemann@arm.com> <e89b250a-7e9b-45fa-9e81-fc071487078b@arm.com>
In-Reply-To: <e89b250a-7e9b-45fa-9e81-fc071487078b@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Aug 2025 15:01:10 +0200
X-Gm-Features: Ac12FXxskiGMJuaGgx3y_xSxFULYlcA0OKM6VKCsSqdhJmPmcrsgp-D0r7FKYkA
Message-ID: <CAKfTPtAwy1ZFQ=-t7SbbDuHj6ZJPtB3pJS6fZxt=1robLwvXjg@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq,base/arch_topology: Calculate cpu_capacity
 according to boost
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Christian Loehle <christian.loehle@arm.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, Beata Michalska <beata.michalska@arm.com>, zhenglifeng1@huawei.com, 
	Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 14:17, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> +cc Vincent Guittot <vincent.guittot@linaro.org>
> +cc Ionela Voinescu <ionela.voinescu@arm.com>
>
> On 26/06/2025 11:30, Dietmar Eggemann wrote:
> > I noticed on my Arm64 big.Little platform (Juno-r0, scmi-cpufreq) that
> > the cpu_scale values (/sys/devices/system/cpu/cpu*/cpu_capacity) of the
> > little CPU changed in v6.14 from 446 to 505. I bisected and found that
> > commit dd016f379ebc ("cpufreq: Introduce a more generic way to set
> > default per-policy boost flag") (1) introduced this change.
> > Juno's scmi FW marks the 2 topmost OPPs of each CPUfreq policy (policy0:
> > 775000 850000, policy1: 950000 1100000) as boost OPPs.
> >
> > The reason is that the 'policy->boost_enabled = true' is now done after
> > 'cpufreq_table_validate_and_sort() -> cpufreq_frequency_table_cpuinfo()'
> > in cpufreq_online() so that 'policy->cpuinfo.max_freq' is set to the
> > 'highest non-boost' instead of the 'highest boost' frequency.
> >
> > This is before the CPUFREQ_CREATE_POLICY notifier is fired in
> > cpufreq_online() to which the cpu_capacity setup code in
> > [drivers/base/arch_topology.c] has registered.
> >
> > Its notifier_call init_cpu_capacity_callback() uses
> > 'policy->cpuinfo.max_freq' to set the per-cpu
> > capacity_freq_ref so that the cpu_capacity can be calculated as:
> >
> > cpu_capacity = raw_cpu_capacity (2) * capacity_freq_ref /
> >                                     'max system-wide cpu frequency'
> >
> > (2) Juno's little CPU has 'capacity-dmips-mhz = <578>'.
> >
> > So before (1) for a little CPU:
> >
> > cpu_capacity = 578 * 850000 / 1100000 = 446
> >
> > and after:
> >
> > cpu_capacity = 578 * 700000 / 800000 = 505
> >
> > This issue can also be seen on Arm64 boards with cpufreq-dt drivers
> > using the 'turbo-mode' dt property for boosted OPPs.
> >
> > What's actually needed IMHO is to calculate cpu_capacity according to
> > the boost value. I.e.:
> >
> > (a) The infrastructure to adjust cpu_capacity in arch_topology.c has to
> >     be kept alive after boot.

If we adjust the cpu_capacity at runtime this will create oscillation
in PELT values. We should stay with one single capacity all time :
- either include boost value but when boost is disable we will never
reach the max capacity of the cpu which could imply that the cpu will
never be overloaded (from scheduler pov)
- either not include boost_value but allow to go above cpu max compute
capacity which is something we already discussed for x86 and the turbo
freq in the past.

> >
> > (b) There has to be some kind of notification from cpufreq.c to
> >     arch_topology.c about the toggling of boost. I'm abusing
> >     CPUFREQ_CREATE_POLICY for this right now. Could we perhaps add a
> >     CPUFREQ_MOD_POLICY for this?
> >
> > (c) Allow unconditional set of policy->cpuinfo.max_freq in case boost
> >     is set to 0 in cpufreq_frequency_table_cpuinfo().
> >     This currently clashes with the commented feature that in case the
> >     driver has set a higher value it should stay untouched.
> >
> > Tested on Arm64 Juno (scmi-cpufreq) and Hikey 960 (cpufreq-dt +
> > added 'turbo-mode' to the topmost OPPs in dts file).
> >
> > This is probably related what Christian Loehle tried to address in
> > https://lkml.kernel.org/r/3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com .
>
> Christian L. reminded me that since commit dd016f379ebc we also have a
> performance regression on a system with boosted OPPs using schedutil
> CPUfreq governor.
>
> The reason is that per cpu 'capacity_freq_ref' is set in
> drivers/base/arch_topology.c only during system boot so far based on the
> highest non-boosted OPP since boost is disabled per default.
>
> Schedutil uses capacity_freq_ref (*) in get_next_freq() to calculate the
> next frequency request:
>
>    next_freq = max_freq * util / max
>                ^^^^^^^^
>                  (*)
>
> In case the boost OPPs will be enabled:
>
>    echo 1 > /sys/devices/system/cpu/cpufreq/boost
>
> 'capacity_freq_ref' stays at the highest non-boosted OPP's so schedutil
> won't request any boosted OPPs for util values > ''highest non boosted
> OPP'/'highest boosted OPP' * max'. The 'highest non boosted OPP' will be
> used by schedutil instead.
>
> This performance regression will go away with the proposed patch as well.
>
> Calling drivers/base/arch_topology.c's init_cpu_capacity_callback() in
> the event that boost is toggled makes sure that 'capacity_freq_ref' will
> be set to the highest boosted (0->1) or highest non-boosted (1->0) OPP.
>
> [...]
>
>
>
>
>

