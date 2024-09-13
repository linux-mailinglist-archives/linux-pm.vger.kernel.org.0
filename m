Return-Path: <linux-pm+bounces-14145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76235977F29
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 14:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B72A28835E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13261D933E;
	Fri, 13 Sep 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8kY6jXP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693871DA0EF
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228957; cv=none; b=fU3gnP8tK6mQbBLFLPOh4yG28jZK2VyzmjCRAPPafQX/2RnYQWbKvllNbNIhgqziPZdsANDQXzmoq8bYSo74F4BuFchmUinFlMDJsIyRgYF5kXbhBa/d4z8AZwUR2AQAYQX+HRyih2Fm9utkSFpxanR/j0MNtCUOZhL9VdwxYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228957; c=relaxed/simple;
	bh=QvE2TVXQ6W2C7ymRczabrWiqSouQpIkgqhi84ilDeZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klCsWM0O09R2eQ47YTEPXN6uIY5r3/zNmPNVZy1GmeFlmC2/fcqcExZVmRGZjfZ+RafuzWBIzNZ2pooXoO82k8oS1MELy3XB/ViuQQkxbyZCYNJOZD7qkT/SuFxoEJQTcBzHR/K3M9Lon9r/KN8T8QUyf2WGjxaedCe/nCbsdTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L8kY6jXP; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6db20e22c85so17051887b3.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228955; x=1726833755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcAm2/IOLoHziP4KJeQzrLPo6iRoaonV073IWS+KZ98=;
        b=L8kY6jXPPqySGBh57Ab3JMVpqcjcwYs5Xs8Fli2rh14lmRYf5pXOVIJdQayQX2Fpfl
         s3QefQskfiV45gycNEdmDm5VyWLUcMu37YN/XvxE8lGVrZvuhWHLrWUR9C75gYEkhWxj
         EHBMwgO7bthE3V4g+APzy3eoa5k66VvCdNzIwvTbPekGbJwsEQnN2Isj5bexbyK9GB4B
         p/vhoqZrMJP3aT4QFojxmd9QbeqgYp1E9b2ck+dxrR2PczUzrz8wXzJJ7oB7YzPRQ2u0
         dzyIp8x22TvEG3ujXh91xMiXtTTu9PQrZDS2GZQ60X097wAo8QEDjCWoTLqaSODVVNos
         fhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228955; x=1726833755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcAm2/IOLoHziP4KJeQzrLPo6iRoaonV073IWS+KZ98=;
        b=dH7CHf1JSB1nUYO+sILSQ14V1rD2XGN3L90GVcGhw6mdJsnsgh/b3/SFaqd6n5XE3A
         DHdcj05Ct7pZ7hts7raBpF0nAKZikrHW2qMBiKgybznYbyrmNeE8t5K+wlMroIP6FJHn
         SZlv7sk56aT0h9NkPMxHIDZFX2vcbdBTZJbDxX+i+9gLv1TN7z+s4/HxbEc4mnAHQjCd
         b9h6iTqhdo7Ly+4NmGpjG+8TPEFV8IXNMGZEKpVbnFd1j7iJrTd5iNl7e0wCp4xIZq8H
         m7iv2MA4GlL+Z/8lOJxg1VB6ggSGrD3lGlWzz29WP+yHMN1kIs9l9sP20yQAizanmWNf
         NmXg==
X-Forwarded-Encrypted: i=1; AJvYcCUAgZALOiYlqEhVTh254FnaHMkWiW/YX1xg1lmURmHBCrJYHgfquexqVb0OpvXyMISkhEPbJKFCbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TwcsDWi+uTrQ1oP/wF7bsH/g/owCkEfJ1xncDkpOwQXfl7O3
	ydH/l1niG55JZUELTaQ6HVCwJpcgwLkfYDlOSGvpfSfy2GuqKtYJfP2YT/60LcpHEheREwgQeh8
	QFJ15aGOWJOxNFL0f0lk0RR5O6urgk7Uh+nBWFd5M3jqxuXGX
X-Google-Smtp-Source: AGHT+IHiP9b6dJV25d/Htzen2O7catAWENjnMqHmAX2mIxCvI/j2Vrccz+v9rt8y3xny5gEO6++hJXVM9Bd8jPS8hus=
X-Received: by 2002:a05:690c:6683:b0:6db:d572:aa7d with SMTP id
 00721157ae682-6dbd572ae48mr7812527b3.19.1726228955300; Fri, 13 Sep 2024
 05:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:01:59 +0200
Message-ID: <CAPDyKFohY+p8c9R3M82jcGrRxEA6V6fGyOUBz6ABMQQjyxKBzw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: Simplify dropping OF node reference
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Aug 2024 at 20:31, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Drop OF node reference immediately after using it in
> syscon_node_to_regmap(), which is both simpler and typical/expected
> code pattern.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 64b4d7120d83..5ee7efbd2ef8 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -716,12 +716,11 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>                                 goto err_unprepare_clocks;
>                         }
>                         pd->qos_regmap[j] = syscon_node_to_regmap(qos_node);
> +                       of_node_put(qos_node);
>                         if (IS_ERR(pd->qos_regmap[j])) {
>                                 error = -ENODEV;
> -                               of_node_put(qos_node);
>                                 goto err_unprepare_clocks;
>                         }
> -                       of_node_put(qos_node);
>                 }
>         }
>
> --
> 2.43.0
>

