Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002FA7B96A8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Oct 2023 23:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244111AbjJDVq7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 17:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244092AbjJDVq6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 17:46:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255A0D9
        for <linux-pm@vger.kernel.org>; Wed,  4 Oct 2023 14:46:54 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d86a0c97ae6so376896276.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Oct 2023 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696456013; x=1697060813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qEbU8CefnmyxzPVcmg3qvbOFWDDg1iUYnbnQT6L2GM=;
        b=Tinl0shrzp19m4XiDWHqC6WzRpSbyrqImp1oJHkOlrs+S2eGP0oEuSBM2TIQvFYVS6
         Gzdwm8wR9+q7esAGFbkRDQbTlVVj589muZenASjN7ykYjEBhfRtr0Gp3aWV2/iN5ELaJ
         Zh674ntU0wrqp2QYGysNdxZLK+bgJv/I/vah0mb9FuR+QgAG3VYpeAiX87bOf6fSYYW1
         NfjNBoLa5LzES+jrsq1g8UvnHdt7fFlQG6KWUQ5e8EtC4D0kntNmFkdXZUB9lot33611
         bZhc6+wxLi9VP6KI1uuj+KMKxjkIL8+wTDBDrhu14lx1WQnyZvR749zm1v7gUkmgP/Bb
         faiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696456013; x=1697060813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qEbU8CefnmyxzPVcmg3qvbOFWDDg1iUYnbnQT6L2GM=;
        b=jNQTArHPch6SDAW+OMO7BmRIMW/Vv9yPFY3vIRvXQsenFBzW+VGu8aD/qlVzJMXt9o
         Ajp+vHez9MowsI2IHePO5V5vmjQzkMM3X8Fytp6bwUJ1aOAwoGaXdU6F+/sRUkRnWBc6
         D3bE6C60/AFYWmhn62R/iM+Mbc+pHelzolVrHZXZEr4OaXScpEvLQClrPvUWJoX/Q8Pa
         iJmbHnPe9dcq3D56gVAlRj0NQIJspCplJBlmluCCg3i8uJaAvJCXcrtJWsL482/zE1FL
         8J/ZMFNatQVroDpv/llMcxbvUD0L5VmBjSUSswBJYkLMkil/5/9aKZAt1KcAzYlrINyl
         QOUA==
X-Gm-Message-State: AOJu0YzSBm2JMsQpjgldsgciRWelLJ39w2VFHcIg735USnAUuu2oVXgp
        eyWpyrWG94fFD52+2nPvXnItL4HQNKJCBZJIuIKgDA==
X-Google-Smtp-Source: AGHT+IGM+a9ee3sjXYFYEDqq+rc6CPhFi39CeztSVz54fvnEXT/PKFZQrVPdT08OqadHn1ZVPfg/t+JMya8g7iT7sD4=
X-Received: by 2002:a25:b210:0:b0:d81:6344:540b with SMTP id
 i16-20020a25b210000000b00d816344540bmr3157985ybj.45.1696456013128; Wed, 04
 Oct 2023 14:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230927130734.9921-1-changhuang.liang@starfivetech.com> <20230927130734.9921-2-changhuang.liang@starfivetech.com>
In-Reply-To: <20230927130734.9921-2-changhuang.liang@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Oct 2023 23:46:17 +0200
Message-ID: <CAPDyKFruXQp83DdnX2wNMoC41NCVtKCq2NG_BoPqcc3D0NFhNA@mail.gmail.com>
Subject: Re: [-next v1 1/2] dt-bindings: power: Update prefixes for AON power domain
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 Sept 2023 at 15:07, Changhuang Liang
<changhuang.liang@starfivetech.com> wrote:
>
> Use "JH7110_AON_PD_" prefix for AON power doamin for JH7110 SoC.
>
> Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Applied for next (spelling mistake fixed), thanks!

Kind regards
Uffe


> ---
>  include/dt-bindings/power/starfive,jh7110-pmu.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt-bindings/power/starfive,jh7110-pmu.h
> index 341e2a0676ba..7b4f24927dee 100644
> --- a/include/dt-bindings/power/starfive,jh7110-pmu.h
> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
> @@ -14,7 +14,8 @@
>  #define JH7110_PD_ISP          5
>  #define JH7110_PD_VENC         6
>
> -#define JH7110_PD_DPHY_TX      0
> -#define JH7110_PD_DPHY_RX      1
> +/* AON Power Domain */
> +#define JH7110_AON_PD_DPHY_TX  0
> +#define JH7110_AON_PD_DPHY_RX  1
>
>  #endif
> --
> 2.25.1
>
