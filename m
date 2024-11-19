Return-Path: <linux-pm+bounces-17757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7219D274C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 14:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3922849BF
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3F1CCEFA;
	Tue, 19 Nov 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyfJGjIv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1C1CCED8;
	Tue, 19 Nov 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024275; cv=none; b=ldSLJnf0oUfKG6awv1438hkKHIIfgpYdD7pKkdwARV/bgp/o0SmPVJVYDLzY9q3wtsuObUUa56PFB7WioGc/WCM3iPe0xYOTQJbvJYvjqfQQWSk7s3ctpzqy6jjEEJywY5HmfqGaqRRm13U4lxz2zg2bVROuzp743jXRiJhoHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024275; c=relaxed/simple;
	bh=8QwOJl5WHjGaRTgE0rhL9lEjUcRF9+/nMUyV9CahWu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKZlLQBees715H27X75l0RwvF6TOUHXPfj/ptcrjkpYzQaGebVPYs9H8flo1G4X70vYXPMDulK7ONzl9UmkGSMjyeftwr1vlE2cRfZaH5lqVlkzCYOYZh/VjIGR5ny5vY1uzsJPe7QHk0mOiqtMLifYIeTE7GgvyisOqNQsaRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyfJGjIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C506EC4CED0;
	Tue, 19 Nov 2024 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732024274;
	bh=8QwOJl5WHjGaRTgE0rhL9lEjUcRF9+/nMUyV9CahWu4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LyfJGjIv/JYQVgEV31q9fQ4P0HnyzlCopF49Xzucqtw0EZWe29uUY3EV9T4bmHuJH
	 0Fsp7fVcTSSjGQoNfuniES8i3RrbNE/apklZ08YYDcADFJ1TG1ja+bypqk4ip3QPNJ
	 PChML/nGDtwSmRf0v2YLv4L4O+gFdEe2mUQDnougAsLNwC8NobqghOeMzZ3Fd3rK8D
	 HlJld93J9H/J1+SfUeRf1H2hcvLYLY/ly3qHFLYyfeN1OLlhhWauL9iKDcToCQBlEv
	 eRjMB0/SkXzf/xn8qT39FIkCWCf6pWIemCyIzPeW/1FIX3cIwnS1Ph8QLs0111srWb
	 l9e1nWTXVvMKw==
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7edb6879196so648360a12.3;
        Tue, 19 Nov 2024 05:51:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDlKoJ3StdHHD9TQcqRcTc6/dz4PvyyXVX5cB6yOr3O8PjM5fjQIwQ/jMfwiyM1NSEzuGjkLyyhQZQDeQ=@vger.kernel.org, AJvYcCWQfEPOzsKMkyYZuwWf/Gd+g20HWa8q0jwIf3bjBRjhfF/cX1i9ESxy/0Ms8J4lW8ox4dJnp8WTxM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZQpRZbODAt9Xu5lJ+SxPZZqCGTWQLmrb8fMB0iA91JxKYmj8
	1Xa3xq8XdXUkYyIdzQG0JhN8bHHdc350eLL60a0h3wvOdil5fsPb18tb1TqF9qj051bwnCL2qyl
	u2eh7JZYgZj8GjneUCW4ka9GZRN8=
X-Google-Smtp-Source: AGHT+IHUMtYxBvfLYQItKbePQ/umS4Ht1ykT0e7FqIyLa2HT/3A/UOJsKW51yQEGE2SNdY2TpLy4hlZZYrtL+TDRNPc=
X-Received: by 2002:a05:6a20:7fa6:b0:1db:ecb5:221f with SMTP id
 adf61e73a8af0-1dc90afc47amr24006837637.4.1732024274323; Tue, 19 Nov 2024
 05:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3607404.iIbC2pHGDl@rjwysocki.net> <2017201.usQuhbGJ8B@rjwysocki.net>
 <173507d9-ec20-431d-a444-0531fd346c03@arm.com>
In-Reply-To: <173507d9-ec20-431d-a444-0531fd346c03@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Nov 2024 14:51:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iv05RxVQ4n3+RPOGp3PyFzWgz60+hEP4rd8cAU0aGiqw@mail.gmail.com>
Message-ID: <CAJZ5v0iv05RxVQ4n3+RPOGp3PyFzWgz60+hEP4rd8cAU0aGiqw@mail.gmail.com>
Subject: Re: [RFC][PATCH v0.1 3/6] PM: EM: Add special case to em_dev_register_perf_domain()
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 4:25=E2=80=AFPM Hongyan Xia <hongyan.xia2@arm.com> =
wrote:
>
> On 08/11/2024 16:38, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Allow em_dev_register_perf_domain() to register a cost-only stub
> > perf domain with one-element states table if the .active_power()
> > callback is not provided.
> >
> > Subsequently, this will be used by the intel_pstate driver to register
> > stub perf domains for CPUs on hybrid systems.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   kernel/power/energy_model.c |   26 +++++++++++++++++++++++---
> >   1 file changed, 23 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/kernel/power/energy_model.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/kernel/power/energy_model.c
> > +++ linux-pm/kernel/power/energy_model.c
> > @@ -426,9 +426,11 @@ static int em_create_pd(struct device *d
> >       if (!em_table)
> >               goto free_pd;
> >
> > -     ret =3D em_create_perf_table(dev, pd, em_table->state, cb, flags)=
;
> > -     if (ret)
> > -             goto free_pd_table;
> > +     if (cb->active_power) {
> > +             ret =3D em_create_perf_table(dev, pd, em_table->state, cb=
, flags);
> > +             if (ret)
> > +                     goto free_pd_table;
> > +     }
> >
> >       ret =3D em_compute_costs(dev, em_table->state, cb, nr_states, fla=
gs);
> >       if (ret)
> > @@ -561,11 +563,20 @@ int em_dev_register_perf_domain(struct d
> >   {
> >       unsigned long cap, prev_cap =3D 0;
> >       unsigned long flags =3D 0;
> > +     bool stub_pd =3D false;
> >       int cpu, ret;
> >
> >       if (!dev || !nr_states || !cb)
> >               return -EINVAL;
> >
> > +     if (!cb->active_power) {
> > +             if (!cb->get_cost || nr_states > 1 || microwatts)
> > +                     return -EINVAL;
> > +
> > +             /* Special case: a stub perf domain. */
> > +             stub_pd =3D true;
> > +     }
> > +
>
> I wonder if the only purpose of stub_pd is to just skip the capacity
> check below, which doesn't look very nice.

It is.

I guess I could just skip it if nr_states =3D=3D 1 because that case means
the same cost for all frequency values.

>
> I may be echoing Dietmar's comments here. What's the problem of just
> having 3 domains?

The energy-efficiency of a CPU is not strictly related to its capacity.

It's about the cases when there are some special CPUs that can
turbo-up higher, but there's no other difference between them and the
other CPUs in the domain.

> Or, could you just specify the same capacities so that the same-capacity
> check won't fail, but just to use hardware load or CPU pressure to model
> the slight difference in real capacities? This way you'd re-use a lot of
> existing infrastructure.

That would have been confusing though, so thanks, but no thanks.

> >       /*
> >        * Use a mutex to serialize the registration of performance domai=
ns and
> >        * let the driver-defined callback functions sleep.
> > @@ -590,6 +601,15 @@ int em_dev_register_perf_domain(struct d
> >                               ret =3D -EEXIST;
> >                               goto unlock;
> >                       }
> > +
> > +                     /*
> > +                      * The capacity need not be the same for all CPUs=
 in a
> > +                      * stub perf domain, so long as the average cost =
of
> > +                      * running on each of them is approximately the s=
ame.
> > +                      */
> > +                     if (stub_pd)
> > +                             continue;
> > +
> >                       /*
> >                        * All CPUs of a domain must have the same
> >                        * micro-architecture since they all share the sa=
me
> >
> >
> >
>
>

