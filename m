Return-Path: <linux-pm+bounces-7664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77008C0306
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D944282911
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9E5127E27;
	Wed,  8 May 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mctxl4Cl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF35336D;
	Wed,  8 May 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189053; cv=none; b=npAX9u2jpbxTGTAV3xQlMed+p/qINvEO82nQZ3QlbbcAQZKCpm+WHFBbluYM8UJ/0gS7IrFGPVyagkVU72iTcVH59kQgqb69cv+nwqKGL3dEuIkaIJolSrjlJz7J27Lc4trGEbldQxR0Tghq3xAmHaFV6WWZy8q8GkRfkd91O9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189053; c=relaxed/simple;
	bh=tgV1CXwWsl+p61PgQKuNqvgRR6FjZHYST25qfrxpaSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRH9fzAdd7oUyHmAt8SnJLR88sO9ivsFw2ArDC6EPMw6A7p4+Q9u57NVJAYAHEDBUJhPfRw3YIb8xh4jMEs5KSgiFGYF4xlU5UShU7TQB4lml29kFBuiBaFWphDbR/FvzExXzQQARMzR1DNkvstzl5O7fAgbKTgZMKDw5oXaYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mctxl4Cl; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b1ffd24c58so2476234eaf.2;
        Wed, 08 May 2024 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715189051; x=1715793851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ/+17iczEabMzYSnwED5XJS+Nkb33ul+oPCIawtx9c=;
        b=Mctxl4Cl713M1NYq+8bft2Qe9KRAQ/gakVt7BCbKp2YF9jskK1h8cNJMfHP9dzN5Nd
         oxM4BSOa495iE8mt+ZhV/7TyGgTjowe1jg8RXqEMIdKCCUSVZnrWJHyIl8E9Kp0Ay4lA
         tL/4umWQdn39D++WgdwXPSi8Fu7tJ5h0Ia4OKExIRASwifIpjBorsT4nzJz1Md/cGT3y
         R35pLqPOJrPZHcfOT80TOMqePhjs4JHwavfw1ft8IjqjrzjZj/kMMvYEB/Qdp62Y3uAU
         55VvUuPly9sa3Eci+39vofcTrL18J5ne8ayhkc8eCHNuCLFvsbcaSPLOZE36vSFAuuxR
         uikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189051; x=1715793851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ/+17iczEabMzYSnwED5XJS+Nkb33ul+oPCIawtx9c=;
        b=wxuPqZqEwrw6t+nBVI6dZsOOE2vwA/pvXxO7LfgsD6z8OU4W2Kz6yM/PucaYOLNWCo
         BvFJ1SzzdtVYdfaEx7f/gAbHP9N/DyHRj6Q3tReE5ysD/wSaqj6TBjW5J/fxlp8ufvri
         mSIFdNoAhgnMq2LiGBOP+/yo2HeGKFFWt1HqGq1gJpWhvcimtLLEnUMy9eKO1Wi/gcvN
         zrOnnGYRDZxHHR9GjNjrMLeq9zgYmATpQJau4yyMdBjRFRAnEnOg9G0cfsKLr0utwFwr
         CfKDsCjFVMxr1heQvh+KgGomd8RpCKKawgK1+y8ukUju4tvjUv/4oCwmSHFqS8qzlHJv
         vqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT3WFaQJqFhF0r3UvYfxPkr/NbTiZQJ8VCB0cR53RrwTypUacj7u+AEkgKWCJDrK8rERev7zBZzeaFqz3oNZgUKvUfREhyn5v6lzCM8wQ9jfMl14Gkx0TnGjSnqPkUxVDJNd5nVfoF72zK3vc0vexwXcuYxjOyF4mt6f0oI3uXfGss8BQqKR4B9A==
X-Gm-Message-State: AOJu0YyhnJ2Y4wC6+VdQoDY1psoBsuG+V3Y6TlpzImsgOrP5VXXknh7i
	+hWSIkQeKy0wa/jbsUFa02NNP+hWWPQBKckMG8j3luhLPZmg36VU1yfBeMqCGPTjf43TuJFM6lN
	FTHKd1Rv59LcfJH4VYI8kXZ9b0no=
X-Google-Smtp-Source: AGHT+IHiJkUZQ/+LcuQSBjvtRv27j6+1yp6q0NXJp6d29mGbuu8y0YmDIRS3eipJjBddJoQovYbw4CUS+2ANQeNIaaU=
X-Received: by 2002:a4a:aa09:0:b0:5af:c4b3:7c6d with SMTP id
 006d021491bc7-5b24d5e69dfmr3356211eaf.5.1715189051165; Wed, 08 May 2024
 10:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417044459.1908-1-linux.amoon@gmail.com> <CAGTfZH3oJQsc0XVrrA-F7NxSfKx8=mOYDM1Vvxt37+skvXZVaw@mail.gmail.com>
In-Reply-To: <CAGTfZH3oJQsc0XVrrA-F7NxSfKx8=mOYDM1Vvxt37+skvXZVaw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 8 May 2024 22:53:54 +0530
Message-ID: <CANAwSgQsqWSn4yvsgrEAyHTx2n7ccpeFqL-qUZG+3_=GgsF4rg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM / devfreq: exynos: Use Use devm_clk_get_enabled()
 helpers
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chanwoo

On Wed, 8 May 2024 at 21:16, Chanwoo Choi <chanwoo@kernel.org> wrote:
>
> On Wed, Apr 17, 2024 at 1:45=E2=80=AFPM Anand Moon <linux.amoon@gmail.com=
> wrote:
> >
> > The devm_clk_get_enabled() helpers:
> >     - call devm_clk_get()
> >     - call clk_prepare_enable() and register what is needed in order to
> >      call clk_disable_unprepare() when needed, as a managed resource.
> >
> > This simplifies the code and avoids the calls to clk_disable_unprepare(=
).
> >
> > While at it, use dev_err_probe consistently, and use its return value
> > to return the error code.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v3 - No change
> > v2 - No change
> > ---
> >  drivers/devfreq/exynos-bus.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.=
c
> > index 245898f1a88e..153340b6685f 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -160,7 +160,6 @@ static void exynos_bus_exit(struct device *dev)
> >         platform_device_unregister(bus->icc_pdev);
> >
> >         dev_pm_opp_of_remove_table(dev);
> > -       clk_disable_unprepare(bus->clk);
> >         dev_pm_opp_put_regulators(bus->opp_token);
> >  }
> >
> > @@ -171,7 +170,6 @@ static void exynos_bus_passive_exit(struct device *=
dev)
> >         platform_device_unregister(bus->icc_pdev);
> >
> >         dev_pm_opp_of_remove_table(dev);
> > -       clk_disable_unprepare(bus->clk);
> >  }
> >
> >  static int exynos_bus_parent_parse_of(struct device_node *np,
> > @@ -247,23 +245,15 @@ static int exynos_bus_parse_of(struct device_node=
 *np,
> >         int ret;
> >
> >         /* Get the clock to provide each bus with source clock */
> > -       bus->clk =3D devm_clk_get(dev, "bus");
> > -       if (IS_ERR(bus->clk)) {
> > -               dev_err(dev, "failed to get bus clock\n");
> > -               return PTR_ERR(bus->clk);
> > -       }
> > -
> > -       ret =3D clk_prepare_enable(bus->clk);
> > -       if (ret < 0) {
> > -               dev_err(dev, "failed to get enable clock\n");
> > -               return ret;
> > -       }
> > +       bus->clk =3D devm_clk_get_enabled(dev, "bus");
> > +       if (IS_ERR(bus->clk))
> > +               return dev_err_probe(dev, PTR_ERR(bus->clk), "failed to=
 get bus clock\n");
>
> nitpick. I recommend that better to keep 80 char on one line as following
> for the readability.
>
>                return dev_err_probe(dev, PTR_ERR(bus->clk),
>                                           "failed to get bus clock\n");
>
Ok
>
I will update this in the next version.

Thanks
-Anand

