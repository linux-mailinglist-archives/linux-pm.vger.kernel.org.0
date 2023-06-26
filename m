Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53273E594
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjFZQpV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 12:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFZQpU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 12:45:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1D8E4C
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:45:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4774849e87.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687797917; x=1690389917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIFt8n1nErZrh34dAomtKoLN8rbez3CVPdsde3QJRw4=;
        b=NPcZgQKm1MvmoCUf1GJ1m8W2/WCSKhm+Cp/pSJLZy2BQybI+bjSPEwdyBTGRzF8ahs
         sOzs3RcQOm5X+mxbNJmrJcWbA3qX4tAZNwJxqNqi3DMaGgf/4/+gQgn2RH2I4QDihF2F
         GVmEoFlVzt7TnWF0X/l1ALhGPtDST9LjJrcqjBZqsgy9rRYRcn+9T4fFzTlq95N6eKRw
         6OPQ2WVkqQ5mB2J+GqFm/5rwl355bi9SMN3YiN1Mbc6BvBnJFlbu7cpboRDzeziod0uL
         t5ENzbI0A09HLbd5dCTKapsFCAtBtFu8Jftb/idSBNx4xA4xuxJr4xa+XAzXWjkjOYT3
         /jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797917; x=1690389917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIFt8n1nErZrh34dAomtKoLN8rbez3CVPdsde3QJRw4=;
        b=GAfzqaO6eOo1x/7craQAn5/D3XpRaUY5KQsZ61ptmgq0ZYflsY/rDMoxTZQb5cvD8o
         phj/tHrvvXHCB5n848h662oLdaT/jJitjxXced1B7uLxCJnWa0FlR2VobUUjSWS/y/Fr
         CELPprkfAUh3MBEV9O9rb3v8HsQWoxZ9wvujkw9kOgyJxtOXU5vWUw6SqO/iQuLUDPPg
         UmfWS1RloRtPMSsdDuXaq5YpmcQqS0MTs6XdiuQsxZ9AbUVhHpXLiBVbj1wIQ2f6JeLu
         XoYnMGqphmAoLoR84b5cNW7KSleLjk/mC+j6XGpbb7WG7aGRlSwZL116QzWFlJMopv2W
         g51Q==
X-Gm-Message-State: AC+VfDwLMJbr/DeF2NcSGUTjygrA1Pw+M8c9xlPb21izG6rVb8pL4Jg1
        g4OTZB93beUm74KkhihyZRfZYg==
X-Google-Smtp-Source: ACHHUZ5neI4dd52E/aR0a1KOrTSHOMvDVvlYRgVBcRxcuzHdNwVc3D7dqRRoMp73xv6YR4ViXpfN8w==
X-Received: by 2002:a05:6512:5d0:b0:4fb:79b5:5512 with SMTP id o16-20020a05651205d000b004fb79b55512mr1282679lfo.66.1687797916950;
        Mon, 26 Jun 2023 09:45:16 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id s3-20020a19ad43000000b004fb745fd232sm604405lfd.30.2023.06.26.09.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:45:16 -0700 (PDT)
Message-ID: <467650f5-2398-0a1f-30de-a6f103b7ba05@linaro.org>
Date:   Mon, 26 Jun 2023 18:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 21/26] ARM: dts: qcom: apq8064-ifc6410: constraint
 cpufreq regulators
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
 <20230625202547.174647-22-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230625202547.174647-22-dmitry.baryshkov@linaro.org>
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
> Add additional constraints to the CPUfreq-related regulators, it is
> better be safe than sorry there.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
same comment as in p20

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
> index 96307550523a..ad3cd45362df 100644
> --- a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
> @@ -215,8 +215,8 @@ s1 {
>  		};
>  
>  		s3 {
> -			regulator-min-microvolt = <1000000>;
> -			regulator-max-microvolt = <1400000>;
> +			regulator-min-microvolt = <950000>;
> +			regulator-max-microvolt = <1150000>;
>  			qcom,switch-mode-frequency = <4800000>;
>  		};
>  
> @@ -262,6 +262,12 @@ l23 {
>  			bias-pull-down;
>  		};
>  
> +		l24 {
> +			regulator-min-microvolt = <1050000>;
> +			regulator-max-microvolt = <1150000>;
> +			bias-pull-down;
> +		};
> +
>  		lvs1 {
>  			bias-pull-down;
>  		};
> @@ -269,6 +275,14 @@ lvs1 {
>  		lvs6 {
>  			bias-pull-down;
>  		};
> +
> +		/* HFPLL regulator */
> +		lvs7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
>  	};
>  };
>  
