Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4A74E77B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 08:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGKGml (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGKGmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 02:42:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AA6E0
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 23:42:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so7878473e87.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689057756; x=1691649756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXWRfTiKWgzQTnNN2WcZy38rIo+7gjAKL9uUjuh2w5s=;
        b=xp4OhmqXs1+5nbQgmi4iTm5UwuToxLoZu1V3qo3CtKlVHI+KO+XP1ujpdBtzp2dH3f
         lu/gIhL3Qxxw+9kX1qoeAlVoaEgMcezDa09XwY+X6JvAJgtzI8nN3ecCGu6filJZMUc8
         sNvvDBuyNFtQEQuP7gsu9bCJ2FjYkvdX5enLx8o3V09g5gIv4JbbyLe2uoluZhgzHYjF
         dB9sv+7KX7jGeaqsJB5Wdldc1GToPPnlXEnWCSwSNHptmqINhkYRwaS99wHhwYX6VIvE
         pep/EkmP7SISKjvAeA8GL0h6BUJX4M09JyHYL1+uN4+TjkqZoy2P2ov3X9ezfhFPa/G0
         dBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689057756; x=1691649756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXWRfTiKWgzQTnNN2WcZy38rIo+7gjAKL9uUjuh2w5s=;
        b=Y/Q0QetT7VmXERTrdOk6lIX5OTSdOPMS0wC1/pydXZuTTJtsq7U3wkS1qjJ3k0QNlm
         zo600UAKYKeKxD2SLZEwXq/l/3BU8tTCOmrCdvj0c60jzwxUl83qwG0JMJTRQWkAjrjg
         3AfAaWQ4ETwssKW/lx/b7xKJBcSJg/muuY0Qa4XIW4y1xkPTGOS729uFqNLEB6x6FrQg
         /2htxSgsBlM3IO6K665uKDcK/4XRmsdMvuJcPJ2T7qH5Y1QgI3wtbmtAUnYIt7E/la3+
         UQMTHKvunpR8cmnCUC63c+LbtXgO08KuSXPIRoZKuAVL3A/V7qoO8wy0gJCqr0TNl9Pj
         7PEg==
X-Gm-Message-State: ABy/qLYqK8fP0ttWNjunGgAwvtX2eZoXvEB1fFWJQekquc1vmx9YGGJP
        q6jZxLzUzd0pAcpkCsBv9YW6FQ==
X-Google-Smtp-Source: APBJJlFKthYaLd34YMfFomj+8VTbGZcu43EhaOYtCrjJhZFsZPzCXEZ/gZ8+CR2DhCITHFqPmU9/XA==
X-Received: by 2002:ac2:4f0a:0:b0:4f9:92c7:4026 with SMTP id k10-20020ac24f0a000000b004f992c74026mr14050350lfr.1.1689057755845;
        Mon, 10 Jul 2023 23:42:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l11-20020a056402028b00b0051e26c7a154sm755626edv.18.2023.07.10.23.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 23:42:35 -0700 (PDT)
Message-ID: <f937db2e-a5b2-8ad9-ce5f-ed1ee9f2dda4@linaro.org>
Date:   Tue, 11 Jul 2023 08:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,bwmon: Document
 SC7180 BWMONs
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616-topic-sc7180_bwmons-v1-1-4ddb96f9a6cd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/06/2023 01:46, Konrad Dybcio wrote:
> SC7180 - just like SC7280 - has a BWMONv4 for CPU-LLCC and a BWMONv5
> for DDR-LLCC paths. Document them.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++

Can we get this patch applied? DTS is already in next so without this
patch there are 90 new warnings:
https://krzk.eu/#/builders/90/builds/40/steps/25/logs/warnings__94_

Best regards,
Krzysztof

