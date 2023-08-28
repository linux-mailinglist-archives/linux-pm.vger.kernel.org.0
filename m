Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2988078B874
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 21:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjH1TeV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjH1Td4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 15:33:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C82123
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 12:33:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500aed06ffcso4041757e87.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693251231; x=1693856031;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CiarbQtD+xC5DtTjisG8v8mGGJJMolzlgfURNHkn86w=;
        b=PmOeSBTouvQtEcED9cysO6ruZgW1Szo0PTU18gI+tsZS3q7CxZfa//+Qm4TsRayb/f
         t1Ct/eQe+OcqBVB/7fnRxhtKnWXPLtXbXBxjkNAU9ZaS4XjO3AW4SBGz7IEonSDLg0Uc
         2wY8PLKaUOX1I/dstZz6EvPsKQlqgf9OvpbzCUnEQeIHIEI8QIpGQWB8jRUPWo1WuwXV
         fX7jlX+mbGVGUkOoOiTW3J7ehlqfQsSZGX+436tjPxjKtHdlOWSC8+QucixsVhaOamnH
         QZrKLyfc0lcrY1VMXEK4KQLhUWifpZtoNQ2FFqohC55FlmL2zpHLyVHXOMpgFt08qBeO
         hgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251231; x=1693856031;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiarbQtD+xC5DtTjisG8v8mGGJJMolzlgfURNHkn86w=;
        b=Knl79QveDRIfhA98cwJC6KyL69/EXhV5/YPvFQhukZvYWpd9ZWUz2qzF3uWintlJqX
         P5fHMEXEIQ/DucyApY+NVexc+UD1kgI/0vfJ93qidXyErdb8atgO3F5bfWzBg+VEXcQ3
         UZIGx2AlDa9EwarLiBdHoPuhaPTUnt+5/rZSnfQPjkNvPgh4F5zqBIrRTKlmWOeqyu8n
         T5GX+3vaIBQ0LO9xsjWCnS1714jUAgDwmF1Va76UWaZT+Rksp0bYNYR4AdJ3IbyeoMEy
         vChQsbEz0V5k/6mXeiakylzQi7EvjlzYY4JODMldTgNsws1KX1yDFp7ZiHFIm61BGbHz
         dd6Q==
X-Gm-Message-State: AOJu0YyIL9LRiSPHmMO56NO4J0srluBILeZeXrGThSAdMsdpdOylyqWT
        plrcFZc2VRp66r4tueYuGxGeuw==
X-Google-Smtp-Source: AGHT+IHjz0sCfIdVIddGOrOzZRol2eqGwQHs8xLuV1s4P3Us5juhskU/HlZOlEIgzvFipqAoI2L4RQ==
X-Received: by 2002:a05:6512:11e3:b0:4fb:ca59:42d7 with SMTP id p3-20020a05651211e300b004fbca5942d7mr17418630lfs.33.1693251231327;
        Mon, 28 Aug 2023 12:33:51 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7d615000000b005256aaa6e7asm4760940edr.78.2023.08.28.12.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:33:50 -0700 (PDT)
Message-ID: <4882b193-9135-f5f1-74b7-7321ced261ef@linaro.org>
Date:   Mon, 28 Aug 2023 21:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/7] thermal/drivers/qcom: Add IPQ5018 compatible
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
 <1693250307-8910-5-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693250307-8910-5-git-send-email-quic_srichara@quicinc.com>
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
> IPQ5018 has tsens V1.0 IP with 4 sensors and 1 interrupt.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  drivers/thermal/qcom/tsens.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index f39495b61952..a24eb88b3444 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1101,6 +1101,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
>  
>  static const struct of_device_id tsens_table[] = {
>  	{
> +		.compatible = "qcom,ipq5018-tsens",
> +		.data = &data_ipq5018,
> +	}, {

This patch does not make sense on its own. It must be squashed. You
already brought the IPQ5018 in previous patch.

Best regards,
Krzysztof

