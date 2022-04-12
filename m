Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F44FE49A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356947AbiDLPXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 11:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356951AbiDLPWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 11:22:24 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F304193EA
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 08:20:05 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso13606689otp.4
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d+PIhawCGQKqSaXqYa/iZBL6dgcjK4qOFHlBoybLaRc=;
        b=nBkGsJgmCNSS9IGV9Ejz9t/B5eC84S5Ir2h7JTfwxVIjXPKXhNFqWWY3C/RDP4ZWQ1
         9LrWOl9ulQfyKZm2eTl72xbF+u5BqUyG32TzYFva4wgpBAn8/9SO4A2rbsxtRofgjR5M
         7oXNc1wNuowc5gn+Y+uNdiUKPvB53Jrl0ZgHEMjT3ZZmOlrGxY9hU0HZvu+1+O39hndb
         R950jUQa1n18bT8774XYDHdNoSjSpdr0wkOcZslivcyo4RXc6uzIJAHVEG+lkI+FFI3z
         lNtV9hNKNv3mXH5uzS6b3iQ5sZV2PX9bseA4zwcCFMwuv7U1vE5jjSv1MfX0B00yshbt
         ucyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+PIhawCGQKqSaXqYa/iZBL6dgcjK4qOFHlBoybLaRc=;
        b=zH0ZIta/AWIpyqZ1PaMjH3DGZUWC0t+HAXm/Girw0nvvhXlUat9DCWzRx3gfRVxJzq
         LmzYPnJ6hZHnBkVysRLhRgYXO4nTz/BCOLbmgeGWlUwt7m3fD04goQkDjKqbguP6p62W
         k8uWnzYlbBny+yZlmCdSS7qhZMpRBCmqZHW4xEBfxcdkE2OdqKQeooiv2nJJh+Mzsezm
         LmeAxBi/JsIEX7ykUArzSPZ8STbrYz2WYgyekgCW+nKLVeLDhBujZsQ1HvMcBP/nhidt
         797Xnenp5y5xMcmz/6YnUuzaPrczJw8eOq85Eqr1FlmTnNXENOTz/o6tFGA/320z0ua9
         WFtA==
X-Gm-Message-State: AOAM532M3EyiHpzJg4beGgc+i5aB+CVO414mzT8LkUBh59Kn67SRrktq
        mLcfab5AE1fZ4dnkIxqeKsh/8g==
X-Google-Smtp-Source: ABdhPJxL/d3Q0dZmV5j0Z6N1rGq3uWRPM11JQ58vEe8BmpfuWmxwJ3FaHYUM2BW476AU0Q0tFlyVIw==
X-Received: by 2002:a05:6830:154c:b0:5e6:85c5:ed8b with SMTP id l12-20020a056830154c00b005e685c5ed8bmr13202510otp.253.1649776804685;
        Tue, 12 Apr 2022 08:20:04 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id r17-20020a0568080ab100b002f9fef240f7sm3110364oij.50.2022.04.12.08.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:20:03 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:22:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: clock: qcom,gcc-sdm845: add
 parent power domain
Message-ID: <YlWZKprJuLJXd+r4@ripper>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154347.491396-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 11 Apr 08:43 PDT 2022, Krzysztof Kozlowski wrote:

> Allow Qualcomm GCC to register its parent power domain (e.g. RPMHPD) to
> properly pass performance state from children.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
> index d902f137ab17..daf7906ebc40 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
> @@ -43,6 +43,9 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  power-domains:
> +    maxItems: 1
> +
>    '#power-domain-cells':
>      const: 1
>  
> -- 
> 2.32.0
> 
