Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098F474E80D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 09:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGKHek (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGKHej (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 03:34:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0731A2
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 00:34:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so409383a12.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689060873; x=1691652873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVGsQe3FUvv+xqMI8vCQvvS1X9l7yvBVYvNRcfMvnjc=;
        b=YoMU6R41iCVoQ6qW72RIftQJDCPOhxwNgyaEX5gI4GQIMoAYPBfxXeRz46h9k2Cv8U
         LkcOG+wKEie73Dm/fAiI/WsvJRW9EI2puXkq676MtlZKucZ0t7NWHZzvnqZ3YgcQ16VZ
         7Nt/eT7XKvo4PLODlyI1pEWM+zQHp9xu4+LlqKWgWZ4mieaREM5dFrlpedVnmiUaEG9f
         DyRKIO+YznQ/DwxFvBqqzorE6ZW9p5VKiOQsi/3DVJvWw34+kvUQTSGaiFTsVq1Vhx6y
         48df+zpXk+Cch2/S3SbocnH5cJkR9GdOcYxH7/JYpGKc/udntLkzlDgquSyOfi4Oghrk
         Vz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060873; x=1691652873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVGsQe3FUvv+xqMI8vCQvvS1X9l7yvBVYvNRcfMvnjc=;
        b=Qrh1emCudzldI+pVlOKs7isjwSSNsPFUTEofRe5WQl4k7Hx9xbHvt501XFIJWRKqqX
         qtxJOgmEgzzexCugyYu71Y4MTJ4sWM7ZAqkXrxleFD2TinTPFyPJzkYUz423LAkQGewR
         /n5xGBAqmAr57nRsHLRYOvDgu/cg2Ujx93DBn0I+xElJnkMFioKF1/Ctl7jy7+/Gt9xM
         xRrfG6rQHlFZunbP7BJbHua0gxI92nLhdYW4HUryaSSKATxXAR2rOfJHZTTPy2K3AyTB
         nmmHH1Dwpv74Q5tR9vveJ7NdOLRgyY6COAp6jSlfEQIgXdIiIOj3WCTtvLsGKd4kAAyo
         mkvQ==
X-Gm-Message-State: ABy/qLbIvpx2hMJ01lW9CiLFvhczRipwrhmlgxE5l6uQTFU5dWIyT6pV
        wlfEtxKUMrfRXZ5vMf02PJFjJg==
X-Google-Smtp-Source: APBJJlEqf7DSKvBA7MMiWZC8+MdYyeLkgMHXXmaEaKpoeKhcuoF1fO5qhs6JE1aIC0sI1kQIpw7BZg==
X-Received: by 2002:a17:906:51db:b0:993:f9b2:93c1 with SMTP id v27-20020a17090651db00b00993f9b293c1mr8448036ejk.9.1689060872827;
        Tue, 11 Jul 2023 00:34:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id hb24-20020a170906b89800b00977c7566ccbsm753487ejb.164.2023.07.11.00.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:34:32 -0700 (PDT)
Message-ID: <a6f44e59-1b4e-efe1-0ba8-575610ec4aae@linaro.org>
Date:   Tue, 11 Jul 2023 09:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,bwmon: Document
 SC7180 BWMONs
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616-topic-sc7180_bwmons-v1-0-4ddb96f9a6cd@linaro.org>
 <20230616-topic-sc7180_bwmons-v1-1-4ddb96f9a6cd@linaro.org>
 <f937db2e-a5b2-8ad9-ce5f-ed1ee9f2dda4@linaro.org>
 <5ce1c3b3-a55f-4ff8-f6db-dc66eebf9257@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5ce1c3b3-a55f-4ff8-f6db-dc66eebf9257@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/07/2023 09:23, Georgi Djakov wrote:
> On 11.07.23 9:42, Krzysztof Kozlowski wrote:
>> On 16/06/2023 01:46, Konrad Dybcio wrote:
>>> SC7180 - just like SC7280 - has a BWMONv4 for CPU-LLCC and a BWMONv5
>>> for DDR-LLCC paths. Document them.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>>
>> Can we get this patch applied? DTS is already in next so without this
>> patch there are 90 new warnings:
>> https://krzk.eu/#/builders/90/builds/40/steps/25/logs/warnings__94_
>>
> 
> Applied.

Thank you!

Best regards,
Krzysztof

