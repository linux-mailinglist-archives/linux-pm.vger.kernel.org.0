Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446D15BCB19
	for <lists+linux-pm@lfdr.de>; Mon, 19 Sep 2022 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiISLxQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Sep 2022 07:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiISLxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2022 07:53:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6BC2BB16
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 04:53:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w8so46495911lft.12
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=B6qYgq4tZVjjKBdLQA77w07q/sp4ao3eYtkYwlJCGPI=;
        b=XwquBQPtdvbakJD6j/fG9HvmxdVvgha8hwkeOcfCmTMp3ZCVhS0V35T+dLtI4bvIvZ
         Cjv7GrzWqO9l51NSVr4/eFeOQ8oobBOXvvZ0INp1IBRtcQUtw3MJOiZTVobzY8fLLHpi
         RM51l+vvhP2IOku2whKFq7PSlOtDwWbzx1ZTqtFgVPCf5PMxAgzKiIS8bSFWRcuowM53
         nX+Rv5u46hlPwUaUEfg1kucyCWZenLMR6TnnO+DhkZ5cp/j03bmLPcHgGSHW29xb5NHn
         dLP7/MjXRh1y5rbhhXwB87sxeLrhB7DE86OZcghtegA5KdLhrAeHR0TTEjoq2ZaCXQwU
         XSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B6qYgq4tZVjjKBdLQA77w07q/sp4ao3eYtkYwlJCGPI=;
        b=1f+q0lELtC0wYsHhdhE38Sn6dg8JwrA6VqmIzz6vnUkO4aB8beag61k+rAbZjrmhFt
         eRU1lpQoSJ7V1lr6z+2NaZwbHfA1MpJ5Ff8QaTMtIgoOHxDIZtQvt0CYpMoqYTXM5Mk0
         WQwgJbT9t4mFzN6qxtDdHAFAD6BbCh8qO9Hl/u3aNXQ7uT5xLMsi/mZL4FYIafQul0eW
         Nu3bkLG1qtG9uKQn8uYtRWt+O6PqR+zdgWFu03gAXadiJdLLvzMhoDUwTDFBw+g+hAbb
         8/2neg+Bhxqb3Fu+/OOXYle+xAHLU3w2tgwWQGWXSR+Sbus6PZiv1irPpU2akwSEVxej
         JiHQ==
X-Gm-Message-State: ACrzQf28nM+GoV+ZQ+TqZLMUtdxa/4AnCp231/QsPa0M5x9gQT2IaX8v
        O7X8amm5c9psGb+TP2MRF+KKcA==
X-Google-Smtp-Source: AMsMyM6JZ3UfeH6M8omR0Zt1TEDfX5GQ9ftvQ8Y5pDm5vECfEUfq19pM7T0gGok8g7xxQwrbwC22YA==
X-Received: by 2002:a19:5e50:0:b0:497:a331:91d9 with SMTP id z16-20020a195e50000000b00497a33191d9mr6253444lfi.162.1663588389325;
        Mon, 19 Sep 2022 04:53:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b0026acc9edecdsm4893992ljo.47.2022.09.19.04.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:53:08 -0700 (PDT)
Message-ID: <b70df37b-e803-acca-e7e1-5b4526e76776@linaro.org>
Date:   Mon, 19 Sep 2022 13:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: thermal: qcom-spmi-adc-tm5: add qcom,adc-tm7
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220828081022.96813-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220828081022.96813-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/08/2022 10:10, Krzysztof Kozlowski wrote:
> The qcom,adc-tm7 compatible is already used in PMK8350 so add it to the
> Qualcomm PMIC Thermal Monitoring ADC.  Based on downstream sources, the
> new compatible for TM7 differs from older TM5 by allowing configuring
> per sensor decimation, time measurement and number of sample averaging -
> unlike one configuration per entire device.  This was not reflected in
> the bindings, therefore comment the new compatible as incomplete as it
> might change and its ABI is no stable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml | 1 +
>  1 file changed, 1 insertion(+)

Bjorn, Daniel,

Anyone picking this patch?

Best regards,
Krzysztof
