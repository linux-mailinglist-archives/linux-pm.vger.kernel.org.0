Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB527979FF
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjIGR12 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243586AbjIGR11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 13:27:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24D31BEA
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 10:27:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50079d148aeso2023746e87.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694107569; x=1694712369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpHIUYmzApKmGGiHZZpnMSxi31KSn/xZKBPfgME94EA=;
        b=V6Us4WQ4SvWzE5lMj/d9C/mcpM8sOF0YlgeP7Cta3YifaBDXuy5RqtCHPbbnPWlL0R
         cWNyJGbChsaBkMnwCH6Tgbuy02s3w1sJoL+CXouDq3fDpvPyWAd9l0qN/Jh4lw8AEih6
         xsJtQaaF0kzZdLrOLz4PYPCZzMRhyoqGDX7+OfVvHS3Ln6EpuZC6AchSLdRevKdm7nfN
         CLJnH94gV2cnbbvv2m+BAtBN9ImIArEOO/GbnM2NqlAGuZ6DTIyv+Dpt/vAlD3vaeIlm
         GESnA+WpiXjS1ZaMihHCD88VgfvaEEnFcktROvKNOdARCPPwcN0Gcc/vPwiFyKaws30h
         cFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694107569; x=1694712369;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpHIUYmzApKmGGiHZZpnMSxi31KSn/xZKBPfgME94EA=;
        b=rP0bLSFIhxJd4RcxEJ36eho1Na2LmulzS/u5O1AlMmRfFRZbeeAM1Lnio0QE8ThKmS
         +2/05CmJhmPLpDoTjJ+YL0b4yfaM9aobXpGMRxnCtOBIZTszRbVqjEiKxXPCFCPQ6MDG
         ecJt7PpJ8oclHayBNjfKIPGLxg7ofSrQtWG/T/yAYLRGtwNj/RR9eyKonpWSPofJwWq2
         PXHMeWlcSNAW+3NPOUMgRWglncuVuz5TEy20GHvuzVb4PTM+tBKyuykB2KgfR3mvSp3R
         C1ldYZkUFqZHLDIBYVAFv4oXcNb1XNdviyLPHjrCL8NvdEhZTBrKJu8vYEp37DwhQc/M
         SKHg==
X-Gm-Message-State: AOJu0YxkiH5sjVnaePAhXYBV75t6z+Vh7e8GGBw9sFGWLaj5Oy1uC5Hl
        3k7rHGyjaBXDuSJdiNbmF1EUL1PriL9Jz08gOZaUXg==
X-Google-Smtp-Source: AGHT+IE6rP7AS4FnGxp/huXUuWImGW5DpdIfQDtTj/sIRkZFOXfhElTxhQiu10RgpaNZRjIoSI51Qg==
X-Received: by 2002:a17:906:5c:b0:9a5:db06:4264 with SMTP id 28-20020a170906005c00b009a5db064264mr3607933ejg.72.1694066638936;
        Wed, 06 Sep 2023 23:03:58 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709064e4200b009a5f7fb51d5sm9928020ejw.21.2023.09.06.23.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:03:58 -0700 (PDT)
Message-ID: <4f882fa1-8174-2816-71c4-a2941372aa19@linaro.org>
Date:   Thu, 7 Sep 2023 08:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 10/10] arm64: dts: qcom: ipq9574: populate the opp
 table based on the eFuse
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <1512a94f8fe1f8fe22cef2bf8498a6ac27989633.1693996662.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1512a94f8fe1f8fe22cef2bf8498a6ac27989633.1693996662.git.quic_varada@quicinc.com>
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

On 07/09/2023 07:21, Varadarajan Narayanan wrote:
> IPQ95xx SoCs have different OPPs available for the CPU based on
> SoC variant. This can be determined from an eFuse register
> present in the silicon.
> 
> Add support to read the eFuse and populate the OPPs based on it.
> 

...

>  	};
> @@ -223,6 +254,11 @@
>  			reg = <0x000a4000 0x5a1>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +
> +			cpu_speed_bin: cpu_speed_bin@15 {

No underscores in node names

Best regards,
Krzysztof

