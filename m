Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CDC44C143
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhKJMdF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:33:05 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59709 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231751AbhKJMdE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:33:04 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id CBBB4580867;
        Wed, 10 Nov 2021 07:30:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Nov 2021 07:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=LuBuJ51kAs683
        zqagRQH/JKcv0PkL6c6myFxIpkwVuU=; b=WXqqYsLPWMrZFTi+OsHclSw1gfZ93
        lKgMeeGpn+t/n5l7QFtDeqOnnEETnyPTSbVFmoliEZ0WVBgB5ZF1GpQ85IsAKuCZ
        RpG4Ou49VyjMHeJnCt6AG9BgmiG8/+9hU+QEyoglVw5x6V4yGviaaPBSw0Pa/qMC
        6OheWgKn3zpLWfuHyiJCDlZrz1pgiJHHK2afUVxWkfOydO5A//lu5jRGhrw/pSpd
        6o3TVk/WwYUt1EtZFILw0KnWfzjysj2mf8/5DZdluYV8Y+FCTBOqE5iOuZ80gxjf
        ubv+h2sXabu1qtmYLhrtQfQLwOUcRdzA5FDh6FsKsHnMwIkLOtt2RfRig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LuBuJ51kAs683zqagRQH/JKcv0PkL6c6myFxIpkwVuU=; b=JXjigXYy
        6YiwB1K4VPfRsQO8R3uJoLjF4r1VWJwEJeAAVcWx573qVvoIecA8K8W7NTbafrpa
        xSK6XWtapGILZM+0+iLPa5kzMvVmsK9MyQSjR/WnFxdWX1feUha5ga8tLPwbGzCz
        O7p6BbUYQ+r6jsxbVYZrc4wBhJqjJD5Axbb1xHBNs7W07o8616jPcrS9LjbEyI3P
        yFgi+xyFg1kRoRl4Hoh0ootxhBHreS4dhALw8nhQOSLKWmk/RsHpMIzN7YdxQ1Lc
        tu2rBJbGRufQwPFJGuMqoWHod63DMR74lRhzIsKbZtH1C6dF8lZKrU/8CewL+gnw
        vFEvbxJr8pGDrg==
X-ME-Sender: <xms:WLuLYXYECYAnH3gad_JIWwib3o2LsmFgRGQV4e369fJLzrkpDb9cGg>
    <xme:WLuLYWYGl1aBLHxwoCqApJv5Y2mdENbolUq8cia-NSaI3rwhHk7Uzsci9KvsAWCX1
    mOu09U2rlAePNsg8YQ>
X-ME-Received: <xmr:WLuLYZ-1dd9PIbGYX1hNyK_gRz83X4w4CzZPYMeYN9nfVYTMlWc3fHWh18JoU17qCM2rCmGfHFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:WLuLYdqawnv-ynJVgnfUjRKPJhW8shTZ3xmyZMvwEdk-CDNY9DftQA>
    <xmx:WLuLYSqPN5IE8EelEUC6r5KRGnBiGT9c0dvHpz1ZIX2P_CQTM-Jrcg>
    <xmx:WLuLYTRN5hNUdnRQD-4h5CNgZtzcCg3pZ7a2MNiUFVoD4U-AX9336Q>
    <xmx:WLuLYQakZ7n-WzcBhlVINOQtq3d_kesskmsVheTEMah3GgveFlLgYg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 07:30:10 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, andreas@kemnade.info, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 3/8] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Wed, 10 Nov 2021 22:29:43 +1000
Message-Id: <20211110122948.188683-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110122948.188683-1-alistair@alistair23.me>
References: <20211110122948.188683-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/simple-mfd-i2c.c | 11 +++++++++++
 include/linux/mfd/sy7636a.h  | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 51536691ad9d..f4c8fc3ee463 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -62,8 +62,19 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 	return ret;
 }
 
+static const struct mfd_cell sy7636a_cells[] = {
+	{ .name = "sy7636a-regulator", },
+	{ .name = "sy7636a-temperature", },
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
index 000000000000..2797c22dabc2
--- /dev/null
+++ b/include/linux/mfd/sy7636a.h
@@ -0,0 +1,36 @@
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

