Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9252375DB79
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jul 2023 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGVJmD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jul 2023 05:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGVJmC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jul 2023 05:42:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8824EAB
        for <linux-pm@vger.kernel.org>; Sat, 22 Jul 2023 02:42:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso23107675e9.1
        for <linux-pm@vger.kernel.org>; Sat, 22 Jul 2023 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690018920; x=1690623720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIiKd8WhXPxz7X6XYM8LX2pk87FlZNE/jREJGMzG5bc=;
        b=lTr70M+v01b1HK/Rs0QIfQheuBdH7tjoJmDoxRUdvtjVgBjSwBMUdItWDtUOeZOJEe
         pTxTAh5/BNzKSBPIjWobW1QJUnmOeKQ70Ryb9g9E3sd/AT8i5hIvKS1xHQoe2jtR9MZY
         Es6jc9JuuAqCz4BnUd3BZlEVxhq/UQx69PJgG9HprXxj6R/sJmE1cG3oX2F7q7wD6Vh/
         JT+rw6Gb1fUyhQRa0oghXSPxF9GkRwPIPk5Fvgw15Y7O91tyJhavGnpZRrfkTU938u21
         4ZGXF8Ejwrq9o4L81HlZYhpcV3IgsLDQ4p5yrKSVwlc939M6MBFlZ91O4Kh7HrEQmVRr
         Kz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690018920; x=1690623720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIiKd8WhXPxz7X6XYM8LX2pk87FlZNE/jREJGMzG5bc=;
        b=IyPXPWLTDhVSBcvwrLhs40uK8uj/bUHYTTj3f5LJXcRRIwplV2UGtu4A7AIpl8n7yr
         h2NYzemJ4b9XwrfmGuGwllO/Cx1NdeCnp4l7ZYmCae755Wb8uIiGcmmoxOtZ6b+2YBPu
         1iaYD3RGnWiXhuEaJG+C4aWB+mxo0USc+x8eVCKY5xwBTwAE7fPP9/cfQ2zQbiN44v/4
         Bf29qVF286qrhiHGoI8jnj7tv2I3S7CN5CVfyPcIhl/XegssDImncp87Bb6CzXDdcbfw
         n/2izChcqNn372HZvqo7LfkGDOzW75KCdNSEHmQ/3pNi1yYSZaKsBTgO7BAxslQ27+TH
         C84w==
X-Gm-Message-State: ABy/qLaF1w8wrZdJ9OqNEbdftPGUN/TkLRF36J/Ajf8MELQnTdtmhfS9
        736R/5neBfazbSUt3w29tBMYnQ==
X-Google-Smtp-Source: APBJJlFi9gcxEqT8Nrf3W3sLqaEiCNa3FbHoebyV+XTi/Z0TwxbzXjy2gMsN4FU1Y1OAcLSTdClcdQ==
X-Received: by 2002:adf:fec8:0:b0:313:f86f:2851 with SMTP id q8-20020adffec8000000b00313f86f2851mr4007408wrs.3.1690018920017;
        Sat, 22 Jul 2023 02:42:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d65d2000000b00314172ba213sm6405562wrw.108.2023.07.22.02.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:41:59 -0700 (PDT)
Message-ID: <b2b68cc6-1dd9-25ed-c65b-c4bf3a5a4f16@linaro.org>
Date:   Sat, 22 Jul 2023 11:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/7] dt-bindings: interconnect: qcom: Fix and separate out
 SDM660
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
 <20230721-topic-icc_bindings-v1-5-93e2bc728fb7@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v1-5-93e2bc728fb7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/07/2023 15:54, Konrad Dybcio wrote:
> Separate out SDM660 icc bindings from the common file and fix the
> clocks description by removing the wrong internal RPM bus clock
> representation that we've been carrying for years.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

...

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sdm660.h>
> +    #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +
> +    bimc: interconnect@1008000 {
> +        compatible = "qcom,sdm660-bimc";
> +        reg = <0x01008000 0x78000>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    cnoc: interconnect@1500000 {
> +        compatible = "qcom,sdm660-cnoc";
> +        reg = <0x01500000 0x10000>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    snoc: interconnect@1626000 {
> +        compatible = "qcom,sdm660-snoc";
> +        reg = <0x01626000 0x7090>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    a2noc: interconnect@1704000 {
> +        compatible = "qcom,sdm660-a2noc";
> +        reg = <0x01704000 0xc100>;
> +        #interconnect-cells = <1>;
> +        clocks = <&rpmcc RPM_SMD_IPA_CLK>,
> +                 <&gcc GCC_UFS_AXI_CLK>,
> +                 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
> +                 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
> +                 <&gcc GCC_CFG_NOC_USB2_AXI_CLK>;
> +        clock-names = "ipa",
> +                      "ufs_axi",
> +                      "aggre2_ufs_axi",
> +                      "aggre2_usb3_axi",
> +                      "cfg_noc_usb2_axi";
> +    };

Keep only two examples.

Best regards,
Krzysztof

