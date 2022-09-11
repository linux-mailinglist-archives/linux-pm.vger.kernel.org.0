Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD45B50B2
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 20:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiIKSm6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Sep 2022 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIKSm4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Sep 2022 14:42:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F527FD5
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 11:42:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so3892593pja.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Fo3J1n/Cp6jNn8Q5ca+GxDHv1JlzhPXIMXy71jWY/RY=;
        b=qpYjdW1N67wAT1+0RmDlbH7VgbFBCbyBJAs6uQDReUoEHsQI6iCmtOpCz9WMyvpm1k
         GjpqBnEmsVTbrkEN6I8O1RjV9cnWlc2O4ylINt24nY7wqTTUH/cRMfxj3ue7i/GVq0lK
         XIZtzv/Q5njqhNZy8+EEh8BPEUXEb5MPAlqMPAFJzCAQsYM6xsMURFg4NP/i9iURFnZF
         onpZ0RPT9qoGt0IR7MHCs/qWT0JzM8iuZUtk2M562uXPqN6KoM+4Gw5/RlfYtAbjqeh2
         I7ejsi2l6ioJhBnwdhkHHffdljebG+q4uqSifsD7yDQVR0rrenjbnLmiSBlidQ7wIuH6
         JLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Fo3J1n/Cp6jNn8Q5ca+GxDHv1JlzhPXIMXy71jWY/RY=;
        b=w0m9GHz0ry7EokPhkGiqIxFEmKaCpnxsdd0jo2vCaoV1FauFGe1p3xsZBuFkdDC0Ku
         7NdEPRVYpycX5wcaHg8r9b/j0nDts0pc1eMVQC5t4cfFaZwQjzAQ8bYOolW4E7Gt+PJV
         OKYRUXDLEDTAznP82DhceZVOuUXoght2EpuKR4DC+SqYTNg4sBg5TS0xcH7GolPm5tWz
         sX166dvE1HlwsMgXhul0PkZ0SBTZqRPBfcmtMDyEn8iaKIz6GPvvcZ+2fA+VmV0oNh9B
         1SmQR4rghebc1LZb1/prEsq9DVHn3Tj5zh+gajBK25BROjl00Y2xcns4Lg2pKMZjbGaJ
         MVHA==
X-Gm-Message-State: ACgBeo24zGY+QnAOrLKMl/N76F9Je0dOxEymkRnVnlqeKxZTxg8+6Kfx
        TcbRBOcvId1x/hFJWhvNLJqZD0Hal0drtg==
X-Google-Smtp-Source: AA6agR5g5L4XIOjX51yqRCL6Hy8DWHDhLOzpX2ms84YC1oF3d5m9U6X1xdaHib0fHJZP3eNdoaVs2Q==
X-Received: by 2002:a17:90b:2745:b0:1fb:1666:80f6 with SMTP id qi5-20020a17090b274500b001fb166680f6mr20097035pjb.103.1662921774689;
        Sun, 11 Sep 2022 11:42:54 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b001754cfb5e21sm4216417pln.96.2022.09.11.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 11:42:54 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH 1/2] thermal: Introduce CONFIG_QCOM_THERMAL in Makefile and qcom/Kconfig
Date:   Mon, 12 Sep 2022 00:12:31 +0530
Message-Id: <20220911184232.3198957-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce CONFIG_QCOM_THERMAL to allow better control
over selection of various Qualcomm Thermal drivers
available inside qcom/ directory.

This is a preparatory change to allow new drivers to
be added inside qcom/ directory in a more structured
fashion.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/thermal/Makefile     |  2 +-
 drivers/thermal/qcom/Kconfig | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index def8e1a0399c..a12b647be0d1 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
 obj-y				+= intel/
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-y				+= st/
-obj-$(CONFIG_QCOM_TSENS)	+= qcom/
+obj-$(CONFIG_QCOM_THERMAL)	+= qcom/
 obj-y				+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26eb..ccfd090273c1 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -1,8 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config QCOM_THERMAL
+	tristate "Thermal drivers on Qualcomm Snapdragon series of SoCs"
+	help
+	  Support for thermal drivers on Qualcomm Snapdragon series of SoCs.
+	  There are several thermal sensors available on the Qualcomm Socs
+	  which can be used for thermal mitigation purposes.
+
 config QCOM_TSENS
 	tristate "Qualcomm TSENS Temperature Alarm"
 	depends on NVMEM_QCOM_QFPROM
 	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_THERMAL
 	help
 	  This enables the thermal sysfs driver for the TSENS device. It shows
 	  up in Sysfs as a thermal zone with multiple trip points. Disabling the
@@ -15,6 +24,7 @@ config QCOM_SPMI_ADC_TM5
 	depends on OF && SPMI && IIO
 	select REGMAP_SPMI
 	select QCOM_VADC_COMMON
+	select QCOM_THERMAL
 	help
 	  This enables the thermal driver for the ADC thermal monitoring
 	  device. It shows up as a thermal zone with multiple trip points.
@@ -25,6 +35,7 @@ config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
 	depends on OF && SPMI && IIO
 	select REGMAP_SPMI
+	select QCOM_THERMAL
 	help
 	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
 	  PMIC devices. It shows up in sysfs as a thermal sensor with multiple
@@ -35,6 +46,7 @@ config QCOM_SPMI_TEMP_ALARM
 config QCOM_LMH
 	tristate "Qualcomm Limits Management Hardware"
 	depends on ARCH_QCOM && QCOM_SCM
+	select QCOM_THERMAL
 	help
 	  This enables initialization of Qualcomm limits management
 	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
-- 
2.37.1

