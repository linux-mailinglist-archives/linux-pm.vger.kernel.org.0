Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F69662295
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 11:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjAIKKR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 05:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjAIKKA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 05:10:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D315FD4
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 02:09:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so5873197wmo.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 02:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P564rb+wmbYDNgz0jFI4cUpRLfA1JGmzomxbN/CSgz4=;
        b=f00XbMRjiIADWQW/rOSYhOVw7dIWnll7nTruNQSNT/O27i+vefS0yVQ0H2dmpp0kSb
         onyV2xfNno9lva9qfGlDSGvQV/lBYk9jXaA9nAPBrDb1Wm7duIbUdWGgnYvFuDPT668c
         ZQGlzR20ldNTYBZ2/XJN4OZNppdtdota4VQ7MpFa2pEsJkUpxcZ/vc3REn65VlMr9yaS
         fCUs7vTVicEEfiJ/Y3pHjZoxxLPYvSMcz2QYTp5p/BTc4N6UMUErNenC1VgBwInfK068
         D3oaLMQv07q+Sjt2j2r+5zQ3J44FFpENVswm/JDXina574KapjoGxBan+OiSp/beQMPq
         Hdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P564rb+wmbYDNgz0jFI4cUpRLfA1JGmzomxbN/CSgz4=;
        b=xsa1gkgbC5Dd6XMvbFuLrquxXsybYdCkWVbBp/jpYOeWvJFs0pLCZ1v668LkKCDXXm
         DkXtnEdQhvygN2dD9d/S58tpy6Min3mitr7ZsPL14/n0iZK3BSIOFM+6gmE3A0NVY0B1
         lJhpKBgHiMiT1PkMicfzXdjLjNfbHbw7H5tYzuXqUUQGdMG9kybrZvH7iVWVVadg1wGu
         reO+S/LusO4Ji6PSlE6Wq2RMhnOUpTjcZY/rN90JWR4dCwCwM4V8ZTKzFKUvd7LeSzhu
         VtuWTdzBxKla4UFJksz83p1W+eIDtw6QT0c+pigrAP3do13jWccxWqpk5yDMR9sQKKPR
         N+gg==
X-Gm-Message-State: AFqh2koRbIql3dll+Seloa1NvMFM+GgSJBI27GmuCe5lOAZm5xseKstf
        N8fQmw1FUcrNCKMz8uhtfimErQ==
X-Google-Smtp-Source: AMrXdXtN3DnZFwhYMRJ08uiYOqtTUyQNUzlPKfBfgIy/o+OmcOWh00v1JYfi7yqRQ13Am24UewgvMA==
X-Received: by 2002:a7b:c39a:0:b0:3d2:640:c4e5 with SMTP id s26-20020a7bc39a000000b003d20640c4e5mr44217767wmj.8.1673258984238;
        Mon, 09 Jan 2023 02:09:44 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003b492753826sm10310646wme.43.2023.01.09.02.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:09:43 -0800 (PST)
Message-ID: <655f4a05-5fed-7481-1d00-a6a4faf4c6d8@linaro.org>
Date:   Mon, 9 Jan 2023 11:09:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] dt-bindings: interconnect: qcom-bwmon: document SM8550
 compatibles
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-bwmon-v2-0-20c555e3ba5d@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221114-narmstrong-sm8550-upstream-bwmon-v2-0-20c555e3ba5d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On 18/11/2022 09:29, Neil Armstrong wrote:
> Document the compatibles used to describe the Bandwidth Monitors
> present on the SM8550 platform.
> 
> A BWMON v4 IP monitors the CPU bandwidth, and a v5 does the LLCC
> bandwidth monitoring.
> 
> This is described by adding "llcc" and "cpu" into the compatible
> strings to differentiate the BWMON IPs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@somainline.org>
> To: Georgi Djakov <djakov@kernel.org>
> To: Rob Herring <robh+dt@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v2:
> - Reworded commit message
> - Added Reviewed-by from Krzysztof
> - Link to v1: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-bwmon-v1-0-b6dd08927f35@linaro.org
> ---
>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml         | 5 +++++
>   1 file changed, 5 insertions(+)
> 

<snip>


Gentle ping,

Thanks,
Neil
