Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0E631E50
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiKUK1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 05:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiKUK1a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 05:27:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEB72738
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 02:27:28 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p8so18105488lfu.11
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4vLjDW5pxAZYBb4K1UAmCxfA1OtDW5XxiF4hNRgkak=;
        b=zTLDsqGDCUsX09712uw+EGwMkkzzhsfae9v+gXMmnbcLx15ZtrQB1l5sVF2CkP4AvJ
         pkvl9p28k+rsKl25G1cGtPxRpczUrmn0hwdpm2+tgdA9QgZf3Pt6R8hsw7oTdPAfOsYk
         2FAOSxT71IhruhJ+XUBOtaoOY7u66KUsqaBBHNaGPazZNiWbaPfvPd9Wpmdg+bCV9G/K
         PPpWQWX1KJvrsxFfQ47rmaXFDcKO608npqxG3d8dfhUN1SKpzfj9PuOM7JNAeVX1MPCL
         lMAs+ITg50rcdwnkfCqjWcShWMeQxBkMSi9AGPsoshJt1OleAL6oFu/MTFuY6u3gVALW
         S9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4vLjDW5pxAZYBb4K1UAmCxfA1OtDW5XxiF4hNRgkak=;
        b=GxmDcwzHo/QhkrFc2YwW+QVwNjjaVoOW3YfG8Xo2LkMcYDvCcZesnXbCyjmRl12kgV
         UHU2+NIQUdbXKi8qpZczMCKh3nOqGAd1iWR3XIq9OJuPlVqj7oy/wxTR7ru+gtWfdRUy
         8jMJhnvckenAPHVfCEtTndD8+HRLgqcnZEmkeSjLiNw/RouzO8sW8V0MGxkYY5Ua91Xc
         C2GlMSLPrrgKrERYnCLQA8U/YfVb1yxtGffozs8jA5FH9jPpleLMsoof82FVZtI9pN4/
         XkwVGcX1OFi2jQr9DfM8Kw2LCKLq6741KhvPQbzLzFK4DvI0RarNLVvvVADtRv3D0idR
         Cp0g==
X-Gm-Message-State: ANoB5pnw+Pk/DcZPlxXPWcoTQjaNceTdHljDFZvOBOcDhrJPfjT7Ad8r
        kx0Es5R5eIHYClZkwg27zqXorA==
X-Google-Smtp-Source: AA0mqf49Ge3im43fSMMT2mwvHHCBYeaMZhpMqvMLkINOPgbTUp8WHKqT7+wK7E6lpZ2Vb6RpoXVhaA==
X-Received: by 2002:a05:6512:3d1a:b0:4b1:2aab:7cc4 with SMTP id d26-20020a0565123d1a00b004b12aab7cc4mr5473004lfv.241.1669026446783;
        Mon, 21 Nov 2022 02:27:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p1-20020a2eb101000000b0027709706194sm1441943ljl.49.2022.11.21.02.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:27:26 -0800 (PST)
Message-ID: <d2c730eb-1c77-9339-b491-e3a8bb503b60@linaro.org>
Date:   Mon, 21 Nov 2022 11:27:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Add
 QDU1000/QRU1000 cpufreq
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221118182416.4920-1-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118182416.4920-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/11/2022 19:24, Melody Olvera wrote:
> Add cpufreq epss for QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

