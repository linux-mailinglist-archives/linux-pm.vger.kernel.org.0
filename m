Return-Path: <linux-pm+bounces-11306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90EE9393C0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 20:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2C91F22151
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4874171661;
	Mon, 22 Jul 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoM81yJN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8817109C
	for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673732; cv=none; b=Z0T0QypqdL/+IU2ZX1wIsI+BykLsr6e6RWF+Z99oCBeNbfHO5FEMKwNe9JZ5xrZr66UCPlEj93u1yUCDcPatJsrJze4RSASN+lu8YA1vWcPMi6AV5a7PYJB9a6qFyMFVHgLAcrqocsbLD2nfxY8XnpUJPokVfcysQ82d3iShCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673732; c=relaxed/simple;
	bh=+amIieoWJ9CX4mMMjpPZdcjS+0jEdmiGnO2u6Xqp1Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLNZB7ida5M41G8aNDqJp77iizra6B927e49EiZyhKmjN3uN52xFwzoSEfNVSBwPLfUbz2GKwj8BgWf6CtAG14iqazv/GLHF1NA4g/SBB48C8pbEiStTMmzbD+2tnmQe3yfcarpbCECJXZnQ7IZ5RiS3W/6DZz9an8sA7RWVJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xoM81yJN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-643f3130ed1so45993087b3.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2024 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721673730; x=1722278530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4rdGF+Z/Yh8hymhxBTniZ382LqDBxfp7vlKwSbjjk4=;
        b=xoM81yJNcxAX32JmQ4I9U72mRFUyziBISzw722h0u9Nz9myutdzZYDVGqRlCviocsq
         i10M7oZl5673cx+kQXKo/RmHhMh/OCCTupT9B0pGxgVOgmrS0rVjzh9apoUoi3hUOAvz
         MO2YfaX+cRnzDRe/L6R4Ry+Fk77zeNGVt+vGgKOEFKppIljiMfDFlt5zlhIemC+ZITQL
         kh+yU1MDbQQreUKS1rdOwtF0W7j6tfXctk8W649QlmGGgpaxjt7Xa4g5bs3zvbjg0fgp
         0xD6pHc8yeFQsjvADWPW7OI4H1kq6PYSjb0DfE8MzYFt8MlunLs2MLx/UEouZt7F5Mmm
         UVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721673730; x=1722278530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4rdGF+Z/Yh8hymhxBTniZ382LqDBxfp7vlKwSbjjk4=;
        b=e+MHfjbg1SUnAclsJ+AF5HTgIjukCog3YbpJz8hoQvcDgyq//LDbYqJk9d8M25gAoC
         dfNFRqttKcO1xp7OsYPKgouW32wysCYbWNgqysZ3G0sEMo0bZVJlyCqgrEsbDwgXVOUr
         eiaLpZNb/2tm3aoJnqSDe6CwHtJJoztyUW907yR29Evwgwa8zx2YlI6kk8r8GkiGMuJ9
         a01se2NUJuCoYOF+xcIPKDzILGLV6MxNLEnVfqEgujmLfQND5ENi2CsELCHqFN6y34zp
         sx2w2+F/2UsqkCdSQ5NgdPLWIDZcaxZYZfIDoXt545vv2ov2tL0mBXo8MdbQP1aN4PTz
         yQpA==
X-Gm-Message-State: AOJu0YyIQCX9sdIlUVSpLxyhePnRV/eVGqLCGa4AMsf9f4Qab5fdhG8q
	Zt9LRg9Ju0MEQFNrSy1mcrMxD0+CLtPTf8pVWeeRyYM8L9UiJB1WogT3ZTt68KQSE9SKF1JLOOY
	EIXVFpg4rbndg89l1UGIfNn2QxK4bcyhKs6JuBg==
X-Google-Smtp-Source: AGHT+IHyjq6NgbF3ZUXX0L4gapb6B1fFnlurqaVxvZPJbrOQlcRjRKj0aSuLj6GTSIGVU3z3I1mo6FeWF8LwK/kCyo8=
X-Received: by 2002:a05:690c:2c81:b0:65f:80bb:e6b2 with SMTP id
 00721157ae682-66ad8ec55fdmr72566757b3.14.1721673729754; Mon, 22 Jul 2024
 11:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240719120945eucas1p2aa5e35f78daa7ec1ea07f512180db468@eucas1p2.samsung.com>
 <20240719120853.1924771-1-m.majewski2@samsung.com> <20240719120853.1924771-2-m.majewski2@samsung.com>
In-Reply-To: <20240719120853.1924771-2-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 22 Jul 2024 13:41:59 -0500
Message-ID: <CAPLW+4=VgRBqw0X9PTOwSNNfLgvv2-5dTF4bP78_7gk4BwJGcQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:10=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> SIMPLE_DEV_PM_OPS is deprecated, as noted next to its definition.
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/thermal/samsung/exynos_tmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index 96cffb2c44ba..9b7ca93a72f1 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1150,8 +1150,8 @@ static int exynos_tmu_resume(struct device *dev)
>         return 0;
>  }
>
> -static SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
> -                        exynos_tmu_suspend, exynos_tmu_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
> +                               exynos_tmu_suspend, exynos_tmu_resume);
>  #define EXYNOS_TMU_PM  (&exynos_tmu_pm)
>  #else
>  #define EXYNOS_TMU_PM  NULL
> --
> 2.45.1
>
>

