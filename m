Return-Path: <linux-pm+bounces-19508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC09F7858
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 10:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8230C165105
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AA72248BA;
	Thu, 19 Dec 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="KRWQ9pp4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC8224890
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600079; cv=none; b=UU7UXcBk1XCqyHwoiGqaxvjK3/QRscDTeYy1LZVrXQ4GQkG+EF1/xU2tvUgZmoTEOeOoyLMyLWlnMxtXlyD062goXaJWIZ1ipJMBPuPRpCoMtBdq70TcxDjiSWCWgJFKRhF5tvfia10ptNM8gmeh3+vQf/RZ2/yCCp8DHwFkaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600079; c=relaxed/simple;
	bh=PeK3Erz2u2VNsT1KrhNrC1lKahHsiRjttm3DwxNi8zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsJClxwaqWi+K5yVLZSkpo2ri0eVJlTzivCieryITh3FgOmMNIpWZGgLyB3q/QnYvDzzA187dWLW6/KDG4ZEQfgrmWeiBQ6A/+Hyt8oNTCXrSR2I2sOjh/7ncwwnjoGvE30jrIwbR0eYZT/YvMDGJdbba2QgdOUejNcS3jaWRc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=KRWQ9pp4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd17f231a7so301091a12.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 01:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1734600076; x=1735204876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IsPONPE+X13c/VfEPHRay9Cqx4TtGB/TUoXn2SEqYbM=;
        b=KRWQ9pp42Ydag88tGXFxx1RPniK1agie7UmLq1ZOIv+o/19do7oztDc+sJMrv0vr7w
         mhqihoLSRvCYAC8A4HrSH14Pit4Vl4qk3cm3f0EJDWqWvyuo3LuAAsFeHscNSGkXS5UM
         2GrwzU+Y/M9gSLExnLnp0TstWhRwFVKH3XccoA8s6bxiwhJF9tAV99kSOq8mW5fIYPGZ
         OWTab+Vr7Q58X0mpTB+QH8N4+aY9OENYS8sI+u89yWX2Q991dU9Rj3DYKe+TRP6ThNBf
         xEGTh82vB+fdIWtpP/Rb4q4wzAOlIg38ADXVteZLLidRpxz69ADOsoFwuV2+lCBcWGK3
         OkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734600076; x=1735204876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsPONPE+X13c/VfEPHRay9Cqx4TtGB/TUoXn2SEqYbM=;
        b=bBoUPt/ZN2A3K0S3HZiHbtK0PWUM+zcbkaBOjlXvfwVuIw8b/P04Sm9+g/OcOdbgOY
         JVH5m9HG4yXzLh/YTPUKVzklHXbCWUdpoFVc2FYVJn3eZXHuIW58uEiWuVL8tToUwyyR
         7lLtV3uGU2h8VkTVYk0KNqex58E4Fo4/Uy2WJ7c5s2sISoZbbtVdHsr5DZvOhYxBob5P
         yS1NOlmBJh+uksnM4njCncSMIfvJWaK+RsOzHXz4TF/cs0qC56vZdg06maKzRnaMKP+B
         w5AbatjxWf94gi2zWT9ZTGJFNiXLtgfGUMVeJAE1fSejaXqTRwaWfnL85GT+uKFiZUCv
         tKBw==
X-Forwarded-Encrypted: i=1; AJvYcCU91e5yLt36AYsq0mu/2Bg5wAnMmO/87RAaaaTPbGsCdVcUdcaNJyp5ffoD4pUHM1SiAhH9sn9J3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNi2ZQSTsbIZhmb/4HTvY9I1AMODBUeEbPWPOFkeP4zhS8hFR
	40avtGpN8Fz370AatAoN/wSfCpIf+C4Yn3ExDlKnRdW2gguhWLxFY/pniWvgZy4G/rOp4HEwMei
	WYYAScUE3KLA6rClwNHijEMbmnIRz0QNjGsNB3A==
X-Gm-Gg: ASbGnctL4c7kVZi5rCWY8jqKgSQW20AuUNHsbvD5uPLUEIrt1rXezUS+uVDN85K8ye7
	BU8RhxHFd/rExaW2QvJzS6BIFUSLfg0aBR/yOOvk=
X-Google-Smtp-Source: AGHT+IFfmk0LhhhUZWa9TPRyEGMYUEe+2S62e6wTE3V3wNGeIrZpxGsKZ1tmE70rz4nx4PGB3GM3SYo491wHRhNMfNc=
X-Received: by 2002:a17:90b:2804:b0:2ee:f80c:6884 with SMTP id
 98e67ed59e1d1-2f443d6e77amr3809323a91.33.1734600075862; Thu, 19 Dec 2024
 01:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218190030.1228868-1-naresh.solanki@9elements.com> <b1210cbf-22c8-48f1-ad50-d81395abc8f3@amd.com>
In-Reply-To: <b1210cbf-22c8-48f1-ad50-d81395abc8f3@amd.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 19 Dec 2024 14:51:05 +0530
Message-ID: <CABqG17h_b+_c2oBPyKWjUjHUVe0Nis+PyvgfvzAMdA1Dcd=rMA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Refactor max frequency calculation
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi ,

On Thu, 19 Dec 2024 at 00:50, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/18/2024 13:00, Naresh Solanki wrote:
> > Refactor to calculate max-freq more accurately.
>
> Can you add some more detail about what you're finding?
> What was it before, what is it now, why is it more accurate?
Sure.
The previous approach had some roundoff error due to division compute
when calculating boost ratio.
Which intern affected max-freq calculation resulting in reporting lower value
In my Glinda SoC board,
See below calculations with below values:
max_perf = 208
nominal_perf = 100
normal_freq = 2600

How linux kernel calculates:
freq = ( (max_perf * 1024 / nominal_perf) * normal_freq) / 1024
freq = 5405 // Integer arithmatic.

With the changes
freq = (max_perf * normal_freq) / nominal_perf
freq = 5408



>
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >   drivers/cpufreq/amd-pstate.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index d7630bab2516..78a2cbd14952 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -892,7 +892,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
> >       u64 numerator;
> >       u32 nominal_perf, nominal_freq;
> >       u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> > -     u32 boost_ratio, lowest_nonlinear_ratio;
> > +     u32 lowest_nonlinear_ratio;
> >       struct cppc_perf_caps cppc_perf;
> >
> >       ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > @@ -914,8 +914,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
> >       ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
> >       if (ret)
> >               return ret;
> > -     boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
> > -     max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
> > +     max_freq = div_u64(numerator * nominal_freq * 1000, nominal_perf);
>
> This doesn't apply currently, because of some changes in the
> superm1.git/linux-next branch; specifically:
>
> https://git.kernel.org/superm1/c/68cb0e77b6439
>
> I haven't sent this out to linux-pm yet so it could be in linux-next,
> but will be doing that soon.  So can you please rebase on that branch if
> this change still makes sense?
Sure. Will do

Regards,
Naresh Solanki
>
> >
> >       lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> >       lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
>

