Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEECE5608EC
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 20:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiF2STz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 14:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiF2STy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 14:19:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929C1183BC
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 11:19:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cf14so23352106edb.8
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J5IsAqclMR/GR6FWvKy0CKdxWT09gsEwtdB8dZsKId0=;
        b=ESHrtF1+9DddzbkDBir19HHKiKDw5TxbdRv46WyQP7F199QQPKSu/e2hKsczo7A90J
         QSaDDN7WgdbkJ3+URouzmojuUgiK7sk4SxRbrvvMNYfUG6Ea9RZypECYkQwXkvcfqI3V
         9P+cifEBi1kYnd6N9U9TYY9k9esZWqDrkY8GlSv3EMhOixaeRqvNvDYaTxJrALJVO05G
         ZS9ZuPUrn4huopDpEwtA7llEDKsBpE9X1myHR328DjFH/aT6bWELcSPrtdEavuhNgldA
         aTEiRMQywBWJUvAtOmi+MnAaDfqaIwF3o+ohsAwGerPZXBPAomvS3ktz5IC/ng7X2x8c
         pCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J5IsAqclMR/GR6FWvKy0CKdxWT09gsEwtdB8dZsKId0=;
        b=UlPrfM5kcBJHbc0lIBpv/0ciZyPim0T73cN1j+Sicf6WQwniFzoXP41j71hpe71hVm
         CPGGAFcydaAWjpCGseXtY9lU5/Mw1/cC0dNmUAJGTheTX5YnbM8lAYZtTqmMwtvqCvkB
         BYjwRi1Gk0hPaRxOzLkqgW1KC/FODGPowuArawd3dM1aUdUCUQr8R9cP6JMtFB5qvFgV
         Ex1KeZU0eh5sgJ49cWXfIIObPI17IBz2+HRGhLPGV4vjyjD1pxQ+P5rwJkS3X6T5dY1m
         CzZe+6MjqBLwyVg1BkNxD/nkL4VhUCj6DVkLj9MZZ2LIbHm9gXNBgQo3OoydEzTXL9RY
         6aow==
X-Gm-Message-State: AJIora/QMtuH76o+i84/dT9T0uhjeOA+RDmuLJwzkgDNZDrPykZhei/U
        q371LBAiW/cmtY+ZVYQY1WmrAQ==
X-Google-Smtp-Source: AGRyM1sZNVCjGAnZXMIZTfbWV4EhUi0BdUVZ/yZQi9bubd8l62fh7mnJHckL3hruEx6SVvcrwwCJLA==
X-Received: by 2002:aa7:cf0f:0:b0:435:80ab:2e7e with SMTP id a15-20020aa7cf0f000000b0043580ab2e7emr6050682edy.207.1656526792231;
        Wed, 29 Jun 2022 11:19:52 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n4-20020aa7c784000000b00437e08d319csm558876eds.61.2022.06.29.11.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:19:51 -0700 (PDT)
Message-ID: <dfb6a331-aad1-70f9-b6e3-b2cf703d05b2@linaro.org>
Date:   Wed, 29 Jun 2022 20:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RESEND PATCH 1/5] dt-bindings: opp: Add missing compat devices
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, ilia.lin@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
 <20220629130303.3288306-2-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629130303.3288306-2-bryan.odonoghue@linaro.org>
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

On 29/06/2022 15:02, Bryan O'Donoghue wrote:
> A number of devices listed in drivers/cpufreq/qcom-cpufreq-nvmem.c appear
> to be missing from the compatible list.
> 
> Cc: ilia.lin@kernel.org
> Cc: robh+dt@kernel.org
> Cc: krzk+dt@kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
