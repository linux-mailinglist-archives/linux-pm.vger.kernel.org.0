Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61DB4FE8A8
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 21:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358028AbiDLTdM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 15:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358967AbiDLTdI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 15:33:08 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E92148E71
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 12:30:48 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so14030320otj.10
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aCVxPSm0uTRhRMeo9G7lwXu5Dd9Hg2ilAqo4ZKpYC5E=;
        b=t8lvK28JV09j7gDhXW855zKKcRPxFUomohHzI1FrhYI1GfBMf9IRV07109hIum+ZMy
         /63lrqsPbKLc7q35hKmxaSLVuW9BDiAJ2PiJu0U9hLiBzMaQ8aTsld26t3gpe7m4DNeJ
         eJmhPCZqkx7silh+LsV1FF8k/GFc8ITh11LGtN43SfEJCZhicmMwVl9qgSF+AAkDo5Va
         CfNQxSZI+RQjG1RRHPrrSzHAoDy9DWYCwkAV3UGmRymKxiiwQwcmwOz394k17Rgp7LFi
         pWFU6ryAmPmohP0ZwnQlrhjeuLC3JDxYG7ztEWHNUOneGLJSpykihVcR4rFbG5mgMtrF
         Tfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aCVxPSm0uTRhRMeo9G7lwXu5Dd9Hg2ilAqo4ZKpYC5E=;
        b=uA2FeK03y2Iiy4qJgEhzA8I0AJ8uiUzIDTTnBcVuZecgiFpCbWaCNRcSA0V112Zvw0
         sycrObpoSwbFBhkVJJPEKQwq9b3Cps64qIDujyd1bz4fVfxG019jTnuRNWGPkCppuVTg
         ZpwOb8MB8P7VZjfAB61LrSwUTWtugcgX8dINR/DTtNFUfvb/UH+NWRFVQaQz44uG/yG0
         PJUYAQpLWQUZ5E3FOGisVZecNhz1fmH51kE2bps1B+z0hEmsO9r+2te2BTUKo+FXqsbY
         h9khAHRc6nzb7T59xQ7RWziqBSn5gJSgfrJg28yM/xjepR/CUFJF3UjopvBrCXhqEquw
         S9ng==
X-Gm-Message-State: AOAM530BZRVBp4YdEJM6NEoCFasC1n9K+MAMeKv+82oPQshhmAAxVAYN
        sf9DqB/wzWG+yi5Vn3spazqNpw==
X-Google-Smtp-Source: ABdhPJy3LQycPDu4hDJNVv/MgO6q8PgjxQnbVUjw9fu+Cl4bhIOfEIG07xQbOJW9Er4vH2+n/Q4VnQ==
X-Received: by 2002:a05:6830:1483:b0:5cd:a7c4:754c with SMTP id s3-20020a056830148300b005cda7c4754cmr13945610otq.261.1649791847990;
        Tue, 12 Apr 2022 12:30:47 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm12951946oov.3.2022.04.12.12.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:30:47 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:30:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/9] dt-bindings: arm: qcom: Add MSM8996 Pro compatible
Message-ID: <YlXTZRPcOtM++g57@builder.lan>
References: <RHPEoHDkl9-X9DzB2A9P1Z-EowLK-VscTXgVAorSBWFb6yqJY585bMsVSe8otaj4Ahb9ng-CK5jnTt0wlhY_K1DPV3hRf7xg7pZa0mLgxy0=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <RHPEoHDkl9-X9DzB2A9P1Z-EowLK-VscTXgVAorSBWFb6yqJY585bMsVSe8otaj4Ahb9ng-CK5jnTt0wlhY_K1DPV3hRf7xg7pZa0mLgxy0=@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 08 Apr 23:18 CDT 2022, Yassine Oudjana wrote:

> Add a qcom,msm8996pro compatible and move xiaomi,scorpio to the
> same items list as it.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 129cdd246223..dcf2e0102857 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -186,7 +186,12 @@ properties:
>                - sony,kagura-row
>                - sony,keyaki-row
>                - xiaomi,gemini
> +          - const: qcom,msm8996
> +
> +      - items:
> +          - enum:
>                - xiaomi,scorpio
> +          - const: qcom,msm8996pro
>            - const: qcom,msm8996

So we want both platform compatibles in there?

> 
>        - items:
> --
> 2.35.1
> 
