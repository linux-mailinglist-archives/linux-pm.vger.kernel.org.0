Return-Path: <linux-pm+bounces-25063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB99A83684
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D767AFB72
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 02:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7171581E0;
	Thu, 10 Apr 2025 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG1aXFtV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB96A33B;
	Thu, 10 Apr 2025 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252259; cv=none; b=IU4+QpxLRLFuC9+qlCt168iXt3J7S8oM6ilf6D8B5Is1lNLbZUlAt2ZO8PrnARfd731TCXL/MzBFLayMMcrg1whydU1tgtAghhhmrvJ9eNf2VzVSvOtdh6JvhAqXUPIwIb8yr70J11B6Rs8OgVdz0mdZsDkTZSZ4VjacIllBa98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252259; c=relaxed/simple;
	bh=Sb01m70QVvzYf1OKQKlLLPEOLSL11UilQ80M/hCHXPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0GPbYtoa6zcyG8kQ4xmMHgpxOBZurMfrcJFfPmPoLOKAlb0ylazC3OkAE8YAL0JA160RjErBVapY6XJsq2ZpQRL+7kgsUa12fq4QDSLyblGTrgdFk8UJ2HuBjp87touf5CjzPozy2SlLp5/uQhuxRgdIeqntZyKCcRGX/l86Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG1aXFtV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47662449055so1244871cf.1;
        Wed, 09 Apr 2025 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744252256; x=1744857056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZpZ0RxdQu0KsJTftzIw3BlvounQbNro5YfvvV+zxxs=;
        b=nG1aXFtV90MThxJ/mxAOGnIVyzOCEjn2kj02jYU0S/LBA0jDb1c0jxO0lw+qdixD8P
         6cTesaf+1XJrmVm8P2icLUCbahAljzdgjDOPnwjq/kleo1Ls/gbSzqJLIR+ICDSWemxn
         XgyY2k6jtKAhTk1nHgSIL0TBRoHyb6AFHi4H5KSzwsO7E5216HT4aDtqZByPJWVLWu6m
         ScR0lJc2TmAkhaoxO2AaBkgVdnbOZValg/gb0O/YyngTJYhAhpp4gLmwM+zBJPA0QTRj
         M7XOv7RkP/MyDS2Ya67151CC5cQTO+O1sI05LeUpNahVAAp9k5rhLlqLHGoWShCf3n2v
         Ww6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744252256; x=1744857056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZpZ0RxdQu0KsJTftzIw3BlvounQbNro5YfvvV+zxxs=;
        b=mIetKFxejIW9Mi20KzGtInAwRSpQrBPIb8Esepm1Q36JmGX2ViK0oLOlTe/GCUAbpM
         3yawUsI6DN4jJsJWwKqq+rXOCUzvYOlHzW8c0Anb97J0q8+oTIf1SyFmIvPCLVHjuM9x
         qxytTg8tIvyDJedLN+rjLLq+PZGoYjaxC+BxifOvUpH6wXKLdAY4gG0fcKHDMa0m4l35
         PsxgWbS7WPzeWPCPRnz9EjkIGyqyy4jVpdagyS/BBnbEBh09o6ZWCE94RBqfp1gRp2dg
         lSuFpR1tqbKFsATnpPO+Ail61EoDZIwobDdjYYUOJiFizbC9XXrMx+3rp9sfyW+tNy8Z
         KXuA==
X-Forwarded-Encrypted: i=1; AJvYcCUDOsnWo74a2x//+ybBJkG5nt05Ag+moYbrhcNxFHzLDizTgHd2Byr4D4StFx4wZcpKlBfhhT8V/KzBayA=@vger.kernel.org, AJvYcCWR82UZw39hn/mxe8mrqKpjw6Y2ysR6S1tsQN7kG4o7qG2HW51k3nY09zBoL7UtW6RbKw59nOEDJ4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTKiHmv7gETwf10ctEY1+gZH8hzewtkQ5XDbpHTCZKx9IqWa8
	3ytjoldxB2JZoFNt6jF+7xHwicB11cjcPd7LEOsDud+Er1IUuTTwLBTkqfSkh1NV7BearxOqhuv
	fN5DZCJ2+fJ1Jj7V88Bis76RoUbQ=
X-Gm-Gg: ASbGncspLBFqThwvTJrNAmXxoJQ/F3zBwTvXuv4FM024jDTVnQYyw1sKgzCUWMS83TG
	8zXkXJxsLlfIebPNqKknyT0bCIhxyPd/n9zH4oixXBP6J43LwFIs/Xx1V9D/ZgHpFmhomXRS/OB
	Sq1YBzpk8zmO5F7+xqBL6Gqew=
X-Google-Smtp-Source: AGHT+IHUr7nWNpiEV/6XlH+uwtqAJdlvL6R7rj02t7hAXM9X/dD+mB60uGgZ5b7Mg9qLXWSvyMj9rOBkEFSddAul1T4=
X-Received: by 2002:a05:622a:2d2:b0:476:7d74:dd10 with SMTP id
 d75a77b69052e-4796e2f04b2mr9171451cf.19.1744252256279; Wed, 09 Apr 2025
 19:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212015734.41241-2-sultan@kerneltoast.com>
 <Z_Tlc6Qs-tYpxWYb@linaro.org> <Z_U_LN0AtH_n4YtE@sultan-box.localdomain>
 <Z_VTRspvmOUfrawh@linaro.org> <CAB8ipk8ARRdR8UPgLqJ3EcAzuE4KNEO=cmLNJLk6thTxdBSHWw@mail.gmail.com>
 <CAB8ipk_Ayqmh=Ch2aH2c+i-q+qdiQ317VBH1kOHYN=R9dt6LOw@mail.gmail.com>
 <Z_cjv0EJ45NShYOp@sultan-box.localdomain> <CAB8ipk8WOh5_XvRYJrPi6b6wf8G4=zjoFRWpXk3viv3gkHCn1g@mail.gmail.com>
 <Z_coNmh-CabcfIWD@sultan-box.localdomain> <CAB8ipk8AAFFtV3OA4S=g9X9AXsC4Ntr911DLLRkhgQtvMvXAvg@mail.gmail.com>
 <Z_cracmQRfB8hF06@sultan-box.localdomain>
In-Reply-To: <Z_cracmQRfB8hF06@sultan-box.localdomain>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 10 Apr 2025 10:30:45 +0800
X-Gm-Features: ATxdqUHuTBLEzKjqC6nkY7dr2Z1PrNT0S5pjEPgHFxGaQU8APrRFNlRZOyQwk0Y
Message-ID: <CAB8ipk9FdC2X78B4sAnne5=ZS=ZrhZdUKYREEZZk7RQLH8LAwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused by need_freq_update
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:22=E2=80=AFAM Sultan Alsawaf <sultan@kerneltoast=
.com> wrote:
>
> On Thu, Apr 10, 2025 at 10:13:04AM +0800, Xuewen Yan wrote:
> > On Thu, Apr 10, 2025 at 10:09=E2=80=AFAM Sultan Alsawaf <sultan@kernelt=
oast.com> wrote:
> > >
> > > On Thu, Apr 10, 2025 at 10:06:41AM +0800, Xuewen Yan wrote:
> > > > On Thu, Apr 10, 2025 at 9:49=E2=80=AFAM Sultan Alsawaf <sultan@kern=
eltoast.com> wrote:
> > > > >
> > > > > On Wed, Apr 09, 2025 at 07:48:05PM +0800, Xuewen Yan wrote:
> > > > > > Or can we modify it as follows?
> > > > > >
> > > > > > -->8--
> > > > > >
> > > > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cp=
ufreq_schedutil.c
> > > > > > index 1a19d69b91ed..0e8d3b92ffe7 100644
> > > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct
> > > > > > sugov_policy *sg_policy, u64 time)
> > > > > >
> > > > > >         if (unlikely(sg_policy->limits_changed)) {
> > > > > >                 sg_policy->limits_changed =3D false;
> > > > > > -               sg_policy->need_freq_update =3D
> > > > > > cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > > > > +               sg_policy->need_freq_update =3D true;
> > > > > >                 return true;
> > > > > >         }
> > > > > >
> > > > > > @@ -95,11 +95,15 @@ static bool sugov_should_update_freq(struct
> > > > > > sugov_policy *sg_policy, u64 time)
> > > > > >  static bool sugov_update_next_freq(struct sugov_policy *sg_pol=
icy, u64 time,
> > > > > >                                    unsigned int next_freq)
> > > > > >  {
> > > > > > -       if (sg_policy->need_freq_update)
> > > > > > +       if (sg_policy->need_freq_update) {
> > > > > >                 sg_policy->need_freq_update =3D false;
> > > > > > -       else if (sg_policy->next_freq =3D=3D next_freq)
> > > > > > -               return false;
> > > > > > +               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDA=
TE_LIMITS))
> > > > > > +                       goto change;
> > > > > > +       }
> > > > > >
> > > > > > +       if (sg_policy->next_freq =3D=3D next_freq)
> > > > > > +               return false;

I have deleted the else.

> > > > > > +change:
> > > > > >         sg_policy->next_freq =3D next_freq;
> > > > > >         sg_policy->last_freq_update_time =3D time;
> > > > >
> > > > > If CPUFREQ_NEED_UPDATE_LIMITS isn't specified, then there's no ne=
ed to request a
> > > > > frequency switch from the driver when the current frequency is ex=
actly the same
> > > > > as the next frequency.
> > > >
> > > > Yes, the following check would return false:
> > > >
> > > >  +       if (sg_policy->next_freq =3D=3D next_freq)
> > > >  +               return false;
> > >
> > > But what does that change fix? In fact, that change causes a limits u=
pdate to
> > > trigger a frequency switch request to the driver even when the new fr=
equency is
> > > the same as the current one.
> >
> > We set the sg_policy->need_freq_update =3D false instead of
> > sg_policy->need_freq_update =3D
> > cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS),
> > to fix the original issue, and then add the
> > +               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMIT=
S))
> > +                       goto change;
> >
> > to allow cpufreq to update when CPUFREQ_NEED_UPDATE_LIMITS is set.
>
> Please take a closer look at this snippet in sugov_update_next_freq():
>
>         if (sg_policy->need_freq_update)
>                 sg_policy->need_freq_update =3D false;
>         else if (sg_policy->next_freq =3D=3D next_freq)
>                 return false;
>
> The 2nd if-statement is an else-if. Therefore, when need_freq_update is t=
rue, it
> is set to false *and* skips the (sg_policy->next_freq =3D=3D next_freq) c=
heck.
>
> Sultan

