Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC625167A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 12:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgHYKSd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbgHYKS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 06:18:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D940DC0613ED;
        Tue, 25 Aug 2020 03:18:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j13so991457pjd.4;
        Tue, 25 Aug 2020 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTXwWEO7xpItI/hq1nsVeIjAqEsDo//nOpDaKS8wYn8=;
        b=I/KSM1idjKxWs6Z/ih+DZem5MLLX9wbuFcfdFOC2TdvDtzvpKc0m42EQK7s58fp98t
         /e+VD/XorRRR3stFgOGgPu/efXJPU7YwBVn2SGGhn7eel2KTnDT/1pPejhP57V/zFDvp
         X/lAXkvxuWwOiKfrHuJw46jYjZa2gjQqTuqnQHX5EJYHyycaVdKIE18siftgTAAh6sKr
         pkds6VjwXTNyihGIujA7sM8uWWwGEgnbTHY27QYo71cXH0UgTj5eXNgR3c3bVKieE+Am
         ySV1rpqAh73mBDSONnNI6J8o0cIUIYkVBVWqjbE/c6yK6jV6ptxVrnzHF8zH2dS4FxcD
         Q5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTXwWEO7xpItI/hq1nsVeIjAqEsDo//nOpDaKS8wYn8=;
        b=ehSwA30ta9+rEX6RPygHw5kW7vI2Jbg9oZ2ByVQbKQUDzPOBZxzUbd7XhJ54vrJb/+
         /EvjMnxF4/k2LTOd/qpjLv7aNp+ySqsHyQgiELy+4IrcjMnYp/m64nQvCEEd8JONVTSk
         EuPipbSJF2BqNXHW5X0u4ITreep1CbYHcC9nBMFH4PREMXBKKPivZdc2kAy3coWuLdUo
         nu1kdi0ZGMwell24Fo2VIOCp7hsGmmHj4348+U2PEm3NyjEBjKN5Z7A8dPTBhWe7J6C/
         DnO9+/no94ta0POjZaPmBHWwP2V98bQ9/ZELYrs8JhlpSBQjUzB3wZLskPsRFKCd4mCB
         1bDQ==
X-Gm-Message-State: AOAM533E3+RFmgN0EgxtB0E4WI3qIO++YHU1qE/OTQGyt1UR+gbZ81xD
        5R9ZNOMSm+WdULNxvRQm33CgbdDOsH7UBA==
X-Google-Smtp-Source: ABdhPJzUCpXICCP/pI/qCwDnW1DTSEcXI/eR/+eOjoROjCae/iKpaLGyrsRP1fr5AosITFam8V/UsQ==
X-Received: by 2002:a17:90a:bd07:: with SMTP id y7mr1096325pjr.170.1598350708109;
        Tue, 25 Aug 2020 03:18:28 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 19sm1788911pjk.28.2020.08.25.03.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:18:27 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v10 2/4] power: supply: core: add wireless charger adapter type property
Date:   Tue, 25 Aug 2020 18:16:15 +0800
Message-Id: <b57461ee3d3fe4b3ad7462e251506e83bdb13887.1598349907.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598349907.git.huangqiwu@xiaomi.com>
References: <cover.1598349907.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Reports what type of wireless adapter connection is
currently active for the supply.
for example it can show if ADAPTER_PD capable source is attached.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 28 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                | 19 ++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index a6ec1c45adee..2850adbc8c58 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -730,3 +730,31 @@ Contact:	Fei Jiang <jiangfei1@xiaomi.com>
 			3: QUICK_CHARGE_TURBE,
 			4: QUICK_CHARGE_SUPER.
 
+===== Wireless Charger Properties =====
+What:		/sys/class/power_supply/<supply_name>/tx_adapter
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Reports the type of wireless adapter connection is currently active for
+		the supply, for example it can show if ADAPTER_PD capable source
+		is attached. Expect common wireless adapter type, also increase by
+		some vendor private adapter type(ex. ADAPTER_PD_40W).
+
+		Access: Read-Only
+		Valid values:
+			0: ADAPTER_NONE,
+			1: ADAPTER_SDP,
+			2: ADAPTER_DCP,
+			3: ADAPTER_CDP,
+			4: ADAPTER_OCP,
+			5: ADAPTER_QC2,
+			6: ADAPTER_QC3,
+			7: ADAPTER_PD,
+			8: ADAPTER_AUTH_FAILED,
+			9: ADAPTER_PRIVATE_QC3,
+			10: ADAPTER_PRIVATE_PD,
+			11: ADAPTER_CAR_POWER,
+			12: ADAPTER_PRIVATE_PD_40W,
+			13: ADAPTER_VOICE_BOX,
+			14: ADAPTER_PRIVATE_PD_50W.
+
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 67f568c88c0b..76de6ae199d3 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -211,6 +211,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
+	POWER_SUPPLY_ATTR(TX_ADAPTER),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 24b31b7e88a0..4e161d8961c1 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -172,6 +172,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_TX_ADAPTER,
 };
 
 enum power_supply_type {
@@ -215,6 +216,24 @@ enum power_supply_quick_charge_type {
 	QUICK_CHARGE_MAX,
 };
 
+enum power_supply_tx_adapter_type {
+	ADAPTER_NONE = 0,			/* Nothing Attached */
+	ADAPTER_SDP,				/* Standard Downstream Port */
+	ADAPTER_CDP,				/* Charging Downstream Port */
+	ADAPTER_DCP,				/* Dedicated Charging Port */
+	ADAPTER_OCP,				/* Other Charging Port */
+	ADAPTER_QC2,				/* Qualcomm Charge 2.0 */
+	ADAPTER_QC3,				/* Qualcomm Charge 3.0 */
+	ADAPTER_PD,				/* Power Delivery Port */
+	ADAPTER_AUTH_FAILED,			/* Authenticated Failed Adapter */
+	ADAPTER_PRIVATE_QC3,			/* Qualcomm Charge 3.0 with Private Protocol */
+	ADAPTER_PRIVATE_PD,			/* PD Adapter with Private Protocol */
+	ADAPTER_CAR_POWER,			/* Wireless Car Charger */
+	ADAPTER_PRIVATE_PD_40W,			/* 40W PD Adapter with Private Protocol */
+	ADAPTER_VOICE_BOX,			/* Voice Box which Support Wireless Charger */
+	ADAPTER_PRIVATE_PD_50W,			/* 50W PD Adapter with Private Protocol */
+};
+
 enum power_supply_notifier_events {
 	PSY_EVENT_PROP_CHANGED,
 };
-- 
2.28.0

