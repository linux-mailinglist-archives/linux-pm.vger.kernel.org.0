Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23C0646827
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 05:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLHEQX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Dec 2022 23:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiLHEQW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2022 23:16:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F0629814
        for <linux-pm@vger.kernel.org>; Wed,  7 Dec 2022 20:16:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w23so362177ply.12
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2022 20:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr4Iu5BVbe01s1rT8smT36x+TYWRbPQICEznB+Ae7Q8=;
        b=yBvhrWL+A/kCBVS4MGy/NjwrpHIMPZurfmIzsx4neakG3t+cCfME3n8wajiL58P/dg
         5myFyO+w21AjPpL4V0vTGsaWblNF97osEbvgCBLoOHGts4G31mWPAZkOWp86o2dvWXtx
         vCfVI9SPvAE7EF/e4RC1hs8pNXF6V+FcupNqwZjS0+3zsdd9w8cNgb0KgLJgaSM024/L
         gospE35XY3gSe1nEW5mN3LYPXkqhiVB00ymiMfsyPRm3ESy6htE09X2ByY21Ea+VQWqi
         PVAUJX+VIu9zGHyN5KIWtUqymV1OdyNqHv3i1N+KSj1pwoxp6hJS+LG2rNZSBO35rFqi
         M5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr4Iu5BVbe01s1rT8smT36x+TYWRbPQICEznB+Ae7Q8=;
        b=1QO+AjwXoaapPsWVnEzJNZQwA7kRGb5XX//KTsHXUvNYSirHMl7EClTj2X+AHT3oiB
         WHtbDXgpbAAlHGuq1v1PcgBwKmAIqMYderYZFWsF4H80o6ADWMJY4Lk9gCa4SmRdAd7A
         6eImpZJCo6co357WMC3P7K/Rb7ekh/Tuunw1LKIlPfIcn1zs7oBLu6Uf0ScasgyDtbbn
         2kWcmvVwD0omDx7xgUdeG9BJ1oVlmNhL2SYryCRNmvTFdB4FR32L3RTTW5VxdQes2JLi
         JdpyNLeG2Ji8Fos7kU1vmsq5tdzu//3OAebgkyK9Rb9tqm8EodxS5Fxke8UoQ5wDqDqS
         0EKQ==
X-Gm-Message-State: ANoB5pkR1jW8iH+VCd+KKGZ1+Q9oFotG9hgaEUalr+oxQ0hh0YfOJnPN
        0ly1GGh+ptD/Hkqr8tPq7nYpuA==
X-Google-Smtp-Source: AA0mqf4njlA4WTgWF83snVkrtQ9N1QP7elEJdN3JpX/G4HiuA7X9rnolD38Li/2QJmaAM777LvIJgA==
X-Received: by 2002:a17:903:452:b0:189:6574:7ac1 with SMTP id iw18-20020a170903045200b0018965747ac1mr61287388plb.47.1670472980638;
        Wed, 07 Dec 2022 20:16:20 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id mr4-20020a17090b238400b002193f87fb4asm314384pjb.4.2022.12.07.20.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 20:16:19 -0800 (PST)
Date:   Thu, 8 Dec 2022 09:46:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp: opp-v2-kryo-cpu: Add missing
 'cache-unified' property in example
Message-ID: <20221208041614.zpg5skdixia2mduj@vireshk-i7>
References: <20221206014343.3117101-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206014343.3117101-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-12-22, 19:43, Rob Herring wrote:
> The examples' cache nodes are incomplete as 'cache-unified' is a
> required cache property for unified caches which an L2 cache certainly
> is.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index a202b6c6561d..27412c2cfc0f 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -106,6 +106,7 @@ examples:
>                  L2_0: l2-cache {
>                      compatible = "cache";
>                      cache-level = <2>;
> +                    cache-unified;
>                  };
>              };
>  
> @@ -140,6 +141,7 @@ examples:
>                  L2_1: l2-cache {
>                      compatible = "cache";
>                      cache-level = <2>;
> +                    cache-unified;
>                  };
>              };
>  

Applied. Thanks.

-- 
viresh
