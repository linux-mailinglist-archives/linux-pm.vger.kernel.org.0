Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8843942A
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhJYK4T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:56:19 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36689 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232951AbhJYK4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:56:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id C9D1858045A;
        Mon, 25 Oct 2021 06:53:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Oct 2021 06:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=LuBuJ51kAs683
        zqagRQH/JKcv0PkL6c6myFxIpkwVuU=; b=ZCxLDnyWr0Pq9l9Mw18+UvpgAw/M6
        OX7+WwBKykBmT7M/QH1mdxNy9pu+ZwZxHsDmS5VHmbOoAcdCbyKUTxVw3qKNLq0S
        usa5ev/O+JZCsJDm3aKfpij8xa3WJgnPNhmvKKXzOpZk7JTn36RZK1f5rRQ1LvCv
        grTQce5HfjmjGIAbk8HLEyFdO/pQdQ6RrVNZkr2DEwtE5bbjMILJjg2FttxiasYI
        t/QejmUdclpBOueSISOFhFF6nWExHgGfaiJamFAg79/qSe8oVoH7EoORna2Z4Tyc
        TTuXtDIe16VwVfCamwRJdMJSbLLVcx87yJnvj/BxtAwmXeUzykBJoFICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LuBuJ51kAs683zqagRQH/JKcv0PkL6c6myFxIpkwVuU=; b=fugy0bp1
        b2e3mPjitpKoZTXVyM3KoeVF/oWhAH07La9tCmNddbnxM2nJG2LTYPC2/GWP5xlI
        8bzL8K02ctWebjHh+4cEGATLO8nyO5lqfnb3291vy56iCm3Q/7hmEINtmtWuxi0u
        1wjLPEv33fcrOafZRZjT+8TZscRgO+9glGgZWx3rhHDfzpSQSrnzy25xIuQOj/Wq
        ulKCMgUUxwkN9VvE8ryIfLJx+04u3VKIePqIQOiI1ZTea9WwPTgKcj5pPl4qz0Uw
        ApwLBXjGViyqSZ6uXdS5mamSkhRGXRagDijb4jaW6loji274eQxfx75acJBy8v04
        lsQC/lRNbY7Fag==
X-ME-Sender: <xms:wYx2YQ2bcRDRwlYdUtFV4atyBYNhUT90DubKhp8D3jDU2se9XPO9og>
    <xme:wYx2YbHOno-szkqHe_Cuq7lLCsTr5Oz5cwQWJIPR1ZSbBmQr-Z4Pfgi5umexKGSla
    yYQKl0YyfV_RlkIPQE>
X-ME-Received: <xmr:wYx2YY5f3dTmIZWyyzPDHDWbTrtyp4EoUraVhDhFRSYEy5qGYHF5tOb1qRR0L_WZ3m5hNM1jaCtE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:wYx2YZ2v5gX9h9CQLL5bE-R52DCChIIezyOgfwwg_dV7yP7-hgmK6g>
    <xmx:wYx2YTGY_wvVFZBMJ4MU99hyUFTG_Kc7-gSAJVCivHDFEvDfdV-tPA>
    <xmx:wYx2YS9vogrKA1Nzsqn3FCikXA3J4qP2ChfmACRB35-vt333mySDOQ>
    <xmx:wYx2YZXOLuBVb4aH4m9U1bXc6oJo8aHddTzXYGCOV9WGKjk_OhK7wQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 06:53:43 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     robh+dt@kernel.org, kernel@pengutronix.de, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     s.hauer@pengutronix.de, rui.zhang@intel.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        amitk@kernel.org, shawnguo@kernel.org, alistair23@gmail.com,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        andreas@kemnade.info, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v14 3/8] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Mon, 25 Oct 2021 20:53:04 +1000
Message-Id: <20211025105309.37942-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025105309.37942-1-alistair@alistair23.me>
References: <20211025105309.37942-1-alistair@alistair23.me>
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

