Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0075DB6C
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jul 2023 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjGVJhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jul 2023 05:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjGVJg7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jul 2023 05:36:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E877A4200
        for <linux-pm@vger.kernel.org>; Sat, 22 Jul 2023 02:36:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9939fbb7191so576498966b.0
        for <linux-pm@vger.kernel.org>; Sat, 22 Jul 2023 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690018569; x=1690623369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jw5vB4jQadlis7FBZsHKEXJYndmWMjgiUazeh+f78kg=;
        b=o6wzJbilZ/Q4qzk60E8uLdy2i7o0n324xMztUu5qVkitJfw/6sFUw3hzGXLAvs5mqU
         YyJ0prZiMMCnQPBkRaN6zSGKmtHL1uOc9Jd0/ZXReBqtIJId7pMrGR/SQNVs7jFjZnVw
         7uZ30JijP3y25ApXq1rsU4Airl1d/RVvOZt3HwY5GXWMc8nkP7xYF4LV2rBIHADGlysE
         owRrGEwjrlsVz+gER0nO63/0GAJSySji0Ajh7NrjQo1bN+MdU8NgWu5vqWpHAlFQmq+z
         FXmTKRNmHowxL7FVHFgkN8ALXTnxxaUwApcRWfSE2KFjC1Xy345mscSdxj6yKKqT9tcD
         I5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690018569; x=1690623369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jw5vB4jQadlis7FBZsHKEXJYndmWMjgiUazeh+f78kg=;
        b=cGU7+fL3WJFToqLc8FxdDHkio818m34O9EcpIN5nx3K+t130TaJImr2BPdUVScP6po
         rMd+ZNyecgj3zw0yWBQe3iuCK5WGKyr7UlubvcuWQoWCJsxB5FLH45V/MH7R6S3rfQDF
         eOd1AiBn55KTXu8gtmyuXqSMCKzoxtOhz+KkhiJgTvlYuWa3L+F8TQCxKvvPf6L1cSMB
         mXEAR81fnpAkx2tZSfTeEzfWR3P0Eoj9Ck+s/wiT3+wcgfC0PnvWY5JpM7csqYfvS9kH
         W+CSUiVeyvpXfzrOyZc7ntLkVebMVVsm/hdW/zUwcOh8N5Wcx5eVhup1x+BQLcueGeLG
         Wc7w==
X-Gm-Message-State: ABy/qLbzHyKYRKtSgqB02SqH0TfJkwpP6PwwY+XX594gkRa7MjL69qSr
        pzF+Lz44wGol8COdNQPuqsGdaQ==
X-Google-Smtp-Source: APBJJlHp69yH1Rxzbyg6zI+m+OBef9KIwhv7f+VTzcaI9qEXRvCokxkybBCwOyvbMXYWJRslRpwyrg==
X-Received: by 2002:a17:907:1dd8:b0:994:5407:9ac9 with SMTP id og24-20020a1709071dd800b0099454079ac9mr4490099ejc.5.1690018569292;
        Sat, 22 Jul 2023 02:36:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906080c00b009927d4d7a6dsm3274640ejd.192.2023.07.22.02.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:36:08 -0700 (PDT)
Message-ID: <8a1a6c29-808f-9731-02ba-11826d9b54fc@linaro.org>
Date:   Sat, 22 Jul 2023 11:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/7] dt-bindings: interconnect: qcom: qcm2290: Remove RPM
 bus clocks
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
 <20230721-topic-icc_bindings-v1-2-93e2bc728fb7@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v1-2-93e2bc728fb7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/07/2023 15:54, Konrad Dybcio wrote:
> After the recent reshuffling, bus clocks are no longer exposed as RPM
> clocks. Remove the old description.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/interconnect/qcom,qcm2290.yaml        | 42 ----------------------
>  1 file changed, 42 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

