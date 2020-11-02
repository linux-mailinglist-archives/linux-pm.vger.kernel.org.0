Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08F62A3215
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgKBRuL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 12:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKBRuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 12:50:10 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834DBC061A04
        for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2020 09:50:10 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id k25so15975997lji.9
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2020 09:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppiJR77c+oyF2YPqQViuqav70ajnTqRX4XIvZy2HLv8=;
        b=P/MG9Tv8yKh05V+RGDwsfeCaBAy5/EMDL8aqOuQT9DN4ijQpresf3gAV32WrEvUssV
         iVqB5kEkmwfiIB9KAW/FXdAlmunC8CDcG4STquVzRFZ/cNPmq2aUU/Io43tO0kwTBn94
         6isKoUY8MR6L9KCN3roYwIiZgc/SgqMlgYpupkFm4NT2hwpLrDkvRSFM0sGbORSdy9C7
         Z3/iLoDdzUp1bHAQDtkF2vzVpuFHd1Bhzz+IJoigTlDuJ+F9hOW1XAOLgU8skRnAtvYr
         insuKh2K5Jbd/le/Ny7z7opspcMyhsRnqGvBoUMp5zgVHNGlXuxZvPl97QdNhK5BPQ3l
         GyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppiJR77c+oyF2YPqQViuqav70ajnTqRX4XIvZy2HLv8=;
        b=GI1Wwfs6QFWc3JloPtwB37BvKpuGj5WTboDOkyZ6URaM0XJ9NOTkys5A1O+i+crr3e
         FLISYRoUU7ZBPA/K9CSBFY5Qj55kFdiXvFP8tKHt1kLItlCyiqLwEqBcnk0Bfa74DdwD
         iISFOQL9pNLUznf0Fz242QgXpNrEArmfnNmCGyvtJRZ9fnWx8KLN1EndWNhwPQhgy3t4
         8r3qiroN2S4ln60+MGS0paTcilZZnOW81wm1imabpiroUwW1H8tkNfYITXBeb8TITjBr
         kM6Y3X0KZRQM0BpwHcMJR51HFgJsLw8gamP1goA6DPybx8z9GvK95DnOxY/VSPSh0gky
         M6xg==
X-Gm-Message-State: AOAM533ybTRIBEDIxhOKZPM4P+JRznvrPf3kXO6nfeb5yzeIORYlcJKr
        uDK5LDfv/Ndmfi3QlOI+mJ4pdw==
X-Google-Smtp-Source: ABdhPJwYaksJTUNQRk459sHWzLk+fyKa8oM0/yErm94oBk1D9iu+vV7mncVbGFOT59WFGQB2ur5TfA==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr7367577ljg.311.1604339409029;
        Mon, 02 Nov 2020 09:50:09 -0800 (PST)
Received: from eriador.lan ([94.25.229.254])
        by smtp.gmail.com with ESMTPSA id r7sm2516163lfc.206.2020.11.02.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:50:08 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: [PATCH v9 05/15] iio: adc: move qcom-vadc-common.h to include dir
Date:   Mon,  2 Nov 2020 20:49:40 +0300
Message-Id: <20201102174950.1148498-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

qcom-vadc-common module will be used by ADC thermal monitoring driver,
so move it to global include dir.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                   | 3 +--
 drivers/iio/adc/qcom-spmi-adc5.c                      | 2 +-
 drivers/iio/adc/qcom-spmi-vadc.c                      | 3 +--
 drivers/iio/adc/qcom-vadc-common.c                    | 3 +--
 {drivers => include/linux}/iio/adc/qcom-vadc-common.h | 2 ++
 5 files changed, 6 insertions(+), 7 deletions(-)
 rename {drivers => include/linux}/iio/adc/qcom-vadc-common.h (99%)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 7e108da7d255..0610bf254771 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -10,6 +10,7 @@
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
 
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
@@ -21,8 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/regulator/consumer.h>
 
-#include "qcom-vadc-common.h"
-
 /*
  * Definitions for the "user processor" registers lifted from the v3.4
  * Qualcomm tree. Their kernel has two out-of-tree drivers for the ADC:
diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index c2da8f068b87..b10a0fcf09dc 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -7,6 +7,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -19,7 +20,6 @@
 #include <linux/slab.h>
 
 #include <dt-bindings/iio/qcom,spmi-vadc.h>
-#include "qcom-vadc-common.h"
 
 #define ADC5_USR_REVISION1			0x0
 #define ADC5_USR_STATUS1			0x8
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index b0388f8a69f4..05ff948372b3 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -7,6 +7,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -20,8 +21,6 @@
 
 #include <dt-bindings/iio/qcom,spmi-vadc.h>
 
-#include "qcom-vadc-common.h"
-
 /* VADC register and bit definitions */
 #define VADC_REVISION2				0x1
 #define VADC_REVISION2_SUPPORTED_VADC		1
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 40d77b3af1bb..ee94774b72e6 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -3,14 +3,13 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/fixp-arith.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/math64.h>
 #include <linux/log2.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/units.h>
 
-#include "qcom-vadc-common.h"
-
 /* Voltage to temperature */
 static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
 	{1758,	-40},
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
similarity index 99%
rename from drivers/iio/adc/qcom-vadc-common.h
rename to include/linux/iio/adc/qcom-vadc-common.h
index 7e5f6428e311..03a9119edc71 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -6,6 +6,8 @@
 #ifndef QCOM_VADC_COMMON_H
 #define QCOM_VADC_COMMON_H
 
+#include <linux/types.h>
+
 #define VADC_CONV_TIME_MIN_US			2000
 #define VADC_CONV_TIME_MAX_US			2100
 
-- 
2.28.0

