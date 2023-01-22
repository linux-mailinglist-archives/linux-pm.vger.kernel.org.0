Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9448B676D57
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jan 2023 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjAVOAa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Jan 2023 09:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjAVOA2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2023 09:00:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B116F1E29C
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 06:00:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so6793989wmq.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdiNtdUzDSNjkfrLI1XyxfUQrXm9A0/KpGIdOvbJRBs=;
        b=eMt5C6g6bjdP2zwpVZADjhiFtBJMN/WOpc2ug3gd+b9qLR1Cq6j30I+FsBvx/zLsSj
         HkltIXBr3q/pKksh3TAVvrmS78uUKP5mFjwvKGxOSVDoU/jfpmS2gSKlQgi1uzH/3aaY
         eKuUbqa39ldeEf6uHqdtixfXV0iDYY8+6leKV1BAvtXP6soJTy8a6eLSC3k3chqB0LIh
         VTs1cCi3n8n1aO46uXEL1F10yb2OFViMwunpeYAWrbvWuvq/xDE/W1VHuflQ7+1iq6KH
         r+RDaXsklUZo0RaVrOyDxQyKPi4o9WS/r6PTE7a0tRfj2vh3iX80rNj3mbNc/lpQ0Hc1
         0w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdiNtdUzDSNjkfrLI1XyxfUQrXm9A0/KpGIdOvbJRBs=;
        b=TnNn8ic/ljLohug8KhAwho+hSuB0Gbb3dDXCaeAwDl5D0zzSp6cNjntnA1tUyV63wb
         IrKsVuMfGz5MKuJHUMDRDBU+HMZ1ttJlj2EnEp6vzxmn8G5DQFYlgT0EXYT19DLhpP82
         3CXjQCL71ny9nWO4lattVkolEHNMlfGoBoCg3GqHzSki7SdCvrpnkFulToLfYB3wg7bx
         A6H7HrEO5W/MheZSRkkjxbvsqIQraYfgUL8SVZ7CTqx56qGxICVm1T+IZ9iug9x+Muo8
         P3/LGgUlpF2bB6U2oz7sPjDRvD6tpGz1im5QxmWqCjv9CiMgJEb+LE7xNPDXO1tr+yQJ
         ztgA==
X-Gm-Message-State: AFqh2kq8cpr3NOhLgYPfYihAqufdANC78h9EoWOiH6LtB5QuVkfN0bF0
        4CyGUm4HLGSSywXl+TrNa49pRw==
X-Google-Smtp-Source: AMrXdXs0JQRtQnYauZIlR3A+e26rCG+DYCwtpwZVGqYvz7atFYKwwQCVmfh9CjkA+F02koPFUAdgdw==
X-Received: by 2002:a05:600c:4e05:b0:3c6:e61e:ae71 with SMTP id b5-20020a05600c4e0500b003c6e61eae71mr21667261wmq.1.1674396025224;
        Sun, 22 Jan 2023 06:00:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b003d237d60318sm8781576wmq.2.2023.01.22.06.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 06:00:24 -0800 (PST)
Message-ID: <4b58dcf1-df8a-048f-ba6f-ea170479751b@linaro.org>
Date:   Sun, 22 Jan 2023 15:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] dt-bindings: opp: opp-v2-kryo-cpu: add opp-microvolt
 nvmem based
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
 <20230121000146.7809-2-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121000146.7809-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/01/2023 01:01, Christian Marangi wrote:
> The operating-points-v2-kryo-cpu driver supports defining multiple
> opp-microvolt based on the blown efuses in the soc. It consist of 3
> values that are parsed: speedbin, psv and version. They are all
> appended to the opp-microvolt name and selected by the nvmem driver and
> loaded dynamically at runtime.
> 
> Example:
> 
> opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
> opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
> opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
> opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
> 
> Add support for this and reject these special binding if we don't have a
> nvmem-cell to read data from.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index b4947b326773..cea932339faf 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -61,6 +61,17 @@ patternProperties:
>  
>        required-opps: true
>  
> +    patternProperties:
> +      '^opp-microvolt-speed[0-9]-pvs[0-9]-v[0-9]$':

This does not end with correct unit suffix. Should be
opp-speed-.....-microvolt

> +        description: |
> +          Assign a microvolt value to the opp hz based on the efuses value from
> +          speedbin, pvs and vers

Where is the DTS change?

Best regards,
Krzysztof

