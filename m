Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C49641B96
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 09:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLDIaO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 03:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLDIaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 03:30:13 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B623E17885
        for <linux-pm@vger.kernel.org>; Sun,  4 Dec 2022 00:30:11 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id x6so10159020lji.10
        for <linux-pm@vger.kernel.org>; Sun, 04 Dec 2022 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEAdA2tVF8LZsf2n1iXOw7OGaaP2byXd0qqESevi+8I=;
        b=KEBOyL1H3wNxjNsCsrflL9EbNiiXkVxCp5C4hjn4Hr8zHQfX9sqaXAA6omrLiM3/B1
         NiwIl+tjZVJXnT4eQi7GJG0eRAWGU9XSO9UHU/FQmg2JUc3X83dkUzksPZsnAfSdA1/x
         dEQ49WCHjJq6Txvc7ccAke9CottCxLUY0LtONsCqKURYa1YXNvvX3jRc4tF8qimmdzWi
         gYHLvcXBoWlzCQupbHyZDPvcSW39mKDMpALiQRLF021DWcjIhQOcIARheZic4q2CEvO6
         lt34gekM3ahYf+43pRrDo6RX5uSPlgz9C31g4d/1QFkIP0640anP3CqAsdZ5/Ly8C0/D
         P4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEAdA2tVF8LZsf2n1iXOw7OGaaP2byXd0qqESevi+8I=;
        b=0Xsf8YkTsrSU+8TAOWTQFk6EPCc9BvanegEQytOn6/C+TEYwDJHgFJj4cP3j6tToSF
         oAW4jBWil7R9/36lAVmKgQDGh51W2knE82xUpUC/0OJVg/yYa5oxiA6QmCTsymWh4zi5
         wh9J2C04KeNZzOJSVVAEbf5/Sq5RvPbAiTDU3mBSK4kd/HgQLUzitIfINn4ACdqQ/MJr
         C/haM4MYWWlX/JFBa6Kw7imfiQwBU3H0W586rEyryWHaLouQO+bXkcV7YivLp+rSp0On
         ke32AmmyujbO52T68G1JTxPlbvZDdbRHYq++geyZIo3GMCKiS4lzsQbxGvzodm2BVpQB
         Vggg==
X-Gm-Message-State: ANoB5pn5EKgxRS60eucK5VhqiYJse7opxr1vkRgaJOHWlNetcco0h/DN
        KzfWbZba6QqWpj245WXuFAvPGg==
X-Google-Smtp-Source: AA0mqf5C7jR+6hYSd6dpy0tVAxQpBI7eTmjIBiT886Zz8Nn3VihEMxKjc3qUdA7dDL0h1CFKel4yHQ==
X-Received: by 2002:a2e:875a:0:b0:26e:1d9:c2a5 with SMTP id q26-20020a2e875a000000b0026e01d9c2a5mr24793234ljj.353.1670142609979;
        Sun, 04 Dec 2022 00:30:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b0049fff3f645esm1692861lfa.70.2022.12.04.00.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 00:30:09 -0800 (PST)
Message-ID: <e78b8c4c-81e3-3d36-10b4-36f8b52e6131@linaro.org>
Date:   Sun, 4 Dec 2022 09:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 01/15] dt-bindings: thermal: tsens: add msm8956 compat
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
 <20221204055909.1351895-2-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221204055909.1351895-2-dmitry.baryshkov@linaro.org>
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

On 04/12/2022 06:58, Dmitry Baryshkov wrote:
> When adding support for msm8976 it was thought that msm8956 would reuse
> the same compat. However checking the vendor kernel revealed that these
> two platforms use different slope values for calculating the calibration
> data.
> 
> Add new compatible for the tsens on msm8956 SoC.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

