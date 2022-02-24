Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645144C36A1
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 21:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiBXULP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 15:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiBXULP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 15:11:15 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6823D2782AD
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 12:10:44 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 12so4640111oix.12
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tp/pxUAsN1dsuv2WMgFOFlatJS81kJvAhFMGsLib+Ik=;
        b=QD5DoxG2HFUYczwhvfPpKRZtnIME+v8s7w+BMnIyEY0/+LA6uzKnzx48TQFLyCi7F0
         ZXnFA/+CXBjbSFYOtS/HtPQdxpoqKQCikgKMJ5nqywsutlOh215hj+5w2XnG7hcGhqfP
         ettNPp5G8VpeUXSppkEJD7y/PNFkQQpjRzdLxM5Tk2YLpzBQRCJaMqG6jpW6LUISA0MG
         v0BXQJ9gVeL2EVPR1q60Ac2A9Or1s6tbjQPqawwfA3VHvUv9z2gYfs1VgaS4+kIcdWyl
         KckZ6LmxFupOpCf7p0rOAYnEGLcZDBB1clh3kSO+0qp2AO0mGbovLAP+k1RJ+ejdlYn7
         YEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tp/pxUAsN1dsuv2WMgFOFlatJS81kJvAhFMGsLib+Ik=;
        b=bghhGp+Jt+TLxGlF1xvHcoC/C6mimwbiMwrpQniYSUI+HWP97DnvZ05XEneVTKHn0I
         unK1612sfSCuwEby6M8u7iIcZg9Bq80PvzNqAUWlnPF4F+sw73m/C27je4MBfJZ3oxM2
         EPraybn1HZe0WLGNjD344vThnbJZ+DHmx62HcMDoau0xQh7pBOjRhA3shIPvD+Xladst
         8848QW7gJLGHW9hiPU5nooSwLeXY9mto7oWgZKuoR0Sn7izkM2AnXMYbdsr1X3n2WVSk
         9INI+BsqJqdYAMEItkoVrVwF4HAZ+hyFuu5V9wzuhdWw/gqJNcmrxvDDxH9yFxmnuEN/
         oumg==
X-Gm-Message-State: AOAM531QP98vzgy+D2UR9lx3Bhn1484OhHYsWZH2vTsmNv5TsgBzbbA7
        D4Fpnge/58u8tenZjAnmFRGbng==
X-Google-Smtp-Source: ABdhPJyN1tJXc2OmNxcbayjctonbYe7XOluBMlLa7fjoRQREv6clqrbNE7J3VS7gOJPpy7RKF/DD4A==
X-Received: by 2002:a05:6870:6014:b0:d6:ca51:2108 with SMTP id t20-20020a056870601400b000d6ca512108mr2044865oaa.47.1645733443809;
        Thu, 24 Feb 2022 12:10:43 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id p16-20020a05680811d000b002d72ec3a921sm249592oiv.21.2022.02.24.12.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:10:43 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:10:40 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: thermal: tsens: Add msm8953
 compatible
Message-ID: <YhfmQFFCmb74dOvV@builder.lan>
References: <20220220201909.445468-1-luca@z3ntu.xyz>
 <20220220201909.445468-3-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220201909.445468-3-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun 20 Feb 14:18 CST 2022, Luca Weiss wrote:

> Document the compatible string for tsens found in msm8953.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Acked-by: Amit Kucheria <amitk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

Daniel, can you please pick this patch through your tree?

Thanks,
Bjorn

> ---
> Changes in v2:
> - no changes
> 
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index d3b9e9b600a2..b6406bcc683f 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -43,6 +43,7 @@ properties:
>        - description: v2 of TSENS
>          items:
>            - enum:
> +              - qcom,msm8953-tsens
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
>                - qcom,sc7180-tsens
> -- 
> 2.35.1
> 
