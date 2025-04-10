Return-Path: <linux-pm+bounces-25059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ED9A83631
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4A87A3E04
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75361AF0BB;
	Thu, 10 Apr 2025 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCjIKpjm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D10136327;
	Thu, 10 Apr 2025 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744250814; cv=none; b=qY2AAlO7E5exhlPsmCz+U61WopsToZ8v4cO7SatPat6lH8X4monhArYn0vLfT0YHG/lD3XmSMCeKy4JgthSdEMMabawDTl6OVR68k8RykKmQ6OMfZHMqtz54HzZIdCgiE6yfs/yXqq5yOE/0zWnI/JgBh7SG8LP64X2VkF8PDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744250814; c=relaxed/simple;
	bh=6aKPcDBjxIk54AoAKfLiANygiBTVJUz4dADL4xOc+ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTU97hACGFQpCPbuh6SWh0vnvJRHqwKeZ1jtGH2hLZNmjYYG/vsxFHGO65Ary1MIqirM07VsdIl1YyvSQK4ahUiNm6mJkoqzIFuRGjkJ3SXWbKYeCTaVgEyZRZoO9UTK8jm60eaiZQI1Gs6ukaPms6DP7rB9VmuKWo9SOTgehXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCjIKpjm; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-477296dce8dso2873771cf.3;
        Wed, 09 Apr 2025 19:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744250812; x=1744855612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oznmRH0MRwn5C+Bdh8MND8wsPstvx/A6QgxF4SDozmc=;
        b=jCjIKpjmEfIqHiq0QuUXDGiz2kOBRzMf1LlNs0sofAzfscmFIfTn5eSOmKxMc67WEv
         HP3zpCaluB+BarRjfIbZW3DfHdhIDiKext5qGhpQ4itAWIwsRUg/cqUSoiqnY0VQmGBS
         YqRPey2yBqij/Ab6n+MawH54QGj9tdyzOqofJB0CVs1fUp1iARJnstiqmQc1bYeI0Fkl
         JySBHw9L6BhnnCTGttmOameV0LOxpqOMvOhF44sjyEGNIaIL+iEeuJWzBRkPaYHqtkMf
         L99FB+Ez0KF0RchiAKZO1xrcCJoFB+lCOcW1JsfQrKEU4SwtmN/dTpEDXmU89/wnctpt
         eCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744250812; x=1744855612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oznmRH0MRwn5C+Bdh8MND8wsPstvx/A6QgxF4SDozmc=;
        b=X2u8rFtjpqDECNvDjVwG0UA1dmlvWx01rbNpnnD+KR17A920dspYqSsCNvV1BA6Vpj
         sTcaIuKw5OeNkzvLUcrUNaJdKSZBMBpFH7nuTvBcxR/Enia3CwfD926ExM243BIKnCFo
         TFK5rKsjwXjg6+vz5ST4WErXI2Ge42Fp+Go8NhmONxhVyBAwXjqcqs8ya8g75AKO0CNv
         luaw1OIh9YxhjHLV5tuLtsq+TRRKv4/j723zuFJtxbR5VEDAUQO8Fvyw+pebv2xZ/0Zm
         kAxwXWs05zZji87u0L2TmVSkX4S7ewe5T4D59W8OF/0uoI99s52z4KO4PgN9Y6CS27Nz
         iyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeCDFv7XnzhptERI6iqk0wxpCdfULjIsE4eoTFL4XVcYZVTyHxSZ+w4+IoiSWKVm4c4cSUN0HQCfc=@vger.kernel.org, AJvYcCXwgAu9+rlobwQ56BQPo3HHfffSJ5LXQFNq6DS5ytSqGDqt/PunPaKUCpR0IoVT7gDRJG1NXtaGo6GH6YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoE1CljK9D6QmTEjHhLyFxjkBfnPtomJJmtsV2TD7FJnEGG+2L
	jZ9WrwOwNEjINOxhrTlT0M+7EbEoQLp3hTc/a8sjFnG0//ZtIQl7Q/F2lHe+xX3IQl0iJxga2uH
	d7o02J2H+PXuWy4fC9FfRPG0I3e+a0OOf
X-Gm-Gg: ASbGncstUNJ7jweMROABHyBqF0jR8ms/s/bheBRW7U6DAuoMPlzFZwHngoOsdv1V/pt
	Ost3FJZ+S2aU0El2OeqPkutESHxScYJ9qghknhYDbO1OoXzxQRIKQVHEAXGfl6lSCQyaFFfkQHO
	/cTKAsQM6VK3qo6FEdqiR6IXQ=
X-Google-Smtp-Source: AGHT+IE6feir823tk9p04+MQ67tkEvsGFpDhlxE85coCIxK4OgZI1UVSSK2WTf3Psf1vgVvryrvZlJSoAGUwxwPFhA0=
X-Received: by 2002:a05:622a:7d8e:b0:476:a3c8:c78d with SMTP id
 d75a77b69052e-4796cbc7845mr13216021cf.29.1744250812062; Wed, 09 Apr 2025
 19:06:52 -0700 (PDT)
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
 <CAB8ipk_Ayqmh=Ch2aH2c+i-q+qdiQ317VBH1kOHYN=R9dt6LOw@mail.gmail.com> <Z_cjv0EJ45NShYOp@sultan-box.localdomain>
In-Reply-To: <Z_cjv0EJ45NShYOp@sultan-box.localdomain>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 10 Apr 2025 10:06:41 +0800
X-Gm-Features: ATxdqUH-TO5SSdUlIRTVuklZTtQs4JbzNell1efpaLSC386_i8obXDuf740Va-4
Message-ID: <CAB8ipk8WOh5_XvRYJrPi6b6wf8G4=zjoFRWpXk3viv3gkHCn1g@mail.gmail.com>
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

On Thu, Apr 10, 2025 at 9:49=E2=80=AFAM Sultan Alsawaf <sultan@kerneltoast.=
com> wrote:
>
> On Wed, Apr 09, 2025 at 07:48:05PM +0800, Xuewen Yan wrote:
> > Or can we modify it as follows?
> >
> > -->8--
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index 1a19d69b91ed..0e8d3b92ffe7 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct
> > sugov_policy *sg_policy, u64 time)
> >
> >         if (unlikely(sg_policy->limits_changed)) {
> >                 sg_policy->limits_changed =3D false;
> > -               sg_policy->need_freq_update =3D
> > cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > +               sg_policy->need_freq_update =3D true;
> >                 return true;
> >         }
> >
> > @@ -95,11 +95,15 @@ static bool sugov_should_update_freq(struct
> > sugov_policy *sg_policy, u64 time)
> >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64=
 time,
> >                                    unsigned int next_freq)
> >  {
> > -       if (sg_policy->need_freq_update)
> > +       if (sg_policy->need_freq_update) {
> >                 sg_policy->need_freq_update =3D false;
> > -       else if (sg_policy->next_freq =3D=3D next_freq)
> > -               return false;
> > +               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMIT=
S))
> > +                       goto change;
> > +       }
> >
> > +       if (sg_policy->next_freq =3D=3D next_freq)
> > +               return false;
> > +change:
> >         sg_policy->next_freq =3D next_freq;
> >         sg_policy->last_freq_update_time =3D time;
>
> If CPUFREQ_NEED_UPDATE_LIMITS isn't specified, then there's no need to re=
quest a
> frequency switch from the driver when the current frequency is exactly th=
e same
> as the next frequency.

Yes, the following check would return false:

 +       if (sg_policy->next_freq =3D=3D next_freq)
 +               return false;


>
> Sultan

