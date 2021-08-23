Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E303F47FF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 11:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhHWJ5I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 05:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhHWJ5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 05:57:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3ECC061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 02:56:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w6so9817266plg.9
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YgI5dSo1rEo/T5lu/F1tJ8HTg39LuCdrSBpCETyTyKc=;
        b=fCVgWBkqqxB2VWxndj2ZNMXH/u9E53XphBp7R9cM0AosvnjzbBlwVUm6Z8ClH1UUki
         lba1retD9gqFz4AD+A1bRjssUR5FG38+dNphX6kLgLTNGPAlaRWOC9IxENZTFuQSCyHW
         Fu7icMrnpqzxug0ECpFphrKq22JWcqCt75t+iB9dsrTw2JNIbWlsdTtPA8H/1WmJm+qK
         xvUIYVHLMJX/jHmZhO0OWESPJJnwsK4SEwh4hhaECxANTSApsZYK7zhQb6FRnh5w+8PG
         FQsefcrAyYzRhthlGy5jGapJ2v2NbaLTD354pxsREul/54yvCPsGNpb2gH13HhZRbS3v
         Gxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YgI5dSo1rEo/T5lu/F1tJ8HTg39LuCdrSBpCETyTyKc=;
        b=Ij6bxTdwNaXVlmMD944UeYNF+MuR6a6hL+ThJFUzL5AWhaDkI8V7KzyCI4bNSxpJVv
         wk1FtAan5m9lalLRIa+DFf/l0UYlvjmcWciwfvyLbK7ggRGLezrSXRtZkjvTFn2ljv6b
         TF4qutNYWLpalM82vdtsvn+0FQvQ+VLquJnn1d7ySTE54GuDo+eDZ7YSzD0uSjRpmTWA
         asvuTy8gr0TkrEOWCiKDJc3HwPHVQFfo52Qp2VrJuyUZn6JQtors6cljGy8o5PqWFxTT
         YIOX07zldmSCSb51978DRg2DhXm2ul3V0tlY36IcnFetDhJdKGXEbtk8wKlrspvYK+Vo
         m4BA==
X-Gm-Message-State: AOAM533AOEudW0pbSThZlcyyobgnYeyA6/H/yRJ03WtB7ffNaRAHg6gE
        1WaTksxfRWiB7/cIBnB085dI3A==
X-Google-Smtp-Source: ABdhPJzXhpIwSbmq3vyin7oSjRPegikoV1A3ObQFHtjf4gYuy+4iaQDvZLveI+G10hrf5CZsbCiw3A==
X-Received: by 2002:a17:903:31cd:b0:134:5b6f:2ff8 with SMTP id v13-20020a17090331cd00b001345b6f2ff8mr3956135ple.46.1629712584447;
        Mon, 23 Aug 2021 02:56:24 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id z24sm18708230pjq.43.2021.08.23.02.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 02:56:24 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/3] interconnect: qcom: sdm660: Add missing a2noc qos clocks
Date:   Mon, 23 Aug 2021 17:56:02 +0800
Message-Id: <20210823095603.5538-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823095603.5538-1-shawn.guo@linaro.org>
References: <20210823095603.5538-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It adds the missing a2noc clocks required for QoS registers programming
per downstream kernel[1].  Otherwise, qcom_icc_noc_set_qos_priority()
call on mas_ufs or mas_usb_hs node will simply result in a hardware hang
on SDM660 SoC.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index c89c991a80a0..661eb3635d21 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -174,6 +174,16 @@ static const struct clk_bulk_data bus_mm_clocks[] = {
 	{ .id = "iface" },
 };
 
+static const struct clk_bulk_data bus_a2noc_clocks[] = {
+	{ .id = "bus" },
+	{ .id = "bus_a" },
+	{ .id = "ipa" },
+	{ .id = "ufs_axi" },
+	{ .id = "aggre2_ufs_axi" },
+	{ .id = "aggre2_usb3_axi" },
+	{ .id = "cfg_noc_usb2_axi" },
+};
+
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
@@ -811,6 +821,10 @@ static int qnoc_probe(struct platform_device *pdev)
 		qp->bus_clks = devm_kmemdup(dev, bus_mm_clocks,
 					    sizeof(bus_mm_clocks), GFP_KERNEL);
 		qp->num_clks = ARRAY_SIZE(bus_mm_clocks);
+	} else if (of_device_is_compatible(dev->of_node, "qcom,sdm660-a2noc")) {
+		qp->bus_clks = devm_kmemdup(dev, bus_a2noc_clocks,
+					    sizeof(bus_a2noc_clocks), GFP_KERNEL);
+		qp->num_clks = ARRAY_SIZE(bus_a2noc_clocks);
 	} else {
 		if (of_device_is_compatible(dev->of_node, "qcom,sdm660-bimc"))
 			qp->is_bimc_node = true;
-- 
2.17.1

