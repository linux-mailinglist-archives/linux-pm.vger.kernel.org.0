Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E587428EC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jun 2023 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjF2Oxi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jun 2023 10:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjF2Oxh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 10:53:37 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A191FC1;
        Thu, 29 Jun 2023 07:53:36 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-77acb04309dso31953839f.2;
        Thu, 29 Jun 2023 07:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050416; x=1690642416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOYUzFM6nNg6hOjwQDWmHYcu/9hQEbryLCl82/r+usM=;
        b=AlTaaPGJ0kBf+fBsOIioJGJnAP/HW2SBWftlPXHt0xBMGmH1jwEo22vM3Gye2KeTaS
         W6KgKvUHk1G6y4upON0MklJnuqj9q1LoMRk4YB+WjgumD3u6Y/7LaFhl5a7FGdrW1Q3o
         RnUZR3abv83YTfvf3Ou5lBCvLR9maLrRFjkwxtPggSgUP2ZrGPznlka5zda+4Sj9g2nQ
         j8d1f/ocwLowOQMyPLvPl7yMgYCtkQq9mkiaAj7eoL2oQNYbqtI8ahdVsbwmOVfQQC5f
         sx1x5HVl7Ez/noWTMN1Xi6clS1NSg5pwuxaAPkBtWsE6LIqKzNgr1gROZ/z66MaC2SiK
         uQgQ==
X-Gm-Message-State: AC+VfDwOoMeVBmAZNMhL4XMDZyKvb0eWqT3AholwK51GXED5kKmNFLdB
        5mgpVoPxDEGQofSkeZjNvw==
X-Google-Smtp-Source: ACHHUZ6RbEYn/dqa3uP+/XLwve1o9v7zVTMLczYa5gDwSwHtGlYMl02sOx42hOyX+it8cX64Lr3kig==
X-Received: by 2002:a6b:7a4b:0:b0:783:6eef:1496 with SMTP id k11-20020a6b7a4b000000b007836eef1496mr10830023iop.19.1688050415845;
        Thu, 29 Jun 2023 07:53:35 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t1-20020a02cca1000000b004165ac64e0asm3292747jap.40.2023.06.29.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:53:35 -0700 (PDT)
Received: (nullmailer pid 2954772 invoked by uid 1000);
        Thu, 29 Jun 2023 14:53:33 -0000
Date:   Thu, 29 Jun 2023 08:53:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-clk@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>
Subject: Re: [PATCH v2 04/26] dt-bindings: clock: qcom,krait-cc: Krait core
 clock controller
Message-ID: <168805041257.2954718.13141524461815116895.robh@kernel.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625202547.174647-5-dmitry.baryshkov@linaro.org>
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


On Sun, 25 Jun 2023 23:25:25 +0300, Dmitry Baryshkov wrote:
> Define bindings for the Qualcomm Krait CPU and L2 clock controller. This
> device is used on old Qualcomm SoCs (APQ8064, MSM8960) and supports up
> to 4 core clocks and a separate L2 clock. Furthermore, L2 clock is
> represented as the interconnect to facilitate L2 frequency scaling
> together with scaling the CPU frequencies.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  include/dt-bindings/clock/qcom,krait-cc.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,krait-cc.h
> 

Acked-by: Rob Herring <robh@kernel.org>

