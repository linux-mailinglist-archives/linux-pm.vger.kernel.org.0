Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F1472A0A6
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFIQw5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 12:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIQw4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 12:52:56 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0981993;
        Fri,  9 Jun 2023 09:52:54 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-777a6ebb542so82946039f.0;
        Fri, 09 Jun 2023 09:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329573; x=1688921573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eujn8JUGHI0bBmgrTXDm/BLkyXowc0kt/C2sds+BNXQ=;
        b=iPU0N01EfzqpjtP1WyrIQIHASkBXtdSJ59OUQUEX+qG1j67PPukrfAatgVB+oENiLD
         4OOjY1H4FZHB31cqipRL9FzBJsiSGP8NDOSLWMdUrx48Cs6rryETb1sO7UuVPg3in4UY
         +NMN0onbpo3kyD6gxqpBW4ny8tuvd5Xtg7qD00LQ6i7KZPrPjoUl/SxBK+hT+MHC66cn
         wPi0Tmed4Qjup5AhZBOS+iEq/u2QXfyrZkv0rTWJcbHruqjY4I6OUGUGGCi+44/rh/+U
         OegMtXxI8PbPvh4LQLRGpYHdvG2xWrXEQLuITL9pRNenTR1bww8PJvmdNYXtl9A8qim+
         y2Xg==
X-Gm-Message-State: AC+VfDzW5j77LqumHtS1+Jro+X6dmJ4Whz5aTLFt0d3x2QqtqRTM+4Iq
        m0d+e7qiGeX7gW69GAU8sPUS5AIvhA==
X-Google-Smtp-Source: ACHHUZ5W5KHyotltYhmI+LU0LABrhutXkkEdJQOh4ifI18m6JBhrPVQsDgMYEamdr04ba47axOw5+A==
X-Received: by 2002:a5e:8612:0:b0:77a:c54c:1e51 with SMTP id z18-20020a5e8612000000b0077ac54c1e51mr2120674ioj.9.1686329573613;
        Fri, 09 Jun 2023 09:52:53 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y10-20020a5ec80a000000b0076c70f8c4d1sm1174734iol.45.2023.06.09.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:52:52 -0700 (PDT)
Received: (nullmailer pid 1263494 invoked by uid 1000);
        Fri, 09 Jun 2023 16:52:50 -0000
Date:   Fri, 9 Jun 2023 10:52:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: power: reset: qcom-pon: define
 pm8941-pon
Message-ID: <168632956664.1263392.15400080254479022707.robh@kernel.org>
References: <20230609022553.1775844-1-dmitry.baryshkov@linaro.org>
 <20230609022553.1775844-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609022553.1775844-2-dmitry.baryshkov@linaro.org>
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


On Fri, 09 Jun 2023 05:25:50 +0300, Dmitry Baryshkov wrote:
> On PM8941 pon doesn't store the reset reason. However we still need the
> wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
> device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/power/reset/qcom,pon.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

