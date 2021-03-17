Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7479633FB55
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 23:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCQWjD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 18:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQWiz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 18:38:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A540C06175F
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 15:38:55 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t4so187085qkp.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y3WIcVanAPbeqAQh7jfg7XBL28xTxUqUbFVcumJpKn8=;
        b=QV9Mt7ewVJ/fzBR+EAgorYvcGR4Nbr7Un9rQvvJssFBkwCagvdOutFQGKYirEGWRqn
         kCKu3q4q7OXtD4voFM2br5zSKmwb23ht0FD5ggdkJ2lv4kDexjW+zFKAwg0RdyzhNgHg
         MgQIhP1Sp5QbmDNaOd+KYpJ48LC6xHh/g4GjBLSg7UZ2Fq7Ri24H7WIPZJ68V3dKLg1f
         59FFe4abylBnaFaqV2zsLy7iv+mMnxibiXNYUDjDBknmOVHj6fMKFaD5veJqEm/rZlon
         H9qexoXpHaVTQkD/YJEPZhyfdXg1HaAieo2h3QEMf9W01Z7PKutu+W5uybzWX7oX6Lad
         NWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y3WIcVanAPbeqAQh7jfg7XBL28xTxUqUbFVcumJpKn8=;
        b=g6YJ8VakotrhETME62sUiWWQL+TM56c3frJrutDdGhBavPPucBi0y64U1o6c4+H7sS
         SfU7DjrFy4Gv/2v8uCTgurA0z0CvosWBP/aAppC0Df7k0tWh6851XM5OEY0WqHU9Sas1
         dKWyTx+17jpTRI7SmO9K14tcr1ULApkeIkdtvgexZAkp9WroCUCPqvUCMbIhb/g8Qtj7
         ONDRDF8cXk/kHtsq1wwGF2BuOZIUHDcF4qlgUJTg8K1JDxSjRyS+FP+r4jDk/tjnOeoH
         njKk4Pqplm0RDIm1stSNrjpOr4U2lzSTL+905n1H8SkCQeTDZq0F4xd/0FQpAeHTc7yO
         Htig==
X-Gm-Message-State: AOAM533XMa2stgsS+ccUmV8hLRFG+Ffj0blsYfRicCzXYQOeSGRcIyuB
        aW37cT6Mp6VhiA7/alHC12Jykw==
X-Google-Smtp-Source: ABdhPJwwJZpvhcOORgGoJP4ZnOZvFuanieCWGNRtDMMo2gMDCmO5RqAYc2IfRAsc2b9rpnJSuoad4Q==
X-Received: by 2002:a05:620a:854:: with SMTP id u20mr1627059qku.106.1616020734201;
        Wed, 17 Mar 2021 15:38:54 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id m17sm363140qkh.82.2021.03.17.15.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 15:38:53 -0700 (PDT)
Subject: Re: [PATCH v3] thermal: qcom: tsens-v0_1: Add support for MDM9607
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210209192526.455106-1-konrad.dybcio@somainline.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <2cfd496b-dc50-d4d9-92c6-0003f74a6c2a@linaro.org>
Date:   Wed, 17 Mar 2021 18:38:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209192526.455106-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/9/21 2:25 PM, Konrad Dybcio wrote:
> MDM9607 TSENS IP is very similar to the one of MSM8916, with
> minor adjustments to various tuning values.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ---
> Changes since v2:
> - Address Bjorn's comments (remove redundant variable and kfree)
>   .../bindings/thermal/qcom-tsens.yaml          |  2 +
>   drivers/thermal/qcom/tsens-v0_1.c             | 99 ++++++++++++++++++-
>   drivers/thermal/qcom/tsens.c                  |  3 +
>   drivers/thermal/qcom/tsens.h                  |  2 +-
>   4 files changed, 104 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 95462e071ab4..8ad9dc139c23 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -22,6 +22,7 @@ properties:
>         - description: v0.1 of TSENS
>           items:
>             - enum:
> +              - qcom,mdm9607-tsens
>                 - qcom,msm8916-tsens
>                 - qcom,msm8939-tsens
>                 - qcom,msm8974-tsens
> @@ -94,6 +95,7 @@ allOf:
>           compatible:
>             contains:
>               enum:
> +              - qcom,mdm9607-tsens

This should be split into two different patches. DT binding changes is 
usually not combined with driver changes because two different 
maintainers handle them. Also checkpatch.pl throws a warning stating the 
same.

>                 - qcom,msm8916-tsens
>                 - qcom,msm8974-tsens
>                 - qcom,msm8976-tsens
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 4ffa2e2c0145..a9fc92a4779b 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -190,6 +190,39 @@
>   
>   #define BIT_APPEND		0x3
>   
> +/* eeprom layout data for mdm9607 */
> +#define MDM9607_BASE0_MASK	0x000000ff
> +#define MDM9607_BASE1_MASK	0x000ff000
> +#define MDM9607_BASE0_SHIFT	0
> +#define MDM9607_BASE1_SHIFT	12
> +
> +#define MDM9607_S0_P1_MASK	0x00003f00
> +#define MDM9607_S1_P1_MASK	0x03f00000
> +#define MDM9607_S2_P1_MASK	0x0000003f
> +#define MDM9607_S3_P1_MASK	0x0003f000
> +#define MDM9607_S4_P1_MASK	0x0000003f
> +
> +#define MDM9607_S0_P2_MASK	0x000fc000
> +#define MDM9607_S1_P2_MASK	0xfc000000
> +#define MDM9607_S2_P2_MASK	0x00000fc0
> +#define MDM9607_S3_P2_MASK	0x00fc0000
> +#define MDM9607_S4_P2_MASK	0x00000fc0
> +
> +#define MDM9607_S0_P1_SHIFT	8
> +#define MDM9607_S1_P1_SHIFT	20
> +#define MDM9607_S2_P1_SHIFT	0
> +#define MDM9607_S3_P1_SHIFT	12
> +#define MDM9607_S4_P1_SHIFT	0
> +
> +#define MDM9607_S0_P2_SHIFT	14
> +#define MDM9607_S1_P2_SHIFT	26
> +#define MDM9607_S2_P2_SHIFT	6
> +#define MDM9607_S3_P2_SHIFT	18
> +#define MDM9607_S4_P2_SHIFT	6
> +
> +#define MDM9607_CAL_SEL_MASK	0x00700000
> +#define MDM9607_CAL_SEL_SHIFT	20
> +
>   static int calibrate_8916(struct tsens_priv *priv)
>   {
>   	int base0 = 0, base1 = 0, i;
> @@ -452,7 +485,56 @@ static int calibrate_8974(struct tsens_priv *priv)
>   	return 0;
>   }
>   
> -/* v0.1: 8916, 8939, 8974 */
> +static int calibrate_9607(struct tsens_priv *priv)
> +{
> +	int base, i;
> +	u32 p1[5], p2[5];
> +	int mode = 0;
> +	u32 *qfprom_cdata;
> +
> +	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> +	if (IS_ERR(qfprom_cdata))
> +		return PTR_ERR(qfprom_cdata);
> +
> +	mode = (qfprom_cdata[2] & MDM9607_CAL_SEL_MASK) >> MDM9607_CAL_SEL_SHIFT;
> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> +
> +	switch (mode) {
> +	case TWO_PT_CALIB:
> +		base = (qfprom_cdata[2] & MDM9607_BASE1_MASK) >> MDM9607_BASE1_SHIFT;
> +		p2[0] = (qfprom_cdata[0] & MDM9607_S0_P2_MASK) >> MDM9607_S0_P2_SHIFT;
> +		p2[1] = (qfprom_cdata[0] & MDM9607_S1_P2_MASK) >> MDM9607_S1_P2_SHIFT;
> +		p2[2] = (qfprom_cdata[1] & MDM9607_S2_P2_MASK) >> MDM9607_S2_P2_SHIFT;
> +		p2[3] = (qfprom_cdata[1] & MDM9607_S3_P2_MASK) >> MDM9607_S3_P2_SHIFT;
> +		p2[4] = (qfprom_cdata[2] & MDM9607_S4_P2_MASK) >> MDM9607_S4_P2_SHIFT;
> +		for (i = 0; i < priv->num_sensors; i++)
> +			p2[i] = ((base + p2[i]) << 2);
> +		fallthrough;
> +	case ONE_PT_CALIB2:
> +		base = (qfprom_cdata[0] & MDM9607_BASE0_MASK);
> +		p1[0] = (qfprom_cdata[0] & MDM9607_S0_P1_MASK) >> MDM9607_S0_P1_SHIFT;
> +		p1[1] = (qfprom_cdata[0] & MDM9607_S1_P1_MASK) >> MDM9607_S1_P1_SHIFT;
> +		p1[2] = (qfprom_cdata[1] & MDM9607_S2_P1_MASK) >> MDM9607_S2_P1_SHIFT;
> +		p1[3] = (qfprom_cdata[1] & MDM9607_S3_P1_MASK) >> MDM9607_S3_P1_SHIFT;
> +		p1[4] = (qfprom_cdata[2] & MDM9607_S4_P1_MASK) >> MDM9607_S4_P1_SHIFT;
> +		for (i = 0; i < priv->num_sensors; i++)
> +			p1[i] = (((base) + p1[i]) << 2);

minor nit: extra braces around base

> +		break;
> +	default:
> +		for (i = 0; i < priv->num_sensors; i++) {
> +			p1[i] = 500;
> +			p2[i] = 780;
> +		}
> +		break;
> +	}
> +
> +	compute_intercept_slope(priv, p1, p2, mode);
> +	kfree(qfprom_cdata);
> +
> +	return 0;
> +}
> +
> +/* v0.1: 8916, 8939, 8974, 9607 */
>   
>   static struct tsens_features tsens_v0_1_feat = {
>   	.ver_major	= VER_0_1,
> @@ -540,3 +622,18 @@ struct tsens_plat_data data_8974 = {
>   	.feat		= &tsens_v0_1_feat,
>   	.fields	= tsens_v0_1_regfields,
>   };
> +
> +static const struct tsens_ops ops_9607 = {
> +	.init		= init_common,
> +	.calibrate	= calibrate_9607,
> +	.get_temp	= get_temp_common,
> +};
> +
> +struct tsens_plat_data data_9607 = {
> +	.num_sensors	= 5,
> +	.ops		= &ops_9607,
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4 },
> +

please remove the stray blank line.

-- 
Warm Regards
Thara
