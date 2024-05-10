Return-Path: <linux-pm+bounces-7705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A3B8C1FE6
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E05A1F211AA
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D4713C827;
	Fri, 10 May 2024 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuvpS+aF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5514B963;
	Fri, 10 May 2024 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330363; cv=none; b=c29KqyNBsCTJbSbu0ANkE7r/7n6w+MBjRnSgflY3dZFnpVsF/2NTZw01eL7iaGsYCrGmX2eBTHof+IPvyuyhV9xCGDfcXCU1KSnE8EjUdBoaqL7CI0rknTKGN84bI/B9sKKYC64RT7zVj39AzTyDrqJt0Mxrvb6KjCvGhDnL2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330363; c=relaxed/simple;
	bh=mGua7qHG1pGP4QRa/mrBJm3+ufp8FEusDvUeNttJfho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kz+jOHLaNPZEN7c44EVQNzQz7BEBKE47hSBTNA1S7xBqWb7XNfPdSUDFgH42eIyeBblqmvzFjzAQIqsViCRbtZ14KoGDactYw/Rg9+iVfY4/gcRd6nSmpj+j6P7Bi8RRqz3bzcisXn8DtrTzEpWUOq7RFXvxrgOkTJpUZKKj7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuvpS+aF; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6eb86b69e65so1056397a34.3;
        Fri, 10 May 2024 01:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715330359; x=1715935159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHhvceP4g5t+S02T9cjC1vOupjlyO7jmTM7d1jrCe4c=;
        b=EuvpS+aFLepObD69RHT5+uwF9+lJljN+GvlRHpWkiu5+iRNs5jIPFHeEJXHroDzZbf
         DO1VvfGV2wc1Vz/JKZlE/IAdVR38HMpidTNmyXp6AQj/EserrYocxdSzdAv38MCa3Elb
         u/fZbzBypOLY1Z1c47JQo6DVwAVA70DPJk4fyfr7r8Y3H+lfWLm4llWNJ4JxsQFLAIEX
         Yej9vnSEWArAjZwxzbH4mvkqUlOSAirAZcurSOYbhPBNX6KZ1JCpGeqB2N8w1WJk136k
         G1o+2IUEDbd/UGq6CQZotsQgk3najqBe7xdT8FME2pvjwepxvyAnMxMCiByfF6oWhXgf
         1x5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715330359; x=1715935159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHhvceP4g5t+S02T9cjC1vOupjlyO7jmTM7d1jrCe4c=;
        b=fz9drbobfsLJuo+LaPPVeS9n9y1lJCs27yz/vXs8dGJbm4VhNF7csut92fL8vKLoU5
         s01fmIcxd+9JRra3+vBsYmcObAzx4MBk6RvTm7N2Yt0uQ0kcg6fIPsv0/XHyEdaGauBk
         CEXkwkwTJ+cGk0GA67FBMXInA+04Ef1IsuLUTafRxaesRjvxWMJsKP7jq1vMoYk8nnlr
         GLJoxyGDtXeOSiaf4dy0K/6oRBGiHdyzMAk9nSAoksKSM/WKvGFlJzO2xmyslpLjybHs
         Ufw1kdHKw0kJgkFoicu9yv6OjrpDZx6qrEjMUygiBbROy0neqQuF/OQa+Hh+VIbMuzjF
         /khw==
X-Forwarded-Encrypted: i=1; AJvYcCVSZ5DyEZJT9zv/0QkVYPiNK5NyP1YQDQf56xGRRQLZs47tmy5KZKnfO6PXz4xgzHTcnRdLqhwJHwGyRsfJagxxSrSxNiZNq3dIk2MbhdJ0BGSWMSctDSB/yZXzbwlTIrJlmER9fmFgn3w1AmuupAb6CRWwSEVdame0gIq4e1okm1XS+huw9tjLDQ==
X-Gm-Message-State: AOJu0YzllbAUrsWq4qqz47Y0+SU6w7JSjOfhL7QHCPeVifZsilNUT5hJ
	7cVHO0t421eddlYLUVL/5A+MLeVXC5r4Z+jQCkyQk6BX8Z+plrI6uw/lo4Sd7WyogavV15gR1hh
	ENs0px4UZ56IpNr1YBiIoIIea0rraUkhc
X-Google-Smtp-Source: AGHT+IGzxoeGadEOks27Uo16JnYIjHpfGcnHfUYaIdN4wRRdjfDkaaWI7ed+BLlVzaBT4pTJNy18lABYrhtdIH+/3I0=
X-Received: by 2002:a9d:76c2:0:b0:6ee:404b:62c with SMTP id
 46e09a7af769-6f0e90f6065mr2509494a34.4.1715330359402; Fri, 10 May 2024
 01:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509064754.10082-1-linux.amoon@gmail.com> <d2943958-ac80-4158-8e7c-b5493ab713f8@wanadoo.fr>
In-Reply-To: <d2943958-ac80-4158-8e7c-b5493ab713f8@wanadoo.fr>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 10 May 2024 14:09:03 +0530
Message-ID: <CANAwSgQ+OxcYyqX5hSvmdD=V3WdTqDdG3XDbcH02gRKmzkHNyw@mail.gmail.com>
Subject: Re: [PATCH v4] PM / devfreq: exynos: Use Use devm_clk_get_enabled() helpers
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Fri, 10 May 2024 at 01:35, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 09/05/2024 =C3=A0 08:47, Anand Moon a =C3=A9crit :
> > The devm_clk_get_enabled() helpers:
> >      - call devm_clk_get()
> >      - call clk_prepare_enable() and register what is needed in order t=
o
> >       call clk_disable_unprepare() when needed, as a managed resource.
> >
> > This simplifies the code and avoids the calls to clk_disable_unprepare(=
).
> >
> > While at it, use dev_err_probe consistently, and use its return value
> > to return the error code.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > V4 - wrap up the error messagee within 80 char
> > v3 - No change
> > v2 - No change
> > ---
> >   drivers/devfreq/exynos-bus.c | 22 +++++-----------------
> >   1 file changed, 5 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.=
c
> > index 00118580905a..7d06c476d8e9 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -160,7 +160,6 @@ static void exynos_bus_exit(struct device *dev)
> >       platform_device_unregister(bus->icc_pdev);
> >
> >       dev_pm_opp_of_remove_table(dev);
> > -     clk_disable_unprepare(bus->clk);
> >       dev_pm_opp_put_regulators(bus->opp_token);
> >   }
> >
> > @@ -171,7 +170,6 @@ static void exynos_bus_passive_exit(struct device *=
dev)
> >       platform_device_unregister(bus->icc_pdev);
> >
> >       dev_pm_opp_of_remove_table(dev);
> > -     clk_disable_unprepare(bus->clk);
> >   }
> >
> >   static int exynos_bus_parent_parse_of(struct device_node *np,
> > @@ -247,23 +245,16 @@ static int exynos_bus_parse_of(struct device_node=
 *np,
> >       int ret;
> >
> >       /* Get the clock to provide each bus with source clock */
> > -     bus->clk =3D devm_clk_get(dev, "bus");
> > -     if (IS_ERR(bus->clk)) {
> > -             dev_err(dev, "failed to get bus clock\n");
> > -             return PTR_ERR(bus->clk);
> > -     }
> > -
> > -     ret =3D clk_prepare_enable(bus->clk);
> > -     if (ret < 0) {
> > -             dev_err(dev, "failed to get enable clock\n");
> > -             return ret;
> > -     }
> > +     bus->clk =3D devm_clk_get_enabled(dev, "bus");
> > +     if (IS_ERR(bus->clk))
> > +             return dev_err_probe(dev, PTR_ERR(bus->clk),
> > +                             "failed to get bus clock\n");
> >
> >       /* Get the freq and voltage from the OPP table to scale the bus f=
req */
> >       ret =3D dev_pm_opp_of_add_table(dev);
> >       if (ret < 0) {
> >               dev_err(dev, "failed to get OPP table\n");
> > -             goto err_clk;
> > +             return ret;
> >       }
> >
> >       rate =3D clk_get_rate(bus->clk);
> > @@ -281,8 +272,6 @@ static int exynos_bus_parse_of(struct device_node *=
np,
> >
> >   err_opp:
> >       dev_pm_opp_of_remove_table(dev);
> > -err_clk:
> > -     clk_disable_unprepare(bus->clk);
> >
> >       return ret;
> >   }
> > @@ -453,7 +442,6 @@ static int exynos_bus_probe(struct platform_device =
*pdev)
> >
> >   err:
> >       dev_pm_opp_of_remove_table(dev);
> > -     clk_disable_unprepare(bus->clk);
> >   err_reg:
> >       dev_pm_opp_put_regulators(bus->opp_token);
> >
>
> Hi,
>
> If the patch is correct, I think that clk in struct exynos_bus can be
> easily be removed as well.
>

Yes, you are correct, I will submit a patch following these changes.

> CJ

Thanks
-Anand

