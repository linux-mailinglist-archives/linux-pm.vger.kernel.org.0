Return-Path: <linux-pm+bounces-25067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5438A836E5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363973B5B7D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3D31E9B23;
	Thu, 10 Apr 2025 02:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghQ02jdi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4218A6C4;
	Thu, 10 Apr 2025 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253721; cv=none; b=A0dvTx9VuAWkf/aphoDsSVd6ZPd8phSZPwjHgGkwQM5zbgb2dVh9hCRpUnADTsDylZZO5S5jJxz845Fbv+bZLZa4mIQco4ThPTkQRoMF2677PuarKDQwldqfzVveSWN/oN0q6sWDSmKgmipJtKbRDJ+qNm0ctcmYPAngxyq/un4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253721; c=relaxed/simple;
	bh=Skvjlb3TsMI/7aUElRo+vpqhWlHtAXfJ1L6bd9G/KL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdHp4V2xIhxG8lJXRvXPmecU398o4KJX2mR5oOld/6c+sXsJ2jm1TnqZkN5crxUUutXf529EuIFPMlWK0vCzB00mFR6quZZC75Z8UpinI4iC8c08JJ+GNlxvmVkwiwfLXfzWuO+rqARLgLiyFw6ZA3/PEq106NtifwAPHKTG3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghQ02jdi; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-477282401b3so2970011cf.1;
        Wed, 09 Apr 2025 19:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744253719; x=1744858519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt5jKfyXlciGnS8cQeWyfuqT6MgKQJzfSgAcv0mBHaA=;
        b=ghQ02jdiE1995z8XcigcykkKe5hHvjuWu0csuM24rM4PGp5vE4mwISTaFsg1x+WwUK
         to8eMXI7ZG+UDwqGLsHLk3qXbEc/BUmnnEHb7Cv6uNKkIH7S3sPynqMaWlCHMw8E1Rr0
         1uMch+4KwRlNV+4WrUGnQf6tkyRW6OexNwD02R6XSLLTzWLoWIF6/LCOmxXsRUSkq3P+
         xy2n/8IbfzGWiu9GHH2vbBvC7h8jjHgOdso9mNiZNloRHh4J3sG9zq8fjoyCYYpi7Bne
         QOI3572kzdWtKjY5SCArqRRHa7JOQKj63lRGPJpMxKuhA9KSmaQTdvum6HofEm8DGLYF
         tWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744253719; x=1744858519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lt5jKfyXlciGnS8cQeWyfuqT6MgKQJzfSgAcv0mBHaA=;
        b=j6Z44reoPO7jCCEKyFZhnl9/0HOSU2iXneMMrW50huIO6RdRbifFFaItKALCP+lr7E
         yi345jZ3yPd1nq+QOml4sKLFq0hLbP9rf90FSESXHpTMP5Nfd1ZEpppBbY8vmk1y2xHp
         LFP6UGbLKzYV0+CMt2vFcctbZ6253uFQ3Pd6cHtnlOjt9vWKz5kvdfTj+iEmKRy3re4L
         uui7LY0DaDvZfHC7k/FPxUX5BwGbaxRYch5BNw+3hP+9poDw+bbiSJn5AJYKpcbQ2v5+
         dNW7kNRx1sv2qnOYfKUlbjL9zkR2AJR7BmOY93sZICNtrX4pWl0bJxQ1Rbl/Hr8Sm52Y
         Fl5g==
X-Forwarded-Encrypted: i=1; AJvYcCWA6LU3OD1TcKslKKMjc7h6p9+9OdmjBXt1s1tJsIuj9AgyyR2xiHtfaj1UNj4u5cvnM27XpunAqHQ=@vger.kernel.org, AJvYcCWFjCnrbiKkzCAa+E0wk2e+KTtQnu6c3YwTLYUMzPy6Ypxg2hmFxbX4apEs+b6xVnsV9sBuEBHbnlDFSZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Y2vEw7cIyQ5MroC/xkQfdd3TSU8ppWh2dEy1rUpQ8uwYRqKi
	Xwa99ch0ZU8Zz6/uNsgTv/NU1eTH6fdf3JxRIQ4pHLtPJASpfafS492FqDczrCIGPAilfOu4gV3
	9NxmGEHqi2ZBq4kK0gOAHo8M3y/0=
X-Gm-Gg: ASbGncvwv6SK6HtM2IE0l4O8kSnChvKB7hT9kuPS6dqcY5NfQYA8qMgZzSOHKe2MO5R
	FN6R3Ntv/3DK6ZmFv5vpRgJDrqRHLty8oXtwnsNjHidoALch65gN7Jv3+uL849yxiH5eb8zB5Li
	i3cVeCtfl2MY9EZVm8i3GB+laa+dF29YhOTQ==
X-Google-Smtp-Source: AGHT+IF8Zl4Vyemejd2NKha0SKjSe6VEDXFCF3JcDCXSrredngihjmNJ1aFeBaKlCBMXJbTxqLubH6AGEjJR58qwSHI=
X-Received: by 2002:a05:622a:34d:b0:476:8225:dac9 with SMTP id
 d75a77b69052e-4796cd2c147mr19291041cf.45.1744253719052; Wed, 09 Apr 2025
 19:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410024439.20859-1-sultan@kerneltoast.com>
In-Reply-To: <20250410024439.20859-1-sultan@kerneltoast.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 10 Apr 2025 10:55:08 +0800
X-Gm-Features: ATxdqUFc6YgUQfhCMnoIpCaGgYqx4juFi1Lr3vqNkCx7fD6pl2ho0-y4CwI8Dyk
Message-ID: <CAB8ipk8uFReNvm2bYtegN_Nq3qqvW9X9M0xY7uEed=isrms_JQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't ignore limit changes when util
 is unchanged
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sultan,

On Thu, Apr 10, 2025 at 10:46=E2=80=AFAM Sultan Alsawaf <sultan@kerneltoast=
.com> wrote:
>
> From: Sultan Alsawaf <sultan@kerneltoast.com>
>
> When utilization is unchanged, a policy limits update is ignored unless
> CPUFREQ_NEED_UPDATE_LIMITS is set. This occurs because limits_changed
> depends on the old broken behavior of need_freq_update to trigger a call
> into cpufreq_driver_resolve_freq() to evaluate the changed policy limits.
>
> After fixing need_freq_update, limit changes are ignored without
> CPUFREQ_NEED_UPDATE_LIMITS, at least until utilization changes enough to
> make map_util_freq() return something different.
>
> Fix the ignored limit changes by preserving the value of limits_changed
> until get_next_freq() is called, so limits_changed can trigger a call to
> cpufreq_driver_resolve_freq().
>
> Reported-and-tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Link: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org
> Fixes: 8e461a1cb43d6 ("cpufreq: schedutil: Fix superfluous updates caused=
 by need_freq_update")
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 1a19d69b91ed3..f37b999854d52 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_polic=
y *sg_policy, u64 time)
>                 return false;
>
>         if (unlikely(sg_policy->limits_changed)) {
> -               sg_policy->limits_changed =3D false;
>                 sg_policy->need_freq_update =3D cpufreq_driver_test_flags=
(CPUFREQ_NEED_UPDATE_LIMITS);
>                 return true;
>         }
> @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_polic=
y *sg_policy,
>         freq =3D get_capacity_ref_freq(policy);
>         freq =3D map_util_freq(util, freq, max);
>
> -       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->need_fr=
eq_update)
> +       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->limits_=
changed &&
> +           !sg_policy->need_freq_update)

As said in:https://lore.kernel.org/all/CAB8ipk8ARRdR8UPgLqJ3EcAzuE4KNEO=3Dc=
mLNJLk6thTxdBSHWw@mail.gmail.com/

We also should add the limits_changed in the sugov_update_single_freq().

Thanks=EF=BC=81

>                 return sg_policy->next_freq;
>
> +       sg_policy->limits_changed =3D false;
>         sg_policy->cached_raw_freq =3D freq;
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
> --
> 2.49.0
>
>

