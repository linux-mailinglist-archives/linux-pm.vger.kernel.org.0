Return-Path: <linux-pm+bounces-26140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A2A9B4C8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED5B7B6A70
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947FB28DEE5;
	Thu, 24 Apr 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2BQCgHP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E302820D2
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513873; cv=none; b=IuEzHPnqJYDtCDNM/jDbY2rB1Ill2MaH6gtS9zXDUEiOwG+A3orNE0xKLE836xgwz0H2LTnK0tEJu08nhxkcbNn1n40jTy29VZhKKYUkZvKIAP+HddfdBswC6opA3JA4PmYINaobXCeq918AlCL1ZfejkGDQrDN+RS5IARhRDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513873; c=relaxed/simple;
	bh=hksVtKaRPTFtu43/2eBbm7KR05otSNcnbJ3cGqB6teM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0cwvgwUGzkXwdYEWLFKmVhfZavKSGVEZNOw/39Ik2iNGpmd3fcjnbfz16aX/UR1YMd+4ZiydafkJCEhOxG2k+SgE6ZtqGeu01pknbFC6ZHAg3dm/v4yD3Lm7cbEgJ0xBeOfI/a+9GdHFrXw3tObRNgp+pLmWeYfNWRHTjvheFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q2BQCgHP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-707d3c12574so11441517b3.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745513871; x=1746118671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4UWBOqT9BQ7cJ0Q+cVJ9EImaxIc5GHy8LlSBjL9UleE=;
        b=q2BQCgHPet3D5DAzEEeCI+Nw5W2kzsBWuGGDCV9y8Lyz/MSu4G+lyQuXk7MDTBgtLM
         1MoIH44Pq7kAnKm2oDITkTAazp60JAiQ/HMxIj4dFCSe3al397BB8It4ypyq1qZLanTo
         c6meVDqR1rt/J7/ghigkjuClobQRLz8iPXtFtbYHHU1mOzuTYgwRGTOqVUXrpQZNbFNB
         +A8ZvspAEzlaCHyD8RdoGFQVZkEbpqrvL4nPCdj+D2z+Z1Zz5exh6J+9z/WedZNggG0O
         Id3zjUyvK25rG+1xcX9FCcaWR/xBeC+XuhrxrLTY9UHqpq/XL8BSBGDgI5RrnacqBOb4
         7G4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513871; x=1746118671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UWBOqT9BQ7cJ0Q+cVJ9EImaxIc5GHy8LlSBjL9UleE=;
        b=o8WwExzUrLM0rHImg4VPsZ6EL5MZHAucbBddA3VDvpGO3vVX26EUUitaVuXhMcdHJ6
         XSrKMhsX6i7GCUYCfbgwB6XMju5SdpMvbsqscfS/Wrfi+ffCeOhVCg1BKh76ZO3J/taz
         cdIopano1IsFBmPIH5Io/mfTnuoQ4CQw1MRy57L11zOYCkInamK8x7ijRJrd4oDmYIbN
         i1OM1B4YvpcEXm9HmEvVJ6d7me8JRqk6ECA+DtzCoSy06nVJeU0xHQgIOz9pEic46TTM
         OdJAiFvMXeIARzuuuCwRUGTZjZUwvUooCX7tM+q6r4uLo6cuJNRQlcRKVQ5m6sXRxyrr
         RuCw==
X-Forwarded-Encrypted: i=1; AJvYcCV3OC4ZaXMlW1iB+nZ92oOegpesrf1OY2H/LBooIps9Diel/XJnKpGmedwlmvLPBCiq/us3GcX/6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9ryd35Nib1uDm/EhuAFgM+e1ejD341hGq0B34RqJblD1dooT
	nxA2Irs9wGGVEVZPYLwO0+75au6rxpqQGheUYpEOPbYNLgHwvxDj2My44xzxQZN0Z7rIBQc/53A
	KPp42Ot3hPB2UyHDvsBVKbiulDhagNGFHCiNQnw==
X-Gm-Gg: ASbGncuco6G/kUPvsbg4FiDGyDoNPYEdAp/qzRPTbfh5GoToQKp+8h1B7vXsfaxbpEs
	Uct3K+u5YOfaqMYaeh7CkYITLNKkyZY2ht+8Gq88rWPOihjP72llgYFdcRvvK8sO3uIXLUy8cU6
	vT4WKmV4HtZTob9ZDgPVH+4ds=
X-Google-Smtp-Source: AGHT+IGZwaRl4P1Wxhayc+MnVljOr11BOtHfrFEm1vQsUQMxHQizyhtv/7AFFv8NlJ5cAkU5O6MeCHOLGAaLO55RO0Y=
X-Received: by 2002:a05:690c:f8e:b0:6f9:c8d9:50f with SMTP id
 00721157ae682-70841872b65mr41237107b3.2.1745513870829; Thu, 24 Apr 2025
 09:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415190558.16354-1-wahrenst@gmx.net>
In-Reply-To: <20250415190558.16354-1-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 Apr 2025 18:57:14 +0200
X-Gm-Features: ATxdqUHxyVIHgxpL1J4W8JjxhWlMB9H1a8S4Aqg362aeLmyJrpLw1ILNYaKA04U
Message-ID: <CAPDyKFp+unkqOSwF5hh9dLe9Q1o0_dUPfOmfrmv52Dt6-aUoHw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Use devm_clk_get_optional
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
	bcm-kernel-feedback-list@broadcom.com, kernel-list@raspberrypi.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Apr 2025 at 21:07, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> The driver tries to implement optional clock handling with devm_clk_get.
> It treats all errors except EPROBE_DEFER as a missing clock, which is
> not correct. So use devm_clk_get_optional here and get the corner-cases
> right.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
> index d3cd816979ac..f5289fd184d0 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -506,18 +506,10 @@ bcm2835_init_power_domain(struct bcm2835_power *power,
>         struct device *dev = power->dev;
>         struct bcm2835_power_domain *dom = &power->domains[pd_xlate_index];
>
> -       dom->clk = devm_clk_get(dev->parent, name);
> -       if (IS_ERR(dom->clk)) {
> -               int ret = PTR_ERR(dom->clk);
> -
> -               if (ret == -EPROBE_DEFER)
> -                       return ret;
> -
> -               /* Some domains don't have a clk, so make sure that we
> -                * don't deref an error pointer later.
> -                */
> -               dom->clk = NULL;
> -       }
> +       dom->clk = devm_clk_get_optional(dev->parent, name);
> +       if (IS_ERR(dom->clk))
> +               return dev_err_probe(dev, PTR_ERR(dom->clk), "Failed to get clock %s\n",
> +                                                            name);
>
>         dom->base.name = name;
>         dom->base.flags = GENPD_FLAG_ACTIVE_WAKEUP;
> --
> 2.34.1
>

