Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C146FC577
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 13:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjEILyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 07:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjEILyo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 07:54:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC04487
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 04:54:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so6566063e87.3
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683633279; x=1686225279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRecC+blqX9umwq/P5o5GfKySbyBcOvvkdfafugMVB4=;
        b=CLQ2+SBETxw7FIQSLl+c+VQNoYKBMi9PhduEZ0j+mnr2VwWv98pKnkgn3j15Ynx5Gl
         oh7WDqncyZwebtggkfpfVejLes1MbvrbCDptFyb5MgiPTV0IIbImBm4UI6T9letI62Y7
         v8pjWaAR0DfCgUNF5Z7HhdTMdeJcJCBfUC6gwTxR1Abtl7ZlXCYKpaTVKn+4FXQL+Hhu
         h7zqlUlvF4NP6misQq1rOWr31EpK5kqjeQAhnWYUlS3oNmEsPUfgF3iFosgYccnPYUg2
         9TVakDYqFHeYxPAwielTeEJ9Fgc3MGrczlQsZsEa8w/BhwKxBCfd5HMW+FPRLXm8ltAt
         T2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683633279; x=1686225279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRecC+blqX9umwq/P5o5GfKySbyBcOvvkdfafugMVB4=;
        b=ZjznWPWa7ZYsjesFHvXNsRZnEzGUPGcRscPeC7oPt2k1sMKLOHk2s/y7GUYKvs6RvE
         Wjqgtg3340kCcUYs6tD9VpW9IGwAKhC0l8j6hhjoF5Fck4VH+rFSrF9mDCnUP7k5DHhy
         S0wAxgBy9gkZx+oNQDBI8ScOdQZCmRi8RXVZEeZFcA+0/m31AtuLxYpcSsMNahZD5RPA
         MVsNeEBXIPOFK4fbCkRewLp377Y/YKnq43589/uCduKIiyz3L85+p3Z3wXOgc0RBdV4p
         SvIkbMHBTVtDTvOHF14+6KUAts1Uzvmg+yKkBK0d3Hv7HVRs3gOZDMQFrBIdJJ2ARLT3
         /1wA==
X-Gm-Message-State: AC+VfDxAoTmXMpvCGHP46hgqbaM2UAkqw5Q6D9XJMCb/aoAZD71iEQ7c
        VNbAYsR+EXxCuYD0/eD9QfQ2fg==
X-Google-Smtp-Source: ACHHUZ7jeJe34EYrWUEMtQP+6NBiZHhuzbzSe6XdD5VsJLpeAL3yD6LEK9LGAqGYeTbykuNM2Q7PGg==
X-Received: by 2002:a05:6512:208:b0:4ea:f526:5bef with SMTP id a8-20020a056512020800b004eaf5265befmr654546lfo.28.1683633279482;
        Tue, 09 May 2023 04:54:39 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id i17-20020ac25231000000b004f122a378d4sm321300lfl.163.2023.05.09.04.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 04:54:39 -0700 (PDT)
Message-ID: <761fd2ec-b83f-b695-5d23-f1cf5db48f99@linaro.org>
Date:   Tue, 9 May 2023 13:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/6] dt-bindings: power: reset: qcom-pon: define
 pm8941-pon
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
 <20230508160446.2374438-2-dmitry.baryshkov@linaro.org>
 <32d6b9be-58f1-1d63-2c1b-de9f7ba7b3b5@linaro.org>
 <CAA8EJpr4yC8sKsvscSK3FtQdM7fFUJAbA6zogzAo96U0MxvKDw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpr4yC8sKsvscSK3FtQdM7fFUJAbA6zogzAo96U0MxvKDw@mail.gmail.com>
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



On 9.05.2023 13:21, Dmitry Baryshkov wrote:
> On Tue, 9 May 2023 at 11:53, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 8.05.2023 18:04, Dmitry Baryshkov wrote:
>>> On PM8941 pon doesn't store the reset reason. However we still need the
>>> wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
>>> device.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>> Should probably also disallow setting reboot modes!
> 
> But we don't set reboot modes in DT!
That's what I'm saying :P

> 
>>
>> Konrad
>>>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>>> index d96170eecbd2..0f4f55dd4eac 100644
>>> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>>> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>>> @@ -19,6 +19,7 @@ properties:
>>>    compatible:
>>>      enum:
>>>        - qcom,pm8916-pon
>>> +      - qcom,pm8941-pon
>>>        - qcom,pms405-pon
>>>        - qcom,pm8998-pon
>>>        - qcom,pmk8350-pon
>>> @@ -63,6 +64,7 @@ allOf:
>>>            contains:
>>>              enum:
>>>                - qcom,pm8916-pon
>>> +              - qcom,pm8941-pon
>>>                - qcom,pms405-pon
>>>                - qcom,pm8998-pon
>>>      then:
[...]
	  allOf:
	        - $ref: reboot-mode.yaml#

Konrad
> 
> 
> 
