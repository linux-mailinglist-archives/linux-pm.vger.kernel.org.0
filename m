Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8573E57D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjFZQny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjFZQnx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 12:43:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44284E48
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:43:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso1931783e87.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687797829; x=1690389829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4+6ENFQ8YL76Bgs3hZByPsBVdXOLkkUKyglIdwW3YU=;
        b=P4Ol8kh/84DztMI8MF3KdnZR6E8Nefk+Q1WKdU3ZUz0k+xFmN5fJ7T8HWjN2lYXgFn
         wgo85jPaN3Cf7f7SJpk5tbqhPNh6+57IQ1rgjgGDRZG3PKKpbOgBJEDzNjurwRlh2IVT
         I9dLvQPPhvKrca6+S6w/ANr/foZIqNKwNXaDbk+TWUcmDdxENZyuQt6Hkif6EmTNNyev
         k1Pl0rBfzwl5/gPnAzqINQb3POTqMfngp1nGeLBCzwjgxlwHSgUH7M7anqqscfIFXtsO
         00w0z5rPsSCzECVHu7eXSN+jh0e43RMWSDZT9BziDHOhogWE1aaU+632eMjzAJuzl33O
         gsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797829; x=1690389829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4+6ENFQ8YL76Bgs3hZByPsBVdXOLkkUKyglIdwW3YU=;
        b=cD0Meo0kmFm/ru1zcfT6r+lpoICzE/K5IvAW7FF3ZyYAkkfpnSDi+DQp2QQaXOJZ3a
         WJuvunwCc3Boglwr1GarjuiSftif+/BEaDAiPeQylFsId7EMtdy5L9zmW5m3xkt+nsHd
         k+zA0Lchzq4i9cXeQmFhm+fhGnZGfA/skLG2Oxa6WgqUvvlcunGnj2XZa9eNuR95AzCe
         qkcbP7r3oCdDx3ckzHyS3k9yXgAx5KZWApycTqokjD0Q4B0/iRSpCrs6gqlHylLue+v8
         ApfTqbpjSQ+Mcf2D25sh8K/Fjlc0PLMsifnk/YKxJanD5jTmoBEeqcgSK/IX1mm7tL4u
         tUMg==
X-Gm-Message-State: AC+VfDynZQsEMyidp1QiBaxCld4UHHvFAc0D/DX4MmAVH0VmsC1UPvuP
        2sAvOWMqZrLxqzL3u+Mx2qaI2A==
X-Google-Smtp-Source: ACHHUZ6Nhqo3EwNdTHTLVrrQ3l8y16/cfJmlaTRJeHMBeF/u+5iNaZDMrfJSXdJb6IZVF+m3w1TjmA==
X-Received: by 2002:a19:670f:0:b0:4f8:7513:8cac with SMTP id b15-20020a19670f000000b004f875138cacmr12525009lfc.48.1687797829523;
        Mon, 26 Jun 2023 09:43:49 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id 20-20020ac24854000000b004f86c76258esm1177832lfy.206.2023.06.26.09.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:43:49 -0700 (PDT)
Message-ID: <28343db8-a4fe-f967-ee43-6bd89c4c52de@linaro.org>
Date:   Mon, 26 Jun 2023 18:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 19/26] ARM: dts: qcom: apq8064: enable passive CPU
 cooling
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
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-20-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230625202547.174647-20-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.06.2023 22:25, Dmitry Baryshkov wrote:
> Wire up CPUs and thermal trip points to save the SoC from overheating by
> lowering the CPU frequency.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 29 ++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> index b97d88517805..f38e3394b422 100644
> --- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/soc/qcom,krait-l2-cache.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
>  / {
>  	#address-cells = <1>;
>  	#size-cells = <1>;
> @@ -701,6 +702,13 @@ cpu_crit0: trip1 {
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu1-thermal {
> @@ -722,6 +730,13 @@ cpu_crit1: trip1 {
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert1>;
> +					cooling-device = <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu2-thermal {
> @@ -743,6 +758,13 @@ cpu_crit2: trip1 {
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert2>;
> +					cooling-device = <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu3-thermal {
> @@ -764,6 +786,13 @@ cpu_crit3: trip1 {
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert3>;
> +					cooling-device = <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  	};
>  
