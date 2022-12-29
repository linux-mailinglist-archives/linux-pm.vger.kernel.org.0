Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2B658C27
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 12:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiL2L1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 06:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiL2L1P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 06:27:15 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEFB13DE5
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 03:27:13 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y25so27133688lfa.9
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 03:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0p6/hBiX76Ekhx+g6ggMtqHC28SQzutXJpUDl3JkiEk=;
        b=e23BqtgTPHg0mf0eaBRETHbj73x4sy5yNQChiujd9n+c/CHmVpUyMujBGQ3A6ZgUvl
         wwwWCG8De2xZvuYx9KtBXAx/6NUwNDGWAA1Wyu5DoKwMzhqC74L9GoUkyOplydfpCZ7G
         SYSpYE3Ugy2BhseW8EooGi8G/ZcZpKFp/5Yudpe4z40XIwJSXmYEKQI+Y5vsF0Kfg7BH
         4TbfdXnIA3Nd0S2BVGSzAaYDxahOQ6YnaVBqamFHbpu+rAYsh15sT0Z1mbTheHlb4hGn
         SAN+EhFx0nPg+PsMW7Ua06SqA0EID9IJhhi43fipGYa4T5yVLtjzaGCRASFzgOKXyhwl
         rdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0p6/hBiX76Ekhx+g6ggMtqHC28SQzutXJpUDl3JkiEk=;
        b=46AXBEec1gJqa7RqEL4V43dRnnilLSBtoies0pRwvvWR4K458N5dIZ9MZPUbexCJHO
         P5fsQ4rPZ27NU77fM1MlMv3A905aaroBXJ67S2VaOqPYpGEVj7e9XflmthA7qKE1G6O0
         qWnb8pq2A4XR3Rj51tzqwE6UwG5YA1hfzXriW8PqA6GduPNV3nwfbQ67Ogn07zjpdVt0
         QPYgCKazKi+nNYUgT+FwTqXtVOyPLV4+FMyEQvz8F5drFwoJKsjlOq3TeBApwCF8Bvg1
         YGa/uGwVhAp+SwWlyz7DN1QVYnhiw2BECCp0OowlqyLmtxkn07ZAZatmpSq6reZYwVFE
         0hwA==
X-Gm-Message-State: AFqh2kqkq5eLQSHI/BxIWzHAOOC3yq+iv63dIG1+zDdTr0tLz7WTaTTN
        dPe1BYIFPxK9YDHg1QWqFuumAA==
X-Google-Smtp-Source: AMrXdXtp9hZE89hbMFMwUzjz5kWJuypGeC1NtTkL9OCqgmBRIIOfnn+3S17AVo0g8bIvltwg3vcLRg==
X-Received: by 2002:a05:6512:4014:b0:4b6:f22c:8001 with SMTP id br20-20020a056512401400b004b6f22c8001mr13088365lfb.56.1672313231739;
        Thu, 29 Dec 2022 03:27:11 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id b8-20020a056512070800b004cb00bf6724sm2166724lfs.143.2022.12.29.03.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 03:27:11 -0800 (PST)
Message-ID: <6bb9f656-43e0-1142-1cfa-ba9de81af1f1@linaro.org>
Date:   Thu, 29 Dec 2022 12:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 13/20] thermal/drivers/tsens: Drop single-cell code for
 msm8939
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
 <20221229030106.3303205-14-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221229030106.3303205-14-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 29.12.2022 04:00, Dmitry Baryshkov wrote:
> There is no dtsi file for msm8939 in the kernel sources. Drop the
> compatibility with unofficial dtsi and remove support for handling the
> single-cell calibration data on msm8939.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v0_1.c | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 9488416b568c..e89c6f39a3ae 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -150,30 +150,6 @@ static int calibrate_8916(struct tsens_priv *priv)
>  	return 0;
>  }
>  
> -static int calibrate_8939(struct tsens_priv *priv)
> -{
> -	u32 p1[10], p2[10];
> -	u32 *qfprom_cdata;
> -	int mode, ret;
> -
> -	ret = tsens_calibrate_common(priv);
> -	if (!ret)
> -		return 0;
> -
> -	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> -	if (IS_ERR(qfprom_cdata))
> -		return PTR_ERR(qfprom_cdata);
> -
> -	mode = tsens_read_calibration_legacy(priv, &tsens_8939_nvmem,
> -					     p1, p2,
> -					     qfprom_cdata, NULL);
> -
> -	compute_intercept_slope(priv, p1, p2, mode);
> -	kfree(qfprom_cdata);
> -
> -	return 0;
> -}
> -
>  static void fixup_8974_points(int mode, u32 *p1, u32 *p2)
>  {
>  	int i;
> @@ -354,7 +330,7 @@ struct tsens_plat_data data_8916 = {
>  
>  static const struct tsens_ops ops_8939 = {
>  	.init		= init_8939,
> -	.calibrate	= calibrate_8939,
> +	.calibrate	= tsens_calibrate_common,
>  	.get_temp	= get_temp_common,
>  };
>  
