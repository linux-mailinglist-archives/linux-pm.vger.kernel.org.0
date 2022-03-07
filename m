Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891134CF657
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 10:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiCGJf5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 04:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiCGJfU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 04:35:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F066366C9D
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 01:31:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so6032349wmq.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 01:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mEobgGRGVJ5wiAE2capMOyflSnP2BH+i8WBwi8HQrCE=;
        b=NjumzJzXCW534OAtBTl5MUzvZ/jln6ubPNbWaGKP0P3vhbQk0ynhrATl5R8P8ua6PE
         jL7QXrBuehr/5qfZoRo7xAZPwv2FkvT329Qhq5iQ/bCJIeb87w2R1fsLjrWPZ0l//qCg
         tYPDMOCjCq0N6QZyloMMGqvwdRQ99LolPRzcpnEPRbmLDFSE1SmD70dsPfGsPlv5XRXT
         imSCAybERGskCUPGNBRperwkzn/+mHVGRBJVl2Qu1z1r1Lp9VZoJplbNe5LZ56FQRwP3
         H6ON3vUdPlKsWhgRGxGoM4aSSOvmt0MqIocAVAIwQfitt8ryyh9rSJIeON46u3ohAq8e
         +FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mEobgGRGVJ5wiAE2capMOyflSnP2BH+i8WBwi8HQrCE=;
        b=s425oQhmm6WUsJFCFna3uCZs9TlQmE09Rkcjeh271GfyVV3Ki2q/ZOihEShHLU+5Ep
         foUVOJbdoSseii+2Q+L39SBrHuZx9jcnPU+u0ESGz6d3bxgWljYhbWCYpZ1J4lXBVrLI
         WRm1veOdQtcS34cpB+H/m+Cbrpiajmq0ihECk9vU7geLb7RFktv1ybo/ttoHXvQdsIP2
         5OV336b2fgxoJKImVL+ur9b5bvkc4AAovuheccjbddxZLpaNAaLSe298xsDrUYXbJjbw
         i1dbFJEZ7j8Fb1PgBvZBZWu0JtMSY7eAKmYUrF3vsMxViezO3aunbwpBz+IgBxoM/dV7
         TcbA==
X-Gm-Message-State: AOAM532YCT8lJjm6pkT37elXOIQEIr8KGozyUL0MtWvFjbCzl7MQAS8a
        1HyCOjNod2q4QIngrUGpDLI40w==
X-Google-Smtp-Source: ABdhPJxVFyQ+f5cy6lUcxFa91ShR5PJvJhr2UPMVkDjDE6mY7sIKkjrehIRNnwFunvP9OhEL6QgSoA==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr17701505wmh.21.1646645445640;
        Mon, 07 Mar 2022 01:30:45 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g17-20020adff411000000b001f03426827csm10805840wro.71.2022.03.07.01.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:30:45 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:30:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] regulator: dt-bindings: maxim,max14577: convert
 to dtschema
Message-ID: <YiXQw01QZ4zFeALb@google.com>
References: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
 <20220215074759.29402-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215074759.29402-3-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 15 Feb 2022, Krzysztof Kozlowski wrote:

> Convert the regulator bindings of Maxim MAX14577/MAX77835 MUIC to DT
> schema format.  The existing bindings were defined in
> ../bindings/mfd/max14577.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/regulator/maxim,max14577.yaml    | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
