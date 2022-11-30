Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EF063D8D8
	for <lists+linux-pm@lfdr.de>; Wed, 30 Nov 2022 16:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiK3PIo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Nov 2022 10:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3PIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2022 10:08:42 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2D971F1A
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 07:08:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp15so27353990lfb.13
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYfIBfYi65QOjaw7VkDUPxWFzywCv79WV4n65fszNVU=;
        b=sf/2hz/IrnallWjP9XknwUUDXHJblaEo/mri/HkWsjmzY9Yr4/WWEU6udOKIk2LbZZ
         JYwehJjD9anBF7rMx5ggMRESEhnAU7X2nRSjF6BcWt2zEUDeL5phkf8NSSYzLII7qZ9b
         R4YLwjPB0m5mcLxIKnjx6oRUv2hy3px/Y9pLx9DlOn5t80oaawpjVqY+oIMDOUHOOclk
         i9taTM84hKpMbFvznl+qh70JXN5Q7SimgyquECB8clAnQOGGG01Wai8vVh3FJ9uoFTrN
         eF8qwk18aAp2/ItmdGq2cTnOkPj0Ev8bo54XnWwwmiLR7yWHY5S47LGlNrqYyJ2FQp1o
         MfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYfIBfYi65QOjaw7VkDUPxWFzywCv79WV4n65fszNVU=;
        b=kRLgiefgGlkOn5et6vF3AB+UlS9vun+HlWYINLQL/Sx8UpQEWJvOCAuVJQ8Il68rmq
         SRDC3hr1hBc1HthCfxKES7xXRq+0ICVUD1ecIqKEx3/d8XaAXYNR61dLi5GRs6nfdbxs
         RrtHGvdoR/+wpJS2JAM6UypyVEAH9OOPhsV1Hx8QdTwmkJ7aQgVG455C6LzVOLOp4SyL
         3xSMLh9P1Dj8RvAR8SwtzBl2O0WYRP21KtM1PTrQVKFz35T78Yl0klaMFV4F3iapvisy
         0DAvjBmETx4Wv7dZ+DuYisWICx4/7bJajMEmpVME58r16p3PHllU1XTMORFYiZEDwI0W
         NIrQ==
X-Gm-Message-State: ANoB5pkrSl9sJjNoyhgEoVexmtmU2d0QvvqOg3I7Q2tadffsrtiVcDN7
        Ci5HCwmtNy8Ci/T9UoTlIxYS5Q==
X-Google-Smtp-Source: AA0mqf5Wdcn8iJZuhr5JDcQFbL8gXEwhGIZrCy6wdy3H+GPIx6fF1A2ejA8+AJRekiQCwjCpDmUgIA==
X-Received: by 2002:a05:6512:211:b0:4b4:ea76:8017 with SMTP id a17-20020a056512021100b004b4ea768017mr11854189lfo.560.1669820919397;
        Wed, 30 Nov 2022 07:08:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y15-20020a19914f000000b004b4b9beb0eesm292896lfj.50.2022.11.30.07.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:08:38 -0800 (PST)
Message-ID: <dcd1ae97-e04b-1021-37d5-749d263cdabe@linaro.org>
Date:   Wed, 30 Nov 2022 16:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/12] dt-bindings: thermal: tsens: Add SM6115 compatible
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221129204616.47006-1-a39.skl@gmail.com>
 <20221129204616.47006-3-a39.skl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129204616.47006-3-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/11/2022 21:46, Adam Skladowski wrote:
> Document compatible for tsens on Qualcomm SM6115 platform
> according to downstream dts it ship v2.4 of IP
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>



Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

