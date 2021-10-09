Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F43E4279AD
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244794AbhJILxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:53:10 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47523 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244762AbhJILxG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:06 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3F247580542;
        Sat,  9 Oct 2021 07:51:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 09 Oct 2021 07:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FdDYT5Tp6YL1F
        JGtwpyXkf35bNWjV4edMJpysgQFfjE=; b=hV/V4Vhi5e2RMvkwlHemd/mGEBf2w
        DQGstuLcHgsN2e4UWw1Tb0r6+p5mqorMd8DAD2RzduA7kr2h0QkUz01K8+hAAukc
        231m42zvdxbp7tYuP71f0SeIl5B8XSUXTKJMVRW2KMvdQC9Okviqnq2mKUEFu1Ge
        eeA1wlKiUTUuzP/buC01HdeGH83/J4vH6hre1J32/kXAG77cxjfvqevZ3f9G3V5/
        DHI7T5UIcGtgWdJ2m/cYL/XvfFyr3tjmnVCkb+bigOzvPmFITbySkB/BRIrh/U7/
        ELeVn5in/NjrQ659vqpwS+9gxftj27UE/wjogXOBmJ364k1in+RIj/fGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FdDYT5Tp6YL1FJGtwpyXkf35bNWjV4edMJpysgQFfjE=; b=hv5BHFZ/
        RuQ5WlDtT3f738aDZqGBbLbpbmYBAhBwP1K4sp2BtxLm8sax4skK/TlRptUrMFzr
        DvKmajxg2zRQsIOXtl//dqZ79R+4z5YM7EEw9Y31oRRX3ZwhXp/M0HC862AuqxLS
        ZrWfGWzlPHbS6QJibCK09BO1xS+yFobmHYnvWjHCpw8lf6ktDREHXMZuIDauyorY
        nhqBrGxpTUUO0ZYsAFwPwMSPrA1ZekxuluIoryonIEgJric0t0Gc9cT54CRnr8YW
        63LHEFHYE4y3Riw1M7rg4nb9aEaWnNeu52PwUv4/1FM5AZJDiJGicZ26kIUIaFu8
        0glaeoTG3tbCdQ==
X-ME-Sender: <xms:LYJhYZ_AKymF8sqtVSbasDbvdAqHuZq8fGuoo7nbK6FVkOgxTiS74w>
    <xme:LYJhYdv5OZP0hSu7R7K58kNaWbrXqiAHpWFV3ZGpNJeZtb15GOpZDsZoZ1w_aeinN
    -0RXCMvAi2rB81y0ms>
X-ME-Received: <xmr:LYJhYXB8bv15fmWjN-UBwySoGWKTO93RIkZB7WNU8FFLPR1Ple22kZJbN2AHSJFbNrNQ6LZYjXyfzs8C0kzyrcYl-jZYiN6IUC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:LYJhYdcH-0ck5uZ9uTdOSll3RHLInD2mTUcR9mNGyTFd_46CF3-PdA>
    <xmx:LYJhYeNEZRcmiEyDlkEIb6BYQCzkkMLGp0UGialLZzhFZfelfWOTbA>
    <xmx:LYJhYfniLM4zgbSDU0BHmPOlQUBCXY-CJ0VHP6TPJ6teRQVEgNPchw>
    <xmx:LYJhYbtgTuY5XDBak4QR0v2albG5myluGmUp3GHIyZCYVKjakCct2g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:51:04 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 03/10] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Sat,  9 Oct 2021 21:50:23 +1000
Message-Id: <20211009115031.18392-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
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

