Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4798750FA0D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 12:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348642AbiDZKUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348528AbiDZKSG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 06:18:06 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB6B113C99
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 02:41:49 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q185so12005089ljb.5
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCBZ0j+ES0QNdxwqckFAUR3wGLW9E7d1PkVjGCIYt/4=;
        b=r1acGK2YBreLLygya/EOvCaObm6bBK2btdbyizZrEEZxckdmY3AeHcQ2bsa9N7NU4x
         D0BGu+DwXHkjo9FNLWjQYkK5JUOKQDeMKp7enmXFnLLFfnft4m2gz2kzKy2C5pSs6+Th
         k20E+demYA/Uf0O74o9vaOLtDTRgSSSQjEb8Zpqprry0tUoGkIT2VI1UyvCW7n9RNTJ2
         8/NgACXO/ykQHnmPalMkZqa9MYu2sYKhaJV03yrrQorkPDK5Rxka0EAkImafsx3xOeEs
         UtWHOqzvcoZto9e5PFE64B3wHW9J4FeXliua0SDuap1Lvj8amWR+bsTt1CCXlH79bfP0
         MFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCBZ0j+ES0QNdxwqckFAUR3wGLW9E7d1PkVjGCIYt/4=;
        b=5saaoKpVpS4idGuuYJd2DS6GxIKPqcTe6L/RCK3G3GRH0ttsE7A2U4q/cwP1M/c8ik
         vnCn3tyqGi3gaphQegBVyR9pva8Avp4AMSCG/31m8NDT9mqtIEgFp4JIY1pQf4ACz7LN
         i/QMwDD3HRAwD4o+e1BPlsuKbPp8cmTk49WCZPLoUMEFjHeqzriHgBCAFnWkemNW8wYd
         rBr7WiF/HdpOnEQ/HFa98ALQMV7pnylOxS8y2olNZaz+oIwjCLK9Ia8VIssq4SjqohKv
         b44mEHTuXz5S43oCt3DZLxoIdwX2DMqoobPkmJhOvcy9cte1YG+/3E8zxDH50ItW7lD2
         vDcQ==
X-Gm-Message-State: AOAM531qS7++Gdtl0Uma/wLx07Z0RC3SpQ5l/lNs7J/uOcm+VUTSLTNI
        CLOS4Yu6qcRETIKwWYu5R2EChg==
X-Google-Smtp-Source: ABdhPJzWpE9NmwU6vb9ejFEdUGOTsvjvOrOTdhMT2Iy+07f2LnAdyGRecHaAYpIZ/rElgTBXx3hFuQ==
X-Received: by 2002:a2e:8ec6:0:b0:24f:e8c:230f with SMTP id e6-20020a2e8ec6000000b0024f0e8c230fmr7567001ljl.530.1650966107912;
        Tue, 26 Apr 2022 02:41:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([188.162.64.30])
        by smtp.gmail.com with ESMTPSA id y28-20020a19641c000000b00471f6806403sm1330117lfb.16.2022.04.26.02.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:41:47 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_tdas@quicinc.com
Subject: [PATCH v4 1/3] clk: qcom: gcc-msm8960: create tsens device if there are no child nodes
Date:   Tue, 26 Apr 2022 12:41:42 +0300
Message-Id: <20220426094144.2958416-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426094144.2958416-1-dmitry.baryshkov@linaro.org>
References: <20220426094144.2958416-1-dmitry.baryshkov@linaro.org>
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

Currently gcc-msm8960 driver manually creates tsens platform device
manually. It would be better to follow IPQ8064 approach, where tsens
device is defined as gcc's child device in the device tree. If nothing
else, it removes gcc's dependency on QFPROM, thus allowing clock
controller to be probed earlier.

Don't create it in case there are available child nodes (tsens) inside
the gcc's device tree node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-msm8960.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index 051745ef99c8..a6e13b91e4c8 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -3641,6 +3641,9 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 		hfpll_l2.d = &hfpll_l2_8064_data;
 	}
 
+	if (of_get_available_child_count(pdev->dev.of_node) != 0)
+		return devm_of_platform_populate(&pdev->dev);
+
 	tsens = platform_device_register_data(&pdev->dev, "qcom-tsens", -1,
 					      NULL, 0);
 	if (IS_ERR(tsens))
@@ -3655,7 +3658,8 @@ static int gcc_msm8960_remove(struct platform_device *pdev)
 {
 	struct platform_device *tsens = platform_get_drvdata(pdev);
 
-	platform_device_unregister(tsens);
+	if (tsens)
+		platform_device_unregister(tsens);
 
 	return 0;
 }
-- 
2.35.1

