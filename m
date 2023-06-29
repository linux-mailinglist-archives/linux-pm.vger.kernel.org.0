Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E70D7428DF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jun 2023 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjF2Owe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jun 2023 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjF2Owd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 10:52:33 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD81FC1;
        Thu, 29 Jun 2023 07:52:32 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-78625caa702so31533639f.1;
        Thu, 29 Jun 2023 07:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050351; x=1690642351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nn05R2tUyCMvU1vj7Hfz7xOQtkV8OkP8hSujhGCuZE=;
        b=LrTf+W4J0c3QuYCb/ChqcvNN39Nau/ilUhkf4p5D8DLmk0bHmSWp8Fkqm3LoUJlrwG
         Y8DJlclllAN4fUAL4wwouxjZowvKsKhJhGPlsDdrDH1wglG0Qbdl9SmL4cWIRKoiJcwe
         W25HYs8Y3ME3ti+UXfJ6BAXE/84D6td7Z24siZE72bZVRPgAXKslTDHwawbkElScHXJl
         XfDz8Wj3y4JsCd+0LFxRo2OCUxoTsKyy6tJDLA/bGUmElsBeNfft9QzAZMi4GaRQ6Ye9
         NyQgEfQC4iL6duyA49Qz8efEHc3/V0472JYpaFuOEDMABILbx8IaN2W+GOQXSH9luBbx
         T3bA==
X-Gm-Message-State: AC+VfDxvYYl2DSM3qaSwcqbFw93xB2n5KGkedYeADOVS6LpgBz0c2001
        kD79Hew6TP6Sdgv9to3M6w==
X-Google-Smtp-Source: ACHHUZ6eSwv1Hzu5mGoUF+OBlpott9zj3av2T+Hvr869bDh+w9dNNLhnssQvt8NBXECCiYu6SI/hew==
X-Received: by 2002:a6b:f417:0:b0:777:b4af:32a3 with SMTP id i23-20020a6bf417000000b00777b4af32a3mr32829455iog.14.1688050351643;
        Thu, 29 Jun 2023 07:52:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c11-20020a02a40b000000b0041855b3a685sm898609jal.150.2023.06.29.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:52:30 -0700 (PDT)
Received: (nullmailer pid 2953074 invoked by uid 1000);
        Thu, 29 Jun 2023 14:52:28 -0000
Date:   Thu, 29 Jun 2023 08:52:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Ilia Lin <ilia.lin@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 03/26] dt-bindings: soc: qcom: qcom,saw2: define
 optional regulator node
Message-ID: <168805034808.2953018.11148192929126610166.robh@kernel.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625202547.174647-4-dmitry.baryshkov@linaro.org>
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


On Sun, 25 Jun 2023 23:25:24 +0300, Dmitry Baryshkov wrote:
> The SAW2 device can optionally provide a voltage regulator supplying the
> CPU core, cluster or L2 cache. Change the boolean 'regulator' property
> into a proper regulator description. This breaks schema compatibility
> for the sake of properly describing the regulator.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,saw2.yaml   | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

