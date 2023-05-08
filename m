Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB86FA2E3
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 11:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjEHJCl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 05:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjEHJCU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 05:02:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC89723A34
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 02:01:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f13dafd5dcso4671699e87.3
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536477; x=1686128477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAtcRiVz2LFtjk3uAV0ijqbuFG5j1XYJ0D6hLWgDfzI=;
        b=pwylfqYj9WSIAV1aUQoRGEKHq78WK5q4r8bHsfOWqcTYFHem7MhLDtu1jD1eJbaMnR
         ZGhSeiZ8xIoFY+B3NIJgJS8/zqVTtbwPH9hqQfsjNtb5Vm1RC/S8aKYXcWuNKwpRMNNI
         toRSf95bDjaxGCHFmmWMSUWdVqY3rZIz//wm0WvPtY/X4ZI7Cw9KNIc/yH5L/+CzdnXY
         5FHWO+EATpvGUzcRgGiziVdsZyvEdL87F59JD2h515Gn9nvE5nLqZPA5JHuP9Mf4c99d
         lmv9ixlDHhMfY+rgdzs5p8mO33uek9YM8sRdgMJrpw0Bs+ZpSvBLugGAHpNShFtabi4k
         Y1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536477; x=1686128477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAtcRiVz2LFtjk3uAV0ijqbuFG5j1XYJ0D6hLWgDfzI=;
        b=ElOuDgaufVUhsfNjSE86vzh4LLSHQ4SNASQJnOO1RM8955/QzkRkl7E7NmQjrj8RBx
         UzmPTKTkpLmjKwY78CvIno6JAlT6Yaj51EF7mQR+KNlWeB85ORPidtoVEdFgFOo6nuTl
         +JP7dNMjYpQ43r0wuWvC79OVHhX9ZcWoYWNkHbOo6At2Ji38Z6gfzxmcpSimyd9bGWFy
         xueGevJDMfXWjZmsx4D7FChH26tSANoXKEJpUkLLtsOpW0EsYdjBrnwI70mQ3bfwjOXj
         sn6l9yrHdFGx1Io6PBEUNC6bDI6MxSOAlhk2ptPY7UJIRMF3wpeNCvfP827dZ7vqzbVb
         wfPA==
X-Gm-Message-State: AC+VfDzYUuLjcpijvNmGTtdWITRZYxLq0rkDsrkn0cCYWzpF4sjbI05g
        7Z4oGE0DuJEpvqudYpBoGnU4fA==
X-Google-Smtp-Source: ACHHUZ7gJC78tvNhwpO5RTz9LgxyRb5HAFsJDIa5MZDRAqcbRbzkBMcEm9NKpRpwDB+T5DU6SSWfgQ==
X-Received: by 2002:ac2:546b:0:b0:4eb:c4e:bd87 with SMTP id e11-20020ac2546b000000b004eb0c4ebd87mr2655934lfn.58.1683536477048;
        Mon, 08 May 2023 02:01:17 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id o1-20020a056512050100b004f021a4e5f6sm1241632lfb.52.2023.05.08.02.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:01:16 -0700 (PDT)
Message-ID: <aa9e3c94-cb8b-beb7-2050-de43565d7bb0@linaro.org>
Date:   Mon, 8 May 2023 11:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/6] ARM: dts: qcom-pm8941: add resin support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230508003309.2363787-1-dmitry.baryshkov@linaro.org>
 <20230508003309.2363787-4-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230508003309.2363787-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8.05.2023 02:33, Dmitry Baryshkov wrote:
> Wrap existing pwrkey and new resin nodes into the new pon node to enable
> volume-down key support on platforms using pm8941 PMIC.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index a821f0368a28..ce30946ccf58 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -19,12 +19,24 @@ rtc@6000 {
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> -		pwrkey@800 {
> -			compatible = "qcom,pm8941-pwrkey";
> +		pon@800 {
> +			compatible = "qcom,pm8916-pon";
You just added a new one! :P

Konrad
>  			reg = <0x800>;
> -			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> -			debounce = <15625>;
> -			bias-pull-up;
> +
> +			pwrkey {
> +				compatible = "qcom,pm8941-pwrkey";
> +				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +			};
> +
> +			pm8941_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				status = "disabled";
> +			};
>  		};
>  
>  		usb_id: usb-detect@900 {
