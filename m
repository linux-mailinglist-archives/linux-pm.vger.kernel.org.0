Return-Path: <linux-pm+bounces-11806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70627944935
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F39B24587
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411917084F;
	Thu,  1 Aug 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcsW/37R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA25446A1;
	Thu,  1 Aug 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507643; cv=none; b=f/e3N3mdjGYFFyzB4y1y+tw71CTxpIO6PIpvqxLhx8MitBzoPc0Nkr0mJ9YHe3onpuUScQMoL/2V4WdBzdfFTsJXhXc8WCkEyvh/M5IRCWdkEo0nMTfpVqTMG1EvTa5QL9wmrJ0qkSzZS72879ednMGb4q64nhneduVYsbjQeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507643; c=relaxed/simple;
	bh=WMzuTdTg2s5TWxIzX24VfRvvb5CCJGOth1YTSiRgkuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex1gMjny0Q/VlbB4JlZsEyG9tj8eEMSWFOm3q++VTOTNB/GEAleNT80XbYU68lWDAsHlIzxMFo3Je7BwHoIJblT3Ak6Xb+sMaCox1wEeqpWZ8Pt09s81+FwyC+sFbo1q0IpLzIFFSjKuo6jzEjXP+44tqiV68ensofVqbwLYI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcsW/37R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816ADC4AF0A;
	Thu,  1 Aug 2024 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722507642;
	bh=WMzuTdTg2s5TWxIzX24VfRvvb5CCJGOth1YTSiRgkuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tcsW/37RcJ/SvLTAzAwuPmS3YoTxEOMexQ68aDK8hXBEg/iY0EBPipRTJ46I1jZ1z
	 OQruGuM0+hRAjgxTeEfmRM06r4aO7sKBtD8zEGOHyqTPuimB9+dnSs2Rc14uZuBf0f
	 GmCXDeFQ5J/WidRCiSjUWxG5KpVRdbpDyrpBbmNVzqyiloZI6KO1naJ0IGP5phSBpY
	 GFhOTvKnjtMSmSAJxAn1jmZW/4StUHAcDXJplcIZXBIei/4+iQcK1v5QZcTBzP8rfv
	 38KtMHglwS6Ja6oHwY1E0vRS0jlSDLO6M9gqpv8uSSBNQpLXGGFDVbCrxSaD7rBjQc
	 k0AAW0XBGhWqg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c5ec50da1so1610357fac.3;
        Thu, 01 Aug 2024 03:20:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2+pwT3TrGpBT06Hg9uTD2tMO/WV51QZApqoqJbkT2pAW4ouUX50PMS+9rykUQ+q1X+QGf1RNXfXs=@vger.kernel.org, AJvYcCXFXRnuWFERqIVZppFOAMC6STRLCE7jfD2mHoqXVsNKsgT5xZ0T2ICJvcvZlfoPecB30T8Sv3aHfiSoM8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEDoNDpj+LoOQdA3ho9VRmvTlQgiHPwJW7JDoPg78IAIyrQFS
	yW93f+A15mSiCnNjVtpxyHstsMlr/HcU/cnfH9tECz7ei65SeBJFjMeAG+8j4SBlmdrsmcIgdrt
	WqlCFibkf+6SEA33QzgiaIa9VkaA=
X-Google-Smtp-Source: AGHT+IGE8Nx5iEbli/gNb8pZzP2JFiEEx912Dnpk0VbM3dJ46Kz068r1CIQRKmoUhFBeojV2vCMkYX7iCCGfjnJqxp4=
X-Received: by 2002:a05:6871:72b:b0:260:df6a:28ca with SMTP id
 586e51a60fabf-2687a72b6b4mr1196511fac.5.1722507641841; Thu, 01 Aug 2024
 03:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726062601.674078-1-kai.heng.feng@canonical.com>
 <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
 <CAAd53p5ftAjtfb-uCcVKR8G0JfoGnA_a0Se1E_vPeietgOENOg@mail.gmail.com>
 <CAJZ5v0i9Qt3OFKCbqkd-q4VKYreV2PZZpQ2Km9az2htANG5zxA@mail.gmail.com>
 <CAAd53p4macNjQN3i8vaf1s-5vj_7esKw37nqoUN1h+XqjQk71w@mail.gmail.com>
 <CAJvTdK=wafegpUB-KD=P9KazWngMNQb_rcbwQX_DDwPBtZ9W7w@mail.gmail.com> <CAAd53p52A7ymkQhFweoy2vRXfkT81pumU6V5Q8tbEBKTnX=ASg@mail.gmail.com>
In-Reply-To: <CAAd53p52A7ymkQhFweoy2vRXfkT81pumU6V5Q8tbEBKTnX=ASg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Aug 2024 12:20:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j6i8xHAigiVA_0rGNrYBecmt6Cj1SBUBt0k=y9NOb3xw@mail.gmail.com>
Message-ID: <CAJZ5v0j6i8xHAigiVA_0rGNrYBecmt6Cj1SBUBt0k=y9NOb3xw@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Zhang, Rui" <rui.zhang@intel.com>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 8:55=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Thu, Aug 1, 2024 at 12:28=E2=80=AFAM Len Brown <lenb@kernel.org> wrote=
:
> >
> > On Wed, Jul 31, 2024 at 2:18=E2=80=AFAM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > The crucial part to make the issue (i.e. slow ethernet) is
> > > ".disable_promotion_to_c1e =3D true".
> >
> > Okay, so the problem statement is that on this machine with some
> > ethernet controller and some workload,
> > performance is better when you use just C1 and not C1E (or deeper) stat=
es.
> >
> > And so you want to have the option of accessing C1 without the overhead=
 of C1E?
>
> Yes, that's the case here.
>
> >
> > Presumably you don't care about the power savings of the deeper states,
> > or you are using PM_QOS to avoid deep c-states at run time?
>
> I tried to use cpu_latency_qos in the network driver's NAPI poll, but
> only saw marginal improvement to around 830Mbps. Hitting the 940Mbps
> is still the goal here.
>
> >
> > > Can we use that for EHL and JSL?
> >
> > Yes.
>
> Is it plausible to disable C1E promotion while using ACPI idle driver?

It is in general.

It would require the driver to recognize the processors in question
without providing C-state tables, but it should be doable.

Next week I'll be offline, I'll look into this when I'm back.

> Or provide a C-state table in intel_idle and update the states via _CST?

That should be possible either.

> >
> > You may also have a BIOS option to achieve the same goal, depending on
> > the platform.)
>
> I am seeing three different platforms from different vendors hitting
> the same issue, so it's better to disable C1e for these platforms.

I see.

Thanks!

