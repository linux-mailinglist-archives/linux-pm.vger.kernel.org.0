Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3446F5046
	for <lists+linux-pm@lfdr.de>; Wed,  3 May 2023 08:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjECGfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 May 2023 02:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjECGfF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2023 02:35:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7683AB2
        for <linux-pm@vger.kernel.org>; Tue,  2 May 2023 23:35:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so6185324a12.2
        for <linux-pm@vger.kernel.org>; Tue, 02 May 2023 23:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683095700; x=1685687700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMFo4LAZa4YtLPJ6qEk81O5BipagK49hgJHUBqyoSis=;
        b=E5s1u5FxHss0P+zTalLTG8HqkFTrJ37c1di9ToPR97HaOhNLGG4OJ2wKw/5GNzX3D8
         uilYVLByW0yUy1RYGeTHqTFX0wvSoSppKsniLBC1RvAMcw2R5ykVQUnQm7DasVi986U5
         8d2rgkaihLrNfFxeR/NdgaHh6ItG0EQTAp9e4BSCAMuFr/1qre3nkCwsskc4BHqfeF33
         3Hn1BBN5QCZlnbwTFX8KnIZkTuP+NeBtyyreorZHJhLyseyZlhCv+rIfH1pi9c9qRQb9
         RlExTG9zAuI4GuzOhvBo+hK/cDAtJg69HuNdF/JOY55qxjPrHXZZdnYYr6dXTzjFhfeN
         tZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683095700; x=1685687700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMFo4LAZa4YtLPJ6qEk81O5BipagK49hgJHUBqyoSis=;
        b=GHhNVFO3chckUOE/dlIIQ2y2F2X+wyMKz7IOIyTCM+YtP9bvX9hrETUCi4+QV5bkBe
         aktoME6QrkWIkytE3goGE0Pb6btEcgNcBod8OW6Mq+i/uC++q2F1PKLmqtzoxP/AW1ja
         icOMmE6/XsieIlqqYTVWvyi0K15/bmnm5nb2nHxYQhnciY7rN4GL0XlRVt1LRIui/1gC
         hwS8RXxIVOWCf82o8NuATQDV8E2ZjSuSOTTIYyvrlmOfGJIOS4waYCMN4S9wz/9vplHT
         00s019DToNjCqtykQlFY5TI1sysHp/GLLa0SQGpGdPzQlWtfOPiEm4Ng9WyDCc7sI6js
         Zg2Q==
X-Gm-Message-State: AC+VfDyNBpqKEeym4TxjAGcP8LYGjLnGMwss/6eVWbCg4+rdvVRvfkBW
        Vwd/30K40RgKcRpU74KhjsFtVw==
X-Google-Smtp-Source: ACHHUZ7FG/WPl+wSn/Qk7jTI3vhfRmWf5CtCycTgE9z6uCr2Cx9bg5PwVqINYyomcMsCZmMUvyQOlA==
X-Received: by 2002:a17:907:62aa:b0:94f:31ee:ba36 with SMTP id nd42-20020a17090762aa00b0094f31eeba36mr2236824ejc.37.1683095700184;
        Tue, 02 May 2023 23:35:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5? ([2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5])
        by smtp.gmail.com with ESMTPSA id mm26-20020a170906cc5a00b00961828830d9sm3753484ejb.35.2023.05.02.23.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 23:34:59 -0700 (PDT)
Message-ID: <447ccdf7-8643-99c8-7eed-64333ebf2d95@linaro.org>
Date:   Wed, 3 May 2023 08:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 2/4] thermal/drivers/tsens: Add IPQ9574 support
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1683027347.git.quic_varada@quicinc.com>
 <760555de9101e19a2301ad676dfe687ffb499622.1683027347.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <760555de9101e19a2301ad676dfe687ffb499622.1683027347.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/05/2023 06:46, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Qualcomm IPQ9574 uses tsens v2.3.1 IP, which is similar to IPQ8074 tsens.
> Hence reusing the data_ipq8074 for IPQ9574.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/thermal/qcom/tsens.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d321812..e752b7d 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1093,6 +1093,9 @@ static const struct of_device_id tsens_table[] = {
>  		.compatible = "qcom,ipq8074-tsens",
>  		.data = &data_ipq8074,
>  	}, {
> +		.compatible = "qcom,ipq9574-tsens",
> +		.data = &data_ipq8074,

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

