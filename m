Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5603F638DA5
	for <lists+linux-pm@lfdr.de>; Fri, 25 Nov 2022 16:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKYPrk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Nov 2022 10:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYPrk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2022 10:47:40 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35AD6400
        for <linux-pm@vger.kernel.org>; Fri, 25 Nov 2022 07:47:35 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id b9so5599830ljr.5
        for <linux-pm@vger.kernel.org>; Fri, 25 Nov 2022 07:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4N7ARcCVQV+7m3JTQ82McZk+6Cxj9oXg8wroCaCjgXY=;
        b=tz5sKtkacTpTvyW63bpHecpwDcjz6DHyXT4pcZvh7rXM6Mc041MIP32Qbw5V3gT/p/
         VimweZU9Yena1fcRSUjO3d4LZ67czpnEiOGTjmuHsK2m+mjMvG9/+cie46JGctTQu6Yi
         nY/awH0AO25lGPXDHkJ6SlBJHIj1vAUw+gPjNzPDWru9QZZcFRgLXmv1V71iyUrh9SS5
         W8ah2ZKPvAZ0lee5KrMszNdun3/9J7n7Hf/jHxio+pAaehjsdcFSmpC5YF5I+9VVfB4T
         PZvAatBqyTp4lIn5WHzIwk3HCH/n10dsVCkHTk6gFUZRYekWIGXzu0qC++L8cXjgGiHS
         nKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4N7ARcCVQV+7m3JTQ82McZk+6Cxj9oXg8wroCaCjgXY=;
        b=7F+HAl2qtS47TkAogfooCpSufYx+FfwM6IRIJjefwxZySdm8Suetrv+XeNBtzpRp58
         fHQd82cmWqzgAqEAdY52mBBIKtQJbklug8bq4ZgnDQA7rAQvh//LZgzjoSf6Ya6GRjS5
         YEEv3sF5yxNqDg/ZSoN7j8v1kZ6HZxSkOmr2d/IBvJGLvYzH03mJZWRL7y577eh1f0l+
         C45uNd23ggsrNclCBeBUJujuh7WxdcVhqTpqYRCrnD+vF9jRTwBqWpa9ldeeR/PLSovq
         HktUN+rofKhek4FtncWed77K5z8539Pbb5wyquZ25wT1fNhG6yIdSZ/cy99+wQw4EeSe
         hfxg==
X-Gm-Message-State: ANoB5pk0k12AjV9Z18as03h4qhNopN4kUbrifD/85jQxSUZGoGdBiYq+
        UreXPgkF6HULoblH3Hepu/iy5A==
X-Google-Smtp-Source: AA0mqf4I+flnzU2DvQ1/Qt7lKLlAw5TcGFinfaFNHv2h0CW3Ua/P6prtOSiXZrXwY4HLeTzjGt9spw==
X-Received: by 2002:a2e:8847:0:b0:279:7611:36f5 with SMTP id z7-20020a2e8847000000b00279761136f5mr5227299ljj.134.1669391254296;
        Fri, 25 Nov 2022 07:47:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c13-20020a056512238d00b0049ebc44994fsm572154lfv.128.2022.11.25.07.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 07:47:33 -0800 (PST)
Message-ID: <66a2b0fb-2629-a358-8ee8-1fb6572954ca@linaro.org>
Date:   Fri, 25 Nov 2022 16:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: narrow interrupts for
 SC8280XP, SM6350 and SM8450
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221116113140.69587-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116113140.69587-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/11/2022 12:31, Krzysztof Kozlowski wrote:
> Narrow number of interrupts per variants: SC8280XP, SM6350 and SM8450.
> The compatibles are already used and described.  They only missed the
> constraints of number of interrupts.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Hi Daniel,

Can you pick it up for upcoming merge window?

Best regards,
Krzysztof

