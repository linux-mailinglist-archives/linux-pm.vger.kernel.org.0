Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD09968BAD5
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 11:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjBFK5o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 05:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBFK5n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 05:57:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B1FF09
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 02:57:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eq11so11195624edb.6
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 02:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9Gdf/2MjGZogoBIVbjV9E7gaQxvRNf+5azMe9hz9GY=;
        b=cKlvvlV1MGIpOq1x/OezrMnsVT6hOtG8mgq3AMtaKVqrMg5ex4653EcefGF7VCU7ok
         teEKLCLT0B4ni/PO7EJCvwmLBaP1ap0zC+IUFafrmpNUqVFIHcyVwOssQ44FHtHOKfbI
         nULI1QIrTvXxx22TmPuu+dqqOUs0nb+iKvx+8NQa6771QaidlJiaMqDq8Oeq+EP3g4Dp
         io/iLBgGap9HoreOnMvfh8Zces9ggdjJn5noPYBA6n3rN3neq9nKt8iO6lajkZlbaWCk
         tdmtmfXsI42K3PPhzr0BFtEtcy00rTuGhcmcQur02xRbJ6KsjuuqNbp9w5EOyOuIi0SO
         R/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9Gdf/2MjGZogoBIVbjV9E7gaQxvRNf+5azMe9hz9GY=;
        b=o72eTGph31GgpLymrI//fGft9Wp506MzURQiPJBk7W+Fn8xWWzn2xBC2WhXNB8MY4C
         o62KXUAmQfHxGmFVoKal5auLTE9zxhFd4WPC0iU5Uv/qIEC/7fzpOwXvcSmUg92bSjTw
         zyZKAaIFS3fTtSLFZbwQDJHTfvuj+8mhHKBwAGy1q40UJ79zYo5ORXNNOSHe1QxcfpTz
         aLimSDnQWwhwXbaYPGoss857Zdl/byLpwaaTvs0Ju2k3e9CFA0dQMec8srDor8noU0W7
         37pw3SD0ZqBdOCIv+q+Wlk+M3az+iOJTLyz/UHZ5GltE8NWa8lZ7A25EixHSxQp2LnKu
         2uXw==
X-Gm-Message-State: AO0yUKV09slPDT4S9hlYf7IHq8RK2f5Gcgnog+uDlxL8SfRKq626XwhF
        uCxzYvNp6Y1fgeCHZvVG0u8gFQ==
X-Google-Smtp-Source: AK7set848nDphnldzbj3Q8XWmjilP7Ti0PyzogSDzYf6E75tifBm/Bc56/LAMokGe6LGFsB/8x4kBA==
X-Received: by 2002:a50:ee92:0:b0:4a0:e234:5351 with SMTP id f18-20020a50ee92000000b004a0e2345351mr22652476edr.15.1675681059790;
        Mon, 06 Feb 2023 02:57:39 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7c6cb000000b004a986403dc1sm4473379eds.1.2023.02.06.02.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 02:57:39 -0800 (PST)
Message-ID: <21074b46-1278-b442-1d32-a0ae3ae19ca2@linaro.org>
Date:   Mon, 6 Feb 2023 11:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: c630: Add Embedded Controller
 node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
 <20230205152809.2233436-4-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230205152809.2233436-4-dmitry.baryshkov@linaro.org>
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



On 5.02.2023 16:28, Dmitry Baryshkov wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The Embedded Controller in the Lenovo Yoga C630 is accessible on &i2c1
> and provides battery and adapter status, as well as altmode
> notifications for the second USB Type-C port.
> 
> Add a definition for the EC.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index 7038a0f7c06e..cf56ce68081c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -352,6 +352,33 @@ zap-shader {
>  &i2c1 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> +
> +	embedded-controller@70 {
> +		compatible = "lenovo,yoga-c630-ec";
> +		reg = <0x70>;
> +
> +		interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ec_int_state>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "source";
> +			data-role = "host";
> +		};
> +
> +		connector@1 {
> +			compatible = "usb-c-connector";
> +			reg = <1>;
> +			power-role = "source";
> +			data-role = "host";
> +		};
> +	};
>  };
>  
>  &i2c3 {
> @@ -652,6 +679,14 @@ mode_pin_active: mode-pin-state {
>  		input-enable;
>  		bias-disable;
>  	};
> +
> +	ec_int_state: ec-int-state {
> +		pins = "gpio20";
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-disable;
Unnecessary newline + most other trees do bias- before input/output-

Other than that

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +	};
>  };
>  
>  &uart6 {
