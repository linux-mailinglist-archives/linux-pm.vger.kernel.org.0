Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684DA672157
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 16:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjARPdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 10:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjARPdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 10:33:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627012B0B9
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 07:33:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n7so8268401wrx.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUPpYf55nSewKPfRw1r8GTAzRNx6PisN+J3CJfYWWqM=;
        b=ER+nRfLfGkm6S/o3MmxpSFWWo6T91uTm6DYUbVFOOUC+6DeFJbgFuuyS22UQ55nriy
         pmWZqfjYVV5qpaqONICqbKhaC3QxF4E2pJOloNLIo5uS7NSvF7zNp56PPGTnHThiuF/p
         LnEtVfxQlEncXoNaufozHXbHi8uLjaoucMIXqdQ1amadF3yujWJlVRJ+RVXxjD+bzNLM
         9wpmSjZegYNzNgqR6zt8ODCpgAKpU2IsmMbu+Me5U6eiqvNui0GAjCg3SdGzjp0q5+ui
         xJ89PpSRdyJmedgCuDXRY0yU2KRNDVosV2inzdam3HY3bz2jgEsYfnnEhAZSRW8gQcBY
         Vfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUPpYf55nSewKPfRw1r8GTAzRNx6PisN+J3CJfYWWqM=;
        b=c8i16YpEViFcuZ2XixqIk1cSnw4LixM6F/BNfRK9/LkFPuVuW0AcZmGQ5v5kg7fhrU
         U458m5ASS/8bMGCgUPU54l0GnT6NOSd3cGJLvAAa7vS6xTTEEU34VthE4HSGkDP1k38M
         w3NZl7kOI3RJ6eRSZHLZC1MJkOi+Z3D753mq/LqYZFFVh0t/X0bbUq/lH/EpJt6GSb5I
         JgaBPdfGsizqATP6v1+QjoGSvCa02TIeBlgNi+ci0NzM9DPL2987QNZK6YR/J4iJ1QNo
         j3xIDma81Yx/haR3DuQjT3UxWw2mMirUUul0w5lu939F5kExBi8as3gtMM1ZIZOJC50V
         UjkQ==
X-Gm-Message-State: AFqh2kqI3Q02zYTq0RcOVtWLZGZhgdn8TSLsL9DIJeThAt/ODBEKpX/3
        QTfOFg/1GYTES1rKa7D/eRJNMI9DyM2GCCL1
X-Google-Smtp-Source: AMrXdXtsBYgy2yvXAk1HX7S7z4hIuZLQip5px4lekLCG5EOdySAkbweDKG6rgI8l5Dgzm8Noat9D+g==
X-Received: by 2002:adf:df10:0:b0:2bb:e891:1829 with SMTP id y16-20020adfdf10000000b002bbe8911829mr6814451wrl.4.1674056017946;
        Wed, 18 Jan 2023 07:33:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm31225540wrx.21.2023.01.18.07.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 07:33:37 -0800 (PST)
Message-ID: <f7d3cd69-3eee-d96e-4c53-958c1e3d1c37@linaro.org>
Date:   Wed, 18 Jan 2023 16:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: qcom: document the
 interconnects for sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230118140825.242544-1-brgl@bgdev.pl>
 <20230118140825.242544-2-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118140825.242544-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/01/2023 15:08, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a DT binding document for the RPMh interconnects on Qualcomm sa8775p
> platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../interconnect/qcom,sa8775p-rpmh.yaml       |  50 ++++
>  .../interconnect/qcom,sa8775p-rpmh.h          | 231 ++++++++++++++++++
>  2 files changed, 281 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sa8775p-rpmh.h

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

