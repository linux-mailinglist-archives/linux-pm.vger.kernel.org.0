Return-Path: <linux-pm+bounces-25153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB63A8492F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4DA3A85A2
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804B1DF258;
	Thu, 10 Apr 2025 16:03:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6EB1D5AD4;
	Thu, 10 Apr 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300995; cv=none; b=sgdJyG4adaMKt0GrFJrDqUKomgW+PrRiV1Md0cOQtHHYbOW1mbTW4KTLsV3C0gm6WzaSXpzU8Dt3HhepI2Hvcrmp36s/Vnu5t24e0KE9Pc+gbHEJy8+7dVC2ISdLcXJzQj1RY4cOFK2DFGt5flNkri7nFTUbVjZKy7nBdxLf8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300995; c=relaxed/simple;
	bh=/oTDpAu7OrD2QLuiv4BkYLDBdd7znkvA2V5FJSnC4Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXAmUVn7zvV4NZmnRDC20ItO4Q4+C12/s1OZdCLUftuFjNomSW86rKsu3XZQOPL7pnWNI17qETVaKCNCenLIiRFU7X/dsC0XqoeOQXa0T++rPN/DcZelB8Cf9Lj3vjEUF8AZSg9/Noc0wgElwCIgsw0M84WhK0Sks2xpZGwDQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22401f4d35aso12579645ad.2;
        Thu, 10 Apr 2025 09:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744300992; x=1744905792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyULdQ2xbd0MfyWk0JJOZlIlL3Zu2lJHTx06r7dn5CA=;
        b=oT7tYMjyGRkXvIobefxB7243bkoPNrFB2dMf+oT0CpFgZ69ezmYJtFtSxpIDBlppei
         FlboECnXGjtHlFpi7l9Bb79l6nA0yPl4dhxGsnE8tprN/nTuM0YVJZU3TEZ/rKgGhYpT
         FkhFsJfe0wg6zvr7O7rU91zyAQ4X251C8lGRq9IcVgIxzkMiBk3xGjtrB3bq8JruH8Hc
         AG6lx1Q8E7Ng094J92vo7kzXIJQDiEsScUcLYlFKsoHO2NILLezkUu0b2oM3C8WXSUkw
         fuJFgaw5IsRNwPMIQIwOYrZs074MRop5XiIKGId5+sy4EV3be9pYzAXplgqwfQ6h9T5A
         caeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVri40dBDFSLQlUrEoe43gdbm9ZeJ8NY2HnFNuFtLads71w9Dx8H42mC5eYgV7oDZukzlN6aOJC5KxbWY=@vger.kernel.org, AJvYcCXwsiBMEsEn6yZ0rlGjalPo1CAcb6P8ue0VDbqjDp5FWhKkq+mq26JoIkWY93bHyg6WkTwssPR84fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFuzUGtnDGbmeib8Yc8pqxskFlqlxI/M5JYtDAQV9O0bPSzYa
	jk0ppyB72ud8FS2i/KLHeVyYmHTreJfVOKdYsxuQW7uv7pKn5XPh
X-Gm-Gg: ASbGncuL64+pz0UBw7T6O8gZStLwdlMhiWyZaeRFMTxAaV1CplruAdghitPRe+X8wJr
	RleazjYFSAonK4hvjdotSJolanjfbjlQ/nxbgbrm5YrF7Jv2/aviw9sZqZnyLlvKySvOcJYQDtZ
	o5KOpaUCzEwzqfDgNjlbzVBjlh1teqXmRqWphUeEc/6lZdALNim9RR5wEcIuzM/fc2cVEeEsDv7
	1J3OZIzhmdWq1lHuk6ereRdtSF4XjpRJWWG2R+TWH7+xf+TGoZSsfWEqVxN3SMPl40HFYndiPYX
	mf6MzNum4AVgjR2FAqWzRyeDrxh0BeU/AFaXNHKyxH0Q9taggBi9bmrSn/nRToJSdpfGgg==
X-Google-Smtp-Source: AGHT+IFeC7Gwe6Y4Y3eXlv1Xmgv943loMBAjrYsh3ubashC2+WryPC2L6Z3XTDFLlEKEEqdrQETCzQ==
X-Received: by 2002:a17:902:f686:b0:224:376:7a07 with SMTP id d9443c01a7336-22b2edca7e3mr38991655ad.13.1744300991731;
        Thu, 10 Apr 2025 09:03:11 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8ae95sm32378625ad.61.2025.04.10.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:03:11 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:03:07 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: Don't ignore limit changes when util
 is unchanged
Message-ID: <Z_fru1i1OpAQ-hJq@sultan-box.localdomain>
References: <20250410024439.20859-1-sultan@kerneltoast.com>
 <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>

On Thu, Apr 10, 2025 at 05:34:39PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 10, 2025 at 4:45 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> >
> > From: Sultan Alsawaf <sultan@kerneltoast.com>
> >
> > When utilization is unchanged, a policy limits update is ignored unless
> > CPUFREQ_NEED_UPDATE_LIMITS is set. This occurs because limits_changed
> > depends on the old broken behavior of need_freq_update to trigger a call
> > into cpufreq_driver_resolve_freq() to evaluate the changed policy limits.
> >
> > After fixing need_freq_update, limit changes are ignored without
> > CPUFREQ_NEED_UPDATE_LIMITS, at least until utilization changes enough to
> > make map_util_freq() return something different.
> >
> > Fix the ignored limit changes by preserving the value of limits_changed
> > until get_next_freq() is called, so limits_changed can trigger a call to
> > cpufreq_driver_resolve_freq().
> >
> > Reported-and-tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > Link: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org
> > Fixes: 8e461a1cb43d6 ("cpufreq: schedutil: Fix superfluous updates caused by need_freq_update")
> > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 1a19d69b91ed3..f37b999854d52 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >                 return false;
> >
> >         if (unlikely(sg_policy->limits_changed)) {
> > -               sg_policy->limits_changed = false;
> >                 sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> >                 return true;
> >         }
> > @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >         freq = get_capacity_ref_freq(policy);
> >         freq = map_util_freq(util, freq, max);
> >
> > -       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > +       if (freq == sg_policy->cached_raw_freq && !sg_policy->limits_changed &&
> > +           !sg_policy->need_freq_update)
> >                 return sg_policy->next_freq;
> >
> > +       sg_policy->limits_changed = false;
> 
> AFAICS, after this code modification, a limit change may be missed due
> to a possible race with sugov_limits() which cannot happen if
> sg_policy->limits_changed is only cleared when it is set before
> updating sg_policy->need_freq_update.

I don't think that's the case because sg_policy->limits_changed is cleared
before the new policy limits are evaluated in cpufreq_driver_resolve_freq().
Granted, if we wanted to be really certain of this, we'd need release semantics.

Looking closer at cpufreq.c actually, isn't there already a race on the updated
policy limits (policy->min and policy->max) since they can be updated again
while schedutil reads them via cpufreq_driver_resolve_freq()?

Sultan

