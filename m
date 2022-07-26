Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1B581479
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 15:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiGZNt1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbiGZNtX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 09:49:23 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152DA1FCFD
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 06:49:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p21so8916903ljh.12
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y5BRR0iNLx6aBIjbVl9ArC7hjqevnrWy8iJkMFg13Gw=;
        b=dT2fn0qmN08x8rHVL25zAPZPXxb9sSxyHNjZVrrW2S0kNRdHOsJe3cOdw+SNGK+6pb
         GuLEbjj3CsXGw9nRB38q61/3XyYl1ssLvLP0iuIIruAR9Xjo8ir7ULdYlxFFMJHQXnwP
         4ghhgnbIWtNl3Ba41DwCv8guPqyb1YwPRU/FuN830CkRRByk4dt/ReYyePn36G30bYxR
         PpSQ+eMpVbvtbSOaPPM3PZkYIeJFI3b9AI/jkmLA9qeJMmk4zllanXgUM2Z/Y7lj/Psi
         vG6uCGIhjiydmCr6okRuZz7dIaEzpt/g0I59gQVWTD2ESoYOt3oAUOIiRFofMAYNXAgF
         Ty0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y5BRR0iNLx6aBIjbVl9ArC7hjqevnrWy8iJkMFg13Gw=;
        b=5W7tL+pxilfkUlsRAYONiOjfMZbakQtaEvJWNjyRm5e0rKTmSw6pxY/ZgmjilzBwo6
         J/fgfZ+ODOh7xSnHAMQoVlJ+fDCvBugfjT/k48qLv22GJKJ1hQyXrvNGpRfbWmhPxy+H
         jaEvmlxxESmlDv2U3X9NR3jkSvugXO+wV3Y8ZJNJiqp5xLEx77hPHLsIeVxrhi2PKZrt
         LQwG6SW7aBzCIfXIIw8NdKtVbejbXwA6yHiJ2HlEQOZZCBwl2X6UX+Faz1xw5WnFzLy/
         my3KQFimbzOOTqwuGAsQefGlXoNlsh22jzF1BoaPo+L/nolGzsFYkTo75S9oNFt+SJT+
         CxMQ==
X-Gm-Message-State: AJIora+/zW8aJJ95mihskBoLv5gYgj6vrUX9bkbK4V5VcdKIjtR9d/fQ
        lkEwsuieDrJcDypFt0aUjnFpYg==
X-Google-Smtp-Source: AGRyM1uQNkFPqhr+UY20E19CB6pxfKs587FemzdiLwf9fjReDOp5EzYTe0h56cIIqJGEJrhs0ZzNuA==
X-Received: by 2002:a2e:7108:0:b0:25d:eacb:964d with SMTP id m8-20020a2e7108000000b0025deacb964dmr6560570ljc.232.1658843359139;
        Tue, 26 Jul 2022 06:49:19 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 197-20020a2e05ce000000b0025d70efeaaasm3313237ljf.75.2022.07.26.06.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:49:18 -0700 (PDT)
Message-ID: <b47185a6-07aa-d159-2bce-aa84be9d0abe@linaro.org>
Date:   Tue, 26 Jul 2022 15:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 10/10] arm64: dts: qcom: sdm845: add LLCC BWMON
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-11-krzysztof.kozlowski@linaro.org>
 <25673493-4171-62b0-f696-1316d115f388@kali.org>
 <96552a95-8939-3ac2-c9b3-14dabaf53923@linaro.org>
 <d814a6da-b0d7-2fd1-fd14-8f1f3b88666f@kali.org>
 <d89a540f-672d-83de-d19d-00f10e4370d1@kali.org>
 <fec6bd98-5efd-fe34-6d75-1765219acd82@linaro.org>
 <25321f37-dbea-188b-1b11-e983a00701b2@quicinc.com>
 <3325c626-f1af-2e95-fc53-68cf3d427a88@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3325c626-f1af-2e95-fc53-68cf3d427a88@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/07/2022 14:01, Sibi Sankar wrote:
>>>> I think you may be right; I just applied this patchset to -next
>>>> (20220722) and i do not see the error message there.  On my 5.19-rc7
>>>> tree, i am also testing a patchset that enables qcom devices to access
>>>> efivars, so possibly we are ending up in secure world there?
>>>
>>> Actually mapping of IO space should not touch secure world, so this was
>>> a long shot assuming you test it on the next.
>>>
>>
>> The memory region specified in device tree overlaps with the llcc system
>> cache controller node. Steev probably had the QCOM_LLCC config enabled 
>> when he tested it out on his branch.
> 
>  From what I see we can probably get away with restricting the llcc_base
> reg region to just llcc0_common region and leave the lcc-bwmon as is.

Och, that IO mapping for llcc is quite big. I'll try that.


Best regards,
Krzysztof
