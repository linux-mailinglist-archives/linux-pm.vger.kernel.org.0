Return-Path: <linux-pm+bounces-7327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D78B6C8A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 10:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B181628300C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0915467C;
	Tue, 30 Apr 2024 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXXUF1rc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125D247F42
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464804; cv=none; b=fWbI1Xb8Koaiorao+AtFKY84WPX1hz3WAjew1yVX/8AV0WW3WXZjA/g9qpmmHBATQJxU78VggDTj36I559b6Eq8vZCSXxcCH7FTR+0GGwY8ZZunLgwh4iuHfuLEND20Z16xXO60QSTK6zOXyzw+fSP5CR82mMrhFBB2mjtg1C9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464804; c=relaxed/simple;
	bh=dNOE4T7/QwX8k1T/RC7x+ATlL1W5baul8IPqcUhm8Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beokx/0/uZw/kvL5yekbbJsTJPNOsZFTp20a77eu0FqyOZjxHX87Un0WMb/jFAu7drVfzjfE5CDl+AwEhY/vZl83edr1OWCmtuJmj2wdJd7yNEoRwcSrvq8AMekPYrYMRoweOL/crf1rDI5XoqY6Jml5Qsu2BCZR+gJBpC+kwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IXXUF1rc; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de5e74939fdso1791629276.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 01:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714464801; x=1715069601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TtRmxvOsaI0j8vIb/52uFQJ4Na+dlsFyaOa4Vf0Bw8=;
        b=IXXUF1rckejiWA5Hg5AaStGobwm8R4lQB9M/udFJIUBAuB/dRLx602TamNgb4fEZCc
         +XjERaZ5alsusC9y1D0t0JO5kAdCBdq+AespNnFu0pmWQEs6luckcpJRL8/yyk4PK97g
         /qBZWGAHjt9IEZJ2f4/igW2MicII8cmI+nihw7j3svOfrFCUvyWKcOH8Ck5kozDKsNpf
         TOzof9UYW/EFtOngIo5xolfGGRQ4l05rYFwZJdrbxoRMTZjshmsdXx9ZpmLC5nRy+KEB
         y15lczcjKgG2t5B+6wXc/8xMhp23hdb1cTS5BuZIJYmqSX63+gROGtfHn9f6jMHnRTPu
         q2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714464801; x=1715069601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TtRmxvOsaI0j8vIb/52uFQJ4Na+dlsFyaOa4Vf0Bw8=;
        b=jZtNmsKDAriVSTFp/3aSXCR/xEfJ2ZaSmk6PXG5OUPYJKDe2K44fwXmfsbyUKPkKX1
         7gZd7AscfwhRsP30ItxXV+PWlqpBS7znil3cJc4ewD0N+/BnDy2SFe+p1zOkd4sD4j7m
         dMHc4HVysrWi8p0/2lqXxZf1d2r3KsKNtyaKfVe+YpCzkIhWnlrfbOSKLZ7Hh6YMdKMM
         MTEErZ7fExjK2uDV24qcOal3/4GXa3mw8KNpD2yuKsbT/m/Pf3HhRocLr5Oom38ErlGj
         G27hhJ+hKka3du/ttDvEuYzgKZ8OZis4xvFMeZiSMdx2vz6bUQ0FHxswgqoZlLPy4I5Y
         3AMw==
X-Forwarded-Encrypted: i=1; AJvYcCWr64TcXZNP7f2D4jIlXADKNLCA0SZw1weR7fhAdeaM5MF/6tlGsv/cp4O+ji/ImEyzhVC9sLWE7jMenvBiMxDmr6CTaAEQLJE=
X-Gm-Message-State: AOJu0YxhfkzXJRcONyxaAtE6PLWGkqYGxM4hv6uBzsPpt114WSPbG/hV
	cxdZM76PtT2VGgYPqnA6oyFVXHjOi8PV+fA3RrCwAwIsZ6lAajh6wP416F7ANhhlOfnvx8nAEPv
	ezlEZUfFNu0YYBqeZIoQMqkKFrIfJv+ldgHY/hg==
X-Google-Smtp-Source: AGHT+IFjQ4jcj+SFmGdgdYQVyeYWI84FI6MAtglUVUVYv0AmAjAKKjhMzdBf/Fl4uG4yVHAB5V7kQLamY+zMgVqWZJI=
X-Received: by 2002:a05:6902:1b12:b0:dcc:2f09:4742 with SMTP id
 eh18-20020a0569021b1200b00dcc2f094742mr2145150ybb.51.1714464800928; Tue, 30
 Apr 2024 01:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com> <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
 <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com> <CAKddAkC6N=Cfo0z+F8herKTuJzCyt_MA0vWNbLCr6CbQnj0y8g@mail.gmail.com>
In-Reply-To: <CAKddAkC6N=Cfo0z+F8herKTuJzCyt_MA0vWNbLCr6CbQnj0y8g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Apr 2024 10:12:43 +0200
Message-ID: <CAPDyKFr_M0NDH0gaunBpybnALOFfz4LpX4_JW2GCUxjwGzdZsg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Nick Hu <nick.hu@sifive.com>
Cc: palmer@dabbelt.com, anup@brainfault.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> wrote:
>
> On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wro=
te:
> >
> > Hi Ulf
> >
> > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> > >
> > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> wrote:
> > > >
> > > > When the cpus in the same cluster are all in the idle state, the ke=
rnel
> > > > might put the cluster into a deeper low power state. Call the
> > > > cluster_pm_enter() before entering the low power state and call the
> > > > cluster_pm_exit() after the cluster woken up.
> > > >
> > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > >
> > > I was not cced this patch, but noticed that this patch got queued up
> > > recently. Sorry for not noticing earlier.
> > >
> > > If not too late, can you please drop/revert it? We should really move
> > > away from the CPU cluster notifiers. See more information below.
> > >
> > > > ---
> > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 ++++++++++++++++++++++--
> > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/=
cpuidle-riscv-sbi.c
> > > > index e8094fc92491..298dc76a00cf 100644
> > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(struct gene=
ric_pm_domain *pd)
> > > >  {
> > > >         struct genpd_power_state *state =3D &pd->states[pd->state_i=
dx];
> > > >         u32 *pd_state;
> > > > +       int ret;
> > > >
> > > >         if (!state->data)
> > > >                 return 0;
> > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(struct gen=
eric_pm_domain *pd)
> > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > >                 return -EBUSY;
> > > >
> > > > +       ret =3D cpu_cluster_pm_enter();
> > > > +       if (ret)
> > > > +               return ret;
> > >
> > > Rather than using the CPU cluster notifiers, consumers of the genpd
> > > can register themselves to receive genpd on/off notifiers.
> > >
> > > In other words, none of this should be needed, right?
> > >
> > Thanks for the feedback!
> > Maybe I miss something, I'm wondering about a case like below:
> > If we have a shared L2 cache controller inside the cpu cluster power
> > domain and we add this controller to be a consumer of the power
> > domain, Shouldn't the genpd invoke the domain idle only after the
> > shared L2 cache controller is suspended?
> > Is there a way that we can put the L2 cache down while all cpus in the
> > same cluster are idle?
> > > [...]
> Sorry, I made some mistake in my second question.
> Update the question here:
> Is there a way that we can save the L2 cache states while all cpus in the
> same cluster are idle and the cluster could be powered down?

If the L2 cache is a consumer of the cluster, the consumer driver for
the L2 cache should register for genpd on/off notifiers.

The device representing the L2 cache needs to be enabled for runtime
PM, to be taken into account correctly by the cluster genpd. In this
case, the device should most likely remain runtime suspended, but
instead rely on the genpd on/off notifiers to understand when
save/restore of the cache states should be done.

Kind regards
Uffe

