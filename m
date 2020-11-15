Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB402B383E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 20:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKOTHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 14:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKOTHJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 14:07:09 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB640C0613D1;
        Sun, 15 Nov 2020 11:07:08 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id o15so16445477wru.6;
        Sun, 15 Nov 2020 11:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7roRCqL5Ay4r8Kq4FOxDSQwbJ/1pjtvGTuBd9UPkQAM=;
        b=mIQ8Av7HDseFauMW4+BA3K4phgYTqQpav3PChSMOT5uP83FkZcTXS/8F3Vq5TqcfLN
         EKU+C+Qwf8qbM6r1lmVEfUIav2Uh6nqjPDnm3L3j5/IRd80NTUdyjiDpXevuyJuxRyaX
         04l0/sF560u7nCJiYQpghgqqEOv3NmfunWpBgbCBm+e+edBNII/y8q1MzP34lu26LY4A
         Ha1m1WNTQuQ4edJ2AOGu+EOZgIB0AfhNqL7kooqNuAVXpCFxNCrWh5Hi/qwOPRsktQiA
         IUExLCybSeUtZvLMBLiC/PagdD6CsA/mtdp98ZnD607yzJYz02N0McwH39Va3Zbn2mwx
         mJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7roRCqL5Ay4r8Kq4FOxDSQwbJ/1pjtvGTuBd9UPkQAM=;
        b=JZrRtrpAVpwMKVHbapsmMJpfOBkDnQeUMwgtp689Sinp2MwgoCyRQHel+I+VMgk8TK
         oAc7OdJ08MiDl9eNSFXGDqOOZ0ENMsg1pZhnEXbGp0iysQYAb1Xhs6VDxYB7hcQgIrN5
         2k849f66o2DlsrCYOmQ73Hc2+nK1YHXpXQYzbysWAl1/NpD+xXfxYn/0RyAAry0JF/ji
         qBHRG02bGNxPQGjpWatn9AZFl1aoF/l5ZG1kgUbh7Ir0CcGJmDkTEjBrRftiS/2QIR8J
         K34Wlw/CuQDOBpN0rBfi03sTt42FRxtsQsyoeqzhX1z1tjQW/PV/15BGMMQRM0oS/aof
         nD4Q==
X-Gm-Message-State: AOAM530ziZL1OQDsNMeFhmvr0BFlY3Jpun3yFYRfGt9266Y1teBvFbdQ
        /+dcFBK/Ad+X5YLgWnuLf+k=
X-Google-Smtp-Source: ABdhPJwGSvwkPTTNP2qUQL/7YRVjKWuNCTuVxK+0a3BAbOQqNJL31OfQm92WtFl4KKsqcy903mJphw==
X-Received: by 2002:adf:814f:: with SMTP id 73mr15192513wrm.174.1605467227250;
        Sun, 15 Nov 2020 11:07:07 -0800 (PST)
Received: from localhost.localdomain (p4fc3ea77.dip0.t-ipconnect.de. [79.195.234.119])
        by smtp.googlemail.com with ESMTPSA id u5sm14707869wro.56.2020.11.15.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:07:06 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     glaroque@baylibre.com, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] thermal: amlogic: Add hwmon support
Date:   Sun, 15 Nov 2020 20:06:58 +0100
Message-Id: <20201115190658.631578-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Many monitoring tools read the CPU temperature using the hwmon
interface. Expose the thermal sensors on Amlogic boards as hwmon
devices.

Without this lm_sensors' "sensors" tool does not find any temperature
sensors. Now it prints:
  cpu_thermal-virtual-0
  Adapter: Virtual device
  temp1:        +44.7 C  (crit = +110.0 C)

  ddr_thermal-virtual-0
  Adapter: Virtual device
  temp1:        +45.9 C  (crit = +110.0 C)

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/thermal/amlogic_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index ccb1fe18e993..dffe3ba8c7c4 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -29,6 +29,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define TSENSOR_CFG_REG1			0x4
 	#define TSENSOR_CFG_REG1_RSET_VBG	BIT(12)
@@ -287,6 +288,9 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (devm_thermal_add_hwmon_sysfs(pdata->tzd))
+		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+
 	ret = amlogic_thermal_initialize(pdata);
 	if (ret)
 		return ret;
-- 
2.29.2

