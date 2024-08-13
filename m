Return-Path: <linux-pm+bounces-12130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0C994FF1C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 09:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8911F23F59
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 07:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23D36A8CF;
	Tue, 13 Aug 2024 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H288B9Pa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54142524B0
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535661; cv=none; b=umk1h4FlD0NoPd3hvGK+XWpD7kNsbygoZOH9SRCat9YjKo86yTWhzdcy4NgSxsCiQCtA2y9XlF62fuwdrmHFwZwL4wkdUv1uhbdlf03cFjXpak0Tg9i2wkkXRqsQTVhxJANDHeT4RA165e8gH/+zp9kvwxQRRaRi0tHeZkPkhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535661; c=relaxed/simple;
	bh=Tagmd0ZHFfAZHe1r1Mr1oZyeFx8z9898PM42DLkVG04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3tqPPmrv9t2h1YLYUxcbaQAfP+oDplj/+rvwTMEavL6Z3DzdAajUPL7YmLPwYop1uRIOsSpdCxH855hBHy1AA1+bGSjyVySM6vMS8asb/q2LXzdrpupIyA3M07W6u4nVGRy9fKRqqIOQuj00b8o4PfT3yMDSCr82UfJFjlvtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H288B9Pa; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cf93dc11c6so4036453a91.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723535660; x=1724140460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=quunBnpR+uyAazpYXeUKYV/u6uqA7jUaGY1RNyrzJvk=;
        b=H288B9Pa2ncrbNPkFbSWzfldBmbSIMQmZzXSzvr5jlLsuBUGP4RK97HKVX6XYtzt2p
         me/kmcVraJqZt3wq9G/p9ya/fwe0vSgbQggYhL21Gj4kZ1+aAoUOsDPonuY3cdc/ssX8
         i9jZC6033cwkXY3zBsG62Jx4l9luC+E1k3/SFEKt62Qy98hxr2KkCH2GwA0mPWDdSJtq
         cHlsLA2PFL/gHjRFqRZTV7T0AbJlwoHNlOkLkKsdNhSfROqyjG4BxO87SabE5Wm9Pv5y
         PpZS+G396f8D4nvp7hFGAwdqsrl4S+jmUf3MpRrvZGgoz6iIu/L/Oj/5WhoPyniCgaNg
         mV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723535660; x=1724140460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quunBnpR+uyAazpYXeUKYV/u6uqA7jUaGY1RNyrzJvk=;
        b=HUTAP8+tH9eX1mAmR9YXAOwAONqFQpBVdcNAhGxWpImtJ3NqgFxpEUD8L7WMIy0bYE
         mTYCsJBXUPseAQ1sn2xuuSnoLFpGvSXse5Of4uRji8Q3f6uk1VpfWkCrEqzJIFHqBys8
         Oa0CXMiDKaJINCKrjNJea/tS7aD1Px5iZRhBf1KQahVJ2+FvEWHicpL+JSXPwV3tekeu
         zkSfBKPBVfi2em2nwU0aFhbdbxtXfPpymfRxJ5Ps72E7QoB3wKqkruMN4SXXfJyCHen0
         o6OnhTbJsT5FIkYJGzghuDr2pgiE/mALaQKnZ9t44h2OQwRqTtKdu2k8ZexScV7jwZa2
         5HvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWveVtcm6QzKYswn2SVDY+FO79dD5QUoYWYdlXxe9IaYAUHdpIgYOs281uXWqe3XJE96IYF7Uu7JaJn4JW69jlRi+yzwLTqpKw=
X-Gm-Message-State: AOJu0YwFBGpUTSsSWFKCv01odOfyESAJJzvZ0KrSr5llc6EUGOPRmKBK
	fQ5hGTLKpOxkDpyVZtZwwOGI6ZjXHO8K/oRFrledQTGYV7lWY/JhoW2sE8BGW8O7YnWsZEXis2U
	FHC1fotNXQa5OcSsWDZfEuGDrqlxQzp5AmQeseEfJwq+XTZkQ+S4=
X-Google-Smtp-Source: AGHT+IGjquCO6vuNugRLHkV98nNv6JV31HDxkHG2BV4oq9FFnH3FXSVBipvECEDVXrTZNgI3x5FxnIOGlvzKaRohCqw=
X-Received: by 2002:a17:90a:6785:b0:2cb:4bed:ed35 with SMTP id
 98e67ed59e1d1-2d39269da03mr2808886a91.41.1723535659547; Tue, 13 Aug 2024
 00:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com> <20240809012410.marjxrio3sjequnn@airbuntu>
 <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Aug 2024 09:54:08 +0200
Message-ID: <CAKfTPtD_QzYVeTbQ-j2mOsKmCcjUaxo403M_HYCWbT2RjjGb7w@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Use USEC_PER_SEC for deadline task
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 09:42, Juri Lelli <juri.lelli@redhat.com> wrote:
>
> On 09/08/24 02:24, Qais Yousef wrote:
> > Adding more sched folks to CC
> >
> > On 08/06/24 14:41, Christian Loehle wrote:
> > > Convert the sugov deadline task attributes to use the available
> > > definitions to make them more readable.
> > > No functional change.
> > >
> > > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index eece6244f9d2..012b38a04894 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
> > >              * Fake (unused) bandwidth; workaround to "fix"
> > >              * priority inheritance.
> > >              */
> > > -           .sched_runtime  =  1000000,
> > > -           .sched_deadline = 10000000,
> > > -           .sched_period   = 10000000,
> > > +           .sched_runtime  = USEC_PER_SEC,
> > > +           .sched_deadline = 10 * USEC_PER_SEC,
> > > +           .sched_period   = 10 * USEC_PER_SEC,
> >
> > I think NSEC_PER_MSEC is the correct one. The units in
> > include/uapi/linux/sched/types.h is not specified. Had to look at
> > sched-deadline.rst to figure it out.
>
> In practice it's the same number :). But, you are correct, we want
> 1ms/10ms and unit is nanoseconds, so NSEC_PER_MSEC.

Yes NSEC_PER_MSEC is the correct unit

>

