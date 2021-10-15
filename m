Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9442F0C8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbhJOM2c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:28:32 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57593 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233784AbhJOM22 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:28:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 840BC580EC5;
        Fri, 15 Oct 2021 08:26:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 15 Oct 2021 08:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FdDYT5Tp6YL1F
        JGtwpyXkf35bNWjV4edMJpysgQFfjE=; b=hLppTsDffI86hz6TPn+dR4g3RJoGW
        H8/ffy1O3qCAV7GlDD1bZTGgIazRagkOUb0dwKcUiCconpTWmr8AIGVxn3EXxJL3
        bxKgCp0Tb2qrBfRWrQrn+plov5YqCuarcCjP5Wi3T3L7JNpureLRFY8ja/NblKDN
        pjLgYDU+dAXJ+0SVWnNGfpcYJyprhEZUACSQMkihX8ISDH70dCchdljKp/ygCP7g
        J0lMHCBA1SKHx+GXIb/EJs92fS4L9Sof6HWwf+chefvQh9FmZbJpJHwCbCFD90oP
        S9VVihnHJQNuLJ4bXReAFQzNe5TOIF4MZ9nZ/h2Ag6IfetA6CukrBNWPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FdDYT5Tp6YL1FJGtwpyXkf35bNWjV4edMJpysgQFfjE=; b=gAFlKV9S
        9BSH4pVmNbU2bma0tWxzOedHUlnSX81cn9eV0iX5f3orbK3InqTTtuHtsRumUEPV
        TUr5y8rz5ZfDtXb/yKvbCfDkFSMIOfPaigyNk31FbumLHU0l/DvsXLbVuD07UYwR
        2B3N2VJT2cWeKo+hGdaLF+Y9PC6PESPnKGYjbTSMsb5NgNVKZony3yMcYzqUPwP4
        eMOVAPHbtu+sxu9o8cUioqCpO7+lj7vHs/aiDkYmHsRJi4DT7yoDgJROZdri/nlj
        pnHzUdi2KpU2SGX8Q8wsemtPVY3m/5Xu1fd5D2/U5Eaqi6stuC7umEWMtrxuLSP5
        gnVs1dQ0xdYuog==
X-ME-Sender: <xms:bXNpYcu5AZslWfK9lTEO_aNddvF1WgIIMDYx9PGITjo9wYkONMeq3w>
    <xme:bXNpYZeZwiVSzwLWSggvdbmIgXLDczZgQrgniJZFZGm1i20PTvrUEXPnGV7fzwAN2
    g5_8w1Bu5e-p6neVy0>
X-ME-Received: <xmr:bXNpYXxnbWqq6t2rXmw1RxCs1pBUPIppmVcIWKP5rbFnZdaJkKSoRE3XWr9kTLGRaBo9kKRJdDu2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:bXNpYfPjwc6UkR_lv1xaxyuy-Gb2itIlNWfJ9rZGYEGd6IAiP3AuXQ>
    <xmx:bXNpYc8kolWafWmSj0Wd43CUWDWLl5W6QfsKdXiSYIE7boGWtPqc8Q>
    <xmx:bXNpYXVC1hSCkPrfPqRpFzZd8FKDctgWftIEwEmrsOyYUlgKLTGwDg>
    <xmx:bXNpYfcCypJ1i15hcCySuBM3ELtia6hXZKEHRlqzojPQO3Qt33eCfg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:26:15 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v13 3/9] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Fri, 15 Oct 2021 22:25:45 +1000
Message-Id: <20211015122551.38951-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/simple-mfd-i2c.c | 12 +++++++++++
 include/linux/mfd/sy7636a.h  | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 51536691ad9d..fbc6d6aed6c0 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -62,8 +62,20 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 	return ret;
 }
 
+static const struct mfd_cell sy7636a_cells[] = {
+	{ .name = "sy7636a-regulator", },
+	{ .name = "sy7636a-temperature", },
+	{ .name = "sy7636a-thermal", },
+};
+
+static const struct simple_mfd_data silergy_sy7636a = {
+	.mfd_cell = sy7636a_cells,
+	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
+};
+
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
+	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
new file mode 100644
index 000000000000..15caa54f0432
--- /dev/null
+++ b/include/linux/mfd/sy7636a.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Functions to access SY3686A power management chip.
+ *
+ * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
+ */
+
+#ifndef __MFD_SY7636A_H
+#define __MFD_SY7636A_H
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#define SY7636A_REG_OPERATION_MODE_CRL		0x00
+#define SY7636A_OPERATION_MODE_CRL_VCOMCTL	BIT(6)
+#define SY7636A_OPERATION_MODE_CRL_ONOFF	BIT(7)
+#define SY7636A_REG_VCOM_ADJUST_CTRL_L		0x01
+#define SY7636A_REG_VCOM_ADJUST_CTRL_H		0x02
+#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK	0x01ff
+#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL	0x03
+#define SY7636A_REG_POWER_ON_DELAY_TIME		0x06
+#define SY7636A_REG_FAULT_FLAG			0x07
+#define SY7636A_FAULT_FLAG_PG			BIT(0)
+#define SY7636A_REG_TERMISTOR_READOUT		0x08
+
+#define SY7636A_REG_MAX				0x08
+
+#define VCOM_MIN		0
+#define VCOM_MAX		5000
+
+#define VCOM_ADJUST_CTRL_MASK	0x1ff
+// Used to shift the high byte
+#define VCOM_ADJUST_CTRL_SHIFT	8
+// Used to scale from VCOM_ADJUST_CTRL to mv
+#define VCOM_ADJUST_CTRL_SCAL	10000
+
+#define FAULT_FLAG_SHIFT	1
+
+#endif /* __LINUX_MFD_SY7636A_H */
-- 
2.31.1

