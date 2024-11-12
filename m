Return-Path: <linux-pm+bounces-17440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB6D9C6010
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 19:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE07B3E650
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45804205AAA;
	Tue, 12 Nov 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlSkjZl+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700620515E
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427031; cv=none; b=GBBwJ5y3zNvSL8Kp35Wwx0fJkDkN4RZe5Daylx5/Jv+96UaroGYWl4YqLzBCyw7sOiUA7Cpg4aDClWXtM3AUQmUgOsHgrnm7blgeVDVet4tKlgefONNP+eApXcwi5JPSkPPBjXxak2Ap0+gt22IMpWrEgwFgbMnHjS999nurTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427031; c=relaxed/simple;
	bh=7T1EWpUdFVknKbZI8QiuRaCYoZtqqd0I+lPaOsqrczk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh/XXdEDtL/QB2Maf4upTsvh3tdIbqwVzGMCGq4ueup297+n6+ReLbDK2TbYl5BWNuqAGUDgeJCbrEmaGHi+W7jH5F7SHo+jhWYnLIBqQUVh3w2ZTNdYA2tW7kn4S0rhBimIXWuTTP56XJXHPtAlzgndLfk4kKaFOFh9CBK+7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JlSkjZl+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ea50585bf2so57156187b3.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427028; x=1732031828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wBk1KBzwEOHZKuHnC3LcVYLaBvifyeSlS2dX2zuDsKo=;
        b=JlSkjZl+lcABpzV2c2qb0SI35Ttlj6sWwim6B5osCcSbqVx49rDmt73hXQ2UHcQfIj
         Zm6bQU8t2ywTS9AuE9WfvxKYVf7YzdSQBBg56zfBPpFFyjcmuTQEkxhdereSvkZmWD39
         x5MvGoBHAPYKsIz/G3+CEEw0GnQhN2PkFJZpoOlu8GAD8tsJxO77iHkdQSkxvSL4DH8J
         CsNPvCTc72BcZ118c/RBMfw5HvBEaSj2IHakzv16NQhzH8XfeRep3BWNq31wewiEXRt0
         xHpHf0wYgy4tcNYig3g9YBcepuIswHOGng1kZBhixtlc2nNOA44571rXkTMfpOOTcRaK
         bHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427028; x=1732031828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBk1KBzwEOHZKuHnC3LcVYLaBvifyeSlS2dX2zuDsKo=;
        b=BKIc8gBg3T5sd68y813MdAa8hoLRzcnlrFv43M250zgex/+d5JjagLN/UrzllUltEQ
         Yxjs7qfxLJrB+6hsdLJ03EEyEKUc6vOzooW2mXqpkn6G7/X6iq/dPpZwmjEGlTecSNU3
         Ex/QjkXBlUd3IHJNwQ7+bPTqvp5SOeBWtI1WFXPimKte4JIPFUzbxFgCK3VeKY8NHIs+
         wmhtWPibk82lgVnZj9lhKxLX1XxSMFXV3WH8oWz+T2MrFO4WFdWWvVdveO0q96afuebR
         IzKX9lJv/P2iboR0Z8O3NMPBOPBqRKwPO/oFtFFWFrQqAfnrzr3k7lrMdQHTvFy1TPu0
         A6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHDqMEvrjpbzHFvyQqlT7F3Q12pSlmg7lnb01uL9Crkij5mN0KqS+s0e5IA+3Ei7XKAI5jF9v7VA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2G8Zlddbqbv0mJXUIz/JwZDcitUcS0QwgaCUCdceDNgtA0C17
	3A34mHr2PSxI7xzdyitSek1Kckk1lLsTKwkBfZ+ZCc9grJh+I1qv0qNSZ/zZ5rV5ZNuyxoddQlM
	ub2g+++F1OSRqNeEtBgJpCojpWKScKlOt/ZsZZQ==
X-Google-Smtp-Source: AGHT+IEbIXuO/FqYjARrZep3wROIZJT+00STOjU9kzztmEI5hpPneiVqw/DMdVTNmBDXF4I7LbrGsgy3l8sZTRamFzM=
X-Received: by 2002:a05:690c:700e:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-6eadddbcfd8mr154933787b3.20.1731427028254; Tue, 12 Nov 2024
 07:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104190742.276710-1-robh@kernel.org>
In-Reply-To: <20241104190742.276710-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 16:56:31 +0100
Message-ID: <CAPDyKFreU6wVnsOwz9nstiQ=0sSKN=xtGOaqotwES5UByxQeKw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: Use of_property_present() for non-boolean properties
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 20:07, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/gpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 80a4dcc77199..fbb4c90b72c4 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -411,7 +411,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
>         pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
>
>         /* bail out if DT too old and doesn't provide the necessary info */
> -       if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
> +       if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
>             !pgc_node)
>                 return 0;
>
> @@ -511,7 +511,7 @@ static void imx_gpc_remove(struct platform_device *pdev)
>         pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
>
>         /* bail out if DT too old and doesn't provide the necessary info */
> -       if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
> +       if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
>             !pgc_node)
>                 return;
>
> --
> 2.45.2
>

