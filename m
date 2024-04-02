Return-Path: <linux-pm+bounces-5801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C514B8950AF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 12:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBDB280F02
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549E60DE9;
	Tue,  2 Apr 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkVHyRKI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E65FDD3
	for <linux-pm@vger.kernel.org>; Tue,  2 Apr 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054909; cv=none; b=kVOfR2HhpTCNW/Ast24OG2lPSby4J49hKkguMxym3Cy7gv+IICKnM2KkptM9cy593JRduUku4wYGLJhyyuaCTBSvKKy8wD7vGHM5S7Fwpt/DdSSezOCSUysG/CGuU54y+Xh87629GYreAnyU2O9q0kOukckPW4ReCNq0hbZcovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054909; c=relaxed/simple;
	bh=3EyCUbtnMkP+cwjwavYDGusXVngaEoTsr1iaAdtpXeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUyoPJ4ZdG89sX+17i3WpwU9vCur8Vd6HO+sYxjBanaC5/1SKWUhHeaPz5HojIqBakSvV+5WhaVhjKPjNawLg30QAjKjZguvRwvHM0P7lOgjQoI2iV0gJ8zkJ1Q84F/HcL5Sfk51t9b79RTCn1674PbFYzOOtE3Gshhlj7UJK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkVHyRKI; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso3217872276.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Apr 2024 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054905; x=1712659705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mrrS39kMM3qSYmTTIfDrvL7v8BkqXr1H3y+hhGF7rb8=;
        b=UkVHyRKITqATKyKjfs/CiavGPEGleKdak8ohMaHk8LcaQEZm0bB8GoFjSkDpzNw59H
         bkwbp7u6lRoWskZq6B8SP3HRKuG6CX8pNjMF+Cbrp7rUCXaasn5WLzMGGQmnKiW7kshI
         lRLfnblVRm4pQ4PCg19qVY1KY0asC+oEZSr5Oe5QIjZ7zcEvFwenhsIMToXcHBhhrfch
         13aDuu5F/bIL2ppfSqIv3YwRe4rWn8CnrYw3yIQUVeQgzhteAkeJDXKMt256h/RV0Z0W
         SlpSNbCLR4qk7rEn0jsewuPEeIpj8Gi9bPIBiVrlkPIr+cBY5W8PyLkM8h0VXvD/ax+z
         x3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054905; x=1712659705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrrS39kMM3qSYmTTIfDrvL7v8BkqXr1H3y+hhGF7rb8=;
        b=gCpCxHF7OG7ckZlMgyUfKd3vQNL1D2dnZk4UMP/oFG4T5gCmpNC3VPOL6Bq7sUTevV
         1D01wHgL2j/CkU7L97g1YiLodYxx/JWHOvofACGBcoExDNRwRw9akOQ+AfKV7KvADQJi
         G4AZSVyc1OKUE0PNyl1uGn2wlOUeWguU1rw+ajPn8LSzcdylRLARZ3KouUjbuUjqtwSM
         W8jwGqdXZ3lyDe5q0Ejx/whLGkcBh84lCv1l60P0A8+ZQs4SJTos5SkFl8/NGcA82MF5
         jsD/ihq2uKMKCuz4QYgBWGspCLCxNF0GpKglALZnCf+1qFFdiTQ3iuGda4C+26UFpXIe
         kY4w==
X-Forwarded-Encrypted: i=1; AJvYcCW7oy54uPXJQElYJWodxTygID2xtSslI95Bctzj90r7NhsTVGsVmkpBVclNRhCdFTyJhK3tKus/Nco6SfXrBzkY41g5nFaQzps=
X-Gm-Message-State: AOJu0YwJmA656+yc1ksgvwJg+19dbSMK8N5jh/Hc89pO4HLKkD8FQbCR
	LBflITdHQKI4nY5AbHtOTmiqegSNEdvbzihDsoFssAr1Jn0ggdNigT1mI6fNZd3cfokVuMUjfhm
	Oj4yQFhWnxAIsiFd3EZ4leOVN5wzZHNCNwdNcWg==
X-Google-Smtp-Source: AGHT+IGMS8R++k+DqPE5wOBv2ZX4JQLKxz537DSE/PbugTcEZ6Qe3cfzLMtzIJTZj021l7TVX9g5NKQZckcQNQwOnio=
X-Received: by 2002:a25:4903:0:b0:dcd:a9ad:7d67 with SMTP id
 w3-20020a254903000000b00dcda9ad7d67mr10780266yba.8.1712054905465; Tue, 02 Apr
 2024 03:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com> <20240402103406.3638821-5-quic_varada@quicinc.com>
In-Reply-To: <20240402103406.3638821-5-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:48:14 +0300
Message-ID: <CAA8EJprP0m53B=g7jafAkfcqAQP4kE2ZvtxPXEe4s7ALjFXGSQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] clk: qcom: common: Add interconnect clocks support
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Unlike MSM platforms that manage NoC related clocks and scaling
> from RPM, IPQ SoCs dont involve RPM in managing NoC related
> clocks and there is no NoC scaling.
>
> However, there is a requirement to enable some NoC interface
> clocks for accessing the peripheral controllers present on
> these NoCs. Though exposing these as normal clocks would work,
> having a minimalistic interconnect driver to handle these clocks
> would make it consistent with other Qualcomm platforms resulting
> in common code paths. This is similar to msm8996-cbf's usage of
> icc-clk framework.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v6: first_id -> icc_first_node_id
>     Remove clock get so that the peripheral that uses the clock
>     can do the clock get
> v5: Split changes in common.c to separate patch
>     Fix error handling
>     Use devm_icc_clk_register instead of icc_clk_register
> v4: Use clk_hw instead of indices
>     Do icc register in qcom_cc_probe() call stream
>     Add icc clock info to qcom_cc_desc structure
> v3: Use indexed identifiers here to avoid confusion
>     Fix error messages and move to common.c
> v2: Move DTS to separate patch
>     Update commit log
>     Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
> ---
>  drivers/clk/qcom/common.c | 38 +++++++++++++++++++++++++++++++++++++-
>  drivers/clk/qcom/common.h |  3 +++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 75f09e6e057e..d5c008048994 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -8,6 +8,7 @@
>  #include <linux/regmap.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk-provider.h>
> +#include <linux/interconnect-clk.h>
>  #include <linux/reset-controller.h>
>  #include <linux/of.h>
>
> @@ -234,6 +235,41 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
>         return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
>  }
>
> +static int qcom_cc_icc_register(struct device *dev,
> +                               const struct qcom_cc_desc *desc)
> +{
> +       struct icc_clk_data *icd;
> +       int i;
> +
> +       if (!IS_ENABLED(CONFIG_INTERCONNECT_CLK))
> +               return 0;
> +
> +       if (!desc->icc_hws)
> +               return 0;
> +
> +       icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
> +       if (!icd)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < desc->num_icc_hws; i++) {
> +               /*
> +                * get_clk will be done by the peripheral device using this
> +                * clock with devm_clk_hw_get_clk() so that we can associate
> +                * the clk handle with the consumer device. It would also help
> +                * us make it so that drivers defer probe until their
> +                * clk isn't an orphan.

How the clock instance returned to the peripheral driver is supposed
to correspond to the clock instance used by the icc-clk?

> +                */
> +               icd[i].clk = desc->icc_hws[i]->clk;

You again are abusing clk_hw->clk. Please don't do that.

> +               if (!icd[i].clk)
> +                       return dev_err_probe(dev, -ENOENT,
> +                                            "(%d) clock entry is null\n", i);
> +               icd[i].name = clk_hw_get_name(desc->icc_hws[i]);
> +       }
> +
> +       return PTR_ERR_OR_ZERO(devm_icc_clk_register(dev, desc->icc_first_node_id,
> +                                                    desc->num_icc_hws, icd));
> +}
> +
>  int qcom_cc_really_probe(struct platform_device *pdev,
>                          const struct qcom_cc_desc *desc, struct regmap *regmap)
>  {
> @@ -303,7 +339,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>         if (ret)
>                 return ret;
>
> -       return 0;
> +       return qcom_cc_icc_register(dev, desc);
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
>
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..9058ffd46260 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -29,6 +29,9 @@ struct qcom_cc_desc {
>         size_t num_gdscs;
>         struct clk_hw **clk_hws;
>         size_t num_clk_hws;
> +       struct clk_hw **icc_hws;
> +       size_t num_icc_hws;
> +       unsigned int icc_first_node_id;
>  };
>
>  /**
> --
> 2.34.1
>


--
With best wishes

Dmitry

