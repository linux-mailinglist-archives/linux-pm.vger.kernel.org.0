Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53701662F15
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 19:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjAISaJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 13:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbjAIS32 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 13:29:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC2539F97
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 10:26:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso3341195wms.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 10:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34xoWv9ZRaBvWx1Ukqb34kE7Vi5rXidYbq8azSquKUM=;
        b=yMpIDlUHX3k8RTsFFou3FoMEoLzlTKpxrfNQlV/yrqZsOASlElbveKx2EKtsYTa5kt
         UP1NgB1TjuuIdrgM+qIq6RjHNHcICS2/5b4CQcFLmjltRlDQGRemi9qYe3MU8U5PM/LZ
         sF4/uRX8vwz3eD0b0GXq5ZOkL6YonAErnLS7XokjvW9QrjkXHWgi1ZdYORY6v478ReY7
         YEBgDCep1tzjEdWcezmOlim53cVMd3yFRC2AZ3+mDt2iSoyEKLGf3yTspR4o6x8jflB0
         dNHHyngRE2CmidQKtvOGTybVs0ypyk0tEsyRTDq30VgpNbxC2W51zptdpTf4ddVfHb4/
         XNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34xoWv9ZRaBvWx1Ukqb34kE7Vi5rXidYbq8azSquKUM=;
        b=ET9rWKJNsw4DIKz1k56aVmc92aADBDdmaW8rD73KH5AuqPce5LebT9GQirsqm8WqaP
         DUQNgp8AJm+8e9H0nqK0zIN2s903HQxAN3MzV8elDrTEJtKp8jZLbYEYyz6xq5S5PfUa
         +Fv7EgNAWw49NRXifC1c4dJpavC+YnXmWHFQx6pp8OAYGAscXeo/l9W1y04KEanJI0wc
         cHsWrMpCWH0yUltFE+FLj7NVhph13efk3jA6lRrpV4A0iwU+lya50n4NBkDh1mkLS6Cp
         jZcbQX7POqp/j212nVBuc8Tj0l374xMgWDD1N4333prdUhEAIUzSXEmWm/nyK8ol74+b
         DDXg==
X-Gm-Message-State: AFqh2koRbcRt+V6a0reguRQKAYOoB1e+V4/6y0j/t7/wwxwIyIL2TqEw
        LB2z85Dd6LiLNaQL+tlufnM1/w==
X-Google-Smtp-Source: AMrXdXskjGH2VdSEumH2gFdf5DIfnsEbLq2aONWSNFs8KOjUrGAT3E3icDeZXe8W48sTqhNPO/bfyw==
X-Received: by 2002:a7b:c3c1:0:b0:3c7:1359:783b with SMTP id t1-20020a7bc3c1000000b003c71359783bmr47028901wmj.1.1673288773021;
        Mon, 09 Jan 2023 10:26:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b003d9ea176d54sm9545165wmq.27.2023.01.09.10.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:26:12 -0800 (PST)
Message-ID: <94744e36-e4d2-fe19-fc2b-cf801db247ca@linaro.org>
Date:   Mon, 9 Jan 2023 19:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 17/18] dt-bindings: arm: qcom: document the sa8775p
 reference board
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-18-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109174511.1740856-18-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/01/2023 18:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a new compatible for the sa8775p-ride board.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 27063a045bd0..7490eb0c3e3c 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -751,6 +751,11 @@ properties:
>            - const: qcom,qcs404-evb
>            - const: qcom,qcs404

You miss the update of SoC in this file (beginning).

>  

Best regards,
Krzysztof

