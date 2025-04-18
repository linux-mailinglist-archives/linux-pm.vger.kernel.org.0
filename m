Return-Path: <linux-pm+bounces-25709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F787A937F5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EF03A6E33
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49044277029;
	Fri, 18 Apr 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE4/Cx0d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038F20767E;
	Fri, 18 Apr 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983110; cv=none; b=HCS0ZatgnszRnHu4zZif6kfpdVTth+fgtiNuMupozcxSA5p6KLpXB+vBGRc92G3Alwmu+J6MQqeZJQmgMKZCBCIlGG5fr4eXy2aQXLuaPTWrpu7DUrMgi0X8flIBwQhj5o5S1Yy3mpfbIJcLwiBW6hrQ6qJLwspnSZiQyue/AkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983110; c=relaxed/simple;
	bh=+ipEq0DN1psmNTdr4XRWkkXLvcwAD4hbAap9lZ1Syy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLCP4uzex/vcgGYPRos7HO7ySZ5zUpnVJhYhg22vgT/eroX+zkNrj+8c3pIF37HR1z1viHdU4E2H8MfIg9TVbr3VuBNr0spGIrkqO7xWVgLhM/p6Ez3SdumNdp+E+48KinwhJP2TlVZd1A3eM7uTmm8pnRuQ9DvRi+miNyBQ19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE4/Cx0d; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so71279a12.1;
        Fri, 18 Apr 2025 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744983107; x=1745587907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW/r+Xskypu97YYD6KF6jc5zwux2QZnn2gKuuTUWqVE=;
        b=gE4/Cx0dYk9em6Y0NJOfavwg7aCSmA2Rk/X0hErzcjPsYchSnkXb444UVqpDnIfr/n
         nyphkiRildA9GTrKlcPgYPzO7QzRABd7dciHPk1uz/6PD97IJbU6W2SO7KtFI9VrN3o3
         Fff0spJnyQt2afzdgEu/gprbpaaN37t4aAu45Sh1UXKHI7TFCdjW6T7IgHV5y5Knb81l
         5MkLl9ikM9ODWavwKTyCTt3EaCVjVRYilziOEyuGNYA08wHFFtF5UjgOHRFDs4mI/vsH
         q6bG4CK2mZTouBJlc1UjSIgGk25eddzAxBsj1Cjovy+k9Dz6at/5cp2NXT8a0JA70WEu
         Iiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744983107; x=1745587907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW/r+Xskypu97YYD6KF6jc5zwux2QZnn2gKuuTUWqVE=;
        b=VcfgX+TnAdHxTZ27GuqfHgnw7RSzjAnBng1cNzOwqORJew5nXx1n6eugF4RAJWkGML
         /lLehEB+VEUun6iU/N68fim00+RYNWhrlOHUgKe69nqvR7HIDmSCiVXzbzuQrx7fXRql
         sAufGyyXU8Zo9zvoOfB4+IUVc0xJ0EEhnm2Sl2ZK9BIDew8LDR059iA8t3/SlzAmdeR+
         kbb1+yhGu+0/zovDyYvH1soiZM0UWT70q6X7IO86gdBtrd1mnt8hj7mW2/BAB39db5ds
         jF3ZWwHsPnqeWLVwgl2Z44mNDn9KL9N2ubwX+PZEfZwkKf057AXXLamwrg2uAJfxfkVd
         V1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVie4nK3AYGvW3LlTSTlQE75qk73IGHipe6J4dq2jZOYEamndGybY/LOEmApGxcP+VYCzg1yFayfNbqwrtXez2o8A8=@vger.kernel.org, AJvYcCWt4i/mhbEn3ySZCSw7gmRDY6SyV12/zQV7OOggWJbQP1fBAdjcbHd0rlJQDQfIPXsCTq2LBVaHu4g=@vger.kernel.org, AJvYcCXIS3jo1qjJ3zlliRveB7qTTh91yewW7opGp9YjCEZLVJ38l6oSRMIoFJ7WW2ARhcYULSOsPpjZZFhGgDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYbf1UbPoNpE2bhcjeo2m6+BBfkl9fGIcUUfnOA36IgaklSbOH
	9sIYTa8AP8jB0WYy6tTged5MyPxUx5fb/udCwD8aQu7VY+y2O49JAc49vqRcjSg7kOcPDVRMqd3
	Op1pkTw5Pqkh4f0biwqUN40Wjr4rm3+5+
X-Gm-Gg: ASbGncv97miwI7viGXgaSwX5Ee17bMea1GWzKk1J+XdTnQNYiAeLtF4gaP4CEOhc4fb
	z6CdRuanuqqUGFROoBh3ng2GeKv5aNb+utiRcfGEGAuFCG1NJqa7eCcYdws5qboQilqEKdNRtbo
	k5IcZK9XQwgvzRA47HxKDJ
X-Google-Smtp-Source: AGHT+IE+R7I4dVbYwOWf8/dydNM3ras0vM8Hcd1dtJhxh5iLeMMP4/GOg7s0W+7aCQ1EW35HU9YjtmFodyE+MqjWPmY=
X-Received: by 2002:a17:906:e208:b0:acb:85f2:f032 with SMTP id
 a640c23a62f3a-acb85f31115mr5753166b.13.1744983106327; Fri, 18 Apr 2025
 06:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410063754.5483-1-linux.amoon@gmail.com> <20250410063754.5483-2-linux.amoon@gmail.com>
 <aAIIH7H1oQH8cf-6@mai.linaro.org>
In-Reply-To: <aAIIH7H1oQH8cf-6@mai.linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 18 Apr 2025 19:01:29 +0530
X-Gm-Features: ATxdqUEh1pZaqB8ipWBIif6O9726dyogwx9y_IR39XM-ncpaQF8skGDo78Oz4mw
Message-ID: <CANAwSgS_OnEv=r7S4CetLkW4vo-QdFAKTbqRK9H-Q0dq5VDYLA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] drivers/thermal/exynos: Refactor clk_sec
 initialization inside SOC-specific case
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

On Fri, 18 Apr 2025 at 13:36, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On Thu, Apr 10, 2025 at 12:07:48PM +0530, Anand Moon wrote:
> > Refactor the initialization of the clk_sec clock to be inside the
> > SOC_ARCH_EXYNOS5420_TRIMINFO case. It ensures that the clk_sec clock
> > is only initialized for the specified SOC and not for other SOCs,
> > thereby simplifying the code. The clk_sec clock is used by the TMU
> > for GPU on the Exynos 542x platform.
> >
> > Removed redundant IS_ERR() checks for the clk_sec clock since error
> > handling is already managed internally by clk_unprepare() functions.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v5: None
> > v4: Fix the aligment of code clk for clk_prepare in proper if/else bloc=
k.
> >     update the commit for clk_sec used.
> >     checked to goto clean up all the clks are proper.
> >     drop IS_ERR() check for clk_sec.
> > v3: improve the commit message.
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 37 ++++++++++++++--------------
> >  1 file changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/sam=
sung/exynos_tmu.c
> > index 47a99b3c5395..3657920de000 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -1037,29 +1037,30 @@ static int exynos_tmu_probe(struct platform_dev=
ice *pdev)
> >               return ret;
> >
> >       data->clk =3D devm_clk_get(dev, "tmu_apbif");
> > -     if (IS_ERR(data->clk))
> > +     if (IS_ERR(data->clk)) {
> >               return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to =
get clock\n");
>
> As this branch returns, the else block can be removed.
>
>         if (IS_ERR(data->clk))
>                 return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to =
get clock\n");
>
>         ret =3D clk_prepare(data->clk);
>         if (ret) {
>                 ...
>         }
>
Earlier I got this review comment on this.
[0] https://patchwork.kernel.org/project/linux-samsung-soc/patch/2025021619=
5850.5352-2-linux.amoon@gmail.com/
I will try to fix this in next vrsion.

> May be worth to group both calls with devm_clk_get_enabled()

Earlier, I attempted to change the clock ABI, but it didn't work.

[1] https://lore.kernel.org/all/20220515064126.1424-2-linux.amoon@gmail.com=
/
If you're okay with changing this, I'll update it in the next version.

> > -
> > -     data->clk_sec =3D devm_clk_get(dev, "tmu_triminfo_apbif");
> > -     if (IS_ERR(data->clk_sec)) {
> > -             if (data->soc =3D=3D SOC_ARCH_EXYNOS5420_TRIMINFO)
> > -                     return dev_err_probe(dev, PTR_ERR(data->clk_sec),
> > -                                          "Failed to get triminfo cloc=
k\n");
> >       } else {
> > -             ret =3D clk_prepare(data->clk_sec);
> > +             ret =3D clk_prepare(data->clk);
> >               if (ret) {
> >                       dev_err(dev, "Failed to get clock\n");
> >                       return ret;
> >               }
> >       }
> >
> > -     ret =3D clk_prepare(data->clk);
> > -     if (ret) {
> > -             dev_err(dev, "Failed to get clock\n");
> > -             goto err_clk_sec;
> > -     }
> > -
> >       switch (data->soc) {
> > +     case SOC_ARCH_EXYNOS5420_TRIMINFO:
> > +             data->clk_sec =3D devm_clk_get(dev, "tmu_triminfo_apbif")=
;
> > +             if (IS_ERR(data->clk_sec)) {
> > +                     ret =3D dev_err_probe(dev, PTR_ERR(data->clk_sec)=
,
> > +                                         "Failed to get clk_sec clock\=
n");
> > +                     goto err_clk;
> > +             }
> > +             ret =3D clk_prepare(data->clk_sec);
>
> Same comment, devm_clk_get_enabled()
If you're okay with changing this, I'll update it in the next version.
>
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to prepare clk_sec clock\n")=
;
> > +                     goto err_clk_sec;
> > +             }
> > +             break;
> >       case SOC_ARCH_EXYNOS5433:
> >       case SOC_ARCH_EXYNOS7:
> >               data->sclk =3D devm_clk_get(dev, "tmu_sclk");
> > @@ -1112,11 +1113,10 @@ static int exynos_tmu_probe(struct platform_dev=
ice *pdev)
> >
> >  err_sclk:
> >       clk_disable_unprepare(data->sclk);
> > +err_clk_sec:
> > +     clk_unprepare(data->clk_sec);
> >  err_clk:
> >       clk_unprepare(data->clk);
> > -err_clk_sec:
> > -     if (!IS_ERR(data->clk_sec))
> > -             clk_unprepare(data->clk_sec);
>
> With devm_ variant those labels should go away
Correct.

Thanks
-Anand
>
> >       return ret;
> >  }
> >
> > @@ -1128,8 +1128,7 @@ static void exynos_tmu_remove(struct platform_dev=
ice *pdev)
> >
> >       clk_disable_unprepare(data->sclk);
> >       clk_unprepare(data->clk);
> > -     if (!IS_ERR(data->clk_sec))
> > -             clk_unprepare(data->clk_sec);
> > +     clk_unprepare(data->clk_sec);
> >  }
> >
> >  #ifdef CONFIG_PM_SLEEP
> > --
> > 2.49.0
> >
>
> --
>
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

