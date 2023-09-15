Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB87A1F20
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjIOMqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 08:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjIOMqr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 08:46:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2AD2D60
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 05:46:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401187f8071so14297485e9.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694781966; x=1695386766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLYJMC+6NP26nnWPC1ohFPbvAKuqIM7PzgDWSXVur78=;
        b=nHYg+WgDiLGz9pMXUYiXF6r7W3OIUiAYf6xq6HwADYsk+tW7OwrrPJst6zKs6+WqlD
         7Y07nn7i+QhZutpVdohUEZ0Hz61JscML9MyS9FYqZWg4hCo7e4vlro3U77lLyA6RBSY8
         Poy9ne6xIzmPRNcqIICs/fB/QNXYYdlFJLgx6HQCFgjpNotFwMI62Ro7WR2Wjw8+yW4w
         x7QHdJ7gR9cYeszAMw6zBSuVR0nm9NaaVnnu9w3bNQ4MjdnGkvdIyi//sPVj/t47bNR9
         VHW4LaCm3G6uAGDXtsnEOSlZjH6llsShQQONA4RQc8iWT/xAzEhOlZk/UNRPcazd5AZC
         LRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694781966; x=1695386766;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLYJMC+6NP26nnWPC1ohFPbvAKuqIM7PzgDWSXVur78=;
        b=CRZxdz5YtTrgLwZsBDf0eWhnvlAjlRcKDVZOK1cUpbKM+yFIPEG2XUuxLrVbTyc84Z
         2okfB5OUBMdfphUe3NC+UZz4m01bHZCTLpepnqGLh+4bS3ndA0NJYhFQ62/05YC6XHIc
         QwY8ffzkRq/F2i/t0f/b/aSTp3ZrQA1fONmSK61W18TZOipx+XnQa6ci1GphZU5fhm+r
         jTScs06I68/lMCPzMUOGpbIFAsgIRuzWjjzILzV7R/pbBJHU25NWs0ozV+MfNlLhWcLE
         Ynbq0sSw6lSc0WNKZJKGXQi1IUXghJnKUhQcZYyhlJrWbTDK8TNbwh5SHDP6Ren8ouNE
         Pyug==
X-Gm-Message-State: AOJu0YxN27tVh/t1R5kZDoY9NQK7lGEkN6xpxXYVTAkwf5s7vT1vm5Sj
        4DrJeguRS/Np7FmrFNQ0uA0pSg==
X-Google-Smtp-Source: AGHT+IFrtQWRed5woEiP7OHw9z2/OjVdZwkPgM3Bm79oOPXqJYAs50d5rSrShOp61RLzy6A4eE0qdQ==
X-Received: by 2002:a05:600c:248b:b0:401:b0f2:88d3 with SMTP id 11-20020a05600c248b00b00401b0f288d3mr1255513wms.19.1694781966308;
        Fri, 15 Sep 2023 05:46:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id x12-20020adfdd8c000000b0031912c0ffebsm4366463wrl.23.2023.09.15.05.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 05:46:05 -0700 (PDT)
Message-ID: <b0fe17e4-e4d8-02af-4e09-06b3930b38fe@linaro.org>
Date:   Fri, 15 Sep 2023 14:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 4/4] arm64: dts: qcom: ipq5018: Add tsens node
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
 <20230915121504.806672-5-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915121504.806672-5-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/09/2023 14:15, Sricharan Ramabadhran wrote:
> IPQ5018 has tsens V1.0 IP with 4 sensors.
> There is no RPM, so tsens has to be manually enabled. Adding the tsens
> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
> critical temperature being 120'C and action is to reboot. Adding all
> the 4 zones here. 
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v2] Fixed node names, order and added qfprom cells for points
>       seperately to use the calibrate_common and squashed thermal_zone
>       nodes here
> 
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..d53aea5342e2 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -93,6 +93,117 @@ soc: soc@0 {
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
>  
> +		qfprom: qfprom@a0000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

