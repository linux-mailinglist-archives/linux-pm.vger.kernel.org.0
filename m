Return-Path: <linux-pm+bounces-19524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD1C9F7D5B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 15:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44911894CC9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F1A78F2A;
	Thu, 19 Dec 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9h6Fnx9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62670809
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619906; cv=none; b=l8gYBFYuak8lepEf1YR/OrfgJ2AuPrWMLm3RtmjmcDG6nkiiL65lMCFfpvG6Cl/AvBl0a8j2gy2emxi9n+y9pH9bA7/mDiG0UaEoyHziOPxAEDONuneyrLYJZoXaT5zRPDipN4xX1GghoBWKP1BwtUfAamPuDgU+4UyPS0jk6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619906; c=relaxed/simple;
	bh=txDiBEZM0gVIs1lttwjBq/vvUlt47naOgPQe5kcve/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DI3JGvyJ+5LJtmdPt7y2yp+totO/qa1cL75cv2Ak8WPmPf843HK0gctzoViAYtyW19V8SrM17Eies4IdCOR7rtdGOAo4I8R1HAS0CXQ2gU2qGb+XN2XEBmf9VZpSkNG5qdh07LExxgVWbvSwMfPkwnBiAmVvAAEORvobaBLz8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9h6Fnx9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6eff5f6fe07so6649997b3.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 06:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734619904; x=1735224704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YNZFl+CkOzY78FQ2XaSXdBP1P0COPu8ygIu/l+vv/E=;
        b=Z9h6Fnx9vol9scUsujKwN+/01YtBJb4UKQsNsRWUmagGxW/QgNEzkVazveTkq1wHLW
         Pqgl+Cl4/SstCNfU8zpktO4J20AHgOE+INs7K6CEmXQd3PVb1YE/dt/Ky1sMZg3Omf8K
         tqsXAYKRdS8/vtMkhEQz2YqS84gs6EVi/DUaMWIsYvSW+DsPYKYJrZod6wOk+f8DN284
         wOOACX/gZ8vbvDf1C8nSeyh/QXPRgQFLJ8tGQTVA8e78c6z7Y3yfB+gidB6CQKbadpRu
         22t7PzmATEGbFEn050lDbqrv3HfDu7VD/2VI6VzkpJVEdG3+1aFETggn3+MrGt7k47mY
         +dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619904; x=1735224704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YNZFl+CkOzY78FQ2XaSXdBP1P0COPu8ygIu/l+vv/E=;
        b=lXJLmEiIMHXNc3FIMItDmQtZ3Ozz3Ms80oU5wI0bi0n+EIu0goDXVS8/rqaQPRCYW+
         XlFE5xHJ3cVtHQGdjw1iFVDmFPWZKQYBvBkyyRSBq9X/ng/2RxZXb7ENK2g5rF3FblFi
         0GAoDhJi+0WQRWgQXMlHWf7CLaNLcbodN77oFCH4DcWHf2RjxI6TtHh2cJuw3omhwvyJ
         6cXvYfi62bStfCtOLTk8o8+oW1EjHw7SjVMxe7NNK4QG0NEJDkYHkMg0gyAvZu5sSzkX
         QHwHKRE/5NUFBpi8TFygYfCKKKIPobY10W4XHNMuCMqznkoBSLH9Ei0GGmchjUWqISNo
         FnOA==
X-Forwarded-Encrypted: i=1; AJvYcCV5r3qz4EzjaOozgznXyjlScptAJGZSMdX2GrtdUU++cS4uHI8FOEqJuhYckG/uOiHEakYMg3QNbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRHAb0FfCekbbV0jLoJWPq6nidWmbv1ovE5XzCYXIzBU2MCqK
	tf+kVz7SZDdrYkx+AXrAPk0W5ZJSIPDm52pxp0REimXmdegvoDC1EaSYxNUYlJbJ0wWAsHLR/mc
	/inxJPdJqIL6OaaMkp2ynvPrh+VekaaRSEL4rzA==
X-Gm-Gg: ASbGncsXm6CGShjVXEjQyHf81LMo3QzSPWZUFGSM7lQZISKr3b8kA61gVrHAzWursZC
	d5yt8PEKU+d5OnzKG0W5aSY88JQfjixzMk3eu1qI=
X-Google-Smtp-Source: AGHT+IFK/gEgpLN2E0ozEAL/Yy8nn+29xIvC5r5LsMVaLLm5aza5ZgUhVGiZGHTeXXSypH554QJtd74V83hLFNTxUcM=
X-Received: by 2002:a05:690c:8b81:b0:6e2:b262:bebc with SMTP id
 00721157ae682-6f3e2941ea3mr21840917b3.0.1734619904133; Thu, 19 Dec 2024
 06:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215030159.1526624-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241215030159.1526624-1-joe@pf.is.s.u-tokyo.ac.jp>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Dec 2024 15:51:08 +0100
Message-ID: <CAPDyKFq3vxqwwVnSXpfFD4vsEiZU0tpRuKT-qP76OCt4bXPaXA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpcv2: fix an OF node reference leak in imx_gpcv2_probe()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Dec 2024 at 04:02, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp> wrote:
>
> imx_gpcv2_probe() leaks an OF node reference obtained by
> of_get_child_by_name(). Fix it by declaring the device node with the
> __free(device_node) cleanup construct.
>
> This bug was found by an experimental static analysis tool that I am
> developing.
>
> Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/gpcv2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index e67ecf99ef84..9bdb80fd7210 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -1458,12 +1458,12 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
>                 .max_register   = SZ_4K,
>         };
>         struct device *dev = &pdev->dev;
> -       struct device_node *pgc_np;
> +       struct device_node *pgc_np __free(device_node) =
> +               of_get_child_by_name(dev->of_node, "pgc");
>         struct regmap *regmap;
>         void __iomem *base;
>         int ret;
>
> -       pgc_np = of_get_child_by_name(dev->of_node, "pgc");
>         if (!pgc_np) {
>                 dev_err(dev, "No power domains specified in DT\n");
>                 return -EINVAL;
> --
> 2.34.1
>

