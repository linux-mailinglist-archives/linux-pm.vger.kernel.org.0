Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FF560374
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfGEJ5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 05:57:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44979 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfGEJ5t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 05:57:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so5925714lfm.11
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlHPOuaaif9Wc9OVXywifcQ4VawquOqZ8qWbF4QrYwE=;
        b=Qt2tO08yo8U3hs2e722fdPxFNH10AQO0VUc28Q6MdPGCjZUxKIXFlAOYPWNRCzjITw
         8A4cpUCeqO8zervOimWYnx5AaHjjeD22czPGMMmwNFLTNLLT76LKUEsGZl1JdnXVsOTb
         G0a5Tia9dh5nq2eWnDpPUjcoNbWoRmIdCWzYNPclUj2fR0bjVM+o6dg84bbOboCpPutp
         myiRab9fDlr59X1q0xYiGHhHn3h94I97M44ZMKkGACSZiXRVUtR1zA1OSVnd0xpcM3t4
         9MtaoqQIqu5SkSY6pQB0RiwGBKn/KVLhGCU+3YbKjv8cPLiNbL2ujFznYhCKvL3WuuIC
         9hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlHPOuaaif9Wc9OVXywifcQ4VawquOqZ8qWbF4QrYwE=;
        b=cQERRghqBQcsuP1O/r7konL1j0ZyH3Qz1HWpaxVb5yK2ErROGbXmih+jInhe7OeS9K
         RgQa13dB93xKW7WnLvTmuxiPb1VwhI4fwc3m4vhvyrts+rjsE5ejx+eswR3o07c/z2Mm
         Z1UT/+B+FQ7o1RXjKXWm/hwkKTqoePNQsW1RmL7GOKf0jQlAKQI3QIu9zrYfz15yF/o9
         hWnI/AM/u8iO2Xgzz92rdUi+UjdYNjVgV67PMNX2q4WzCGWCy/Yo262gfMVIOXEqhJKv
         cuDvzy0RRZPRMbRMg3I3rx8/92sibi+MjUTMsZcdMyCXtB2c8v15a9Dw+hY8aD/SNNl/
         /RdQ==
X-Gm-Message-State: APjAAAU0oy3fYGJwXmL7CVrZsuI1+pjqiu+M9rU7CWpodGZHeWrQ1+fp
        HFVnS8IAkUS3xDtOR8hLPKK90w==
X-Google-Smtp-Source: APXvYqyJ2MuCm6HePCmUfwNSJE0q1AUBq6fGLQ0IZQKfDTOzj7L3wj+bciCdJIkTJm1eWJS4XStxsg==
X-Received: by 2002:ac2:4152:: with SMTP id c18mr1631597lfi.144.1562320667663;
        Fri, 05 Jul 2019 02:57:47 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id q2sm1298364lfj.25.2019.07.05.02.57.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:57:46 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Sricharan R <sricharan@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 02/13] cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem based qcom socs
Date:   Fri,  5 Jul 2019 11:57:13 +0200
Message-Id: <20190705095726.21433-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

The kryo cpufreq driver reads the nvmem cell and uses that data to
populate the opps. There are other qcom cpufreq socs like krait which
does similar thing. Except for the interpretation of the read data,
rest of the driver is same for both the cases. So pull the common things
out for reuse.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[niklas.cassel@linaro.org: split dt-binding into a separate patch and
do not rename the compatible string. Update MAINTAINERS file.]
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Changes since RFC:
-Made DT bindings a separate patch.
-Keep the original compatible string, since renaming it breaks DT
backwards compatibility.

 MAINTAINERS                                   |   4 +-
 drivers/cpufreq/Kconfig.arm                   |   4 +-
 drivers/cpufreq/Makefile                      |   2 +-
 ...om-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} | 122 +++++++++++-------
 4 files changed, 78 insertions(+), 54 deletions(-)
 rename drivers/cpufreq/{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} (70%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04a66ba93c26..38ab8374fa7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13242,8 +13242,8 @@ QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
-F:	drivers/cpufreq/qcom-cpufreq-kryo.c
+F:	Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+F:	drivers/cpufreq/qcom-cpufreq-nvmem.c
 
 QUALCOMM EMAC GIGABIT ETHERNET DRIVER
 M:	Timur Tabi <timur@kernel.org>
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 56c31a78c692..b1aa485a28dd 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -120,8 +120,8 @@ config ARM_OMAP2PLUS_CPUFREQ
 	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 
-config ARM_QCOM_CPUFREQ_KRYO
-	tristate "Qualcomm Kryo based CPUFreq"
+config ARM_QCOM_CPUFREQ_NVMEM
+	tristate "Qualcomm nvmem based CPUFreq"
 	depends on ARM64
 	depends on QCOM_QFPROM
 	depends on QCOM_SMEM
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 5a6c70d26c98..8572a918aa75 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -64,7 +64,7 @@ obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
 obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
-obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
+obj-$(CONFIG_ARM_QCOM_CPUFREQ_NVMEM)	+= qcom-cpufreq-nvmem.o
 obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+= raspberrypi-cpufreq.o
 obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
 obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
similarity index 70%
rename from drivers/cpufreq/qcom-cpufreq-kryo.c
rename to drivers/cpufreq/qcom-cpufreq-nvmem.c
index dd64dcf89c74..fad6509eecb5 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -9,7 +9,7 @@
  * based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
  * defines the voltage and frequency value based on the msm-id in SMEM
  * and speedbin blown in the efuse combination.
- * The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
+ * The qcom-cpufreq driver reads the msm-id and efuse value from the SoC
  * to provide the OPP framework with required information.
  * This is used to determine the voltage and frequency value for each OPP of
  * operating-points-v2 table when it is parsed by the OPP framework.
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
@@ -42,9 +43,9 @@ enum _msm8996_version {
 	NUM_OF_MSM8996_VERSIONS,
 };
 
-static struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
+static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
-static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
+static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 {
 	size_t len;
 	u32 *msm_id;
@@ -73,28 +74,62 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 	return version;
 }
 
-static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
+static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
+					  struct nvmem_cell *speedbin_nvmem,
+					  u32 *versions)
 {
-	struct opp_table **opp_tables;
+	size_t len;
+	u8 *speedbin;
 	enum _msm8996_version msm8996_version;
+
+	msm8996_version = qcom_cpufreq_get_msm_id();
+	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
+		dev_err(cpu_dev, "Not Snapdragon 820/821!");
+		return -ENODEV;
+	}
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	switch (msm8996_version) {
+	case MSM8996_V3:
+		*versions = 1 << (unsigned int)(*speedbin);
+		break;
+	case MSM8996_SG:
+		*versions = 1 << ((unsigned int)(*speedbin) + 4);
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	kfree(speedbin);
+	return 0;
+}
+
+static int qcom_cpufreq_probe(struct platform_device *pdev)
+{
+	struct opp_table **opp_tables;
+	int (*get_version)(struct device *cpu_dev,
+			   struct nvmem_cell *speedbin_nvmem,
+			   u32 *versions);
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
 	unsigned cpu;
-	u8 *speedbin;
 	u32 versions;
-	size_t len;
+	const struct of_device_id *match;
 	int ret;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev)
 		return -ENODEV;
 
-	msm8996_version = qcom_cpufreq_kryo_get_msm_id();
-	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
-		dev_err(cpu_dev, "Not Snapdragon 820/821!");
+	match = pdev->dev.platform_data;
+	get_version = match->data;
+	if (!get_version)
 		return -ENODEV;
-	}
 
 	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np)
@@ -115,23 +150,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 		return PTR_ERR(speedbin_nvmem);
 	}
 
-	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	ret = get_version(cpu_dev, speedbin_nvmem, &versions);
 	nvmem_cell_put(speedbin_nvmem);
-	if (IS_ERR(speedbin))
-		return PTR_ERR(speedbin);
-
-	switch (msm8996_version) {
-	case MSM8996_V3:
-		versions = 1 << (unsigned int)(*speedbin);
-		break;
-	case MSM8996_SG:
-		versions = 1 << ((unsigned int)(*speedbin) + 4);
-		break;
-	default:
-		BUG();
-		break;
-	}
-	kfree(speedbin);
+	if (ret)
+		return ret;
 
 	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
 	if (!opp_tables)
@@ -174,7 +196,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
+static int qcom_cpufreq_remove(struct platform_device *pdev)
 {
 	struct opp_table **opp_tables = platform_get_drvdata(pdev);
 	unsigned int cpu;
@@ -189,18 +211,20 @@ static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver qcom_cpufreq_kryo_driver = {
-	.probe = qcom_cpufreq_kryo_probe,
-	.remove = qcom_cpufreq_kryo_remove,
+static struct platform_driver qcom_cpufreq_driver = {
+	.probe = qcom_cpufreq_probe,
+	.remove = qcom_cpufreq_remove,
 	.driver = {
-		.name = "qcom-cpufreq-kryo",
+		.name = "qcom-cpufreq",
 	},
 };
 
-static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
-	{ .compatible = "qcom,apq8096", },
-	{ .compatible = "qcom,msm8996", },
-	{}
+static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
+	{ .compatible = "qcom,apq8096",
+	  .data = qcom_cpufreq_kryo_name_version },
+	{ .compatible = "qcom,msm8996",
+	  .data = qcom_cpufreq_kryo_name_version },
+	{},
 };
 
 /*
@@ -209,7 +233,7 @@ static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
  * which may be defered as well. The init here is only registering
  * the driver and the platform device.
  */
-static int __init qcom_cpufreq_kryo_init(void)
+static int __init qcom_cpufreq_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
 	const struct of_device_id *match;
@@ -218,32 +242,32 @@ static int __init qcom_cpufreq_kryo_init(void)
 	if (!np)
 		return -ENODEV;
 
-	match = of_match_node(qcom_cpufreq_kryo_match_list, np);
+	match = of_match_node(qcom_cpufreq_match_list, np);
 	of_node_put(np);
 	if (!match)
 		return -ENODEV;
 
-	ret = platform_driver_register(&qcom_cpufreq_kryo_driver);
+	ret = platform_driver_register(&qcom_cpufreq_driver);
 	if (unlikely(ret < 0))
 		return ret;
 
-	kryo_cpufreq_pdev = platform_device_register_simple(
-		"qcom-cpufreq-kryo", -1, NULL, 0);
-	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
+	cpufreq_pdev = platform_device_register_data(NULL, "qcom-cpufreq",
+						     -1, match, sizeof(*match));
+	ret = PTR_ERR_OR_ZERO(cpufreq_pdev);
 	if (0 == ret)
 		return 0;
 
-	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
+	platform_driver_unregister(&qcom_cpufreq_driver);
 	return ret;
 }
-module_init(qcom_cpufreq_kryo_init);
+module_init(qcom_cpufreq_init);
 
-static void __exit qcom_cpufreq_kryo_exit(void)
+static void __exit qcom_cpufreq_exit(void)
 {
-	platform_device_unregister(kryo_cpufreq_pdev);
-	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
+	platform_device_unregister(cpufreq_pdev);
+	platform_driver_unregister(&qcom_cpufreq_driver);
 }
-module_exit(qcom_cpufreq_kryo_exit);
+module_exit(qcom_cpufreq_exit);
 
-MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. CPUfreq driver");
 MODULE_LICENSE("GPL v2");
-- 
2.21.0

