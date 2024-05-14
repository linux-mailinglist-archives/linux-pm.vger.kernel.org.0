Return-Path: <linux-pm+bounces-7849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E78C5852
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 16:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9A01F236BA
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750A317EB81;
	Tue, 14 May 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="BW+HZHgi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8261E487
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698470; cv=none; b=VADkCYIb51sBeomh9rqboJNZwe38odvYmFCJcwx6Ydute+myJMBGnKIOVrkL3wecimeS03VnxSZv4kHp3WC9gZlHAk+iROxu72L4IH+yB6xJiQmbi2QpN6V7WYRQMBZKOE3XtuJL3ZFrDPJ/uOPrhEel7bpx9mzfkLlbs73uK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698470; c=relaxed/simple;
	bh=iOTjV7jy9yp8FGBKgS/k3XwbuqTG8obRwB+v96Gsw5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2hk4h2VIwqKZ8h/mdVrfWe6kZFJjcb+58j0+tgng3TuozM7fQDOVsTsmoyW39itpdxaDWRpudYBCYvg1xcpZVaNugx6yfa0Pp4hFCu5nb1mnlZBzFd3hOivjHzBFHqPce6HbMalH89fFSGkQJ/TKcWgSoZLMLud8xzENu4QRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=BW+HZHgi; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36c82cf5cdeso20384055ab.0
        for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1715698467; x=1716303267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z82cBCgLMv0ZYRz/HRSf8L92nhc1deFHJBIJjw5gOc=;
        b=BW+HZHgifWyxMgKr80/6GK3SRQ5sdDHABKMK721ad/mPvPVGhhIR9vEAjnzA01I66J
         UCIC2+1VqMzmpLYrS4CmKt2yYm+UnqbN7f7vb+kD64BWiJQfVGN30AbrXIZFcvzpIuDy
         ytXIJwZLS+kV3IkSc3CapfIC74+qRy1UeYWcWtYzlEYH0ONm7bLUdzIkPA3MY7tuiGzC
         7FsIaIj6sFcITJ2D2Rd1nPoyrnoy1s0jH3TS3xyzjRjOWwWcq4GdYiHVdRwaWgrJIkJl
         +/aV2cmy3G8DhSNpR9KRaN/RHNl5mvPmUIIMpNKTEDapH4v/KIMFHAeuF1XQBtRuhwmm
         igig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715698467; x=1716303267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z82cBCgLMv0ZYRz/HRSf8L92nhc1deFHJBIJjw5gOc=;
        b=ofEdkTyz2obD5qN1o9cxzLrGs9VhFIOAJgwZGHdykAVM5/nSO04UaPD/z8wF4qAqFZ
         7wEB339uuvPysf+jltQr/f8Di0sOb9V0wDSUUwiYvAX9WPn1OH/mDIO8br64YJage5UP
         qBvBhEDwK/jDYBFm2pYJMKnT+u3GYsj0FVsuHJ1hutqOXRYiaFBFs1r6FSGIcwioERSD
         t2QD2Gx+uxnnIdjUdlfRVbPXm7iJap2WM5LsYdt/iqJOOOiVztpOJyCvZbU3lr/dusry
         MIosiGmzOLtNsEDv1MaPoDFASUmFuh5YivGqyGIk7ibR/Z/f+y8XPDG2bVrshb+HXq4f
         25aw==
X-Forwarded-Encrypted: i=1; AJvYcCXuJfAuUpvrok4Bmd8laL4ntWx8AWRnB7Co0+ES9Kxu5Viq6pMp2o5NEQ9/GgPgw7WMz0uJ4OCMEIm1w8QOLP0uZhKdwnYNu/s=
X-Gm-Message-State: AOJu0Yzj6CuaBz37+dA8W5ZTDmuSGTdgOLo0cDS4Kv4Ls+PYtDtYASlu
	hfXyni5Jk4KCWZtGHjgtmvtjQqcb3EgpxOzJymJiYzMLstFqmkqLMzYnGCxrLRWjdMS6fDbQgXo
	F3EX01xmuXej7PsKJO7bprp12KPVS/6VxiLRsQA==
X-Google-Smtp-Source: AGHT+IGCHJkMeiCD73H8EU7f+DvHYW9crMlnudeHRZ1GpJ+PgJcHJr4CDLf335JWUQeU2X9JLK6YCyrTqcy9lzrchQ8=
X-Received: by 2002:a05:6e02:1385:b0:369:976a:584a with SMTP id
 e9e14a558f8ab-36cc12aaaeemr122086975ab.6.1715698467288; Tue, 14 May 2024
 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com> <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
 <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com>
 <CAKddAkC6N=Cfo0z+F8herKTuJzCyt_MA0vWNbLCr6CbQnj0y8g@mail.gmail.com>
 <CAPDyKFr_M0NDH0gaunBpybnALOFfz4LpX4_JW2GCUxjwGzdZsg@mail.gmail.com>
 <CAKddAkC5CRX+ZTh=MgzPYU72SY13+AQYhknhV_CC+=XX9=DKyg@mail.gmail.com> <CAAhSdy1SDd=VUqDQA0T5n9LwHo=3uGzFq1dUcbDFcB3aBdaioA@mail.gmail.com>
In-Reply-To: <CAAhSdy1SDd=VUqDQA0T5n9LwHo=3uGzFq1dUcbDFcB3aBdaioA@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 14 May 2024 20:24:15 +0530
Message-ID: <CAAhSdy33DcNw+pbDRrR=hBH86kwvu3xZbomQby8XhRXcc-exqQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Nick Hu <nick.hu@sifive.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, palmer@dabbelt.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 7:53=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> Hi Nick,
>
> On Tue, May 14, 2024 at 3:20=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > Hi Ulf,
> >
> > Thank you for your valuable suggestion.
> > I sincerely apologize for the delay in responding to your message. We
> > have diligently worked on experimenting with the suggestion you
> > provided.
> >
> > As per your recommendation, we have incorporated the "power-domains=3D<=
>
> > property" into the consumer's node, resulting in modifications to the
> > DTS as illustrated below:
> >
> > cpus {
> >     ...
> >      domain-idle-states {
> >            CLUSTER_SLEEP:cluster-sleep {
> >                         compatible =3D "domain-idle-state";
> >                         ...
> >             }
> >      }
> >      power-domains {
> >             ...
> >             ...
> >             CLUSTER_PD: clusterpd {
> >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> >             };
> >      }
> > }
> > soc {
> >       deviceA@xxx{
> >              ...
> >              power-domains =3D <&CLUSTER_PD>;
> >              ...
> >       }
> > }
> >
> > However, this adjustment has led to an issue where the probe for
> > 'deviceA' is deferred by 'device_links_check_suppliers()' within
> > 'really_probe()'. In an attempt to mitigate this issue, we
> > experimented with a workaround by adding the attribute
> > "status=3D"disabled"" to the 'CLUSTER_PD' node. This action aimed to
> > prevent the creation of a device link between 'deviceA' and
> > 'CLUSTER_PD'. Nevertheless, we remain uncertain about the
> > appropriateness of this solution.
> >
> > Do you have suggestions on how to effectively address this issue?
>
> I totally missed this email since I was not CC'ed sorry about that. Pleas=
e
> use get_maintainers.pl when sending patches.

I stand corrected. This patch had landed in the "spam" folder. I don't know=
 why.

Regards,
Anup

>
> The genpd_add_provider() (called by of_genpd_add_provider_simple())
> does mark the power-domain DT node as initialized (fwnode_dev_initialized=
())
> so after the cpuidle-riscv-sbi driver is probed the 'deviceA' dependency =
is
> resolved and 'deviceA' should be probed unless there are other unmet
> dependencies.
>
> Try adding "#define DEBUG" before all includes in drivers/core/base.c
> and add "loglevel=3D8" in kernel parameters, this will print producer-con=
sumer
> linkage of all devices.
>
> Marking the power-domain DT node as "disabled" is certainly not the
> right way.
>
> Regards,
> Anup
>
> >
> > Regards,
> > Nick
> >
> > On Tue, Apr 30, 2024 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> wrote:
> > > >
> > > > On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@sifive.co=
m> wrote:
> > > > >
> > > > > Hi Ulf
> > > > >
> > > > > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.hansson=
@linaro.org> wrote:
> > > > > >
> > > > > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> wrot=
e:
> > > > > > >
> > > > > > > When the cpus in the same cluster are all in the idle state, =
the kernel
> > > > > > > might put the cluster into a deeper low power state. Call the
> > > > > > > cluster_pm_enter() before entering the low power state and ca=
ll the
> > > > > > > cluster_pm_exit() after the cluster woken up.
> > > > > > >
> > > > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > >
> > > > > > I was not cced this patch, but noticed that this patch got queu=
ed up
> > > > > > recently. Sorry for not noticing earlier.
> > > > > >
> > > > > > If not too late, can you please drop/revert it? We should reall=
y move
> > > > > > away from the CPU cluster notifiers. See more information below=
.
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++++++++++=
+++--
> > > > > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cp=
uidle/cpuidle-riscv-sbi.c
> > > > > > > index e8094fc92491..298dc76a00cf 100644
> > > > > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(struc=
t generic_pm_domain *pd)
> > > > > > >  {
> > > > > > >         struct genpd_power_state *state =3D &pd->states[pd->s=
tate_idx];
> > > > > > >         u32 *pd_state;
> > > > > > > +       int ret;
> > > > > > >
> > > > > > >         if (!state->data)
> > > > > > >                 return 0;
> > > > > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(stru=
ct generic_pm_domain *pd)
> > > > > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > > > > >                 return -EBUSY;
> > > > > > >
> > > > > > > +       ret =3D cpu_cluster_pm_enter();
> > > > > > > +       if (ret)
> > > > > > > +               return ret;
> > > > > >
> > > > > > Rather than using the CPU cluster notifiers, consumers of the g=
enpd
> > > > > > can register themselves to receive genpd on/off notifiers.
> > > > > >
> > > > > > In other words, none of this should be needed, right?
> > > > > >
> > > > > Thanks for the feedback!
> > > > > Maybe I miss something, I'm wondering about a case like below:
> > > > > If we have a shared L2 cache controller inside the cpu cluster po=
wer
> > > > > domain and we add this controller to be a consumer of the power
> > > > > domain, Shouldn't the genpd invoke the domain idle only after the
> > > > > shared L2 cache controller is suspended?
> > > > > Is there a way that we can put the L2 cache down while all cpus i=
n the
> > > > > same cluster are idle?
> > > > > > [...]
> > > > Sorry, I made some mistake in my second question.
> > > > Update the question here:
> > > > Is there a way that we can save the L2 cache states while all cpus =
in the
> > > > same cluster are idle and the cluster could be powered down?
> > >
> > > If the L2 cache is a consumer of the cluster, the consumer driver for
> > > the L2 cache should register for genpd on/off notifiers.
> > >
> > > The device representing the L2 cache needs to be enabled for runtime
> > > PM, to be taken into account correctly by the cluster genpd. In this
> > > case, the device should most likely remain runtime suspended, but
> > > instead rely on the genpd on/off notifiers to understand when
> > > save/restore of the cache states should be done.
> > >
> > > Kind regards
> > > Uffe

