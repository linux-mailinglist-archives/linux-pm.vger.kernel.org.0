Return-Path: <linux-pm+bounces-30301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83865AFB862
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 18:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD89163FB3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D32264B2;
	Mon,  7 Jul 2025 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orDysagG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562C18D65C;
	Mon,  7 Jul 2025 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904730; cv=none; b=XlmlvYSuN/it43igniM/6q7JEyz04jpTrLig7YhR89w2YukhYLrj8xDddXHrIH7yAfpBbK9wK2dOpmL4QjMi1dXK03fqajb6q7oAW4gEAWU0z5h57B8hfYSdpf7kDdOZ5uEw4/TTD2WMVWEyxaySNf3FL672FFhB5LCdD2oi3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904730; c=relaxed/simple;
	bh=wov1r5ZCmJejiVbu/tzWRiyxLJFB7QQF2Lk1aCyMpT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WW36/AOKbx8Siy2gK3+wfzvXY6sZhGvmLirSYMkGv7IXZ8fABKR03INkdeFtI23r7AZTmB/RNehQMqxkOPXBmEzgLg8XSRu2phYLXqM4GtHTDDXg92WOyn/3yKIld6SNk/HJpl69oFKzpaG6QVdB9vpU8OEnoD/AicsvzX4xDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orDysagG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110A9C4CEF5;
	Mon,  7 Jul 2025 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751904730;
	bh=wov1r5ZCmJejiVbu/tzWRiyxLJFB7QQF2Lk1aCyMpT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=orDysagGMFqXXwG9d5Zlns8JlQ3Zp0+1O7m9Ox32+ofShNAVtU2KnL14C1bjaXLhM
	 fdJI8gbAucNYJMNBROFCLVVqcAzESyRsXKekeTWMTNJ/NWElh4ZpLljfUNunv9sCgi
	 7nkogKeCpS+q9eRRCZQXrUJhu1jx637zV3q/B2Wn6xp6PUhYUxH0WvBMxDU8mlW9dp
	 UYQeqyxH4fe796fywS+NKJmKH5Zo6mn2Z12zuuTOYb7PyuqXXy9mr0FMJ3B1y2Bcr6
	 KTFTXIoKh3/ftYd2SE8L7eddp/OBC6SHV1a5wZiIg0ix2LqQ5mRU389ZUkx9ofe0at
	 j7VEKXGjwxNKA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-610d86b3da9so813434eaf.0;
        Mon, 07 Jul 2025 09:12:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxFIHLkXSz3lFHq2bkxwcj7g54Mx8jT1KzzBXMR3teURcxo9wcPwRGv6HYrL+pFzFTFX2NnT2xmxs=@vger.kernel.org, AJvYcCVsGh0eMKJRazPM1uFJF+ZTYjl4nr24SLmH6hLKLhoihv9MI9SeASUrm3jyNBS059UdQ3KdXLL4hVLgifE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsypwYWYoRxunRAzA/HI4brBKvg/kVmeeXL6OSz7uki/cJ4b8O
	6N4IGk1snd3baiqdWVSNVE5Dc3u1BNXnTwfAoGNVSbEZD1qiBjR0ljMb1tSHWy+OwxBT4B7q9ba
	MrLDLQ2u9UCqbdzDWLeg1Bapu++6ItQI=
X-Google-Smtp-Source: AGHT+IElb02x8Xl685G1DpPwBcV+PQuNswcyZVnQR4hfX006qbbFVGw+gnfGxhcsjTmFxbw84Mbhmjk6sHb5u+Tk2VU=
X-Received: by 2002:a05:6820:4b89:b0:611:ae2b:4d33 with SMTP id
 006d021491bc7-613c02656b0mr61500eaf.6.1751904729312; Mon, 07 Jul 2025
 09:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604213908.27819-1-yury.norov@gmail.com> <CAJZ5v0h7CeO+vG4BVcdc=XxcWMRY+OmhrWxtrAS59T-uK1KDOw@mail.gmail.com>
 <aGvoMhLuX0-zIFVk@yury>
In-Reply-To: <aGvoMhLuX0-zIFVk@yury>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 18:11:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gUdm_e6wfLP1aS+L7fe-JNOAWVNvNHLSYqtSydzm5bQg@mail.gmail.com>
X-Gm-Features: Ac12FXxggHAojbFGLIyP5sFl1jk0N63Tg_1Aa4rB-ERdBH7d1jgvNV8-FbqMyWs
Message-ID: <CAJZ5v0gUdm_e6wfLP1aS+L7fe-JNOAWVNvNHLSYqtSydzm5bQg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: dt: fix opencoded for_each_cpu() in idle_state_valid()
To: Yury Norov <yury.norov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 5:31=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> On Wed, Jul 02, 2025 at 08:27:21PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 4, 2025 at 11:39=E2=80=AFPM Yury Norov <yury.norov@gmail.co=
m> wrote:
> > >
> > > From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > >
> > > The function opencodes the for_each_cpu_from() by using an open for-l=
oop.
> > > Fix that in sake of readability.
> > >
> > > While there, drop the 'valid' variable as it's pretty useless here.
> > >
> > > Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > ---
> > >  drivers/cpuidle/dt_idle_states.c | 14 +++++---------
> > >  1 file changed, 5 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_id=
le_states.c
> > > index 97feb7d8fb23..558d49838990 100644
> > > --- a/drivers/cpuidle/dt_idle_states.c
> > > +++ b/drivers/cpuidle/dt_idle_states.c
> > > @@ -98,7 +98,6 @@ static bool idle_state_valid(struct device_node *st=
ate_node, unsigned int idx,
> > >  {
> > >         int cpu;
> > >         struct device_node *cpu_node, *curr_state_node;
> > > -       bool valid =3D true;
> > >
> > >         /*
> > >          * Compare idle state phandles for index idx on all CPUs in t=
he
> > > @@ -107,20 +106,17 @@ static bool idle_state_valid(struct device_node=
 *state_node, unsigned int idx,
> > >          * retrieved from. If a mismatch is found bail out straight
> > >          * away since we certainly hit a firmware misconfiguration.
> > >          */
> > > -       for (cpu =3D cpumask_next(cpumask_first(cpumask), cpumask);
> > > -            cpu < nr_cpu_ids; cpu =3D cpumask_next(cpu, cpumask)) {
> > > +       cpu =3D cpumask_first(cpumask) + 1;
> >
> > Doing
> >
> > cpu =3D cpumask_next(cpumask_first(cpumask), cpumask);
> >
> > here might save a few iterations for sparse cpumasks.
>
> For that it's better to use cpumask_nth(1).
>
> I believe there will be no benefit in calling cpumask_next() before
> entering the loop because for_each_cpu_from() is based on it, and it
> will be called anyways.

Fair enough.

