Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA38E598C7A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Aug 2022 21:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbiHRTZg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Aug 2022 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiHRTZf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2022 15:25:35 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A74C9EA3
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 12:25:34 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t8so2563758oie.8
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=5NWVL3tQy4qA1pqlSSiWCGc9yD+avOvpY/hcNs8st6E=;
        b=fL/lkjwwLeAHRLF8axi8oo+M5EZKDJy+juiENY4UCGS6wyYKBCGMwWWBitHcQZsyzE
         7RJRRaHsX6XDTpSJkTxcgxrBdB25A51haa+faC3iswFrF8ImoYlJ2/QwfKuj7G6Yj4Tf
         BkZoSX7Ov9ulNqtZMhEbn4fiXIhb8e0h2ap5MrmSIFKIIe8S7bUIETvxj+6q4iX1NdTc
         zAXDt7JLU4Yf0nNwFX6fuaPUe5fNljrc6YlSKVu4VzeSjJgSvWrIC+2dfLR7FGD2OBsM
         F+DpFuB2AO7VKkd78bDjveNEJgPSJfF7JauAIUB1hbbP2usLAL1Y8DjoNYrC2Xm1JmOW
         vd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5NWVL3tQy4qA1pqlSSiWCGc9yD+avOvpY/hcNs8st6E=;
        b=DjgtcWTBLErf5pqi3FsfFdQFsPS8LnUBerYzUEKcR1iN5rDWbSqfBjnfslt0t473s+
         XOBx7Rim3kBh3nklT75tWqUm/nGt6m/f98x5FLmC9LInhOHCGFujf/HXfzhNeZEVuEfc
         eCaRNL/zP9z1EHF+rBDESzcr3IaFH9VYuvB55X0LMHESGK0H20gukU/KP4CEm6QTlaej
         GLIGY0Kzy/eB0poFaKsF3+sXVFv1vtDFjS6BsOSZzAZ7x3QNk2B59TL6k3y4NW2KMo6J
         eDtlBWGLpY7tgJQJs9oBM4QAV4i6tJp5vVMRqOt8miZFrUkwP+pTADRYvuh0j8lbEAum
         VaTA==
X-Gm-Message-State: ACgBeo2ni5Xcd4J+de/VbwFubYlnsCNJEMk3ib5AiicB1Gu81Ja2ujjU
        39wviQQMXt5no3Ypdkjgz0y+Zg==
X-Google-Smtp-Source: AA6agR5/gwC8IwKYnsd03M1A+bMDoSaOS3uK2Qoq3RICQa53TTqqRValyBPNBy1OaaWPhFyjOjuWDg==
X-Received: by 2002:a05:6808:f90:b0:343:5b7d:d594 with SMTP id o16-20020a0568080f9000b003435b7dd594mr1993988oiw.68.1660850733540;
        Thu, 18 Aug 2022 12:25:33 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id k24-20020a05680808d800b0033a37114eb0sm547790oij.19.2022.08.18.12.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 12:25:33 -0700 (PDT)
Message-ID: <eb6c5d99-149c-6b19-7219-5074c8171e8a@kali.org>
Date:   Thu, 18 Aug 2022 14:25:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/4] soc: qcom: Introduce PMIC GLINK
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220818031512.319310-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/17/22 10:15 PM, Bjorn Andersson wrote:
> This implements the base PMIC GLINK driver, a power_supply driver and a driver
> for the USB Type-C altmode protocol. This has been tested and shown to provide
> battery information, USB Type-C switch and mux requests and DisplayPort
> notifications on SC8180X, SC8280XP and SM8350.
>
> Bjorn Andersson (4):
>    dt-bindings: soc: qcom: Introduce PMIC GLINK binding
>    soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
>    soc: qcom: pmic_glink: Introduce altmode support
>    power: supply: Introduce Qualcomm PMIC GLINK power supply
>
>   .../bindings/soc/qcom/qcom,pmic-glink.yaml    |   98 ++
>   drivers/power/supply/Kconfig                  |    9 +
>   drivers/power/supply/Makefile                 |    1 +
>   drivers/power/supply/qcom_battmgr.c           | 1422 +++++++++++++++++
>   drivers/soc/qcom/Kconfig                      |   14 +
>   drivers/soc/qcom/Makefile                     |    2 +
>   drivers/soc/qcom/pmic_glink.c                 |  336 ++++
>   drivers/soc/qcom/pmic_glink_altmode.c         |  477 ++++++
>   include/linux/soc/qcom/pmic_glink.h           |   32 +
>   9 files changed, 2391 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>   create mode 100644 drivers/power/supply/qcom_battmgr.c
>   create mode 100644 drivers/soc/qcom/pmic_glink.c
>   create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
>   create mode 100644 include/linux/soc/qcom/pmic_glink.h
>
Tested-by: Steev Klimaszewski <steev@kali.org> #Thinkpad X13s
