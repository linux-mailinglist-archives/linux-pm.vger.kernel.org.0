Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52953745B02
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 13:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGCL03 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGCL02 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 07:26:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079BCC1
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 04:26:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f122ff663eso6628290e87.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2023 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688383585; x=1690975585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwdMnJhZqlWvQtbXAttWH4wGr4WhW5VlgumPKWCD0hs=;
        b=d4+EPs+rLfgk0Hg1CIyefC6USYSiefEi2QaLJCW8U0sbyNZZLj/5/u+j8zJJTmW/rD
         jIQ8SXXmHq6mi2IKSf4hHdw8PqV0JB+H3p8wN5oyRws/UOhJHkW6JL7EaUW2HVhr24ol
         9O035GkAAiFZq23V1NDgEaIzpQrwJYDXbYl4LVgjyYzEgmDc8OhaOR5SSATLO+JwO6g8
         CMIjBYOYoFi6irTV9uotuuA78WlmASg98NqpBCU19wJYiN7qM71H3iVMVZvnKG1N5JjE
         VEDYxvHmuybfkZa6PJRNBrfTkTiSK3iJz6gIYYMPoxXanJUTr/2NszOuUhFU3SjdGsIo
         khAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688383585; x=1690975585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwdMnJhZqlWvQtbXAttWH4wGr4WhW5VlgumPKWCD0hs=;
        b=Q4iuCfL1Twx0U+rmlnegi+YykVUZrzb1Ej+5Zs/vBC8QCTBtxiU90CFgSCdGD/Vhug
         fgrj+KbVqXclal5zxy1yZP8G7x1LB0j8zBZpfuxbUiLKYLKI1Z7IIe8+ETvJSajnLVsE
         /zrXbkBV0QwVKJg2/6drYrc6QVZiRaAq1ZD5XHeoKPcM6cnWl+4VImfZpeU4pDNbUu+n
         FGtbTtJvID9rFy/Ct8eHTM3gpy7laYiKd/VNI+KdR4E/OA3BEkHaBtCOhe5Cb4mrd01M
         CZBmQYROiiZILxJXls8wOhwbbNCWsdi4qwEklngRPZiESD/HLvPEsEapQ0v9ri0Tu+CD
         5rHA==
X-Gm-Message-State: ABy/qLYC394zPb9h7z8QBnxolKmqnDCnSisSLZTZvMF7ezssDn00YcTv
        8yIgySLFZdMZn/k7VwLWgIztEg==
X-Google-Smtp-Source: APBJJlEUPi3eL+BXMS4PHI/B/+24ZM3huuiWm2MgtXjuINfG9TPql3RZi09/eKjz1FIh7VlS+4Rcgw==
X-Received: by 2002:a05:6512:3192:b0:4f4:cebe:a7aa with SMTP id i18-20020a056512319200b004f4cebea7aamr6875222lfe.39.1688383585275;
        Mon, 03 Jul 2023 04:26:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id r11-20020ac25a4b000000b004fb7da93c24sm3328174lfn.273.2023.07.03.04.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:26:24 -0700 (PDT)
Message-ID: <a4b73322-9c32-c4b6-8e1c-663a699cb7a5@linaro.org>
Date:   Mon, 3 Jul 2023 13:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 17/28] ARM: dts: qcom: apq8064-sony-xperia-lagan-yuga:
 constraint cpufreq regulators
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
 <20230702174246.121656-18-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230702174246.121656-18-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2.07.2023 19:42, Dmitry Baryshkov wrote:
> Add additional constraints to the CPUfreq-related regulators, it is
> better be safe than sorry there.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
> index 6988bd212924..26f1e81e2bf5 100644
> --- a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
> @@ -130,7 +130,7 @@ pm8921_s2: s2 {
>  		};
>  
>  		pm8921_s3: s3 {
> -			regulator-min-microvolt = <500000>;
> +			regulator-min-microvolt = <950000>;
>  			regulator-max-microvolt = <1150000>;
>  			qcom,switch-mode-frequency = <4800000>;
>  			bias-pull-down;
> @@ -281,7 +281,7 @@ pm8921_l23: l23 {
>  		};
>  
>  		pm8921_l24: l24 {
> -			regulator-min-microvolt = <750000>;
> +			regulator-min-microvolt = <1050000>;
>  			regulator-max-microvolt = <1150000>;
>  			bias-pull-down;
>  		};
> @@ -335,7 +335,11 @@ pm8921_lvs6: lvs6 {
>  			bias-pull-down;
>  		};
>  
> +		/* HFPLL regulator */
>  		pm8921_lvs7: lvs7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-boot-on;
>  			bias-pull-down;
>  		};
>  
