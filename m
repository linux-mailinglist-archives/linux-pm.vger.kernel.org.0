Return-Path: <linux-pm+bounces-5913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FEF898556
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 12:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10F41C22F8C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA82757E5;
	Thu,  4 Apr 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gN/cpNZt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3679F3
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227626; cv=none; b=lUZ6CdExEEeFZ6bA1WfghXseA/2GPBnacre1jltM4ytoIi6ptWuQEOJDgYdZ03fIItFBvo7rzBYzOp5EO/jr4iNRcfw4Lg92mv3qhsb9m6Y0F5LAZUPjpnMALCkGJ3x54sY6zfajZuVZ7tAEyiHfVU/I6QwLZiDAC6yhYBWGEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227626; c=relaxed/simple;
	bh=c01EuYyZ3SiHskwBzOJ+kOOtzarjS+3wqSXsqxO128w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbKDMZg0FOFbSNYgj62V6aPn+94rJWKKQIKJOAfr+y6UkEItlLjVAvKYur/qw4Lf4kvAbMT+8yjmERVF/iYEoTxLRpUFQb0AW0UI8kqDeyku2xVasY6Gj1OTzOZAPU7HrLh2UtGZYX2zkon6nHeg0r+bY5JYmNfNaHWopOTC0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gN/cpNZt; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed0710c74so780596276.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 03:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712227623; x=1712832423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0OLGHTxDGXllhjSVr+wpHbh0zVlIAwon7mEvnonKBt0=;
        b=gN/cpNZt1xzI5Qt7W9riUkBX2lF/5yY2zwiavdC9N2C/pKG220qmZMxbcTR2NK276r
         QwX0iA2XAHbA9F8/v0PvqlJrvx7a4Pf+cllw7jPFlx7qFG+TQk0bEh8d7HKrNU5ApcKd
         JkT80C9o/mlKG/hCZP1CffGSvI1cX97pvVT4hpQj/JhdAxj3eEZDbqk1T+nyUmgNESW2
         0pO0g9ay0GjvxiqbG2aUnB3ep2a10JO+mHO0XwBrbOYPCjRP+DIxABlmhZD2Zke0uFQ4
         J8g/CoB8SUp9hgP/JZAUNRwhaKqwPIVh6+OQcn6mM/h2cq+cNQK3BrbAp7DIpciT+BqL
         nDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712227623; x=1712832423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OLGHTxDGXllhjSVr+wpHbh0zVlIAwon7mEvnonKBt0=;
        b=FKE0OHOGZoHQAisAlx6qFcii4UdjZG8+J35FYuBuwg3jGuc53Jig+b4raOG+l6KALQ
         9W4HTiej1o1+C1mZ941z8UTQ40MzuQfsu15O3YVKSE4kWgxOhRSMDWd+3EVUvKi+TBpJ
         2Pu1BnaHwf2Xu8hqapluapBvwDl2IJESDf2WuseHo6+Wc61tpLaJiiH46yS6Yp5DETis
         z2L/zpsUUI56tKkpkT2Ba4uM5A2wRDu6U9wwQNQDNh2wECVCm4wjIg2cX2zcksRemKHf
         jvGh4646CR1H2mN0ITE9Ekcrjb01+6O0/cd2MCmhyo4cWjMOmCpAaWHHt39NZT+1R0eA
         UApQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDtoXtvsBbeKLYjUmW5w6l6Y6CWN0ZoEeIkzwEcLGT2xirULfmO1m9D5Bn8zieJVv+Z8zQdvkUKWDNfKvhprnsRcxhs0GHCss=
X-Gm-Message-State: AOJu0YwwIaDs5ei7jcXDz/oyV8YjGymGRtPL1pNfS+QWqaZnNB/mY/Fz
	sDHvTY8CDV6Y57rcwEgv8iZAX2wrM/WCcArwzMFFl3x6xn7BlpFaYd9vi5rD4oEDHgReoZph5Om
	Rtw0YbCG3B/3knT8NNJw4jKX35VpQANm6P17saQ==
X-Google-Smtp-Source: AGHT+IHb2ngWJuGXnRgC7Jjqe2VL15KZSHlCl5aI2amVAv9f9Jw4owxwUzrf1g3jQ6SJX9boCj6Pb0Kb6Mg+LWoz51E=
X-Received: by 2002:a25:d045:0:b0:dc7:4b0a:589 with SMTP id
 h66-20020a25d045000000b00dc74b0a0589mr2041087ybg.55.1712227623549; Thu, 04
 Apr 2024 03:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330211036.100956-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240330211036.100956-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 12:46:27 +0200
Message-ID: <CAPDyKFoWO+xUsOb0xDge62kNYu9v18eWBAZ=RgLjWJsgvqMWtQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: scpsys: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 22:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-scpsys.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
> index 59a7a8c261ed..1a80c1537a43 100644
> --- a/drivers/pmdomain/mediatek/mtk-scpsys.c
> +++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
> @@ -1138,7 +1138,6 @@ static struct platform_driver scpsys_drv = {
>         .driver = {
>                 .name = "mtk-scpsys",
>                 .suppress_bind_attrs = true,
> -               .owner = THIS_MODULE,
>                 .of_match_table = of_scpsys_match_tbl,
>         },
>  };
> --
> 2.34.1
>

