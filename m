Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67C6E4FB9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDQR4C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjDQR4B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 13:56:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689CB6E8E
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 10:56:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec81779f49so1575619e87.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681754158; x=1684346158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKDmMoGXfJU4fYQc4SgnFhXeKOqYUlPRJlTeeGghjx8=;
        b=e71iFc9OvZScNGlXJc4d2BWw8WUA4B4a/x6KjylMvisNQRju5rfTmHoGAERKFeFwZn
         b4b0AbtBHn2fF+dHWmUNI1BZTCo5/CmZ66WbPGiXQtxT73ZIVfY5t5YekrFLga2kz/Sx
         Lch22J7ZYA8bXnLl0pd3/aYY7YbPUVk7U4xLG+54MITzuTcTKozirc0bHF+/t2IQVC9j
         RK86hfbSOLwowXUWoY3kne/x2Q8caGQC8G7bz5mYIVdjlPY4k8OTvZSmCH7YICPy34Nj
         raofRJ/fDGk6ovfpJyr4qj0CJmI3pGyapnUZ13Ngc5mF2vTe67ThfiR3cFk6PCSfIq3Z
         Crtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681754158; x=1684346158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKDmMoGXfJU4fYQc4SgnFhXeKOqYUlPRJlTeeGghjx8=;
        b=GqgxY4LVo55X+wOAhjsLT+ubiaGNCFbXpka7BVCkGxCQw7vVgcH5wy15F66b/AZpF2
         qKbKiLNwacBGJA5rwNDz338kF79L6Uh82F41G973S1X6q1d+pqeKx50jymjKpRs0gtj7
         563lDF6+eLgMvxlAunaOaBlnEXqdzUSVltbGFukFl5/g2FCtrIiKPVMeoxeZfrgpTKLj
         c1S7uJaSw5b08kzILhfNfcY/chYIKhEosM4k94wOdJ5ZgdX+64NOXQw5922Sy24lxY2l
         zQBzsStGwZCD+xNOsd35Z8wmJKpQjUToz86koG8EUpD4lcjNDDIj4pqd1gJd/ssf6Ulr
         3vQA==
X-Gm-Message-State: AAQBX9fkpoZRwN88VwwdGmLHkK//SU3qCoOlULoST5AhJbsj+mG1VXCu
        RlPOVIE8CGLb/YszzzARfDvyHg==
X-Google-Smtp-Source: AKy350ZOy7SA3V/n3VNMo4APMIyDC2YUvIH1K4sUn3ZXx3m0oJ7cyPxlvpT9oHIMKvhOqVnn/3edoQ==
X-Received: by 2002:ac2:4105:0:b0:4e8:3f35:6844 with SMTP id b5-20020ac24105000000b004e83f356844mr1847583lfi.19.1681754158663;
        Mon, 17 Apr 2023 10:55:58 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id u21-20020ac25195000000b004cb45148027sm2111190lfi.203.2023.04.17.10.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:55:58 -0700 (PDT)
Message-ID: <e7d15873-a6b7-9a64-f164-7df64585dcfb@linaro.org>
Date:   Mon, 17 Apr 2023 19:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8775p: pmic: add the sdam_0
 node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230417145536.414490-1-brgl@bgdev.pl>
 <20230417145536.414490-4-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230417145536.414490-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 17.04.2023 16:55, Bartosz Golaszewski wrote:
> From: Parikshit Pareek <quic_ppareek@quicinc.com>
> 
> Introduce sdam_0 node, which is to be used via nvmem for power on
> reasons during reboot. Add supported PoN reaons supported via sdam_0
> node.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> index 5abdc239d3a6..3c3b6287cd27 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -88,6 +88,14 @@ trip1 {
>  			};
>  		};
>  	};
> +
> +	reboot-mode {
> +		compatible = "nvmem-reboot-mode";
> +		nvmem-cells = <&reboot_reason>;
> +		nvmem-cell-names = "reboot-mode";
> +		mode-recovery = <0x01>;
> +		mode-bootloader = <0x02>;
> +	};
>  };
>  
>  &spmi_bus {
> @@ -133,6 +141,19 @@ pmm8654au_0_gpios: gpio@8800 {
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  		};
> +
> +		pmm8654au_0_sdam_0: nvram@7100 {
> +			compatible = "qcom,spmi-sdam";
> +			reg = <0x7100>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x7100 0x100>;
> +
> +			reboot_reason: reboot-reason@48 {
> +				reg = <0x48 0x1>;
> +				bits = <1 7>;
> +			};
> +		};
>  	};
>  
>  	pmm8654au_1: pmic@2 {
