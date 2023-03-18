Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B876F6BFA9E
	for <lists+linux-pm@lfdr.de>; Sat, 18 Mar 2023 15:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCROCE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Mar 2023 10:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCROCD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Mar 2023 10:02:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A62E32520
        for <linux-pm@vger.kernel.org>; Sat, 18 Mar 2023 07:02:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f18so9807927lfa.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Mar 2023 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679148119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSGb6tLChsPoVE3NEJzYoRIMMJLWBj6pgkqbDZo26h8=;
        b=LYV1coWWJMT/K+xfSoUAydHZvBrEuyCnbq7AOYJwCS06RkfKMsXDKf6Bl4p8wOuJAi
         7rO4QA60TtpvJb7k0LgPg6hxkIgDzVQEfsZlopJ+qmXQRp5j5IMAUgVLp/BRP7x+wK2g
         z3YiTkWX0BsAyiI/9C01+XDy1WcZjwo1z5Y6UKsMXiSofbg2wEtOjwQzqjJhqEmC/a3t
         X04qjK7hHeVqSNlLZ0i86rX/WRLHuf2tCh0zkg6ZkH1gP4emztFPkjXtZAC6M7cZI6Ij
         oj6Z/CvxYXyl11IOFL2SaTv/05OYOPeCXdk4wFYAORgqluBZolp9KMK1bth4KZDz+QMx
         ri1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679148119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSGb6tLChsPoVE3NEJzYoRIMMJLWBj6pgkqbDZo26h8=;
        b=s7YKLOTKSAXnljDueWMHxUBU+rspOkq3a8fwW4H2a2GTeUAiNCpS3k4kw68IpMczZJ
         RK5AOyNXXvevG5RHtv7ARpzqJuZllpj/syU9W2HanBMA97rfBQyHAY9WpL7cN8ZZKQg5
         XFXuESsXE6siArcm82bKnZhlb37BbNKz0yLYnvEuSizfqpjMuFJbS5Uuyu35odAos3d7
         vMsEtJQCnedJAEgT85P4RJVJc8B82g228zOgjAf0srW9jrC1CprXdUi8qMKTTtGeXYyQ
         Vr+O+W1rzPLtVfpuXmZAdXEldn6fUhxdViIVaZZXgGFjfq9odc5QJ5Be0DAOZ1bbFCTy
         Wl9g==
X-Gm-Message-State: AO0yUKWMJwgZi07EdksXA3KgUgpnRJREM1Xr/5IJOU6+3BvdRo0rhkIC
        z5BOwDOFcBIs7V7vbQOyDc1hmQ==
X-Google-Smtp-Source: AK7set+wxAIqXZQqpXZHS2F+tyjRULFsxfxLAIlvTByLSfD+2vLEYp1aRfSJia9y+U8E/YK0M0DueQ==
X-Received: by 2002:ac2:494b:0:b0:4b5:b06d:4300 with SMTP id o11-20020ac2494b000000b004b5b06d4300mr4601560lfi.29.1679148119220;
        Sat, 18 Mar 2023 07:01:59 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004e846175329sm847785lfc.202.2023.03.18.07.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 07:01:58 -0700 (PDT)
Message-ID: <23ec1eca-0385-cb87-8917-aef14e7a5545@linaro.org>
Date:   Sat, 18 Mar 2023 15:01:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 6/6] thermal: qcom: tsens-v0_1: Add MSM8909 data
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
References: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
 <20230315103950.2679317-7-stephan.gerhold@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230315103950.2679317-7-stephan.gerhold@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 15.03.2023 11:39, Stephan Gerhold wrote:
> The MSM8909 SoC has 5 thermal sensors in a TSENS v0.1 block. Like
> MDM9607 it uses a non-standard default slope value of 3000 [1] and needs
> per-sensor "correction factors" to workaround issues with the factory
> calibration [2].
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.UM.7.7.c26-09100-8x09.0/arch/arm/boot/dts/qcom/msm8909.dtsi#L476
> [2]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/6df022c6d0c2c1b4a5a6c2124dba4d57910c0911
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
> Changes in v3: None
> Changes in v2:
>   - Rewrite on top of per-sensor nvmem cell changes that landed in 6.3
> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 32 ++++++++++++++++++++++++++++++-
>  drivers/thermal/qcom/tsens.c      |  3 +++
>  drivers/thermal/qcom/tsens.h      |  2 +-
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index e69889dd524a..2fda1ff4f6a6 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -207,6 +207,23 @@ static int calibrate_8974(struct tsens_priv *priv)
>  	return 0;
>  }
>  
> +static int __init init_8909(struct tsens_priv *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope = 3000;
> +
I think assigning 0 here explicitly to priv->sensor[0].p12_calib_offset,
while unnecessary, would make it a bit more obvious.

Either way:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +	priv->sensor[1].p1_calib_offset = -10;
> +	priv->sensor[1].p2_calib_offset = -6;
> +	priv->sensor[3].p1_calib_offset = -9;
> +	priv->sensor[3].p2_calib_offset = -9;
> +	priv->sensor[4].p1_calib_offset = -8;
> +	priv->sensor[4].p2_calib_offset = -10;
> +
> +	return init_common(priv);
> +}
> +
>  static int __init init_8939(struct tsens_priv *priv) {
>  	priv->sensor[0].slope = 2911;
>  	priv->sensor[1].slope = 2789;
> @@ -243,7 +260,7 @@ static int __init init_9607(struct tsens_priv *priv)
>  	return init_common(priv);
>  }
>  
> -/* v0.1: 8916, 8939, 8974, 9607 */
> +/* v0.1: 8909, 8916, 8939, 8974, 9607 */
>  
>  static struct tsens_features tsens_v0_1_feat = {
>  	.ver_major	= VER_0_1,
> @@ -292,6 +309,19 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> +static const struct tsens_ops ops_8909 = {
> +	.init		= init_8909,
> +	.calibrate	= tsens_calibrate_common,
> +	.get_temp	= get_temp_common,
> +};
> +
> +struct tsens_plat_data data_8909 = {
> +	.num_sensors	= 5,
> +	.ops		= &ops_8909,
> +	.feat		= &tsens_v0_1_feat,
> +	.fields	= tsens_v0_1_regfields,
> +};
> +
>  static const struct tsens_ops ops_8916 = {
>  	.init		= init_common,
>  	.calibrate	= calibrate_8916,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 32d2907f76e5..a04179247b34 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1109,6 +1109,9 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,mdm9607-tsens",
>  		.data = &data_9607,
> +	}, {
> +		.compatible = "qcom,msm8909-tsens",
> +		.data = &data_8909,
>  	}, {
>  		.compatible = "qcom,msm8916-tsens",
>  		.data = &data_8916,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 880be6be5c3f..c88287dede96 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -639,7 +639,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
>  extern struct tsens_plat_data data_8960;
>  
>  /* TSENS v0.1 targets */
> -extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
> +extern struct tsens_plat_data data_8909, data_8916, data_8939, data_8974, data_9607;
>  
>  /* TSENS v1 targets */
>  extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
