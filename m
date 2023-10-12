Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E27C74A9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379729AbjJLRXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379679AbjJLRWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:22:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74CBE6
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 10:22:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690ba63891dso963856b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697131327; x=1697736127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0nSQCpbHo4WjON0ZvJMnSfaRdeIMC1CvYzaBbZd7Tg=;
        b=P/ynugekh9pGFo1NTEqzhKrWFAAgSXzWytDBa9eXYQjvvMn0Y6BX7MeSgp1CprqWYr
         EEqhkTj3vYmTEJwuEJipKUjVpcZXgSJomxLWzNOfSXBzm4uh7KmfXkDUorLbceAXoQwL
         G8RCAlI+AeFX/sP3vev+Vh85cTrCK7ND7dguNH2OHm3FDI8ZB3NFWIAI1tinnNMCX6Do
         EyKKQJe+ybzhReurvIWypdrn/R02FSTVHlUjANkcD6XZ8NzEGQ2H0MKVctSX0KRRdrqt
         OhvUfahd6i4/v+5N/avPehAWW/nx5Ck7VYZ52mLLB64SP1OQNbscCSPpmk1OY+Y6FbuD
         u6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131327; x=1697736127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0nSQCpbHo4WjON0ZvJMnSfaRdeIMC1CvYzaBbZd7Tg=;
        b=YFubKvxg6eHTV5sid/bZMumd2L0p20MYTzcbrRRvkSbWdUvpZsduKU8u3CB7IC7fuu
         3K+oYotX4OE3e6pkFK3FRbOTr0b77fkSGW2+Z+K6OoBAU7Pk4fuFrPm/Z+idUU6RtmS5
         U6Ik7Ay4ozQ2jka6FO6aAnP9EL5E/XNZliv5/UUgCg54YaOWzT87vSIvqbo+MbIgxZaT
         M3lQsAr/74roiumQtke7jQiPQsESRst0PMSzOPqb78KnjN3M6nDBpdCFd3I8uHCR2tm4
         vifBJIcepBOCWcfvf9GJvcxTSY7P+tb6jRefmdbHwZjmLYl3x72iuiqAEMbtl5g6XWPr
         ZUWw==
X-Gm-Message-State: AOJu0YxQ5HvIp1vW48Zhc4anTNsIXZGCILdKdW7tAcKJ0XLbfGIvc/gp
        ZkcFYZc1Fpwa0tya7Snk0/1H
X-Google-Smtp-Source: AGHT+IGct0kVQN29NuA2jqe81k+DRJB9qgb2ae86cU0gimTKGn3g/GMK/fYPROa2HKbZeQtKKoVkQQ==
X-Received: by 2002:a05:6a20:430b:b0:138:2fb8:6c48 with SMTP id h11-20020a056a20430b00b001382fb86c48mr26856018pzk.8.1697131327135;
        Thu, 12 Oct 2023 10:22:07 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.180])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001c75a07f62esm2242359plg.34.2023.10.12.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:22:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, alessandro.carminati@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 3/5] scsi: ufs: host: Add support for parsing OPP
Date:   Thu, 12 Oct 2023 22:51:27 +0530
Message-Id: <20231012172129.65172-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

OPP framework can be used to scale the clocks along with other entities
such as regulators, performance state etc... So let's add support for
parsing OPP from devicetree. OPP support in devicetree is added through
the "operating-points-v2" property which accepts the OPP table defining
clock frequency, regulator voltage, power domain performance state etc...

Since the UFS controller requires multiple clocks to be controlled for
proper working, devm_pm_opp_set_config() has been used which supports
scaling multiple clocks through custom ufshcd_opp_config_clks() callback.

It should be noted that the OPP support is not compatible with the old
"freq-table-hz" property. So only one can be used at a time even though
the UFS core supports both.

Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd.c        | 36 +++++++++++++++
 drivers/ufs/host/ufshcd-pltfrm.c | 78 ++++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h             |  3 ++
 3 files changed, 117 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3f52e05002e4..a729be3e1f1c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1064,6 +1064,42 @@ static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
 	return ret;
 }
 
+int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
+			   struct dev_pm_opp *opp, void *data,
+			   bool scaling_down)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	struct list_head *head = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
+	unsigned long freq;
+	u8 idx = 0;
+	int ret;
+
+	list_for_each_entry(clki, head, list) {
+		if (!IS_ERR_OR_NULL(clki->clk)) {
+			freq = dev_pm_opp_get_freq_indexed(opp, idx++);
+
+			/* Do not set rate for clocks having frequency as 0 */
+			if (!freq)
+				continue;
+
+			ret = clk_set_rate(clki->clk, freq);
+			if (ret) {
+				dev_err(dev, "%s: %s clk set rate(%ldHz) failed, %d\n",
+					__func__, clki->name, freq, ret);
+				return ret;
+			}
+
+			trace_ufshcd_clk_scaling(dev_name(dev),
+				(scaling_down ? "scaled down" : "scaled up"),
+				clki->name, hba->clk_scaling.target_freq, freq);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ufshcd_opp_config_clks);
+
 static int ufshcd_opp_set_rate(struct ufs_hba *hba, unsigned long freq)
 {
 	struct dev_pm_opp *opp;
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index 61cf8b957da4..da2558e274b4 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -10,6 +10,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 
@@ -212,6 +213,77 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
 	}
 }
 
+static int ufshcd_parse_operating_points(struct ufs_hba *hba)
+{
+	struct device *dev = hba->dev;
+	struct device_node *np = dev->of_node;
+	struct dev_pm_opp_config config = {};
+	struct ufs_clk_info *clki;
+	const char **clk_names;
+	int cnt, i, ret;
+
+	if (!of_find_property(np, "operating-points-v2", NULL))
+		return 0;
+
+	if (of_find_property(np, "freq-table-hz", NULL)) {
+		dev_err(dev, "%s: operating-points and freq-table-hz are incompatible\n",
+			 __func__);
+		return -EINVAL;
+	}
+
+	cnt = of_property_count_strings(np, "clock-names");
+	if (cnt <= 0) {
+		dev_err(dev, "%s: Missing clock-names\n",  __func__);
+		return -ENODEV;
+	}
+
+	/* OPP expects clk_names to be NULL terminated */
+	clk_names = devm_kcalloc(dev, cnt + 1, sizeof(*clk_names), GFP_KERNEL);
+	if (!clk_names)
+		return -ENOMEM;
+
+	/*
+	 * We still need to get reference to all clocks as the UFS core uses
+	 * them separately.
+	 */
+	for (i = 0; i < cnt; i++) {
+		ret = of_property_read_string_index(np, "clock-names", i,
+						    &clk_names[i]);
+		if (ret)
+			return ret;
+
+		clki = devm_kzalloc(dev, sizeof(*clki), GFP_KERNEL);
+		if (!clki)
+			return -ENOMEM;
+
+		clki->name = devm_kstrdup(dev, clk_names[i], GFP_KERNEL);
+		if (!clki->name)
+			return -ENOMEM;
+
+		if (!strcmp(clk_names[i], "ref_clk"))
+			clki->keep_link_active = true;
+
+		list_add_tail(&clki->list, &hba->clk_list_head);
+	}
+
+	config.clk_names = clk_names,
+	config.config_clks = ufshcd_opp_config_clks;
+
+	ret = devm_pm_opp_set_config(dev, &config);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret) {
+		dev_err(dev, "Failed to add OPP table: %d\n", ret);
+		return ret;
+	}
+
+	hba->use_pm_opp = true;
+
+	return 0;
+}
+
 /**
  * ufshcd_get_pwr_dev_param - get finally agreed attributes for
  *                            power mode change
@@ -378,6 +450,12 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 
 	ufshcd_init_lanes_per_dir(hba);
 
+	err = ufshcd_parse_operating_points(hba);
+	if (err) {
+		dev_err(dev, "%s: OPP parse failed %d\n", __func__, err);
+		goto dealloc_host;
+	}
+
 	err = ufshcd_init(hba, mmio_base, irq);
 	if (err) {
 		dev_err_probe(dev, err, "Initialization failed with error %d\n",
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index fc0d6d37319a..7f0b2c5599cd 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1254,6 +1254,9 @@ void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
 void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
 void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
 
+int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
+			   struct dev_pm_opp *opp, void *data,
+			   bool scaling_down);
 /**
  * ufshcd_set_variant - set variant specific data to the hba
  * @hba: per adapter instance
-- 
2.25.1

