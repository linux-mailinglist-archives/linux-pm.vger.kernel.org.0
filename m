Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DEE65219C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 14:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiLTNjR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 08:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiLTNjR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 08:39:17 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD0218E2D
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 05:39:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id z26so18616234lfu.8
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 05:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6oBJ8oYk8FnE07HmU5+cXGtoQDlc1shnr4HQgSbs3o=;
        b=jsXIn/7Uc90TtAjjxgq5IrlXD5uqjcpOE34sf8m8RTXf3q25kmaKM5I6tdzm9VxWsT
         kpN0Bg+TSAfciPUs0JnXNMBaIDDv+cot4qoQFe721pyYMX3DqPu99EUR3z73gd+eOaik
         1XtnfYyWMGx8ZVVsP777CfngIs2if5hRsShdy9tFVMGE1L7glvwht/BkGW+BqIBVJ6bf
         ThCQmCOHtKi2WIh6R+a1OQejYzXI6NLeIgyCC31WD0To3a1MdQocVEmU9pb+3QUDDg7N
         6pIXuDsFBA643xyeklbPeVhGxa0BAVdz7FDI1ABzHvhBS31x/u2rTbmgTYRGPTLf6BWZ
         OtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6oBJ8oYk8FnE07HmU5+cXGtoQDlc1shnr4HQgSbs3o=;
        b=Y4o/5SaPxo27+yMosd46R9elaebBnh+G1UNE22nbMpavHqQQEY1UP5NOBiq6c82i2g
         cyA3LeTNDLDKZGyFGMfhRd8zhPblMKcW9S63UNgTmdyBF+deb7gl47DUvi9CeNrQSd/y
         LpLxmCr/qC40vNGgNKRCGuvqSs7aS1FPNWCoNkifc2Ow4XxihvB+0K1luQCMsKWS3bGm
         6kn4sm6KXal+Rq6B4RYZmpJvC9+bCKHuVWUU8i595lrvDrr9BOc3do6iXv6uCIQECd1d
         dp4yVJxQEf3Tc1xJ1gYrZqHFhDa2ABQxl+qxenWPsRNE74nglMIf6czigwwuwokgX+gz
         iX1Q==
X-Gm-Message-State: AFqh2kr+QK46PwvM36RRJPhRlvOEk+zpR8iPbgOGWis7L+iakHAQZHxB
        yoTCMVMKcQKr9ndfp67cBiQpDA==
X-Google-Smtp-Source: AMrXdXvwNmIP02ze+f4f9HZ2sX8ad4oa9BLha0iWuj7HGsqN9P/WtFT4aHXxwtstFYPoSoNChTx72w==
X-Received: by 2002:a05:6512:252c:b0:4c0:4387:e3c2 with SMTP id be44-20020a056512252c00b004c04387e3c2mr5736195lfb.11.1671543554280;
        Tue, 20 Dec 2022 05:39:14 -0800 (PST)
Received: from localhost.localdomain (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id u23-20020a196a17000000b004b5774726dcsm1456000lfu.236.2022.12.20.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 05:39:13 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: qcom-hw: Fix reading "reg" with address/size-cells != 2
Date:   Tue, 20 Dec 2022 14:39:10 +0100
Message-Id: <20221220133910.240389-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during
probe") assumed that every reg variable is 4*u32 wide (as most new qcom
SoCs set #address- and #size-cells to <2>. That is not the case for all of
them though. Check the cells values dynamically to ensure the proper
region of the DTB is being read.

Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- remove the comment about 'i' reuse
- call of_node_put() on exit

 drivers/cpufreq/qcom-cpufreq-hw.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 340fed35e45d..9505a812d6a1 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -649,9 +649,10 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
 	struct device *dev = &pdev->dev;
+	struct device_node *soc_node;
 	struct device *cpu_dev;
 	struct clk *clk;
-	int ret, i, num_domains;
+	int ret, i, num_domains, reg_sz;
 
 	clk = clk_get(dev, "xo");
 	if (IS_ERR(clk))
@@ -679,7 +680,21 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Allocate qcom_cpufreq_data based on the available frequency domains in DT */
-	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * 4);
+	soc_node = of_get_parent(dev->of_node);
+	if (!soc_node)
+		return -EINVAL;
+
+	ret = of_property_read_u32(soc_node, "#address-cells", &reg_sz);
+	if (ret)
+		goto of_exit;
+
+	ret = of_property_read_u32(soc_node, "#size-cells", &i);
+	if (ret)
+		goto of_exit;
+
+	reg_sz += i;
+
+	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * reg_sz);
 	if (num_domains <= 0)
 		return num_domains;
 
@@ -743,6 +758,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	else
 		dev_dbg(dev, "QCOM CPUFreq HW driver initialized\n");
 
+of_exit:
+	of_node_put(soc_node);
+
 	return ret;
 }
 
-- 
2.39.0

