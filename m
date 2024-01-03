Return-Path: <linux-pm+bounces-1779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1CE822D95
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 13:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC68B222FE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F711944F;
	Wed,  3 Jan 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOnw9bNd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA511944C
	for <linux-pm@vger.kernel.org>; Wed,  3 Jan 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbd73620c82so6752322276.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jan 2024 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704286478; x=1704891278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pOGNoa+uoP67gG3C3OdO7eu3hZWCRo+rAfnDqGQ6OWk=;
        b=cOnw9bNdlSS3KGMy113cvsKHQg220lVPEWJP/CZ7zG7S+/DxwKnQUPhjSflJmYpQaW
         sPB3bi3+/OIPqpGVpyBpXZ0t+seoM1IALVU9tFE1ikGEhabSNlc8n8qxiV5nL4ThcCEk
         5BN2jEM5EajpBRzTJIF6+Tex9JcFcZV7OHdKxF56cwGznan4RfKRwlds2/r034FvdHvY
         n1zk2S9R4vrvHiNIIYPl1eSnngSUPg1PBoZXsQXHTzCEE4IhuBQqrK+Lf5ninxygGTgr
         bQQDQFHfEzCXZcsd1b5mxViC5gCkavQ1VWjmSCP+Ggj44tRQkrQYjSNtoTEyZWp013P5
         nYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286478; x=1704891278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOGNoa+uoP67gG3C3OdO7eu3hZWCRo+rAfnDqGQ6OWk=;
        b=LrKysMF3ynN92iSd8EcM5iMMGKgUVDVZi2KsTLGDnKxodpQgo7BnKAj/75lEGlxZqx
         m1hpg0vP6Uis/t1zKfrD+cwGyILMIrmi57NDoE7MHlD6YeKgErJc/PGtNCzdM+xptfI0
         hCnJk/VSpHBXD7nfHj9vxj+b63UwTzE4rV6idNj3xBdwuNGgwFmTZ9VXhyr9NMYQBqLL
         iK8yEu9r6gWkweqlQhvtA52OgDJCZtTjz3fLcqudD7MsfsdRBMHhkBbXHteVTH3Ua+iO
         2/n9KZ8/kCdURxcLLbryGPyVqVrV/WyPmiiPbmFlm0XzoGljjtWUFOWSexHlzDzWLyTc
         dnPg==
X-Gm-Message-State: AOJu0YyYdE6LT4j7CK3u9FJwvy7KYUzpbJHw43Qa8pIC34JRHj3htkNg
	Y1PZr8DY243gbVioIpevb9a75tyiEJtFmEANTuGdgTFu2rKAWw==
X-Google-Smtp-Source: AGHT+IEixB+WBNhbDXVIfjA3/lNv5WlNF7f1gcgq06js9K5QExKPJiNz8iPEs2JGsGvCguUuLd4AYEFxFy6bIiDoz20=
X-Received: by 2002:a25:d245:0:b0:dbc:f8ff:c7d7 with SMTP id
 j66-20020a25d245000000b00dbcf8ffc7d7mr9690250ybg.37.1704286478608; Wed, 03
 Jan 2024 04:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com> <20231220-sa8295p-gpu-v2-4-4763246b72c0@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v2-4-4763246b72c0@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Jan 2024 13:54:02 +0100
Message-ID: <CAPDyKFoD-+2q4sDZL3J-2a2kGUmBXpUc6vj8zxzaO72O_Ksj7g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] soc: qcom: rpmhpd: Drop SA8540P gfx.lvl
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Dec 2023 at 05:39, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> On SA8295P and SA8540P gfx.lvl is not provdied by rpmh, but rather is
> handled by an external regulator (max20411). Drop gfx.lvl from the list
> of power-domains exposed on this platform.
>
> Fixes: f68f1cb3437d ("soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

I guess it's easier if you funnel this through the soc tree - or you
prefer if I take it through my pmdomain tree?

No matter what, feel free to add:
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index 3078896b1300..27a73ff72614 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -217,7 +217,6 @@ static struct rpmhpd *sa8540p_rpmhpds[] = {
>         [SC8280XP_CX] = &cx,
>         [SC8280XP_CX_AO] = &cx_ao,
>         [SC8280XP_EBI] = &ebi,
> -       [SC8280XP_GFX] = &gfx,
>         [SC8280XP_LCX] = &lcx,
>         [SC8280XP_LMX] = &lmx,
>         [SC8280XP_MMCX] = &mmcx,
>
> --
> 2.25.1
>

