Return-Path: <linux-pm+bounces-30581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6C0B002A2
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BE41C409F1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989132E764B;
	Thu, 10 Jul 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfG/+dFi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E342E7628;
	Thu, 10 Jul 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152096; cv=none; b=SbOdwf/6f7ygqXBuDngVUjRqYAD1w/n8aow4K4ioTN7+vBnh8zt2sp75fMXm3dzDV/tYBR6wZTpaVIcqZ3UwXaFm+UHpgGEPB82zeF2twuiX4dVXCcWnrSV3WEfbQ0N6ztF4gf9pMbaJduKM9z93E2jpWBkDONgYB16t4kT/zTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152096; c=relaxed/simple;
	bh=raFX8SlcSqJZTRjsPqPv+1TjVlveBcLkzcFU9rKCBM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rc9Zo5lutEAJAXlG1ydgQ6mHRBTEy9sf2P7Q1KMPJ39Bjhabj3O0HJ4o712ZEC0NuX3/SIDHhcl0GQo7dDLDk3qU+DqDAFJB4M17eZzdb6IxoQ2e6v5EtsbTxSH8vo+2j1MScuvmfRZ2VE9+grZYhCN6FkTGT5ufcdoaZ9Yxcfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfG/+dFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020C2C4CEF6;
	Thu, 10 Jul 2025 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752152096;
	bh=raFX8SlcSqJZTRjsPqPv+1TjVlveBcLkzcFU9rKCBM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DfG/+dFiHFR8TCZX/fUqCaGBsEmiM3IOLNdqScJQMyB5Di4ZXcPkePmxO/teXYTOg
	 UMwXVDTkpgbBT9Gah4l9qBfN/r2NM3fzBWNvMCK9/RyhYfKdL0p69yc3LqIryvfARr
	 G8FXMqsbMAHDvhIioNVk75Te7MXy+hvaXkq4JpV/rKg4MA5Jt8CJ49if56R3XijDp2
	 npUKv4P10RBIdDJ59YV6jpBFHjNioGLzsCghqtMqZg7GgiBy9zsT6f7oYhqjRoAR+t
	 aeUf3ZhqYT96ekMqWBfHlevXkyidjqxx8TVOLmHfQ1RnhJo8fcol+b1Vsgmx8p/9TB
	 wdmyV4FyQOaJg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-613b02e8017so492711eaf.2;
        Thu, 10 Jul 2025 05:54:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+WyVPDQXSPT84/Zqvlx62HtKen5za2CwjRTVDq5w8ufmKZEU67gqvbF4hFUoPKNmEE5q+E5ouV+VL7uA=@vger.kernel.org, AJvYcCXOPG0vHyyvaedUepTDCUOp/KbQCU3htdUC1n1L1M6KQSwJQsUzrIbAgVgwSquoCVP2VW7z3pQWn1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YySzDoeWdDl6elojiW7z2/u00pHd9c0w5GFxU9/gPCvg0/UoTf2
	eYoyYYNTnxFYxoGOmUNrIc/M4MSEr2p5gbBCtAI/e5aRRDKZGNQxmpSst4olNS559FW9p6m4dZI
	V5DFD0+aybHRgzbdbdEknMXk211yEnbw=
X-Google-Smtp-Source: AGHT+IHWq9HVJsqGwxm6z6/YwzBqk1k/gGTYfaUT4CJDelvnmMJf2itXGJk6GEJ1oHnpseG5Oydg8MCEDVr8M4uphvI=
X-Received: by 2002:a05:687c:20d1:b0:2d5:2955:aa6b with SMTP id
 586e51a60fabf-2fef848781cmr5349398fac.5.1752152095256; Thu, 10 Jul 2025
 05:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604213908.27819-1-yury.norov@gmail.com> <CAJZ5v0h7CeO+vG4BVcdc=XxcWMRY+OmhrWxtrAS59T-uK1KDOw@mail.gmail.com>
 <aGvoMhLuX0-zIFVk@yury> <CAJZ5v0gUdm_e6wfLP1aS+L7fe-JNOAWVNvNHLSYqtSydzm5bQg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gUdm_e6wfLP1aS+L7fe-JNOAWVNvNHLSYqtSydzm5bQg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Jul 2025 14:54:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLewzEFBZPOc2bTRFjS7LZYdzPr7cmRnFt7h5p2gg4hg@mail.gmail.com>
X-Gm-Features: Ac12FXzrgfWu03VKezMYsx28idOTmzNYFIIVVWAhOnnv7j1QsWByyygSbjUuhhQ
Message-ID: <CAJZ5v0iLewzEFBZPOc2bTRFjS7LZYdzPr7cmRnFt7h5p2gg4hg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: dt: fix opencoded for_each_cpu() in idle_state_valid()
To: Yury Norov <yury.norov@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 6:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Jul 7, 2025 at 5:31=E2=80=AFPM Yury Norov <yury.norov@gmail.com> =
wrote:
> >
> > On Wed, Jul 02, 2025 at 08:27:21PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 4, 2025 at 11:39=E2=80=AFPM Yury Norov <yury.norov@gmail.=
com> wrote:
> > > >
> > > > From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > >
> > > > The function opencodes the for_each_cpu_from() by using an open for=
-loop.
> > > > Fix that in sake of readability.
> > > >
> > > > While there, drop the 'valid' variable as it's pretty useless here.
> > > >
> > > > Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > > ---
> > > >  drivers/cpuidle/dt_idle_states.c | 14 +++++---------
> > > >  1 file changed, 5 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_=
idle_states.c
> > > > index 97feb7d8fb23..558d49838990 100644
> > > > --- a/drivers/cpuidle/dt_idle_states.c
> > > > +++ b/drivers/cpuidle/dt_idle_states.c
> > > > @@ -98,7 +98,6 @@ static bool idle_state_valid(struct device_node *=
state_node, unsigned int idx,
> > > >  {
> > > >         int cpu;
> > > >         struct device_node *cpu_node, *curr_state_node;
> > > > -       bool valid =3D true;
> > > >
> > > >         /*
> > > >          * Compare idle state phandles for index idx on all CPUs in=
 the
> > > > @@ -107,20 +106,17 @@ static bool idle_state_valid(struct device_no=
de *state_node, unsigned int idx,
> > > >          * retrieved from. If a mismatch is found bail out straight
> > > >          * away since we certainly hit a firmware misconfiguration.
> > > >          */
> > > > -       for (cpu =3D cpumask_next(cpumask_first(cpumask), cpumask);
> > > > -            cpu < nr_cpu_ids; cpu =3D cpumask_next(cpu, cpumask)) =
{
> > > > +       cpu =3D cpumask_first(cpumask) + 1;
> > >
> > > Doing
> > >
> > > cpu =3D cpumask_next(cpumask_first(cpumask), cpumask);
> > >
> > > here might save a few iterations for sparse cpumasks.
> >
> > For that it's better to use cpumask_nth(1).
> >
> > I believe there will be no benefit in calling cpumask_next() before
> > entering the loop because for_each_cpu_from() is based on it, and it
> > will be called anyways.
>
> Fair enough.

And so applied as 6.17 material, thanks!

