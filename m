Return-Path: <linux-pm+bounces-34977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9727FB85DDB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 18:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775B22A52BD
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A634316197;
	Thu, 18 Sep 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XE2F37dI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A630F529
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210965; cv=none; b=ckZSq6quoQP6tsZ4+2hZabGa1mlsNtSHK3bRpqNWsrZiqP5sSU+d7vZQSD/9v5N7klp9GuYTAZsFGsXVl7e5J2Iz5TDADeAIXY6/SesLHCIFTIgSVuj8Upqf/5A0CrPCAwOMC1ihrV6m5/r6lJa4bj9bzv8CSUeFRO6F8IO0MfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210965; c=relaxed/simple;
	bh=UeZq0pHTduP+iZFoeFnOKXM6Oxja1vWxpxZAhP3BxT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAmQA5zQEv/+LQEwVDCDhpkeH2PQxFq+wzSTl+6OXrt/py6D8gVuldqG3IJnP+zzfJrrw+vfTacOotLQUoueeXnfibweQtZ1Jo/npU3Tuz8iBdgRH/OWxE51ho4hBJQ1GRRkJ6pjRI+CEnCbkgo2iFTlceZ1LGnbHnrkuVTS33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XE2F37dI; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6294ff16bacso506255d50.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758210960; x=1758815760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdfK/q+Pwfof78/WFiIzEJbNGwk57mdR4QjuAR4qnWM=;
        b=XE2F37dIX2AnItBOkWF2X8l4MTBSpb916/0bPK1aVh0+24FL22SKy+YpsDrjiiZ+g1
         pmyhULYGE2jtjowr67HFz6ZeAaS4Bw+3sMQlaCZiuoG0QalJtctIuuPgg8oclytYzCpC
         n5e+mEjMvEEEpITHeQP926DV9raNPSm/5sx3RFwWYI0Qtgj8LvRqYo4tsIKs22t1zq9G
         GGp+ruIu6HVKWAphx5qkrVGi+xdrGbHjkjrfAO8FYi2RMUs6HGTvDFKZlLg40g4QokFy
         tmiGcSRpjzQ0pKYpRkJy4h2yFB9HUpJIipwECTuZ+2EcmLQuUwmddkoSy55twkJo5ZMS
         ZXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210960; x=1758815760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdfK/q+Pwfof78/WFiIzEJbNGwk57mdR4QjuAR4qnWM=;
        b=Rz8Gdkvwk7lhvBw+t7VN13LMk/kn8eAkoML44z5ahSjS0JfXn2jO0Ak/v6t1WTQ4gy
         Um+EZl18SgPSGpZ843f+ztHHALtWYDRsWvMRkoLShtR6Iw5H4lzS1l5T1pCiRck5GFm8
         R26xdEzw1sQLZOWjHUW+A0GXPCiJ6tdEO/43xDnfRPUfyRU0bRHg6qmAr0+2PGg/UM4h
         1Yuo26fGWR/R9c8GuNriawBIgefULzZwSFDYMAbQCiSW5S3bwpM3PXNClBoTIBoEYru1
         U/f4KOy5x1q6Jp70htJdkEggXoBkAu7c6R5ERaCVrYdAu7gzzUn7nILkUp0GY5wNoF1Q
         s/mg==
X-Forwarded-Encrypted: i=1; AJvYcCWlfI2NWD1hUuwHd43NOzEJdOjkTwgvCJJKIixHOVgBmzzwUorBCbjWJSDKxyVMalEG/B7IacFytg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZMjaUjfwLRzoLIUR9QpjB9bSNGPFrlAvdXPJcg56AtRyoJUj
	I1ARuyHKYdfdbpJ0Isu2vWzrrcVUSZUljI1LFzkCcI/7wawM1Hu2tSzY0mLSW1kwN+1Dl8Yb+Y5
	LghtafPnFNWzQpwJK0EHgmXt3LRFi2QJQOqwnF8kPVQ==
X-Gm-Gg: ASbGncv1a/r8F+5CJ2DHrzyPbcX2SlNDa0m7Y3hJOosclrt3W2puOddwxrlLITrac2B
	t6od5Cy/C5CebrUEGL6nUBorBgaux2rOxQvu3ZZBuWnzvCq0XD5BYX/ntgbDaFZPWdeGVCoJu1g
	VCqY4EEZ2Jy4Eoq1lSXlnpCpbyVFN/1UwoD6orgcQiQfHypudqFFgNRXItaP+aSOMcgZEaJBiLC
	+pYOZvzChJ9d2/t4GUm/+WwAlE=
X-Google-Smtp-Source: AGHT+IEECGH2G8e/CDH9F0qac/7FZa5yDye+HQmQVSLPgRHzbQeecfKUO0vMmnt8GIhKDbVRf8GMagQg2WceGWP5ZzQ=
X-Received: by 2002:a05:690e:1559:20b0:628:9b45:5e29 with SMTP id
 956f58d0204a3-6347f544d01mr24918d50.15.1758210958918; Thu, 18 Sep 2025
 08:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818074906.2907277-1-uwu@icenowy.me> <20250818074906.2907277-3-uwu@icenowy.me>
 <CAPDyKFombYNFvTsChewQ6cFY2woS+vSb1YUV0Bp_+DcigrFFXA@mail.gmail.com> <89ed15328b73b191fe152cf8559b92239b5596bd.camel@icenowy.me>
In-Reply-To: <89ed15328b73b191fe152cf8559b92239b5596bd.camel@icenowy.me>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Sep 2025 17:55:23 +0200
X-Gm-Features: AS18NWAOrRn2SPBMcr_jo91dsxsIlLlmmb44l-SPKPjXdyTcSw8dHOMtiv-1B0s
Message-ID: <CAPDyKFoQuLKwf69YK7ynj-HeWXsMzguYBtbOy8HE5X_jb1dUpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: thead: create auxiliary device for rebooting
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sept 2025 at 17:44, Icenowy Zheng <uwu@icenowy.me> wrote:
>
> =E5=9C=A8 2025-09-04=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 12:14 +0200=EF=
=BC=8CUlf Hansson=E5=86=99=E9=81=93=EF=BC=9A
> > On Mon, 18 Aug 2025 at 09:49, Icenowy Zheng <uwu@icenowy.me> wrote:
> > >
> > > The reboot / power off operations require communication with the
> > > AON
> > > firmware too.
> > >
> > > As the driver is already present, create an auxiliary device with
> > > name
> > > "reboot" to match that driver, and pass the AON channel by using
> > > platform_data.
> > >
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> > >  drivers/pmdomain/thead/th1520-pm-domains.c | 35
> > > ++++++++++++++++++++--
> > >  1 file changed, 33 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c
> > > b/drivers/pmdomain/thead/th1520-pm-domains.c
> > > index 9040b698e7f7f..8285f552897b0 100644
> > > --- a/drivers/pmdomain/thead/th1520-pm-domains.c
> > > +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> > > @@ -129,12 +129,39 @@ static void th1520_pd_init_all_off(struct
> > > generic_pm_domain **domains,
> > >         }
> > >  }
> > >
> > > -static void th1520_pd_pwrseq_unregister_adev(void *adev)
> > > +static void th1520_pd_unregister_adev(void *adev)
> > >  {
> > >         auxiliary_device_delete(adev);
> > >         auxiliary_device_uninit(adev);
> > >  }
> > >
> > > +static int th1520_pd_reboot_init(struct device *dev, struct
> > > th1520_aon_chan *aon_chan)
> > > +{
> > > +       struct auxiliary_device *adev;
> > > +       int ret;
> > > +
> > > +       adev =3D devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
> > > +       if (!adev)
> > > +               return -ENOMEM;
> > > +
> > > +       adev->name =3D "reboot";
> > > +       adev->dev.parent =3D dev;
> > > +       adev->dev.platform_data =3D aon_chan;
> > > +
> > > +       ret =3D auxiliary_device_init(adev);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D auxiliary_device_add(adev);
> > > +       if (ret) {
> > > +               auxiliary_device_uninit(adev);
> > > +               return ret;
> > > +       }
> > > +
> > > +       return devm_add_action_or_reset(dev,
> > > th1520_pd_unregister_adev,
> > > +                                       adev);
> >
> > We have devm_auxiliary_device_create() now, I suggest we use that
> > instead.
>
> Should I send a v2 to convert to use this?

Please do, then I am ready to pick up the series.

[...]

Kind regards
Uffe

