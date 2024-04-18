Return-Path: <linux-pm+bounces-6684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8588A9ED5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 17:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853E81F22594
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D816E89D;
	Thu, 18 Apr 2024 15:44:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003416E891;
	Thu, 18 Apr 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455076; cv=none; b=Yg0/KJq+gciQMg3nJRK5igbKTep2i2vvyBajelAmEAUXwitoabhn8UpxfIFKe2c6BCZn/DcQzt9i+h1YHR/vzcd4Oi70lZPb9XquPqzjp9pE80KmjYciOBmnVxpQbhOn8O0U25j94nDUHdZnqfObz8swUH23VcTCDF8Wb7y3eFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455076; c=relaxed/simple;
	bh=OcO27FTPEuLYXQQvQTT2GS6wEKKq384otptC1NHkZfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1qaskoJhtAFEVOLJ2rBBlIzqfXmCrl7vPsbabp1luqG0cZezHqLJPENgz4vXoy0O6ANK1np8LV4jmlO4U8wj1Z5At9JiWCxH41NmKNenXV1126/53PQeiIt3I/8RFYzkYGl7PSyTj/haMmu+Le+bMSKodcyz5aQ7+HEhl42bnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 974A3339;
	Thu, 18 Apr 2024 08:45:02 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9B593F738;
	Thu, 18 Apr 2024 08:44:31 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v5 6/8] cpufreq: sun50i: Add H616 support
Date: Thu, 18 Apr 2024 16:44:06 +0100
Message-Id: <20240418154408.1740047-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418154408.1740047-1-andre.przywara@arm.com>
References: <20240418154408.1740047-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Botka <martin.botka@somainline.org>

The Allwinner H616/H618 SoCs have different OPP tables per SoC version
and die revision. The SoC version is stored in NVMEM, as before, though
encoded differently. The die revision is in a different register, in the
SRAM controller. Firmware already exports that value in a standardised
way, through the SMCCC SoCID mechanism. We need both values, as some chips
have the same SoC version, but they don't support the same frequencies and
they get differentiated by the die revision.

Add the new compatible string and tie the new translation function to
it. This mechanism not only covers the original H616 SoC, but also its
very close sibling SoCs H618 and H700, so add them to the list as well.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 67 ++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 8719955278d9a..30e5c337611ce 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/arm-smccc.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
@@ -46,14 +47,77 @@ static u32 sun50i_h6_efuse_xlate(u32 speedbin)
 		return 0;
 }
 
+static int get_soc_id_revision(void)
+{
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
+	return arm_smccc_get_soc_id_revision();
+#else
+	return SMCCC_RET_NOT_SUPPORTED;
+#endif
+}
+
+/*
+ * Judging by the OPP tables in the vendor BSP, the quality order of the
+ * returned speedbin index is 4 -> 0/2 -> 3 -> 1, from worst to best.
+ * 0 and 2 seem identical from the OPP tables' point of view.
+ */
+static u32 sun50i_h616_efuse_xlate(u32 speedbin)
+{
+	int ver_bits = get_soc_id_revision();
+	u32 value = 0;
+
+	switch (speedbin & 0xffff) {
+	case 0x2000:
+		value = 0;
+		break;
+	case 0x2400:
+	case 0x7400:
+	case 0x2c00:
+	case 0x7c00:
+		if (ver_bits != SMCCC_RET_NOT_SUPPORTED && ver_bits <= 1) {
+			/* ic version A/B */
+			value = 1;
+		} else {
+			/* ic version C and later version */
+			value = 2;
+		}
+		break;
+	case 0x5000:
+	case 0x5400:
+	case 0x6000:
+		value = 3;
+		break;
+	case 0x5c00:
+		value = 4;
+		break;
+	case 0x5d00:
+		value = 0;
+		break;
+	default:
+		pr_warn("sun50i-cpufreq-nvmem: unknown speed bin 0x%x, using default bin 0\n",
+			speedbin & 0xffff);
+		value = 0;
+		break;
+	}
+
+	return value;
+}
+
 static struct sunxi_cpufreq_data sun50i_h6_cpufreq_data = {
 	.efuse_xlate = sun50i_h6_efuse_xlate,
 };
 
+static struct sunxi_cpufreq_data sun50i_h616_cpufreq_data = {
+	.efuse_xlate = sun50i_h616_efuse_xlate,
+};
+
 static const struct of_device_id cpu_opp_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6-operating-points",
 	  .data = &sun50i_h6_cpufreq_data,
 	},
+	{ .compatible = "allwinner,sun50i-h616-operating-points",
+	  .data = &sun50i_h616_cpufreq_data,
+	},
 	{}
 };
 
@@ -230,6 +294,9 @@ static struct platform_driver sun50i_cpufreq_driver = {
 
 static const struct of_device_id sun50i_cpufreq_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6" },
+	{ .compatible = "allwinner,sun50i-h616" },
+	{ .compatible = "allwinner,sun50i-h618" },
+	{ .compatible = "allwinner,sun50i-h700" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);
-- 
2.25.1


