Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB956FC218
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjEIIxk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIIxh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 04:53:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54911BC6
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 01:53:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac7462d9f1so61704211fa.2
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683622414; x=1686214414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKcSXm1jN2HZxfTOm2QccH4k/B4k/rPFD2WDhppfMdo=;
        b=bN9aiGV+cx/Vr6sT9coXI3GdvyRkQy/N3/Yz08nFWzCk6fbCOoNiZGDnXaQxAhOTHz
         w+0vhE5UxPhfn7FM2iJlGdza9i+2MjlPHkd+rKLvVK15OLvEnIoxcKdt593fV/oXDLRE
         QhPQ1M6tAb/hY1UWn4az/ep/TEpj87GotVUv4Z3bF+JyKdrR09FKLcXGdTvCuZ0zTeEP
         dtMo87harGkVV3t5QrHnDnlrZjz2Sryp3xB7IRVHxxR+04bNEGqndD9+pncQFAlZGTos
         /+YCr0FqD2X8Dy/kq/ifiZtVFWXarEzwZp8Pj5jz/WKp9CzkwF7EdPU5VX51Tf7WznLM
         aUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683622414; x=1686214414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKcSXm1jN2HZxfTOm2QccH4k/B4k/rPFD2WDhppfMdo=;
        b=AuZkUYFLeWii3BZBVKx5TaiB9BExVvFVQEsQnP2neuC9ddPU0sgUQxLc0bsWbyqGfd
         NV3imo8kIo0p83G+gQ/ETNo1dIeFNe6TGtuu1bgPHsiFjqZTJZMz6CbAzwX1hRHppki4
         07m1n+L8I6uVyXv272MC4K3BitZHpt3oUS4Kcc9kPK0ff91GoaVukSLenknsa6PEesDm
         TZlaOjONjbiC+6HHWdZmYy/BcbIJ1xNKWkJtKgdDeSaiYqjeVi6dEra7TLhe2/NBojH5
         hFJDp8Fj/5HqPefwPYX+MG3RzgP8aP0Gw4mcvAsXmnK0YU7ZHqX4Qa/zlyZ0X8tJizBT
         zbxA==
X-Gm-Message-State: AC+VfDwVMEQoTkcjCMB0QX/gwoEfq2wUSTieUT5rj0JROB1cc+vKkFOO
        TeMP+RPgcfS+lY1Z1TNndtiebg==
X-Google-Smtp-Source: ACHHUZ6qXqNA2F5HKqJNIX1LtVu56Ddi49oZzBDFws17/hWEa9mXsRefo0/fkGL2NfD19eqoDPotrg==
X-Received: by 2002:a2e:95ce:0:b0:2ad:9028:4fd with SMTP id y14-20020a2e95ce000000b002ad902804fdmr697105ljh.35.1683622414137;
        Tue, 09 May 2023 01:53:34 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e9588000000b002a77583b718sm1477334ljh.12.2023.05.09.01.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 01:53:33 -0700 (PDT)
Message-ID: <32d6b9be-58f1-1d63-2c1b-de9f7ba7b3b5@linaro.org>
Date:   Tue, 9 May 2023 10:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/6] dt-bindings: power: reset: qcom-pon: define
 pm8941-pon
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
 <20230508160446.2374438-2-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230508160446.2374438-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8.05.2023 18:04, Dmitry Baryshkov wrote:
> On PM8941 pon doesn't store the reset reason. However we still need the
> wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
> device.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Should probably also disallow setting reboot modes!

Konrad
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index d96170eecbd2..0f4f55dd4eac 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -19,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,pm8916-pon
> +      - qcom,pm8941-pon
>        - qcom,pms405-pon
>        - qcom,pm8998-pon
>        - qcom,pmk8350-pon
> @@ -63,6 +64,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,pm8916-pon
> +              - qcom,pm8941-pon
>                - qcom,pms405-pon
>                - qcom,pm8998-pon
>      then:
