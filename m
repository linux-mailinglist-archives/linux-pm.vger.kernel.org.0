Return-Path: <linux-pm+bounces-19530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D69F7FE3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765A71886C29
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F53223E64;
	Thu, 19 Dec 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="P7TDVxV4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF8226165
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626042; cv=none; b=aapMPtsXkmVqtC5c7w74uvBa16IVbgbn6fVLslPNvC0pOEVYvjlnkA7jsODedow3CUY9CnXprOp5RRER8IOiwkLX7llvqWjynawTR6G6gv8VB0NDKaZ3XRYcwqQKaL669HAv4K3cVD2ZR3CrZ5zcwNsALb3XKhapjNUoR+4p7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626042; c=relaxed/simple;
	bh=fd8pe9q27t0snoghbQJuzD4rYDOijUhd6czceJYZ8Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rjlr2e+8AYEKhK+dekc9uy7a4ed+BKphe5zApXZKWfEh3vus9mHW7veuaQYrP7Pi/2SNHWYWKfrQ59oCok22I+86p8sOPifCQnP0hGYS8h2r9CpaOr+vtFpMGgCUmVqy4exEIbggSM/qs0IWajbAL3UI/Ejsu8zBwOygZk7dtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=P7TDVxV4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so930761b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1734626040; x=1735230840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMr+FNY63QVuOOaK2PqZIhybykFZ2EZIgwkJEkGqDH0=;
        b=P7TDVxV4E0sCZ/vC90CLBb2wNMs6gtv7KgFXGJVhkV0rlrNdRn5+NIn2Tj74iJXHHY
         qUgVTdPJK51Qj8z/8jQu8NC9fbKpewpA6kB5AIJl6YSmODFIJUn7b0bKtDAJfQi/C3xA
         WfEBM8EvZ8mZLxdRnKqVuwLVHvTnqVwd4UA//2vPuwE1gupxoWs6fpu9R5/ojdoZ8wvp
         N2CNWF7EpwemCZc+lo/suYd52+noSfghbXqZs3dH51UTa2wxzXshmVARiGLiTxLnLkJH
         3cKl02K73GAZpQOGijRl6E7N4IauoKM8xJ1D+IMUflwTBtcOL28x4uZj2iBYyRlHKe4z
         T8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734626040; x=1735230840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMr+FNY63QVuOOaK2PqZIhybykFZ2EZIgwkJEkGqDH0=;
        b=JIpVW9t3LOP3uPwUFgoost2NUQgyawT/7Yng4lttKJUwsgGvCcDH2zM6ZDV3rY1wrX
         yVNT7vJqp5ZptwfomRQEHsvEy46jKr+NvZGCaM5iYD8MeceNATHJ1Ylu4EH2OqFE1PGy
         LEkKFuoaNFuzpCxdcrSPQbqKFu/U7Wzppxx52Tw3y7926KJONL9wEtDTeI+SIf81ZIV3
         UJ6ye/6NRi8FovVpdEjqddOP9UMbgej5jMN6X8V7K93AZSIzCml2aLg/7uVQQZtBqD1h
         aKJV7Rk99qV+OIptQahzMRwkpiO5LZ0q3xnF9mZ1dxHGLlkJoGDQHqqSNIXzllZ2tn6y
         VKKg==
X-Forwarded-Encrypted: i=1; AJvYcCVRqcX0e8kCx2tHryJOmWAyExZq58fS3cHBeAW2Nr6kbgJOyAjIxLUQABl8nNaekCUbzW0drAcMwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi03/9iormorl5AgisMybCx+lUZrhvWTqC/Y7qwQ5FkIKZgLHa
	TFKGNN6+kLTmBxfUkovqVv2mrn/9hAL9eBtRSZgvZrID+wBCa1CylnF+LZgirB4O2r26siubPta
	gQK4i5Gr93PoEFIIFvzjlOpG9pUaNeWlCpIZKFg==
X-Gm-Gg: ASbGncvN25Mqnu3T80I7yxC//xebCIlZYGpQ3easBpDxQNmSv6j8mhzyawstx/BPYGP
	NPDSG13xu6aUmY4TrgDhNmYRiHvDFVjLZu7SsYqQ=
X-Google-Smtp-Source: AGHT+IGHLOv6nsFKcEDUZDaa1utUkSqEtS0DtmCxfwxIntTOnA6StTo5KdqwFKU7K73+oAovI4i5dkiRpMfO7sHmz0o=
X-Received: by 2002:a05:6a00:400b:b0:729:9f1:69bc with SMTP id
 d2e1a72fcca58-72aa8d544eamr6419561b3a.12.1734626040032; Thu, 19 Dec 2024
 08:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218190030.1228868-1-naresh.solanki@9elements.com>
 <b1210cbf-22c8-48f1-ad50-d81395abc8f3@amd.com> <CABqG17h_b+_c2oBPyKWjUjHUVe0Nis+PyvgfvzAMdA1Dcd=rMA@mail.gmail.com>
 <f919e9d0-c466-4e4b-b32c-3713f6468987@amd.com>
In-Reply-To: <f919e9d0-c466-4e4b-b32c-3713f6468987@amd.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 19 Dec 2024 22:03:48 +0530
Message-ID: <CABqG17g1u0ibMZz_4E0mE0a36g4_Tk8D2gL722GFNWBxQYrgiQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Refactor max frequency calculation
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mario

On Thu, 19 Dec 2024 at 20:31, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/19/2024 03:21, Naresh Solanki wrote:
> > Hi ,
> >
> > On Thu, 19 Dec 2024 at 00:50, Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 12/18/2024 13:00, Naresh Solanki wrote:
> >>> Refactor to calculate max-freq more accurately.
> >>
> >> Can you add some more detail about what you're finding?
> >> What was it before, what is it now, why is it more accurate?
> > Sure.
> > The previous approach had some roundoff error due to division compute
> > when calculating boost ratio.
> > Which intern affected max-freq calculation resulting in reporting lower value
> > In my Glinda SoC board,
> > See below calculations with below values:
> > max_perf = 208
> > nominal_perf = 100
> > normal_freq = 2600
> >
> > How linux kernel calculates:
> > freq = ( (max_perf * 1024 / nominal_perf) * normal_freq) / 1024
> > freq = 5405 // Integer arithmatic.
> >
> > With the changes
> > freq = (max_perf * normal_freq) / nominal_perf
> > freq = 5408
> >
> >
>
> Ah, thanks!  Please include some of this info in the commit message for
> the next version.
Sure
>
> >
> >>
> >>>
> >>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> >>> ---
> >>>    drivers/cpufreq/amd-pstate.c | 5 ++---
> >>>    1 file changed, 2 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> >>> index d7630bab2516..78a2cbd14952 100644
> >>> --- a/drivers/cpufreq/amd-pstate.c
> >>> +++ b/drivers/cpufreq/amd-pstate.c
> >>> @@ -892,7 +892,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
> >>>        u64 numerator;
> >>>        u32 nominal_perf, nominal_freq;
> >>>        u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> >>> -     u32 boost_ratio, lowest_nonlinear_ratio;
> >>> +     u32 lowest_nonlinear_ratio;
> >>>        struct cppc_perf_caps cppc_perf;
> >>>
> >>>        ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> >>> @@ -914,8 +914,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
> >>>        ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
> >>>        if (ret)
> >>>                return ret;
> >>> -     boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
> >>> -     max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
> >>> +     max_freq = div_u64(numerator * nominal_freq * 1000, nominal_perf);
> >>
> >> This doesn't apply currently, because of some changes in the
> >> superm1.git/linux-next branch; specifically:
> >>
> >> https://git.kernel.org/superm1/c/68cb0e77b6439
> >>
> >> I haven't sent this out to linux-pm yet so it could be in linux-next,
> >> but will be doing that soon.  So can you please rebase on that branch if
> >> this change still makes sense?
> > Sure. Will do
> >
>
> Thanks!
Regards,
Naresh
>
> > Regards,
> > Naresh Solanki
> >>
> >>>
> >>>        lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> >>>        lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
> >>
>

