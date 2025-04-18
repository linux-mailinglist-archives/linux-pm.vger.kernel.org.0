Return-Path: <linux-pm+bounces-25711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF7A937FB
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A986B3A8AEA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11CC27815B;
	Fri, 18 Apr 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mABcdzp/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC683277817;
	Fri, 18 Apr 2025 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983159; cv=none; b=UZ1Jc7SCX0wWK3jAwICscsCSTIAgB15t5+dc3Ba5JRap2c8e7VsfcI5M+NUEophfCO/4UuQ8ODebdzXOUuuW5Ik+WI0aHITBwd21rOD/sDyH48st+pbRATAyb176J67BGXGOCQ4SRv2a2U8G8JpCSZLOiSbE3to3M/rTG89zFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983159; c=relaxed/simple;
	bh=7eowmYUF0pclok0D9/mq1P0map8wOZ69347Wa9sCHNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOmPcsWKBQKUmfvEzt11wuIkr/TE3rUgzX4KWp0+WmpYD/grf5dmgfR7fcncbUnhdBcWs7PoRduid3nsDgoueMyLDmUqUiQOarBkaolyl94xI6UPxmpTwLSstZ+Yey4bCCzPPQDJ9vFJ/M3qlm/GVHnM3Fh0b9tZOLpwkyQyC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mABcdzp/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so2691395a12.2;
        Fri, 18 Apr 2025 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744983156; x=1745587956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXZIWWM8mZYdiQktFqPI0+JPo4B/dX6RUUwchm1Zb5I=;
        b=mABcdzp/nxhrHSoGB+Ngv2wEIbGjFA9MyAfutbOaFo71RblvJqPLwMDxt1+dEgJ/h3
         oPjsTd2dieTlSCB6g4KUwsLo3mDDx3S8XvZiwLRo/GbNY7JfysswMFbevuDCe47ZrErv
         AljF5uEwpMpWN7aaUyPlM0zIDObTvsaSXWXDyUTZDVjPKJbQW3ikVg3ckBU9Yxrajp2W
         K1WSSBEvvngNETL5Pyj4hTKXpXrS6/8xU1u9wzwuH+DQffC8A4dXqgxNou7I7x1qCBXK
         4rfc6K5V4T/eZS8J5Cbx5iZLliwb2RlIgwXPG1LGp7/dw2G9Mc9z5JDWs2i94+fAruk2
         70pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744983156; x=1745587956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXZIWWM8mZYdiQktFqPI0+JPo4B/dX6RUUwchm1Zb5I=;
        b=vxw5WGpOZeEbvAID9sw7IFar7t464wNwfZmw2CaUsdRZzWtiE5mHD63Kogicl8GICE
         aTbMWvPu1w0HMLXm6/Fpr50UI4po9qhpqbtRt9mS1LxA/ZRpeEUUt5PXVa07ZqCIfTE6
         N+2QJbr1qVbqM/dtDXmbLzYdegixcPWTiL8LJsGAYVoL9hOGFkTLTA/MfQyq501/nYho
         qsLbtOTANQYVo7E5l5o+nfsg1BNEB6ADquuk+gLirfhwLvUEVhdqyrptyFPv4bsNRS6v
         J+WGzpglQYv1LYRqunKNYoy4nTInTfizUvLdtfOD4Hp0Fsj3rUeHvsbepIoSgCmRaPJw
         el+A==
X-Forwarded-Encrypted: i=1; AJvYcCUiEuq18CnbKlF5lkVbhxRnC6Dsx57a4swdGfTr0GVZclgmyQJiWN2mYDFEpNmJb50Db83TN8+1JC8=@vger.kernel.org, AJvYcCX2ecAKFKaBDwFW466WjNknHHU5Z0qpSLtiIVzUrWMWbvi4WSImKyGT39Fz86AYttHVPof9fKTKpvbJFvA=@vger.kernel.org, AJvYcCXKYJAsJerFRemfq4diYDJMzdiKqpKYaXVFYz8Kq43Hsc+ecce9nG1X+OLhTfIyzVQomQz10nu7WHqR0RpiHHJwmsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKcpOEYW8DZp0l3N43L/Xqgrl1Y9sgZEJNfXtz5bnHq30oV0zE
	Ny/Gvm1VVGOJKyFT/6NiM2nQjwL5m5ndRBVOOczjgXEVZyrqqcXttVeNpKpbG+/lmynLMTdwbtg
	CY5+6dNmZnY9HkCls2k1wiIF7Bk0=
X-Gm-Gg: ASbGncu87KWTonln75ULy5G+IoUjHfoDjy/32om69yJNfhOdeTj/64BND6WsXNhXk1m
	nLVT1ISFIM9wrKm4QVqxY92XmZKDYnNns8Rwv7XbqLQQ/+1REbfifW9YEZRcgQExGv9bThs0k9c
	SMNrsuImcgSGI5zxrLjsCz
X-Google-Smtp-Source: AGHT+IEf1FP4PE+QPrL3TzSuKDCTAio1byV8qwIANyIcWwl3yMCy7oqqmZBQNjRLb7+OZ1bOcdJO2NJMrjzSMyIelCY=
X-Received: by 2002:a17:907:6090:b0:abf:4b6e:e107 with SMTP id
 a640c23a62f3a-acb74b52090mr242322666b.25.1744983155938; Fri, 18 Apr 2025
 06:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410063754.5483-1-linux.amoon@gmail.com> <20250410063754.5483-4-linux.amoon@gmail.com>
 <aAILE01SjRR874jc@mai.linaro.org>
In-Reply-To: <aAILE01SjRR874jc@mai.linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 18 Apr 2025 19:02:18 +0530
X-Gm-Features: ATxdqUHbJXVdHhwcS0IwraNdsY4dmTwIZsNctwmfdNkH6lfYcXleJugDkxPs4Aw
Message-ID: <CANAwSgRK5ONpBM35U7DG=wtHv9N-9kRpbveqyGsVORnJiS5mmg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] drivers/thermal/exymos: Fixed the efuse min max
 value for exynos5422
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, 18 Apr 2025 at 13:49, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On Thu, Apr 10, 2025 at 12:07:50PM +0530, Anand Moon wrote:
> > As per Exynos5422 user manual e-Fuse range min~max range is 16~76.
> > if e-Fuse value is out of this range, then thermal sensor may not
> > sense thermal data properly. Refactors the efuse value
> > initialization logic within exynos_map_dt_data function by
> > replacing the nested if-else statements with a switch statement.
> > Ensures proper initialization of efuse values based on the SOC type.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> Same subject typo: s/exymos/exynos/

Thanks for your review comments.
Opps, I will fix this next version it got skipped.

>
> > ---
> > v5: None
> > v4: None
> > v3: Improve the logic to convert if/else to switch
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/sam=
sung/exynos_tmu.c
> > index ac3b9d2c900c..a71cde0a4b17 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -899,12 +899,23 @@ static int exynos_map_dt_data(struct platform_dev=
ice *pdev)
> >               data->gain =3D 8;
> >               data->reference_voltage =3D 16;
> >               data->efuse_value =3D 55;
> > -             if (data->soc !=3D SOC_ARCH_EXYNOS5420 &&
> > -                 data->soc !=3D SOC_ARCH_EXYNOS5420_TRIMINFO)
> > +             data->max_efuse_value =3D 100;
> > +             switch (data->soc) {
> > +             case SOC_ARCH_EXYNOS3250:
> > +             case SOC_ARCH_EXYNOS4412:
> > +             case SOC_ARCH_EXYNOS5250:
> > +             case SOC_ARCH_EXYNOS5260:
> >                       data->min_efuse_value =3D 40;
> > -             else
> > +                     break;
> > +             case SOC_ARCH_EXYNOS5420:
> > +             case SOC_ARCH_EXYNOS5420_TRIMINFO:
> > +                     data->min_efuse_value =3D 16;
> > +                     data->max_efuse_value =3D 76;
> > +                     break;
> > +             default:
> >                       data->min_efuse_value =3D 0;
> > -             data->max_efuse_value =3D 100;
> > +                     break;
> > +             }
> >               break;
> >       case SOC_ARCH_EXYNOS5433:
> >               data->tmu_set_low_temp =3D exynos5433_tmu_set_low_temp;
>
> Thanks for taking care of cleaning up this portion of code. IMO, it would=
 be
> interesting to go a bit further in the house keeping by replacing this bi=
g
> switch with a set of structures stored as __init sections. The initializa=
tion
> finds the right structure and does a structure copy to 'data'.
>
> It is up to you to do this change or not.

I'll be sure to check this out.

Thanks
-Anand
>
> --
>
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

