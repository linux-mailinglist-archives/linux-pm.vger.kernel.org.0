Return-Path: <linux-pm+bounces-7292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3CB8B5EEF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 18:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0131F2439C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DB84D35;
	Mon, 29 Apr 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OldT80tI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88384D06
	for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407985; cv=none; b=typw/ea2lxg96W8xQaui+mtBTk2adTnGACvaFGT2iAMG3kBr1+ik5NNsBsDu/jd3a50u69qXbOrcL/x4ErAVrafEracJBhaJrtKLI9GLS4MbKURTORdyI6LaqpV2VaoTFs++I8nHWny6hQFyLAQRDWtzWkQahLe/3qmCIc87I/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407985; c=relaxed/simple;
	bh=ktMyEGwewq1kTXaW7guowY90Cmzku2j4e6Z/N7wvSzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbeM8IQCOPg4Q/qct3EhCCNU65SbNxVnZ0uE/pB8BGWjpy2429lEXQUWfxB0iCf2TCKyQW93yywEUpQJQXkAni65UxqyWRxHm0UkFRpZa9SIIVTE6RdOonvWW2Z+PWN4H/fFYUJCRgpKTrHUD3yyFApMNE0+t9+oTvxg1W62V4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OldT80tI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de610800da0so550276.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1714407982; x=1715012782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrS8Hh3nfWDYBnimGcOfd9CKdp//ogZ+PunEhiC75hs=;
        b=OldT80tIQqlxOyo7ZmBG/JbYe4CHq5uivvQhZr9MbUz6q2lLHB0KwE7TCd77ldjpAM
         304QXAnVweuqD2PSBIYQq0jSAVZ7rLMqMf9DCvtvdWdAEDkLkuHaQQ/kbaNoVywagqmQ
         4BwgndWqI12zFgrZFNXeAejQ8W5u1kp8dYUhaP8sI72PRxc+W9V0ShR9wtFVhCBNPObB
         kEImzZravs+K/aVkrz+t0jcit/SvgQHHNjdUkQiyHAqrgK3eBK3qWcGue7k4MupJzcml
         ETM7otxmMaQuM2krHmGKSvplJ2Fd44fjegAblzr+3QSFXne3qGyobRFC6uEriQCvIPJh
         5/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714407982; x=1715012782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrS8Hh3nfWDYBnimGcOfd9CKdp//ogZ+PunEhiC75hs=;
        b=dD9C5cMQpr6MEgw4QoTXIXSndEfOfaWONaAaX9pzFrhrIfpGTxY5Dq1YsmQRRzY3bW
         KF9FospxEBLiBMM8PvjU9rFH3TjTlXlinnFStBc/bQql+gJ97IhCCWtYlW2qj3gaifka
         pSp42++hFTEYacvD6ucXrsAws16MMXJKkqgOcL37IpyX4eZ+Od9rgYMCvQyfDgSGZaU1
         htUhUgK3TKnLbJazxWm+Hfcb6BWJ6NF7QF6ncdZSwh4F+tHV1XN+L5gaCU2zFeCcy8Go
         6MJOZpr+3WCaGhXI2fctuEDPlffKgebihL23te7wSgei0NwD88u59nLMvYM+g04X/jvx
         kJMw==
X-Forwarded-Encrypted: i=1; AJvYcCV9XsQF1ilZexr2CT0NqXHEGLWhK83hdlZRea/X6No/usVof1X6kHqcJr9AV76ccq6FSm/it8Qq18w3lFcP9HrD16bmvGsatbY=
X-Gm-Message-State: AOJu0Yx7m70h7vzJFN22V1WYmZTesRHPdydTMV8aykGduZ/Q6kFpX4g5
	IUbJevmBDoeqw+PyvWzT4ui3+9M2qqS+mXHqX8VrhL7vZ6mJNtJV6G2mOTLLYQnjwFrCRP9Rlo1
	pDwxXh5fqYunmrXLNQF2r2ib4f/vvxUNRrXG5zg==
X-Google-Smtp-Source: AGHT+IGcQ0a/bJ7Wbo1QYQaakNkvhLKajpQcqDOdTeslfWLHwgPsDPVfEB7hwsFcTNWmdEL5wmgcdsTu0TGmuHEbonM=
X-Received: by 2002:a05:6902:510:b0:de5:c619:3f6b with SMTP id
 x16-20020a056902051000b00de5c6193f6bmr7236404ybs.59.1714407982421; Mon, 29
 Apr 2024 09:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com> <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
 <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com>
In-Reply-To: <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Tue, 30 Apr 2024 00:26:11 +0800
Message-ID: <CAKddAkC6N=Cfo0z+F8herKTuJzCyt_MA0vWNbLCr6CbQnj0y8g@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: palmer@dabbelt.com, anup@brainfault.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote=
:
>
> Hi Ulf
>
> On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> wrote:
> > >
> > > When the cpus in the same cluster are all in the idle state, the kern=
el
> > > might put the cluster into a deeper low power state. Call the
> > > cluster_pm_enter() before entering the low power state and call the
> > > cluster_pm_exit() after the cluster woken up.
> > >
> > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> >
> > I was not cced this patch, but noticed that this patch got queued up
> > recently. Sorry for not noticing earlier.
> >
> > If not too late, can you please drop/revert it? We should really move
> > away from the CPU cluster notifiers. See more information below.
> >
> > > ---
> > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 ++++++++++++++++++++++--
> > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cp=
uidle-riscv-sbi.c
> > > index e8094fc92491..298dc76a00cf 100644
> > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(struct generi=
c_pm_domain *pd)
> > >  {
> > >         struct genpd_power_state *state =3D &pd->states[pd->state_idx=
];
> > >         u32 *pd_state;
> > > +       int ret;
> > >
> > >         if (!state->data)
> > >                 return 0;
> > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(struct gener=
ic_pm_domain *pd)
> > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > >                 return -EBUSY;
> > >
> > > +       ret =3D cpu_cluster_pm_enter();
> > > +       if (ret)
> > > +               return ret;
> >
> > Rather than using the CPU cluster notifiers, consumers of the genpd
> > can register themselves to receive genpd on/off notifiers.
> >
> > In other words, none of this should be needed, right?
> >
> Thanks for the feedback!
> Maybe I miss something, I'm wondering about a case like below:
> If we have a shared L2 cache controller inside the cpu cluster power
> domain and we add this controller to be a consumer of the power
> domain, Shouldn't the genpd invoke the domain idle only after the
> shared L2 cache controller is suspended?
> Is there a way that we can put the L2 cache down while all cpus in the
> same cluster are idle?
> > [...]
Sorry, I made some mistake in my second question.
Update the question here:
Is there a way that we can save the L2 cache states while all cpus in the
same cluster are idle and the cluster could be powered down?
> >
> > Kind regards
> > Uffe

