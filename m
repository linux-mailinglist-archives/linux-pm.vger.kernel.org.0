Return-Path: <linux-pm+bounces-8799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B2900C33
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 21:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409501F2339E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC890482FE;
	Fri,  7 Jun 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMmKY4kO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94433EE;
	Fri,  7 Jun 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786841; cv=none; b=NoDcVw5v9v8l4vQQiAEMrHlGjEgaBxDbDVZs11p6L01PYx1MKl59Mg2mbPnWrXbz6c19kp3Z2LIN7jgdqsRpqplFVgGs8OxPN9oZs+IGF3A1qFkUHwij9760Xrv1vJYq84IfS1UK6sesFAznpTlGEssNiLAlJoJvekXbsABj1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786841; c=relaxed/simple;
	bh=IPM3ZjOOoKK9XZRO/WkOmRAqEmZd5KnB0OIVkFoyJt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0u/8MjzR0KBRnimrd4L7x1WkpQaOZ+QawxsPR1Uiy+3meF8djX9qISB3NZvT5NQy5BshRoV8opM6tFRaCyTmeNU9ScNKyT6h9YTSgx0q8KCMkCT7pQAypxvUK3yaxCnsgHfEhRjpA17+O+JvSgD1cMvoGzcvKXCodYCrzVRnM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMmKY4kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0841C4AF08;
	Fri,  7 Jun 2024 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717786841;
	bh=IPM3ZjOOoKK9XZRO/WkOmRAqEmZd5KnB0OIVkFoyJt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HMmKY4kON5jYIpNgJWHAqigbtXut0meWxfry6TCSfOf4J90q07JjF+fb7JOERKuUr
	 oFTNwv/qfpFZsF9YHywvujdVx6o+lOwa4D8e+sUWCQl6wyPPgDEGYK761o3+X3K0Y9
	 OxqETGzOVHuhskjYR1qFkjmZv1PsCZRF9J7c6wmeBHt7/Mv+0kuaJJQqxS81AQoT+V
	 Wy14eBRqFPkmpQOZteiBKmXaaCt/Ct/EEiyeTIAbxqvzbQTBclNWhkg8OThWHVPRFo
	 rIasBBJo4nJR0GgLTHrlHI7ZFkbgkAkoFCmIMBSWs6gIdKf47qzXyz0bHtwbE+Giyk
	 jM4ka91SBxF6Q==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d21c5b48f5so10200b6e.0;
        Fri, 07 Jun 2024 12:00:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyQkvlhipV2yBTjXii0PvYm9X3/HRLxpPmZwXLm2ncj1GHS+dDc38xmxPgonGZphBDOnwlwhgqKIqZLuAp1JxmBItDVrFPGA+c5fTtpSczep+jhQb9TfUB0pTGRm/C30RZxeFpa4eT90RTwUPaQZK9G0vZFYQ8YyAoal4mSnKygV4Wd9+cX44=
X-Gm-Message-State: AOJu0YyYvKtiAUrU5Tz10zLhQL2vOPjG98dZ4EYKF2xb/cnBCYM2onGj
	CXwHU7Oa8K8j5mSjNNrrs3KDp2bCcTsKgHoA5t6t4veAP00sVmGLkCh+waRkczLJXBKycjBv9GN
	Yd0oc2DJcEcnr/g4dGJ7HBXIxdZ8=
X-Google-Smtp-Source: AGHT+IGuJmKnxkTd0KYNZ8GHs2XH6rZN6o7VLhS21c0RGPNYMnNAYBlTibs+T91Q58vZVrd6rRw/ZLbD9DyQjDDA3iY=
X-Received: by 2002:a4a:a7c9:0:b0:5ba:6959:edf8 with SMTP id
 006d021491bc7-5baae6da3bfmr3518182eaf.1.1717786840309; Fri, 07 Jun 2024
 12:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8PR02MB723748EF627AEB253C437FD48BFA2@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To: <AS8PR02MB723748EF627AEB253C437FD48BFA2@AS8PR02MB7237.eurprd02.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 21:00:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ghxCYZKdf3zixi6StSCir7Yyiy5iyPeG2+GmyHU4yzWw@mail.gmail.com>
Message-ID: <CAJZ5v0ghxCYZKdf3zixi6StSCir7Yyiy5iyPeG2+GmyHU4yzWw@mail.gmail.com>
Subject: Re: [PATCH] thermal: int3400: Use sizeof(*pointer) instead of sizeof(type)
To: Erick Archer <erick.archer@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 7:21=E2=80=AFPM Erick Archer <erick.archer@outlook.c=
om> wrote:
>
> It is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not
> change the former (unlike the latter). This patch has no effect
> on runtime behavior.
>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index fa96972266e4..b0c0f0ffdcb0 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -571,7 +571,7 @@ static int int3400_thermal_probe(struct platform_devi=
ce *pdev)
>         if (!adev)
>                 return -ENODEV;
>
> -       priv =3D kzalloc(sizeof(struct int3400_thermal_priv), GFP_KERNEL)=
;
> +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
>
> --

Applied as 6.11 material, thanks!

