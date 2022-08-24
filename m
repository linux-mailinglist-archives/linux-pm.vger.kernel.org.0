Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E4459F363
	for <lists+linux-pm@lfdr.de>; Wed, 24 Aug 2022 08:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiHXGEl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Aug 2022 02:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiHXGEl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2022 02:04:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D6923F0
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 23:04:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r69so14154529pgr.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 23:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Dk8XzDm9D48Wg0yOKNV6jG+OQwP/124WGzj8tislXC0=;
        b=GV2EUQSbNojALXv87dCRbopnxuVC/rIx0y82s6hI/GqE8tRc7A12byQ3c2V4h8ispa
         8xxLUnrIuLPQF4Ne8XNC+OKGJpXHk62Ct75oDChoBcKh4GQCIPh/xW3vm5oAPb760/85
         oqnHDsBgg1UGtSQjBhtq717O86m0WqW2uiqIg8ukV0ysFZ2Cc5a6ufebPpw0MGwJ062M
         pVO7zQUGtvzGgJdbQMeCYIOFDdZek0T0F7MYm5zRPnGk+Qi1WxuzlLhFJZt13PU+/7pC
         uqCtRNXXQRPGG7dGqj6pq/+ZFxcd7xbvZZZz8/AVdCWsxaoKcBlpc8uzoDBPYtZvd25t
         RZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Dk8XzDm9D48Wg0yOKNV6jG+OQwP/124WGzj8tislXC0=;
        b=1sOGktipyz3S/JfPh5mV/8xG4EEAU2O9iOf9D+8IoBirFARSato9SMkfKKtkmOSVtT
         u1hjIp/lz//b73mggDMRJ4btbahLG0ubqkJLiKDDLZEK0uy7mfn8dGLVMBOw9SzMh7c0
         CL13udXKNKj6C42Mi1/Gsy4TerwGbamO6ctbFKiXzk7mYq6hxA/EpTLN4QkD7Bc+gVS2
         1TsADECoWPigOozhx5ErionzX3Tn7eTK2HfH+rQc7LeyeJRIklEUhLMklZOxXEtFnOhT
         OCZfrvMgQnpTe89EU+qbyB2Ys19Krx5Oi8W0dHjvBFFqhF4QCQz9V2phKHfRxpvPT3T4
         EfmQ==
X-Gm-Message-State: ACgBeo0dNMRPQehgStKLsIdQAaMO35Q0if18f6wag33SGOMUWL08hoSJ
        Ohmo66lANjBmDHKLYA4n+aaA+A==
X-Google-Smtp-Source: AA6agR42Mf+/DePJe3KKIFqhmxuPv3YBRiHOFkeDdcXPFc6xg94SgVGRNpLAt2WM0u7q3E2/nzEtRw==
X-Received: by 2002:a05:6a00:88f:b0:530:dec:81fd with SMTP id q15-20020a056a00088f00b005300dec81fdmr28642736pfj.64.1661321079747;
        Tue, 23 Aug 2022 23:04:39 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x63-20020a623142000000b0052d24402e52sm11805350pfx.79.2022.08.23.23.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 23:04:38 -0700 (PDT)
Date:   Wed, 24 Aug 2022 11:34:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Niklas Cassel <nks@flawful.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220824060436.in2weji5hpyabtsl@vireshk-i7>
References: <20220823145649.3118479-17-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-17-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-08-22, 09:56, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 1 +
>  Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index 59663e897dae..a202b6c6561d 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -40,6 +40,7 @@ properties:
>  patternProperties:
>    '^opp-?[0-9]+$':
>      type: object
> +    additionalProperties: false
>  
>      properties:
>        opp-hz: true
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> index 14a7a689ad6d..df8442fb11f0 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> @@ -19,6 +19,7 @@ properties:
>  patternProperties:
>    '^opp-?[0-9]+$':
>      type: object
> +    additionalProperties: false
>  
>      properties:
>        opp-level: true

Applied. Thanks.

-- 
viresh
