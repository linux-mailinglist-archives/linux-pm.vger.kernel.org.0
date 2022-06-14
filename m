Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90554BA0D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358054AbiFNTCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357137AbiFNTCh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 15:02:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7311C2B
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 12:01:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y196so9371829pfb.6
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kBSdpdWwhu3cFbvSAgOFnmCRvHyvZ12l4/jZhBKJpM8=;
        b=aMr/NZiGoj4VQSNPhMdaaGFu46DAflHx82RCkfUzVA+HhewgT+yb5gH18FE9DcwFAl
         NL62aZTXgaPSzvQbpEpm2LU5Yaic9P/Oaq3l1grg/RNRLS8ZXga4ErM8zgGazUAZJJiW
         DIPjBd8Do4hjdksfWyHokrGnJr24qzV/wNaSyazVl+OQC52JaEaw+RGtOt+oJvxaslKo
         mBE1mZgvINzXHdJDRFX8W+Y0gWlvtIcBhJM51+QbFUSv9vLUAXluT6WBjfK2gb3Oya7A
         Mbv1LGS4IN56m6CgRnQ5Ux+XPiRFnilRZYMsPzcoN4pZQKDX4AWFXNDlvjFlxciXYZ9H
         FwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kBSdpdWwhu3cFbvSAgOFnmCRvHyvZ12l4/jZhBKJpM8=;
        b=HvvaNtmxDiQeqbUEWkQHk/YRX6ijeBBTrHRdp14KtWJax1Tpoh5uIEWtOKg2dkOaSZ
         +WfrGCvMSfd6lteEGZsQ7ZvNb0FjPb5Xncr07UDQhlRBTWIQFY2PsKvZNMkyVt8VvEjb
         MrjNS6KYo0p3PCxJYPqoXtiF4rIREQ3GmB6Ib1eKr5eXjNZmdYe9zEvZyxsfjLPIDkR1
         whlfTPYOYsScdCWZfur9gARqTtoewJq1lcvRVSpJiQEjrBtqXx9ZuQ2JDAwLzyihxhkD
         LA+4K73jCEQpFrOHoqhPApF0efJEJND1shR69x6OLvbzdz16m7iqlFIMB0d/s1ZkMweF
         loVA==
X-Gm-Message-State: AJIora/WjkhiOF7e2jqA5oYxSwQqdvc3IgkWSzIYkx7VADw/DucHYOIS
        B2Cpp+0FCsx2GIb+H3lkrBW2XQ==
X-Google-Smtp-Source: AGRyM1tbPA14Sc3Z2l/8zWURNY5ZR0s6/N18Ma5delx/zo6Muhhpc2LzXCGnC8HThC0wfxEXYmlV4Q==
X-Received: by 2002:a05:6a00:1a91:b0:51c:2ef4:fa1c with SMTP id e17-20020a056a001a9100b0051c2ef4fa1cmr5849126pfv.75.1655233303315;
        Tue, 14 Jun 2022 12:01:43 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v13-20020a637a0d000000b003fad46ceb85sm8271025pgc.7.2022.06.14.12.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 12:01:42 -0700 (PDT)
Message-ID: <2c778212-1ff6-6afb-aa13-917bbffcfebc@linaro.org>
Date:   Tue, 14 Jun 2022 21:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom,spmi-temp-alarm: convert
 to dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/06/2022 13:27, Krzysztof Kozlowski wrote:
> Convert the Qualcomm QPNP PMIC Temperature Alarm to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../thermal/qcom,spmi-temp-alarm.yaml         | 85 +++++++++++++++++++
>   .../bindings/thermal/qcom-spmi-temp-alarm.txt | 51 -----------
>   2 files changed, 85 insertions(+), 51 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
>   delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt

Applied this patch.

I can pick patch 2/2 if needed, just let me know



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
