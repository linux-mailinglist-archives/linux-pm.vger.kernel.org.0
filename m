Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A3878B838
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 21:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjH1TZt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 15:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjH1TZm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 15:25:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FA9124
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 12:25:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c353a395cso463932566b.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693250735; x=1693855535;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/61/Jtw3sjcBqjmdxX+cX6l07WobkcJLL3KuqjFb6A=;
        b=cm1BP+wtxglWb0HG8Jh2xdEv8ViqJCxfnghG/SjVY+6Tc3SJJdcqL/pgwzymLG0jee
         Kh9I7URgNJfNk3cawlWuGzI1JY3cwFK3QIUzKDkGfQDJ1Nfbvm7La9Wj/rmCAQzidoQD
         jghFGZTfYoYSSKUUTsXIWNkSMD44i61l4Z80gTxOeZH0pxwMNciDvSYzcmmerjpjWexr
         KLjLxOh2cElLOf67UHaS4CbaGfEHLmjmJYb1fn6tlTaBfFJx+3AGzeMzxqWj5S4zUQOi
         qQGY1z/c5c9nBI65/7xsU5kUqMP9JVpoD1I38kV9oc1D886PvashY2UM0vMkzL9g1xbC
         8gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693250735; x=1693855535;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/61/Jtw3sjcBqjmdxX+cX6l07WobkcJLL3KuqjFb6A=;
        b=KAd/xIp7d5lo34XAnEgO3O8WssNxr4xN5WJln+QcyQn5UnhgK5YgagXFIT9zRWuae4
         ZJsL/nKSCRJF5Uq20jKskiI6HyUnAeyI0KKwoNxD7W0ljsbuawAPJXuYDu7EdGIVvi67
         l42cXlkBY/nJlZA/XQPbSilKFL0S+5qjuTQ40WM3OYl8nFrjtZcO033V4dQjxyXAoT2j
         X+f3WEL3RZqFmWfmeciVOK+ffQd+JjBL+dDqfopCZWOMEKv/Qn49KAXQs3SOB47pepOq
         L4MevBWMbTiG77kHXAgxXH3Fst5OqNNhhItqACXTG/XWgFgVhPAhCkArGCfj+IgOgsP/
         9Sow==
X-Gm-Message-State: AOJu0YyURJVQB1SxZmCjCqSViQCp7rVnvlWGhKY7oQdWVu0deBKFX13q
        tyQAClnAWuxKUkDZ3PQDx9mL+Q==
X-Google-Smtp-Source: AGHT+IGNQJPQLYu2+RCR07QMDcIwBhyAxdTt4ESNCHTrEpvOxyMlIhtB9ugix76vBJP5nyP7/ToHGA==
X-Received: by 2002:a17:907:2712:b0:9a1:c659:7c5c with SMTP id w18-20020a170907271200b009a1c6597c5cmr13137298ejk.18.1693250735538;
        Mon, 28 Aug 2023 12:25:35 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id uz16-20020a170907119000b0099b6becb107sm5044308ejb.95.2023.08.28.12.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:25:35 -0700 (PDT)
Message-ID: <75ca0f84-3aa7-aead-fc99-d72e46c6b711@linaro.org>
Date:   Mon, 28 Aug 2023 21:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6/7] arm64: dts: qcom: ipq5018: Add tsens node
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-7-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693250307-8910-7-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
> IPQ5018 has tsens V1.0 IP with 4 sensors.
> There is no RPM, so tsens has to manually enabled.
> Adding the tsens and nvmem node.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..277b3cfc7f72 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -93,6 +93,29 @@ soc: soc@0 {
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
>  
> +		qfprom_nvmem: qfprom_nvmem@a0000 {

Nope. Come on, where do you see such node naming. Please do not send
code from downstream, but work on upstream sources. Open other most
recent DTS, take a look how it is done and try to do something similar.

> +			#address-cells = <1>;
> +			#size-cells = <1>;

compatible is always the first property. Then reg.

> +			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
> +			reg = <0xa0000 0x1000>;
> +
> +			tsens_calib: calib@248 {
> +				reg = <0x248 0x10>;
> +			};
> +		};
> +

Best regards,
Krzysztof

