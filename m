Return-Path: <linux-pm+bounces-14144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9167B977F28
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 14:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4671F23153
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E9D1DA11A;
	Fri, 13 Sep 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVBUjM0x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6B1DA10E
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228953; cv=none; b=UuGs60PNzlOhEG7ihXarvfbvbXBxN4X83gERDtUHsFhpg5fJnb0a7b3PKXhNOH+2dlUkUqZ99Nh6oOF7D6Xx+2mE3JGE69HpGoZEWi7L7GRcAQh8TmKsMfPmQNy4lvADBqpnJVVHK7bNN+FCWPXOD67WeGJBLMDD1VH00cRwG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228953; c=relaxed/simple;
	bh=mHUpQ2YTBppGi/Y8Y6E0ZLBWe1Fol+OjH92MPUBAM7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEb393+kXxrHs7krZm6rSSIAkQ/cPZvVYiRm4fUB2sqZWDu8RGIaqKEXOeBhW90zwj2t3GsnhZXaacdFFP9djOTNXo87qV2uyfGPhkUmBDEHkUyZsEjP9FIKfnotaVKE0a4eGrdpOsmmyeU/jbxOWyve1SKlEe7alEnjDW8kbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVBUjM0x; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6d6a3ab427aso15787847b3.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228951; x=1726833751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zVpICAxbAun/Z86wk5H+tZRi+f2zjk20FqIxJDRTlCY=;
        b=MVBUjM0xGuPXQO0FUxcFALIbJpWf+8svZr/KTC6QZ4KTXsFZW3gW+YAoS8rryRrwFA
         T5CVWKKYsXKb6PmwXkYTSZ+PJ4IuFLbaEQIrjhzBRGuC0V+RrUIVHdgFm7WC4CJSWwSS
         qLhSF4iFaJ74sDy5CzqSgwhXE2ShWmR5aRnr1KorMMyev0D8kHA6Ou+zEbd+CU20y02Z
         P9Y4P7QxWhMw8mnRy2aMG45bGDIdjZ26J5bT80Go0Z9iog9yMPkgruda5W/VzkiIIJqF
         oBPxaPiz9Larehbacvy5yHyGkHSePvYu59ohql1+LBMA8Zc+79wi/eqUdEXizcaySy+q
         Lgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228951; x=1726833751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVpICAxbAun/Z86wk5H+tZRi+f2zjk20FqIxJDRTlCY=;
        b=bUQVFIa7URjEEG/wXvvna4CdgKCvv1UlSaGu20aJEC9uB7Pt/Z7DOihKN2/S2wsWMk
         0uc3I7+/iaSzLhpb2QyPsJVx78r07bYjXGNcIDm1TePOkjM6/Hs6arwnUwe7cVgcQ9Kz
         UQcG5JiKuj6oH8eLLIxSfEZyAy8I1u+/3c0BCcSAZ54zZoVlZZ+nH2FjWSvdnEfTHJTL
         sjJqCIRqjyM8qjc/nlNnG5w/IUiTs1DXIMAe3H/JswB7VBDh11KF6g0ODdSDLdXWo7kM
         jL3qqec4M9ewTEmiNu6ighmzSnaariysXPRcKJXo+aQ4pUAS7dARQoq2+VxZCuQo7Oxl
         CSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzVq4R5V1/i3QjRSCrtkFxyn1mwcz+wsij0P7QROitZXOuGWY0s4leFNDTUFCxgAjXET//TVHF8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyozao/d0M6a/BwakwbvpgYT63bSZhQtoMy/QFP4PpthzR30e1l
	alnWc9LC+TSysjiG6w5RTQkk+R1NAvQ4Hal2nuNfamBeFbDh6mJgJrfrDos+Cjlib522vRqlSEr
	yfD61ZSfk428AqpbxbH3Z+Q+P3nosBszTRqxTSw==
X-Google-Smtp-Source: AGHT+IGXoMXQAwpn2Ow05AMk5gmTy19hcKor5+jT+80wySjeRS1y7hnBDOOxnb0xBEgQdVhR8e9tNlcK+rkTo9yNS68=
X-Received: by 2002:a05:690c:4a02:b0:6b5:916d:597 with SMTP id
 00721157ae682-6dbb6b236d4mr57262927b3.22.1726228951054; Fri, 13 Sep 2024
 05:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828121230.3696315-1-lihongbo22@huawei.com>
In-Reply-To: <20240828121230.3696315-1-lihongbo22@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:01:55 +0200
Message-ID: <CAPDyKFoy_5qHANFOoQGk0hvHOMrWiOp4p4aqpUTWyAFWiJdh4Q@mail.gmail.com>
Subject: Re: [PATCH -next] pmdomain: mediatek: make use of dev_err_cast_probe()
To: Hongbo Li <lihongbo22@huawei.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2024 at 14:04, Hongbo Li <lihongbo22@huawei.com> wrote:
>
> Using dev_err_cast_probe() to simplify the code.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index e274e3315fe7..88406e9ac63c 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -398,12 +398,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>                 scpsys->dev->of_node = node;
>                 pd->supply = devm_regulator_get(scpsys->dev, "domain");
>                 scpsys->dev->of_node = root_node;
> -               if (IS_ERR(pd->supply)) {
> -                       dev_err_probe(scpsys->dev, PTR_ERR(pd->supply),
> +               if (IS_ERR(pd->supply))
> +                       return dev_err_cast_probe(scpsys->dev, pd->supply,
>                                       "%pOF: failed to get power supply.\n",
>                                       node);
> -                       return ERR_CAST(pd->supply);
> -               }
>         }
>
>         pd->infracfg = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg");
> --
> 2.34.1
>

