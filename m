Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE85D649085
	for <lists+linux-pm@lfdr.de>; Sat, 10 Dec 2022 21:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLJUER (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Dec 2022 15:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLJUEP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Dec 2022 15:04:15 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DB414028
        for <linux-pm@vger.kernel.org>; Sat, 10 Dec 2022 12:04:14 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp15so12199711lfb.13
        for <linux-pm@vger.kernel.org>; Sat, 10 Dec 2022 12:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj0jB4AhzYQNXspmImuMXL7HzHFtFIdHtKGTYSzQnq0=;
        b=q3LIslAF2wRgh8DspOIqNEL5gxAzBjGzT1d0OFAjbzlOaSF6aIcUPKMgV6CNdRTYjT
         BPyhBbUunkkujEuf24tjFN2s0DyYsbiyUuWTIkJPg89nduDRd43gnPE77ozTe1n2AILd
         nFj4xP3Fqfyc/kK+EpUbBwP8ZPCi3yBZ/NMBMxcJGtSjNDODRSoj6/h+hFobDpnyNkhU
         iRcPyHpd+nyjT5hyqqplBO5HJd8CJKw+76tvmYgKLlmqZY6KKZLFj91bZYOz7yzxnzQm
         dhTNd8UUnewDyt8ns8Z8jMVro9FXj/+bcXyTUriQjoSRaTz2XC3Eh10/fU4R6PPLON4o
         vRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj0jB4AhzYQNXspmImuMXL7HzHFtFIdHtKGTYSzQnq0=;
        b=WhgYwdsp3pVLL3dU0QiOkPZEtDGF3/RQ186RlBdZGDuropHn0Ygdvkb/z3815BNWVD
         iGBX0/BHZz0jrXZ3ZbIELVIZC9AVAs1+n/ZyTyWqcN3bbRycmNR0z6RlRjaGfY3TBTds
         aCym91ybDaYdCc1o0XFLs2pCvnBpqq6y+m5AwqzPSgmAP0wpF3Icv7Pa+NrwoMDf0J65
         PVp2vILbhWFy1vBQU56/NCmN2HDK9YyGZIZzDV9AyoxDBIwjgfIRrgMkdD3nNFKZinSy
         WievBqR0H/L0E36cGPqRIgqOSmmvPHFOw+IAbNGhc2r5quig+KsQS9lsarRF96Pkzpdg
         4wVQ==
X-Gm-Message-State: ANoB5plhU5vc086xYGzuULNlSr253lZrWT60Au7GcR1N/m8vjW7l7Qq0
        PWyAyJ16S+s/4kpsRkME56qp2Q==
X-Google-Smtp-Source: AA0mqf5CwtJnVoK36NyIewNyGgUXoqk+uTWRK6Y9C1vqharCIFeloboLPZDqe2xMfIgQsedQVJ2o+w==
X-Received: by 2002:a05:6512:3d0e:b0:4b5:9043:2530 with SMTP id d14-20020a0565123d0e00b004b590432530mr4008272lfv.68.1670702653080;
        Sat, 10 Dec 2022 12:04:13 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004b4f1ea713csm839628lfp.73.2022.12.10.12.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 12:04:12 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] interconnect: qcom: rpm: Use _optional func for provider clocks
Date:   Sat, 10 Dec 2022 21:03:52 +0100
Message-Id: <20221210200353.418391-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210200353.418391-1-konrad.dybcio@linaro.org>
References: <20221210200353.418391-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It turned out that - very unfortunately - msm8996 needs a binding
update, adding 2 more clocks to the A2NoC node. Use the _optional
variant of devm_clk_get to make sure old DTs will still probe with
newer versions of the driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index ba6781f54ab7..df3196f72536 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -488,7 +488,7 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
+	ret = devm_clk_bulk_get_optional(dev, qp->num_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 
-- 
2.38.1

