Return-Path: <linux-pm+bounces-25061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF91AA83640
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A260A466196
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 02:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD91C3F34;
	Thu, 10 Apr 2025 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRR0x8yB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C718A6A9;
	Thu, 10 Apr 2025 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251198; cv=none; b=MRek7LU5uZd1fcRHP8vD4pwc66mXU8nzvWHb6kUgIIxgRziJNF6AonVKATwu8vJU0F6z7m1jUf5gqI5RY3W2taD0BAcGayvRjIxF3h/XA8peaaAa9YLdNSt5QOXhPFR+qQ8xXg2sdi5mJjvClu72M7hV054rDbpCkXcHkp3v2Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251198; c=relaxed/simple;
	bh=9vAUrxAjKyHJDzRWa1qjDyDCIBOGq8ba6734aYNaDFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9SzC0//nJvRmsCXOu9fUufoQceos8rlQM2WL9BJ3RpoBxM27Ebz9wCyup0a4x+TWthw+Hug7PhSB3gsIEfhp6dL+rhwONB8Rxh0GN+p4DTs91LavowEqIi0oEwg2HOvitiJNNKUcChnQ8auxc0fISumdzN+3rdHWe3pmwVnM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRR0x8yB; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4766cb762b6so4007091cf.0;
        Wed, 09 Apr 2025 19:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744251196; x=1744855996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVf9MwoCNxP+/cpn16doeRfq5MCUWo9WG7NPQ6gzoE0=;
        b=eRR0x8yBm76xfey7CH659h6ZZdeLpBLTKQFZ5SH1y8hANcHGksm0njs9M+3Q3C6vJn
         AtChtUkmP7hCTgD9WR4nBbgxibKH4B2xCn8Z24cOYNezwpPZ5eMm9FCvsc8mzLEszirm
         FtXI4Dd+VZs9SEQj/aAOW75Tuepb3K/MjTK/6iEc5oItX1g2MVbimcOQwVZia27EAlN5
         wCXwxH7js8f09TLYJf2x+MObEkuChcSPYSLufHFVs2FJLutijpg5LNk5NCxoxChEQJN3
         ioJLxH8JY7rRrSl2xX8gRgieUrgDZH0Zt66Qj51Yw0a5QxqcCfnLz3tS9HRrVB14xl01
         OBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744251196; x=1744855996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVf9MwoCNxP+/cpn16doeRfq5MCUWo9WG7NPQ6gzoE0=;
        b=tlLv/HSq+CrObXVjgHzKZJr0qBGq8cODoIkRbQjYGengshvs1V0h2VY95uRUMTen2A
         +YUCH1zV/wYp1933mlEPHvDKfbKc8YbB8GBUtaldH7QgezuoF99dLPEDqq9+PrEVg4eF
         PMvm1tG7Y/zLP4YznqfSIwR074uGrJ1vaKKE/xhpqz2VA7dl2rJBAC4c2m0CCzRlHjCc
         6LmSF3vnrqp/nZXFGFrX3E00eT7PUvYHualVRcoqjDzgE3Y4xJPDH1RUqJPlMobVurRQ
         9TnYreSW7tYL5XKx3VCs5LSW/D854PzH//A+pbnRMCS2HJR8ekRKeHtNVtb4DvxcUqhu
         jfIg==
X-Forwarded-Encrypted: i=1; AJvYcCXJSFlH+tArxXXZA3R6DNL7ZXzMX8yJnfHclKj1H3zyJ7sGbYDcCGjtLYcgb2em0tTgmss2hN5z3CU=@vger.kernel.org, AJvYcCXtB4bHI734lDn0EkzLYhjUfRaZfT3xoXgCr6o89ZulZrABnCSaknRn00pvOQRtDGzNZQF02mYNzXycaeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8hpsO4YWT6hG7TuMG770tQX/6NYd8BAeEVJKNuZ4eOtqxNEt
	HNitKJowjkCXdTUFdkPQP8XrdxylG6nJrXPN2vf6MIxyAK5WsPjon0x60R9niMQ/lvNEZwVza7O
	oAL+1fZD17a6EVBLHH72S0+koKHA=
X-Gm-Gg: ASbGncvh3KZh/iQkvUYSNB+q6z4zUXfbkhjrT1jPICSfR1NHLYr+zAF+mwot3kbyClf
	Fs/DEpxw2UZE3lr7kAMLy+5qijR9xecHhs7qjsQNfT9PIdDpn8lFX1lOYRMct0fkNL0qbK/QvtD
	+LvNOLepLB6WeDlih3+Clayv4=
X-Google-Smtp-Source: AGHT+IFJvzycvA5vUmXv5irTcljyr+BVoSet8VToDY4cRxKU3iryBsHi2s0tUv1NJpc+zXaqMfk14OdXqDOQhzDLmPE=
X-Received: by 2002:a05:622a:20a:b0:475:19cc:a81a with SMTP id
 d75a77b69052e-4796cf08fcdmr17056041cf.21.1744251195738; Wed, 09 Apr 2025
 19:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com> <Z_Tlc6Qs-tYpxWYb@linaro.org>
 <Z_U_LN0AtH_n4YtE@sultan-box.localdomain> <Z_VTRspvmOUfrawh@linaro.org>
 <CAB8ipk8ARRdR8UPgLqJ3EcAzuE4KNEO=cmLNJLk6thTxdBSHWw@mail.gmail.com>
 <CAB8ipk_Ayqmh=Ch2aH2c+i-q+qdiQ317VBH1kOHYN=R9dt6LOw@mail.gmail.com>
 <Z_cjv0EJ45NShYOp@sultan-box.localdomain> <CAB8ipk8WOh5_XvRYJrPi6b6wf8G4=zjoFRWpXk3viv3gkHCn1g@mail.gmail.com>
 <Z_coNmh-CabcfIWD@sultan-box.localdomain>
In-Reply-To: <Z_coNmh-CabcfIWD@sultan-box.localdomain>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 10 Apr 2025 10:13:04 +0800
X-Gm-Features: ATxdqUGiOybZ38qHE7UOBf3S7FIMeI6dQZvOR5vocfUu62Ttg_9QZjGSl_fRVik
Message-ID: <CAB8ipk8AAFFtV3OA4S=g9X9AXsC4Ntr911DLLRkhgQtvMvXAvg@mail.gmail.com>
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

On Thu, Apr 10, 2025 at 10:09=E2=80=AFAM Sultan Alsawaf <sultan@kerneltoast=
.com> wrote:
>
> On Thu, Apr 10, 2025 at 10:06:41AM +0800, Xuewen Yan wrote:
> > On Thu, Apr 10, 2025 at 9:49=E2=80=AFAM Sultan Alsawaf <sultan@kernelto=
ast.com> wrote:
> > >
> > > On Wed, Apr 09, 2025 at 07:48:05PM +0800, Xuewen Yan wrote:
> > > > Or can we modify it as follows?
> > > >
> > > > -->8--
> > > >
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufre=
q_schedutil.c
> > > > index 1a19d69b91ed..0e8d3b92ffe7 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct
> > > > sugov_policy *sg_policy, u64 time)
> > > >
> > > >         if (unlikely(sg_policy->limits_changed)) {
> > > >                 sg_policy->limits_changed =3D false;
> > > > -               sg_policy->need_freq_update =3D
> > > > cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > > +               sg_policy->need_freq_update =3D true;
> > > >                 return true;
> > > >         }
> > > >
> > > > @@ -95,11 +95,15 @@ static bool sugov_should_update_freq(struct
> > > > sugov_policy *sg_policy, u64 time)
> > > >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy,=
 u64 time,
> > > >                                    unsigned int next_freq)
> > > >  {
> > > > -       if (sg_policy->need_freq_update)
> > > > +       if (sg_policy->need_freq_update) {
> > > >                 sg_policy->need_freq_update =3D false;
> > > > -       else if (sg_policy->next_freq =3D=3D next_freq)
> > > > -               return false;
> > > > +               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_L=
IMITS))
> > > > +                       goto change;
> > > > +       }
> > > >
> > > > +       if (sg_policy->next_freq =3D=3D next_freq)
> > > > +               return false;
> > > > +change:
> > > >         sg_policy->next_freq =3D next_freq;
> > > >         sg_policy->last_freq_update_time =3D time;
> > >
> > > If CPUFREQ_NEED_UPDATE_LIMITS isn't specified, then there's no need t=
o request a
> > > frequency switch from the driver when the current frequency is exactl=
y the same
> > > as the next frequency.
> >
> > Yes, the following check would return false:
> >
> >  +       if (sg_policy->next_freq =3D=3D next_freq)
> >  +               return false;
>
> But what does that change fix? In fact, that change causes a limits updat=
e to
> trigger a frequency switch request to the driver even when the new freque=
ncy is
> the same as the current one.

We set the sg_policy->need_freq_update =3D false instead of
sg_policy->need_freq_update =3D
cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS),
to fix the original issue, and then add the
+               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
+                       goto change;

to allow cpufreq to update when CPUFREQ_NEED_UPDATE_LIMITS is set.

>
> Sultan

