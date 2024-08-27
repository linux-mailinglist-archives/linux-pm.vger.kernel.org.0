Return-Path: <linux-pm+bounces-12957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7DA96083E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 13:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D9D1C229AC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA7A19F489;
	Tue, 27 Aug 2024 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zafcZuJP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD819F478
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757154; cv=none; b=Vfk4oDMiLPoysIXJrBZReDb9dehChkOzqxsMsDzeIE8vwdYJe8JWIuIdhILeuddlifhReFDhDaJeFPCYhcUBoqnB/+FYKg4hW7to81ZBQ7sQIr980Ymb2K3r1mjl2mTCytcZNNnQoJAR+R3sMxfuy+mfRdqxLCiWlY3V/znv8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757154; c=relaxed/simple;
	bh=+AWoCTjPb2CystHVpVBEd1kzDuWM5n/IGJW+B+ZCYBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMYE+ghmjyCMzVD9njr3wSaFuOFJhO4Lefetgcev49I2VnI0kDnYMAQz3PBp2N3onCkuS09FtZlVBJRMcW48WMkDOEAgNtrdXKYTxR2x/DM3wCgmF7rzo1pTAqgJAp+sysLF2S9k5BKgIR1+Fejai8LCHD9qN926+guseBwUm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zafcZuJP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso7728005e9.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 04:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724757151; x=1725361951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YmzUy7ewCiE5ahSeQMfQbeT1WUf5DWvLVzA+AXLyYSM=;
        b=zafcZuJPDAW5h1vXegaI34gLY49qIy3etckLzhroRIOQHIzoktlJT7C81WIOgO6J9v
         YV1JHiN0TWrjryBNqIBSiRisnabhjGbDRcMF0tNGnTRGdpxW9h/OHUex1S8ItQlyE4vA
         JfdiS5aJc0p8uyLM6IiurM0kpQ+z/BIeYINrDNfYpxocXerjtw2oN8ZAMR9dj7/hK3JS
         MImFnF2pmZzxu5Ij2DBkX5bXUrJNjKtffbFkssHCUfcgDe13HGPknKYybQ75RwthulIk
         2eJZCZmUXaiItmCznkJd9P9nHvj/IRfCZHFdvI4H1NnzjuXL+SrJwGLKrIk743Z0h+nJ
         qMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724757151; x=1725361951;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmzUy7ewCiE5ahSeQMfQbeT1WUf5DWvLVzA+AXLyYSM=;
        b=AOuJUVwZIksBGgRzHs+Kzr0I5h9jqOcgVC66dffnUuBDAhMJvRpCwUUG5nb7e3tmF2
         IEIVY9Xw6FRFGyrtY58BPska+MQPsdZiERdTZ6kaN4yeIAQg2ifDXyVY3jU81Zp1Ommh
         n/0LIyTARZeUrhNrAFJHbLXqCr5LkeTAi3aeZA34iyD4i1oPvl90mCLOtfTdBhPr1cqk
         MLWJwaMCBpdyWHNRjEYUEsB3u7jM1r3cWfG4y4bazTr/5cMY8kURZNhVVCsQ6q10hzKm
         hP8i1iWkm2am9QFQSGia5Rrwd6K4wgdfvc0n5wMNpaiheU6/6KYHJ7WhIQfl1ggkFcgb
         7hJA==
X-Forwarded-Encrypted: i=1; AJvYcCXWlIdWU+AA05ydw39zivPn6NilaCOnLssYy7hC3jUycz/u2mT1TrWZ8NExCRfHmTQSXn10/IokZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45OTtVAL7aIjqJsResnLk5q7YqmFF5g/We9/obJAFA5Mdrs3p
	UMdCF3rmWEiW40NmspkHS9Wo3lPIvNW3wZVppmAHKzHxFhoLwqXBIGl1iTXONQE=
X-Google-Smtp-Source: AGHT+IGA0k36jmgdDgFx0Lv0AZJvjz53dblzhFbQSKezrBZpuUFwtlx0XfcTnR8u7R18varpMaDufQ==
X-Received: by 2002:a05:600c:5118:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42acc8dca6dmr57506595e9.2.1724757150715;
        Tue, 27 Aug 2024 04:12:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86da6sm215978635e9.17.2024.08.27.04.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 04:12:30 -0700 (PDT)
Message-ID: <a20a940a-2d81-465a-8c26-9a7f09a5d477@linaro.org>
Date: Tue, 27 Aug 2024 13:12:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] pmdomain: renesas: rcar-gen4-sysc: Use scoped
 device node handling to simplify error paths
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
 <20240823-cleanup-h-guard-pm-domain-v1-9-8320722eaf39@linaro.org>
 <CAMuHMdV0R0+u1eCiUOHhL5w-wzge9KhgyumJSd28oF9kQmnx_Q@mail.gmail.com>
 <a48f1a0b-0e20-4782-bf6b-c430da9ae391@linaro.org>
 <58f5d332-2f2a-4607-9662-e71fd23b1316@linaro.org>
 <CAMuHMdUQ5AD1QoO5F1nAy+GJoGtbi2ztKfK=2buU1MNeO8etJw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMuHMdUQ5AD1QoO5F1nAy+GJoGtbi2ztKfK=2buU1MNeO8etJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2024 12:55, Geert Uytterhoeven wrote:
> 
> So it's perfectly fine to have:
> 
>     static int __init rcar_gen4_sysc_pd_init(void)
>     {
>             struct device_node *np __free(device_node) = NULL;
>             struct rcar_gen4_pm_domains *domains;
>             const struct rcar_gen4_sysc_info *info;
>             const struct of_device_id *match;
>             void __iomem *base;
>             unsigned int i;
>             int error;
> 
>             np = of_find_matching_node_and_match(NULL,
> rcar_gen4_sysc_matches, &match);
>             if (!np)
>                     return -ENODEV;
> 
>             ...
>     }

It is not perfectly fine because it does not match the preference of
having declaration with the constructor. See responses from Linus.

> 
> But my first suggestion:
> 
>     static int __init rcar_gen4_sysc_pd_init(void)
>     {
>             struct device_node *np __free(device_node) =
>                     of_find_matching_node_and_match(NULL,
> rcar_gen4_sysc_matches, &match);
>             struct rcar_gen4_pm_domains *domains;
>             const struct rcar_gen4_sysc_info *info;
>             const struct of_device_id *match;
>             void __iomem *base;
>             unsigned int i;
>             int error;
> 
>             if (!np)
>                     return -ENODEV;
> 
>             ...
>     }
> 
> is safer w.r.t. to future modification.

Indeed, sure, I will re-write it above.



Best regards,
Krzysztof


