Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE77B5B450A
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIJH5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 03:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIJH53 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 03:57:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A46DF80
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 00:57:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u18so6506907lfo.8
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FBGOIg/B2+IRHqE8BYouXguAvAX+t/CI7o0Vq9YTfI0=;
        b=MlDQ2ythtKpKOjWObS4gfHzZWOKHcWdUoGdVxqhWziD/d3D74tWUoLU3wJWywyaJVe
         J9DNVtw9Jw7v+Ksx7qGMhK6C6ThbmhL7kFPKTpVVEb3Lj5n7d/JrZGkOp+PwpZ3acigM
         URMCRNVKNmxx3QRaLS4sdh6emcAyPwomh4+TcxURVjzjnew/m0gjjuPgcbIGdBL1R2g0
         vrcG4SZuVlvocrhW0xdm0BfqYIL6WCFOUPqreYUJ1iVhZw75xh3L1fNUVNsIr/NH6+hb
         hykWFw+9WcGGtQLBT8hQoihR75L8PyQEcvIBSnHpoZLY1Vu3JZUEkmrYuHaP77G14ZsJ
         MI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FBGOIg/B2+IRHqE8BYouXguAvAX+t/CI7o0Vq9YTfI0=;
        b=iotbUHfHXQ5LERowd0QngbJqJm+U7zgb2QjzbydYbMSUWcfcdegPJ1GblZ0xxlgItM
         +TZYzD7iTlV2kAmS8FyOA8Ugr84wjWu2RL/7zzCe3sJOqKfjtkeru5Tc26zOsQ6UIG+8
         JuNYdJOWAcxNfMHoRoaipr+qo/M+tIL6c4NMi2qjd00OBTzUBmZ5TU1dX2P0FOae5gNp
         V9MQIn3Rvdkeatt2/nCCfPjFxIpuE11vuSm2P3Bb54q0stuMEIUIZAC0mLN8ubYlHl43
         LuNcPUl8d3/9wgIg3fvp7ZpXj4KHk4MabkRnknyHnKuJN7vH6OO0V8jqkvpEM9jBtKdf
         yFQg==
X-Gm-Message-State: ACgBeo16FUpfTPA2ftJASnHiYZmdI86NIHo9SAlHDkDm/N/F91YUHliJ
        7dWfCNne82pXjYwg5rS3UhgNZQ==
X-Google-Smtp-Source: AA6agR5BjkJ+3ILP6ANCTf0QXdk2PGjorpHbnNON4yZjw5qhZAa1CM+brxbEvMXc0lgHySEkklUFEg==
X-Received: by 2002:a05:6512:3128:b0:499:3c1d:f9e with SMTP id p8-20020a056512312800b004993c1d0f9emr1171315lfd.634.1662796645731;
        Sat, 10 Sep 2022 00:57:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 202-20020a2e05d3000000b0026ab83298d6sm251494ljf.77.2022.09.10.00.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 00:57:25 -0700 (PDT)
Message-ID: <91645b10-5f4f-9c9b-3867-96357e06e330@linaro.org>
Date:   Sat, 10 Sep 2022 09:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v5 1/2] dt-bindings: power: reset: qcom-pon: Add
 new compatible "qcom,pmk8350-pon"
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, corbet@lwn.net,
        sre@kernel.org, robh+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com
References: <20220909204207.15820-1-quic_amelende@quicinc.com>
 <20220909204207.15820-2-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909204207.15820-2-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/09/2022 22:42, Anjelique Melendez wrote:
> From: David Collins <quic_collinsd@quicinc.com>
> 
> Add a new compatible string "qcom,pmk8350-pon" for GEN3 PMIC PON
> peripherals and update "reg" property.
> Also, Add an optional "reg-names" property to differentiate between
> GEN1/GEN2 and GEN3 peripherals. GEN1/GEN2 peripherals only need one
> register address to be specified (e.g. "pon") whereas GEN3 peripherals
> can have two register addresses specified ("hlos", "pbs").
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
