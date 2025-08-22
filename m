Return-Path: <linux-pm+bounces-32873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F2B30DEF
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1A6174E79
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4D28D8E5;
	Fri, 22 Aug 2025 05:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/iCU1SY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4A28505F;
	Fri, 22 Aug 2025 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840085; cv=none; b=RMtP1gdAndZ12sSsqFjBs5dTHGBVNzHpxSZmj3bDo+TPtCYp+AjYaSER8NTdVjq4oycz/NZ2sjLbe6rjp4IZNIf1XgAwUM6KJZS2mdpqJm4/m3OKTR3Nn6JSqYLFJBYoh+yOiv7uInTfX+y4bAvGpgTOkLm02hHljEo5zB5KAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840085; c=relaxed/simple;
	bh=Dhq1EKRGFfvC0kDVCsgNN7STDq697m7sI8COfgZ3d7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKsCo4ZzSs8hqRGf++wZOhgno7iBPrMhnIUHlQxCYYTIBm0X0fQYtEfTL60AhW6lMIlgK7KJyJDHm2Ke3j+hCx7DNuSNN4mIEk4x3PAcZf8h+zyG9pY7u84uzknT3CD1ehYjtiipOrOgk65qINjWaEgLXysCbNx6+XjaLIAPQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/iCU1SY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso1427916f8f.2;
        Thu, 21 Aug 2025 22:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755840079; x=1756444879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvKEBQ7yPvPn1i4lpaL5alLsJpeWrgoaDHAdkYx11l8=;
        b=m/iCU1SYRu718c6/x/8TpawGrR2G2KzAH/C51S8PLBBJiQJwZCKUZHQA0kC1ShxFvz
         /qE1Q/X6+nUm6XdxWC+1hGXljcQJHNI6M/2I8Bv/XmHk8Y/S/Y7vqD+AZn+HUna1MnKP
         9ZJzH+A1eYx90h90WxUUWa0VQC98aCHfhPlWhsGWnPv3AjJBQC7wIOmJPofBcEyaYx0m
         Vo6dCDDSe4XR1J2R++ZREU+tXsqz8E0xWC+rqnXICsJKLlGnpD5YrDe+RlnnO4Kg+Jky
         K7aqWzM6A/wnaEi0BiEDMR0/9jNzkx6DL+BbQzWmzrfowo8vF/9GrnJ+tIm40BBZQt6L
         vjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755840079; x=1756444879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvKEBQ7yPvPn1i4lpaL5alLsJpeWrgoaDHAdkYx11l8=;
        b=YkRE8lFtfGC/t87b5RbofzT5aRFLtLdz7D8WqamOX1DMFLkTuKO75tk0aptUM6MyWg
         Z5eeTfTtBQKhhoZ355fVrK8Smo20/pv6Y5fuyaLWK8ATYU5JhoRMNT5dr3iGMcnz/BBD
         lCg3mhu7+wFDSEyBkudLDGNz3U7aWxDyoPLtyGLYUwgZVcKGQJL0KPhBHy03uV9e5D08
         8wY9t9rwwKBONDety1Lim6gMFtReuDqvbsmQtjlKSN8xmwWnkp0howFehl1ebQrwPjCj
         fGWQBl2tXW2mXADrM3iGnV4fbdBumPsfiXB5IFAIdO/useH9E3LPZlVszwuNewf8NeNo
         PqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKVvzsCgab6F1th+yCqLs1WlqCIK2DGUYWgz9xjXSCsCTBrKJMgKEJGNdwoX4AwEr8c2PahCUdGqV1h+hU@vger.kernel.org, AJvYcCWfLb2w3CBuhAE7JK3RWawoilp6A0pwq7Iz7ErgAZ4++j5eeMD7WBqRbyiQsQfNtk0M0cOg8cdAW5Kqqu0=@vger.kernel.org, AJvYcCXYSL8kX2tKA5OmiTz2/q6kEXgQe3CZg8k/5tZMCJUpHHKWv4dpenETTAG8GdQfmvB62nPNSsFo63s=@vger.kernel.org, AJvYcCXltKUZa25oaQ9UMl6GqB0ZXR1fez6Z25Fu+siF+b9zFuz45s5IVwo5VqaHqMWyitO8LH6CEswtobY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/NGyEKpaNQYmXt1EpFKHQX0DqEj2X5TWUvPTLbS9qH8Hw9wx
	zbRFOZj8ezfjG3jIpOr7rtKQmZ0+iua9fv5qtjHIUXijkm7NwmaxX4HjDGxhM3w1mcuJ+F1z/A0
	I4ToJxeps4ewTGV4V2MHk/hnmyQZxARs=
X-Gm-Gg: ASbGncvpISFwkoizkgq6QFNhA7b0iJTwceujTvFdNbcK20Hs30ij3ZJGf6qh25p8Sf6
	bEeXEze43g3+j/wRsZu3zv8n3fcK8bQ034Qf2SeKRt6U9+DSUFY6LnhSjSGJCkpC75VajnCskm9
	vMpYjII6XHLsChItrngPJk68naOv5AiDXKYr9NRt3AQL3L+htRuh1licQghnUL+RpWmpSWtZZJO
	b/EfNzO
X-Google-Smtp-Source: AGHT+IHhSYM0k9SEsMbFsBYZmOGa9t1h6A8KV8hrooA4h0OepLG5bv3p8xVbgieNLPz08xT6yLEXjRsFtXNtt8Gd+nY=
X-Received: by 2002:a05:6000:26cb:b0:3b9:1c80:e1ce with SMTP id
 ffacd0b85a97d-3c5dc540663mr842412f8f.36.1755840078612; Thu, 21 Aug 2025
 22:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321095556.91425-1-clamor95@gmail.com> <20250321095556.91425-2-clamor95@gmail.com>
 <1914341.atdPhlSkOF@senjougahara>
In-Reply-To: <1914341.atdPhlSkOF@senjougahara>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 22 Aug 2025 08:21:07 +0300
X-Gm-Features: Ac12FXxmta7mBPhCxb7W9OiXb4BXH_cyVWGMx9ucUxlZujEVGMRlnBeWr0rx2Ho
Message-ID: <CAPVz0n0zuvXxT=G18ujhV26nbvuCKtyXNC3cxenxGuj8wHWZ8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drivers: cpufreq: add Tegra 4 support
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 22 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 05:5=
8 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Friday, March 21, 2025 6:55=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Tegra 4 is fully compatible with existing Tegra K1 cpufreq driver.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  drivers/cpufreq/tegra124-cpufreq.c   | 5 +++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> > b/drivers/cpufreq/cpufreq-dt-platdev.c index 18942bfe9c95..7d15a1224d37
> > 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -140,6 +140,7 @@ static const struct of_device_id blocklist[] __init=
const
> > =3D {
> >
> >       { .compatible =3D "nvidia,tegra20", },
> >       { .compatible =3D "nvidia,tegra30", },
> > +     { .compatible =3D "nvidia,tegra114", },
> >       { .compatible =3D "nvidia,tegra124", },
> >       { .compatible =3D "nvidia,tegra210", },
> >       { .compatible =3D "nvidia,tegra234", },
> > diff --git a/drivers/cpufreq/tegra124-cpufreq.c
> > b/drivers/cpufreq/tegra124-cpufreq.c index 514146d98bca..6ff2ccc08e5e
> > 100644
> > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > @@ -189,8 +189,9 @@ static int __init tegra_cpufreq_init(void)
> >       int ret;
> >       struct platform_device *pdev;
> >
> > -     if (!(of_machine_is_compatible("nvidia,tegra124") ||
> > -             of_machine_is_compatible("nvidia,tegra210")))
> > +     if (!(of_machine_is_compatible("nvidia,tegra114") ||
> > +           of_machine_is_compatible("nvidia,tegra124") ||
> > +           of_machine_is_compatible("nvidia,tegra210")))
> >               return -ENODEV;
> >
> >       /*
>
> I also prefer using Tegra114 and Tegra124 in the commit message, perhaps =
with
> the marketing names in parentheses, as the chip IDs are more consistent a=
nd
> (IMO) easier to decipher than the product names.
>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
>

Yes, this was applied in v2 already and all other my Tegra patches,
this exact commit was already picked from v2.

