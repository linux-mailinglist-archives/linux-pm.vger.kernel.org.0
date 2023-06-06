Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E175472372D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jun 2023 08:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjFFGHT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jun 2023 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjFFGHI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2023 02:07:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF3E55
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 23:06:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977c88c9021so422381266b.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2023 23:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686031611; x=1688623611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70U1Q012Arkvcx5mvXubiW/F2gAfaONAjH5lT/7WlvU=;
        b=FwdJwg7KgSK2Wwy3ECLHhpcdMeuZtbx74g2OGRGidhbgcQ6qiPYftWQ6JompvNiqEk
         ik1DnRnNyTyx2AxisrtPJIx3kSzcb14U8FuIBxYtLUviWKbYtdfgz3TG1zCNgK3XWPE8
         y1RcCHxueGsKoE/KC8gIjB7fGXBMtd876kdjdEaVhklRfO3fLQlAaYaZDNfx+eJ94SLZ
         WlsjkjCJALb5Do+A1uF51PSYL3/tbkK3bh5C93nXPAHUywZBCYPdV+FNJasQEL/QVHx1
         at4UlUi3vSsDOdSYAZ0kVU9VKD4p70Lecc6EiCjKdDoX0gOaKYptJT+SgwKMBQDuia8y
         1gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686031611; x=1688623611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70U1Q012Arkvcx5mvXubiW/F2gAfaONAjH5lT/7WlvU=;
        b=NFenEcD7YSNRqlU/j5MxXRmbEkFoA5q99Y8+NJEiVA0i+2AbBTpZpxMt7xB7k0ZM4t
         GeFOOAzGNKyzfIw89mGjFWVg2xWw/whDgf8LJ7rHxq7TdTpnCd/UAgPhNUCNftO0SdnI
         b/08qogFXnh4lFUats/FChKM3nk8Ofc1GMLpO6ij9C0jZ8TNIOeH/QVtZNFbhsPcuuyY
         tYY9h4LCtsSqzhStwGpdT4gAM8OFw2kO+K8QmcgnZo/kpHUPgmVcyWPlG9xrToY8aLyu
         IUVplZRoeGaFjf0uQxfPvSn1LIcTybKHtIs18421ojUArRafhXSmGelu6csa5MfoZByR
         4aDA==
X-Gm-Message-State: AC+VfDzi/YbMcG55wM76H+5fxAQk2bgsPc8061JyuM2OaENm87FCtGQS
        RcID8auM9lr7gPQ4zOl7SmkZ2g==
X-Google-Smtp-Source: ACHHUZ7K+10SlLxGan8XiIuR06mM+0EdUD7vth1kPHI0gcVWF/WLesu537LbR8tywrkYFsC332XcBQ==
X-Received: by 2002:a17:907:60d5:b0:973:ff35:a9b8 with SMTP id hv21-20020a17090760d500b00973ff35a9b8mr1062659ejc.62.1686031610221;
        Mon, 05 Jun 2023 23:06:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c95a000000b00514bddcb87csm4669771edt.31.2023.06.05.23.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:06:49 -0700 (PDT)
Message-ID: <a2761197-7121-d6bc-6bb3-a716339f4e26@linaro.org>
Date:   Tue, 6 Jun 2023 08:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 09/10] arm64: dts: qcom: Enable the QUPv3 UART console
 for SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de,
        maz@kernel.org, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, mani@kernel.org, robimarko@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-10-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1685982557-28326-10-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/06/2023 18:29, Rohit Agarwal wrote:
> Enable the debug uart console for the SDX75 IDP board.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdx75-idp.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
> index 1e08f25..cbe5cdf 100644
> --- a/arch/arm64/boot/dts/qcom/sdx75-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
> @@ -11,8 +11,23 @@
>  	model = "Qualcomm Technologies, Inc. SDX75 IDP";
>  	compatible = "qcom,sdx75-idp", "qcom,sdx75";
>  
> +	aliases {
> +		serial0 = &uart1;
> +	};

You just added this board. Don't add it without serial, it is basic
functionality.

Best regards,
Krzysztof

