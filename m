Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844856199C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 13:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiF3LxF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiF3LxE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 07:53:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A872451B05
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 04:53:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h23so38438664ejj.12
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 04:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S270M/2oWojLEpyTbMB/z2H6TZ3tpIFqXHP77DYgqTo=;
        b=MWTnMm+SQSRYa2cIbPAJXqdwuU5CR0gWMfNPjwZh/1b0NUpJFcd6prqI/6EtQyUqdY
         OHqcYATDBXRt9jgKDE9etJ3iPAdRgefZhaTRaAKhNk7iJbW3GS4gcJq5f3xn1/B6+RTP
         gFQyzlPM5GBa5a+Z9Jdv95ClKIbp2rpnMpjY8oFoDT9MyhPa9Pcop0rUAmeLyPIHs1uL
         kMCQmKvyItfrfTAvCgwpNsOti8GprxKt+J5HlW8j+Ltm52Y/4VBtR7urTXmxzLvP15vk
         vNxdiPH1qf4/pk8my1XGf6Vu4pz7fOusHz9gLtGks96eWTs997JR69CRgFfEe0yb/mB7
         KFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S270M/2oWojLEpyTbMB/z2H6TZ3tpIFqXHP77DYgqTo=;
        b=njWasIuBL5KoQUlukTXP2Ty53IT6ZtcgqHl2Et2sLr3ErPTCPHW43l+dayZInomnuD
         R4p5rF4r/tUoSKYqOEmXUSZHV19aNU6RR2tKI+Nt0yA8El9AA4btZNabkMCfhi+tUuTQ
         YjW5YlGQ4pAXMjsnsEM0fg9bW8do3X7Oe/7XSk3iZyrTwAB4wkpNZVX7mdUN7kKy3XUU
         tfJkcRCZQt8E2opNel8H+xD+xCVv4A5nafb1m2RZeSeeBz3neS9MX+q5RbCZId2SUVgS
         KC40SAWjT3NM2qepb5NDZrH2CaTY4xsUMfsdUOLAO281BglrjPY0QtRi+ioD+LGhWLBt
         4KgA==
X-Gm-Message-State: AJIora9FWNECLsAmRjoaD38YVNz3+4sp18B6Ayign8a3hf9mVJcJUCVB
        YhG00IV1IrnijaOuSD88K3O3sw==
X-Google-Smtp-Source: AGRyM1vRThtJMidYWwYHrUpOCPcr6GBuPTh5GFqkw9tVnwCUUpKY3OrJQw/NnoGOkQBr8MErp+/SIQ==
X-Received: by 2002:a17:906:4752:b0:726:9e6b:7fb0 with SMTP id j18-20020a170906475200b007269e6b7fb0mr8333347ejs.747.1656589981248;
        Thu, 30 Jun 2022 04:53:01 -0700 (PDT)
Received: from [192.168.0.189] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090666cc00b007041e969a8asm9027699ejp.97.2022.06.30.04.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 04:53:00 -0700 (PDT)
Message-ID: <c68a688d-c007-2daf-5993-1fe5c765d96f@linaro.org>
Date:   Thu, 30 Jun 2022 13:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 1/4] dt-bindings: interconnect: qcom,msm8998-cpu-bwmon:
 add BWMON device
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
 <20220629140302.236715-2-krzysztof.kozlowski@linaro.org>
 <55cf5a2f-7be2-bb65-09d6-d4d5af4d2f0f@quicinc.com>
 <1de5d955-91f9-032c-0ceb-2e48d04464dc@linaro.org>
 <2e0f19bf-496c-f90a-3549-fe7ace346ff4@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2e0f19bf-496c-f90a-3549-fe7ace346ff4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/06/2022 13:29, Rajendra Nayak wrote:
>>> I just update the binding with the new SoC compatible (lets say qcom,sc7280-llcc-bwmon)
>>> and in the device tree node use it as
>>> 	compatible = "qcom,sc7280-llcc-bwmon", "qcom,sdm845-llcc-bwmon", "qcom,msm8998-llcc-bwmon";
>>> without any updates in the driver?
>>
>> I expect:
>> "qcom,sc7280-llcc-bwmon", "qcom,msm8998-llcc-bwmon";
>> and you need to add sc7280 compatible to the driver. The actual proper
>> solution in my patch would be to use msm8998 compatible in the driver,
>> but I did not test MSM8998.
>>
>> Maybe we should switch to that anyway?
> 
> Right, looks like without it every new SoC compatible added would need a dummy
> update in the driver even though you really don't need to do anything different
> in the driver.

OK, then v7 is coming :)

Best regards,
Krzysztof
