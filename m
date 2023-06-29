Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9057428D8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jun 2023 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF2Oud (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jun 2023 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjF2Ouc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 10:50:32 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF442689;
        Thu, 29 Jun 2023 07:50:31 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77acb04309dso31816539f.2;
        Thu, 29 Jun 2023 07:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050230; x=1690642230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQAFZTZmX1lw+d7qUkoHIgLWFl6mSRPZjS26OYS3NPo=;
        b=jJqW4Zp/tTVafI6nbBUupKooyrkp+0Gy/j5M9dIPUhSTh4YggV1ZT9xugYtMnLaOki
         VprD5z5zF9iKTETAh1qsKYQs/cMNj2nsG/EDUWllaGwJkO7P10PmGHUxND0LRtKfylDH
         /JEA8EZKAvoNz4qBJBOrvXoANbPZT+S4k9yGzNbXWwcUyzExu2QjWSWbUfpmGHO5+sE/
         jKX+O3auK/9CZpg21Rn4h+YKpmrecHesLZVLP8/bN1a/owYCc+pvz8OO/yv6tCvldSuH
         61G+yVUliicAwKv0eNo5K7xfc16yEeUKpZ8agCONmglIZfB5BVRVG80FHkavZzorLDj3
         JkQw==
X-Gm-Message-State: AC+VfDzokMVoVOCTLXirx3n5wj0LT/WBehcWF4pV6WqEo/kv3j4u7a4+
        Tv+IsmArn+1sfMlhkcfnow==
X-Google-Smtp-Source: ACHHUZ7coZk4I5I7rV5IjZOabpvhkI2uIzbP1uY0ZE3sLGByol+I3dMZ/ljIrSKqpmjtP0QL1XY0bA==
X-Received: by 2002:a6b:db09:0:b0:786:4198:3c2d with SMTP id t9-20020a6bdb09000000b0078641983c2dmr1420379ioc.1.1688050230596;
        Thu, 29 Jun 2023 07:50:30 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z13-20020a056638000d00b0042b1354452csm81778jao.83.2023.06.29.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:50:29 -0700 (PDT)
Received: (nullmailer pid 2950324 invoked by uid 1000);
        Thu, 29 Jun 2023 14:50:27 -0000
Date:   Thu, 29 Jun 2023 08:50:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v2 02/26] dt-bindings: soc: qcom: merge qcom,saw2.txt
 into qcom,spm.yaml
Message-ID: <20230629145027.GA2947266-robh@kernel.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625202547.174647-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 25, 2023 at 11:25:23PM +0300, Dmitry Baryshkov wrote:
> The Qualcomm SPM / SAW2 device is described in two bindigns files:

bindings

> arm/msm/qcom,saw2.txt and soc/qcom/qcom,spm.yaml. Merge the former into
> the latter, adding detailed device node description. While we are at it,
> also rename qcom,spm.yaml to qcom,saw2.yaml to follow the actual
> compatible used for these devices.
> 
> The regulator property is retained as is. It will be changed in the
> later patches.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,saw2.txt | 58 -------------------
>  .../qcom/{qcom,spm.yaml => qcom,saw2.yaml}    | 26 +++++++--
>  2 files changed, 20 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>  rename Documentation/devicetree/bindings/soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml} (64%)

Reviewed-by: Rob Herring <robh@kernel.org>
