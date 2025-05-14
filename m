Return-Path: <linux-pm+bounces-27143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115C9AB714A
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E0C1B68536
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66727A139;
	Wed, 14 May 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPjDmFdg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06EC17A31F;
	Wed, 14 May 2025 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239982; cv=none; b=mw1xvBpep6/fJW1HaKmrsnoojzakCEDikd2R+PRcNsP/MbpWW48pIN3+QJXLoWbtPSco1Cxke7DNRdrQDvO3XqsWOe1H/ScKzagYQ1vJzWcKNbPYryEzszpd3hOOrBhNIjTS/IYU1pv/jSsP54z8IwgDQCIRnThLaB37FfJldTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239982; c=relaxed/simple;
	bh=GIESU+iUZJaPMI+zA9vfT9gZW6/Sx15SV7jAG8TtOP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWQyxSbu8A1u3ta0bKAUFChHWnuLSLxeziCTLutsV4aNkawIIk6H8WLjo0nXy4CPHP5NZRSlXknmPCekCzbBLF5ieq2jYCi8dTI/8jEJkTz0XYfOZ6LSHgb5LAZSRSKfbGIZSia8lZIA0rUn5O5A0u6Yg/63Nlr4Qejuup4VcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPjDmFdg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-326d823304fso37166071fa.0;
        Wed, 14 May 2025 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747239979; x=1747844779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMNBvOAelRf/aEmSOjmnBt5f4s2CUzlEA7lgWB9KPa4=;
        b=DPjDmFdgVbiY1uD1LFx8Eq0a5p6PM7RpUqMZUHqER5Io3FYJC2Ff+zEnPVH9R1BzEz
         CTtFbfsK2cMAjwL0yTMda09d7hqFqEJBev9msTC+byRDqhrRJXViuaztEg3lYg8gqodg
         uFkOqgsZF0wdzp+Y8Z5LOJUwrpJeZzD+iAieuqTISCMH/zsQ+W1o0bWDmz4wXk3JCbw5
         U0ODjnc641O4/Rq5sEyilEBBa5G6hkRtegozY1A8my9mQTIq2FuAfQ7zxuwJfxFmYpkz
         Ae9mQ3i4IumyHsRENabOh7ZRo66PEuxUCADgLdHAlwvp3gYqOGWaiuECvR5/6a1jV8If
         qe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747239979; x=1747844779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMNBvOAelRf/aEmSOjmnBt5f4s2CUzlEA7lgWB9KPa4=;
        b=IzS6j0HIdr/K8B49uIMmFXQs/PIhmE2eTw/HXFBIVpiMMPpz7Z88oXI4Z/BjhBZOKi
         rK9XsloreLXBEJimfouH2fAN8fKfEYp9QefxEaCBmbef8VDx1OrDQjztbfVuOcuriaD6
         aOCKk2QJaqhrAzofV7BGIhWsxtzXDb5vGOosbweC/R4J+d9KNOOOUcKaFBJv3SOgG5zw
         7WZnCUxNFbob/noSI7/PPKwsI1h3bnCC0K3O1BtxK6KSKeWAeDg1D14Q0bvDEnuCM4rO
         aphfmuvoMWvwfzUHkOYYtO4778djaXZYPSSLWZvwOiScNCDfqPMbiTTm1e6sOo1FUhOI
         GaJA==
X-Forwarded-Encrypted: i=1; AJvYcCUV8Ht7YbiNE6qbP1MccXyl1dQghMuLXQ1mPMkGfgvQkDiYycLdXHoaMUApMOlpr7YBsg5pu+998CMt+Lg=@vger.kernel.org, AJvYcCWCTwvMO8enLrEW3N6ozQdPZkE+SEyw13og577mDaU34IsTdULA5tYtBbnMEnrY1pGXf3mzWP2VQ6dtbrQ=@vger.kernel.org, AJvYcCWNN/QXjE1RJxsdwuybwHpEnBs97Ye7hS5+ibX1V0mkEnjYNZwP98775mILNtHXI2SnkG6vip1MF84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGrbgbu0iwoMh2mAXfhvHvkX/6Vn3tGkKSnvMZ4v96DHX4h+r
	BK6svyvCDdP+9GCHEywVBSCjEimpfIIflRyacSiLdszER/EDK/FdutSwzS1RjzE1PL+LraushgK
	d2gwSidLnOyXZL+K3l8R/+5NZWFo=
X-Gm-Gg: ASbGnctkEMseMXJayK8fLt+mCcqdS0sEebUvTv4Q79AeGSgTPMGuPOf97Iam32wAu7/
	IKHqP2gPLqDIhwV08kWZsQLjgEhLxp9fQxA5jG0UveohMxCt63Ycnln01iT8ze92hsoFOaf0Rou
	Hm1BQ3xS/FYJ6yml0C7h/pU6i5HBa115bvMw==
X-Google-Smtp-Source: AGHT+IEuGSm3mBr75lUKxAMiFBWmCn7dZDNntjwFzklEiUcmiYMNyrKwOHaq+huwYB9vJJqB47JrALQJlga5dT+Q07E=
X-Received: by 2002:a2e:bc08:0:b0:30b:e3d9:37e5 with SMTP id
 38308e7fff4ca-327ed0d72ccmr15714531fa.13.1747239978632; Wed, 14 May 2025
 09:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com> <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
 <CALHNRZ_AH-OkDak_RDoA3FB6EVO78r5G=5zosiJEXk4UGLH=fQ@mail.gmail.com>
In-Reply-To: <CALHNRZ_AH-OkDak_RDoA3FB6EVO78r5G=5zosiJEXk4UGLH=fQ@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 14 May 2025 11:26:06 -0500
X-Gm-Features: AX0GCFuHlyC0-Iz38p3CLXOkhiqmbRzxA0tQ5KfR89ZAPRMKo0iCPoXGbUHFpN8
Message-ID: <CALHNRZ8Ri4sv7JkFj6t8b3VT=LU9ZS0Wc_8US2b3xGimLY6P6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 11:57=E2=80=AFAM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
>
> On Fri, May 9, 2025 at 6:04=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> =
wrote:
> >
> >
> >
> > On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > Instead, unregister the cpufreq device for this fatal fail case.
> >
> > This is not a complete sentence. Seems to be a continuation of the
> > subject which is not clear to the reader (at least not to me). No
> > mention of why or what this is fixing, if anything?
>
> I can clean up the subject and message in a new revision. More on the
> reasoning below.
>
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >   drivers/cpufreq/tegra124-cpufreq.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/teg=
ra124-cpufreq.c
> > > index 514146d98bca2d8aa59980a14dff3487cd8045f6..bc0691e8971f9454def37=
f489e4a3e244100b9f4 100644
> > > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > > @@ -168,7 +168,10 @@ static int __maybe_unused tegra124_cpufreq_resum=
e(struct device *dev)
> > >   disable_dfll:
> > >       clk_disable_unprepare(priv->dfll_clk);
> > >   disable_cpufreq:
> > > -     disable_cpufreq();
> > > +     if (!IS_ERR(priv->cpufreq_dt_pdev)) {
> > > +             platform_device_unregister(priv->cpufreq_dt_pdev);
> > > +             priv->cpufreq_dt_pdev =3D ERR_PTR(-ENODEV);
> > > +     }
> >
> > So you are proposing to unregister the device in resume? That seems odd=
.
> > I see there is no remove for this driver, but I really don't see the
> > value in this.
>
> This was suggested by Viresh in v1 [0] to replace the call to
> disable_cpufreq, which is not currently an exported function. I'm open
> to other suggestions.
>
> Sincerely,
> Aaron
>
> [0] https://lore.kernel.org/all/20250421054452.fdlrrhtsimyucbup@vireshk-i=
7/

Viresh, could you comment here please? As you were the one that
suggested replacing disable_cpufreq with an unregister instead of
exporting said function. I can make the code changes and verify they
work as intended, but I'm not familiar enough with this subsystem to
know what a good option here is. Are there any other cpufreq drivers
that have to handle a resume failure like this?

Sincerely,
Aaron

