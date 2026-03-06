Return-Path: <linux-pm+bounces-43803-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DdAMKfEqmnVWwEAu9opvQ
	(envelope-from <linux-pm+bounces-43803-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:12:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD50220432
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 455C73105F33
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B1038E105;
	Fri,  6 Mar 2026 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZy7jeIZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5B38E139
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798809; cv=none; b=Cl6N5YN4WuJsy/VosnWWAiSBKkfGYj1GZ4YJMzT6KAcpDoadT/xExvb74sZDL0aqUECLKUEcyUWeAE0+HGJNJkIluUfPiDEirEIhUBIi4B79nHyoL56gfTb5rkyqoDVMfZxpPaNAOG9a+HiYnptTL9u342tRrt5OBAqpsdErJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798809; c=relaxed/simple;
	bh=hVw+is3IrgsvbxMYzWZIAJKkK2WgCGylKMpIkgp+nos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWYr7kO3CJODTSAUu60un3CBz4QTnp/O4nf4Yio/Srdob+B+9B303zfeToJO3OivtJEB+g2bSafXrz8hDXO6ZnUpdv3aegsARZz9mQYc4kyRxLkqQ9tRXtpn/FZ7TV2T8jHdgc5WgyPfci++rAEcr4P4HkgydC8OpX215Sn4yc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZy7jeIZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so712013f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798806; x=1773403606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cwKQ1tTGDPuQ+9frTFQwLU1eS025ZHOkm2TYa1mnyw=;
        b=OZy7jeIZEEGrkcaANFadAk6VRGUnVjnl/pcVmzK/1aEe8/GfZwUbAyTHNgePCAdXrl
         TtVFzyGPDZGnWSmRTIRjUnL4Za4vsV9jzkOqrTiEAVOe1BwYq69D8M8TlPDUbhBjjKcM
         u8xTSiWmTjGg/VXY4hgA1BUdyqC+lijr/JssnuUY1glTwDw1zKTAdKjRdi5ai4EaD+xk
         UBPj/42lCg8xSsmkyxWB2K0jotahG/1cmidcviBH9ok3TDy5unuJWTpP91a87Y/4vdqP
         GwFg/YT/nZnM4qDxCth8ZFzYV33FGTyUCZJOpz3BvfEJfq3Szf24ltza/Efibr9Ir73Q
         dsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798806; x=1773403606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cwKQ1tTGDPuQ+9frTFQwLU1eS025ZHOkm2TYa1mnyw=;
        b=GxylEjL+LzXGoyH2YEYSVxRFVQBu8Ow4/KesXZV1/4JLZDB/we8IAodfYeRYtQV3IA
         2Qk4Lh9/jo5iEI3gFoBsq62lY7IBBV6XWDHbbqdwEmNLMhR0cWo8hYYKWD2fsaWGNTBA
         GoH2FateFGpx4VFlfQBf+mYZNCfiVPSG/8UMk7k+HAr+QuHiqlh7SduBLDnAql4X4Vr9
         RQ9iP4DPcWrYDJERMIu7YC0D6uUmWKIyAGnhBys7ML89NQrlZgyDTp4IXJFkIPVckcJi
         HTRaVJV/ULAQp+oTdCNOklvlknO/lcrry67mHdFqf6U8kHJ/AReJ7VAb2GImJCrozBei
         3XoA==
X-Forwarded-Encrypted: i=1; AJvYcCXC2RawQYn1OybB5bW8sTaRubsSk/X9es6kLgsHDpUXdQougrtRCDP27wRj8DJDDKnJuhLqIeAIBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSV3EP/HQAO5LE86lovV8Dl9iiXrGTMA94MC/v7ERKz+u9oN5
	hGZT6iO46WdI8jLi6bUa7UgEK16tOmXSbkJG3YuQqwaeXjIJwAExQK1X
X-Gm-Gg: ATEYQzzsHvSZjFrYTg/A8VLiHwGw4Wuco5BdYPsv2n6MvUeqZFa7o5v6pMJCr/1W5tz
	Grnm8+vN0CxxjLuPHpU9cINsOyFyKLLUje2a1p3Zj7ermucp8i0LbNl3op44komZHXDanrOxHwV
	IEmgeJU5qY+7w3x3cWVcHK+J0r3F5DpEq+xupRTJYHcGCrM0Z06TqYr7cTZIpYP/r8IV2XiFlTg
	AsphFeWnZenB70P8cPI9KL+VgSZMa5hOgaxJXEtGJyE98jAVVU+cuHj9tkXWembji1L/H2o7JrX
	EUSA3DzMqMKs0NM6bM98s26yIeZqZYLGOIK2slsd+mrQL1v/+N4J0Q+2i04wFd9CvwkABC7XAwN
	KdTuZ/P/thC3p6HURGy/NRd5v9wKawIvcdCPWJ22RMAxAnnWc+1ndcmjwc9/9icBRMN3ir7EFjY
	aiUYmsGz1WKZVezgBasjM=
X-Received: by 2002:a5d:5f82:0:b0:439:b5f9:eeba with SMTP id ffacd0b85a97d-439da354a2emr3260501f8f.3.1772798805681;
        Fri, 06 Mar 2026 04:06:45 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:06:45 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/7] regulator: mt6392: Add support for MT6392 regulator
Date: Fri,  6 Mar 2026 12:03:09 +0000
Message-ID: <20260306120521.163654-6-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120521.163654-1-l.scorcia@gmail.com>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2BD50220432
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43803-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,packett.cool,kernel.org,mediatek.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lscorcia@gmail.com,linux-pm@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:email,mediatek.com:email,packett.cool:email,config.dev:url]
X-Rspamd-Action: no action

From: Fabien Parent <parent.f@gmail.com>

The MT6392 is a regulator found on boards based on the MediaTek
MT8167, MT8516, and probably other SoCs. It is a so called PMIC and
connects as a slave to a SoC using SPI, wrapped inside PWRAP.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Co-developed-by: Val Packett <val@packett.cool>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/regulator/Kconfig                  |   9 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/mt6392-regulator.c       | 491 +++++++++++++++++++++
 include/linux/regulator/mt6392-regulator.h |  40 ++
 4 files changed, 541 insertions(+)
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/linux/regulator/mt6392-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d2335276cce5..66876d730807 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -991,6 +991,15 @@ config REGULATOR_MT6380
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
+config REGULATOR_MT6392
+	tristate "MediaTek MT6392 PMIC"
+	depends on MFD_MT6397
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6392 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6397
 	tristate "MediaTek MT6397 PMIC"
 	depends on MFD_MT6397
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 1beba1493241..db5145cfcf36 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
 obj-$(CONFIG_REGULATOR_MT6363) += mt6363-regulator.o
 obj-$(CONFIG_REGULATOR_MT6370) += mt6370-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
+obj-$(CONFIG_REGULATOR_MT6392)	+= mt6392-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_LABIBB) += qcom-labibb-regulator.o
diff --git a/drivers/regulator/mt6392-regulator.c b/drivers/regulator/mt6392-regulator.c
new file mode 100644
index 000000000000..1c0e9bccfe86
--- /dev/null
+++ b/drivers/regulator/mt6392-regulator.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2020 MediaTek Inc.
+// Copyright (c) 2020 BayLibre, SAS.
+// Author: Chen Zhong <chen.zhong@mediatek.com>
+// Author: Fabien Parent <fparent@baylibre.com>
+//
+// Based on mt6397-regulator.c
+
+#include <linux/module.h>
+#include <linux/linear_range.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6392/registers.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6392-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MT6392_BUCK_MODE_AUTO	0
+#define MT6392_BUCK_MODE_FORCE_PWM	1
+#define MT6392_LDO_MODE_NORMAL	0
+#define MT6392_LDO_MODE_LP	1
+
+/*
+ * MT6392 regulators' information
+ *
+ * @desc: standard fields of regulator description.
+ * @qi: Mask for query enable signal status of regulators
+ * @vselon_reg: Register sections for hardware control mode of bucks
+ * @vselctrl_reg: Register for controlling the buck control mode.
+ * @vselctrl_mask: Mask for query buck's voltage control mode.
+ */
+struct mt6392_regulator_info {
+	struct regulator_desc desc;
+	u32 qi;
+	u32 vselon_reg;
+	u32 vselctrl_reg;
+	u32 vselctrl_mask;
+	u32 modeset_reg;
+	u32 modeset_mask;
+};
+
+#define MT6392_BUCK(match, vreg, min, max, step, volt_ranges, enreg,	\
+		vosel, vosel_mask, voselon, vosel_ctrl,			\
+		_modeset_reg, _modeset_mask, rampdelay)		\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_range_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min)/step + 1,			\
+		.linear_ranges = volt_ranges,				\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),		\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(0),					\
+		.ramp_delay = rampdelay,				\
+	},								\
+	.qi = BIT(13),							\
+	.vselon_reg = voselon,						\
+	.vselctrl_reg = vosel_ctrl,					\
+	.vselctrl_mask = BIT(1),					\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+#define MT6392_LDO(match, vreg, ldo_volt_table, enreg, enbit, vosel,	\
+		vosel_mask, _modeset_reg, _modeset_mask, entime)	\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_table_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
+		.volt_table = ldo_volt_table,				\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.enable_time = entime,					\
+	},								\
+	.qi = BIT(15),							\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+#define MT6392_LDO_LINEAR(match, vreg, min, max, step, volt_ranges,	\
+		enreg, enbit, vosel, vosel_mask, _modeset_reg,		\
+		_modeset_mask, entime)					\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_ldo_range_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min)/step + 1,			\
+		.linear_ranges = volt_ranges,				\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),		\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.enable_time = entime,					\
+	},								\
+	.qi = BIT(15),							\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+#define MT6392_REG_FIXED(match, vreg, enreg, enbit, volt,		\
+		_modeset_reg, _modeset_mask, entime)			\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_fixed_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = 1,					\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.enable_time = entime,					\
+		.min_uV = volt,						\
+	},								\
+	.qi = BIT(15),							\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+#define MT6392_REG_FIXED_NO_MODE(match, vreg, enreg, enbit, volt,	\
+	entime)								\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_fixed_no_mode_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = 1,					\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.enable_time = entime,					\
+		.min_uV = volt,						\
+	},								\
+	.qi = BIT(15),							\
+}
+
+static const struct linear_range buck_volt_range1[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250),
+};
+
+static const struct linear_range buck_volt_range2[] = {
+	REGULATOR_LINEAR_RANGE(1400000, 0, 0x7f, 12500),
+};
+
+static const u32 ldo_volt_table1[] = {
+	1800000, 1900000, 2000000, 2200000,
+};
+
+static const struct linear_range ldo_volt_range2[] = {
+	REGULATOR_LINEAR_RANGE(3300000, 0, 3, 100000),
+};
+
+static const u32 ldo_volt_table3[] = {
+	1800000, 3300000,
+};
+
+static const u32 ldo_volt_table4[] = {
+	3000000, 3300000,
+};
+
+static const u32 ldo_volt_table5[] = {
+	1200000, 1300000, 1500000, 1800000, 2000000, 2800000, 3000000, 3300000,
+};
+
+static const u32 ldo_volt_table6[] = {
+	1240000, 1390000,
+};
+
+static const u32 ldo_volt_table7[] = {
+	1200000, 1300000, 1500000, 1800000,
+};
+
+static const u32 ldo_volt_table8[] = {
+	1800000, 2000000,
+};
+
+static int mt6392_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	int ret, val = 0;
+	struct mt6392_regulator_info *info = rdev_get_drvdata(rdev);
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		val = MT6392_BUCK_MODE_FORCE_PWM;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = MT6392_BUCK_MODE_AUTO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val <<= ffs(info->modeset_mask) - 1;
+
+	ret = regmap_update_bits(rdev->regmap, info->modeset_reg,
+				  info->modeset_mask, val);
+
+	return ret;
+}
+
+static unsigned int mt6392_buck_get_mode(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	unsigned int mode;
+	int ret;
+	struct mt6392_regulator_info *info = rdev_get_drvdata(rdev);
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= info->modeset_mask;
+	val >>= ffs(info->modeset_mask) - 1;
+
+	if (val & 0x1)
+		mode = REGULATOR_MODE_FAST;
+	else
+		mode = REGULATOR_MODE_NORMAL;
+
+	return mode;
+}
+
+static int mt6392_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	int ret, val = 0;
+	struct mt6392_regulator_info *info = rdev_get_drvdata(rdev);
+
+	switch (mode) {
+	case REGULATOR_MODE_STANDBY:
+		val = MT6392_LDO_MODE_LP;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = MT6392_LDO_MODE_NORMAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val <<= ffs(info->modeset_mask) - 1;
+
+	ret = regmap_update_bits(rdev->regmap, info->modeset_reg,
+				  info->modeset_mask, val);
+
+	return ret;
+}
+
+static unsigned int mt6392_ldo_get_mode(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	unsigned int mode;
+	int ret;
+	struct mt6392_regulator_info *info = rdev_get_drvdata(rdev);
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= info->modeset_mask;
+	val >>= ffs(info->modeset_mask) - 1;
+
+	if (val & 0x1)
+		mode = REGULATOR_MODE_STANDBY;
+	else
+		mode = REGULATOR_MODE_NORMAL;
+
+	return mode;
+}
+
+static const struct regulator_ops mt6392_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6392_buck_set_mode,
+	.get_mode = mt6392_buck_get_mode,
+};
+
+static const struct regulator_ops mt6392_volt_table_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6392_ldo_set_mode,
+	.get_mode = mt6392_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6392_volt_ldo_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6392_ldo_set_mode,
+	.get_mode = mt6392_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6392_volt_fixed_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6392_ldo_set_mode,
+	.get_mode = mt6392_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6392_volt_fixed_no_mode_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+/* The array is indexed by id(MT6392_ID_XXX) */
+static struct mt6392_regulator_info mt6392_regulators[] = {
+	MT6392_BUCK("buck_vproc", VPROC, 700000, 1493750, 6250,
+		buck_volt_range1, MT6392_VPROC_CON7, MT6392_VPROC_CON9, 0x7f,
+		MT6392_VPROC_CON10, MT6392_VPROC_CON5, MT6392_VPROC_CON2,
+		0x100, 12500),
+	MT6392_BUCK("buck_vsys", VSYS, 1400000, 2987500, 12500,
+		buck_volt_range2, MT6392_VSYS_CON7, MT6392_VSYS_CON9, 0x7f,
+		MT6392_VSYS_CON10, MT6392_VSYS_CON5, MT6392_VSYS_CON2, 0x100,
+		25000),
+	MT6392_BUCK("buck_vcore", VCORE, 700000, 1493750, 6250,
+		buck_volt_range1, MT6392_VCORE_CON7, MT6392_VCORE_CON9, 0x7f,
+		MT6392_VCORE_CON10, MT6392_VCORE_CON5, MT6392_VCORE_CON2,
+		0x100, 12500),
+	MT6392_REG_FIXED("ldo_vxo22", VXO22, MT6392_ANALDO_CON1, 10, 2200000,
+		MT6392_ANALDO_CON1, 0x2, 110),
+	MT6392_LDO("ldo_vaud22", VAUD22, ldo_volt_table1,
+		MT6392_ANALDO_CON2, 14, MT6392_ANALDO_CON8, 0x60,
+		MT6392_ANALDO_CON2, 0x2, 264),
+	MT6392_REG_FIXED_NO_MODE("ldo_vcama", VCAMA, MT6392_ANALDO_CON4, 15,
+		2800000, 264),
+	MT6392_REG_FIXED("ldo_vaud28", VAUD28, MT6392_ANALDO_CON23, 14, 2800000,
+		MT6392_ANALDO_CON23, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vadc18", VADC18, MT6392_ANALDO_CON25, 14, 1800000,
+		MT6392_ANALDO_CON25, 0x2, 264),
+	MT6392_LDO_LINEAR("ldo_vcn35", VCN35, 3300000, 3600000, 100000,
+		ldo_volt_range2, MT6392_ANALDO_CON21, 12, MT6392_ANALDO_CON16,
+		0xC, MT6392_ANALDO_CON21, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vio28", VIO28, MT6392_DIGLDO_CON0, 14, 2800000,
+		MT6392_DIGLDO_CON0, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vusb", VUSB, MT6392_DIGLDO_CON2, 14, 3300000,
+		MT6392_DIGLDO_CON2, 0x2, 264),
+	MT6392_LDO("ldo_vmc", VMC, ldo_volt_table3,
+		MT6392_DIGLDO_CON3, 12, MT6392_DIGLDO_CON24, 0x10,
+		MT6392_DIGLDO_CON3, 0x2, 264),
+	MT6392_LDO("ldo_vmch", VMCH, ldo_volt_table4,
+		MT6392_DIGLDO_CON5, 14, MT6392_DIGLDO_CON26, 0x80,
+		MT6392_DIGLDO_CON5, 0x2, 264),
+	MT6392_LDO("ldo_vemc3v3", VEMC3V3, ldo_volt_table4,
+		MT6392_DIGLDO_CON6, 14, MT6392_DIGLDO_CON27, 0x80,
+		MT6392_DIGLDO_CON6, 0x2, 264),
+	MT6392_LDO("ldo_vgp1", VGP1, ldo_volt_table5,
+		MT6392_DIGLDO_CON7, 15, MT6392_DIGLDO_CON28, 0xE0,
+		MT6392_DIGLDO_CON7, 0x2, 264),
+	MT6392_LDO("ldo_vgp2", VGP2, ldo_volt_table5,
+		MT6392_DIGLDO_CON8, 15, MT6392_DIGLDO_CON29, 0xE0,
+		MT6392_DIGLDO_CON8, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vcn18", VCN18, MT6392_DIGLDO_CON11, 14, 1800000,
+		MT6392_DIGLDO_CON11, 0x2, 264),
+	MT6392_LDO("ldo_vcamaf", VCAMAF, ldo_volt_table5,
+		MT6392_DIGLDO_CON31, 15, MT6392_DIGLDO_CON32, 0xE0,
+		MT6392_DIGLDO_CON31, 0x2, 264),
+	MT6392_LDO("ldo_vm", VM, ldo_volt_table6,
+		MT6392_DIGLDO_CON47, 14, MT6392_DIGLDO_CON48, 0x30,
+		MT6392_DIGLDO_CON47, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vio18", VIO18, MT6392_DIGLDO_CON49, 14, 1800000,
+		MT6392_DIGLDO_CON49, 0x2, 264),
+	MT6392_LDO("ldo_vcamd", VCAMD, ldo_volt_table7,
+		MT6392_DIGLDO_CON51, 14, MT6392_DIGLDO_CON52, 0x60,
+		MT6392_DIGLDO_CON51, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vcamio", VCAMIO, MT6392_DIGLDO_CON53, 14, 1800000,
+		MT6392_DIGLDO_CON53, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vm25", VM25, MT6392_DIGLDO_CON55, 14, 2500000,
+		MT6392_DIGLDO_CON55, 0x2, 264),
+	MT6392_LDO("ldo_vefuse", VEFUSE, ldo_volt_table8,
+		MT6392_DIGLDO_CON57, 14, MT6392_DIGLDO_CON58, 0x10,
+		MT6392_DIGLDO_CON57, 0x2, 264),
+};
+
+static int mt6392_set_buck_vosel_reg(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6392 = dev_get_drvdata(pdev->dev.parent);
+	int i;
+	u32 regval;
+
+	for (i = 0; i < MT6392_MAX_REGULATOR; i++) {
+		if (mt6392_regulators[i].vselctrl_reg) {
+			if (regmap_read(mt6392->regmap,
+				mt6392_regulators[i].vselctrl_reg,
+				&regval) < 0) {
+				dev_err(&pdev->dev,
+					"Failed to read buck ctrl\n");
+				return -EIO;
+			}
+
+			if (regval & mt6392_regulators[i].vselctrl_mask) {
+				mt6392_regulators[i].desc.vsel_reg =
+				mt6392_regulators[i].vselon_reg;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int mt6392_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6392 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	int i;
+
+	/* Query buck controller to select activated voltage register part */
+	if (mt6392_set_buck_vosel_reg(pdev))
+		return -EIO;
+
+	for (i = 0; i < MT6392_MAX_REGULATOR; i++) {
+		config.dev = &pdev->dev;
+		config.driver_data = &mt6392_regulators[i];
+		config.regmap = mt6392->regmap;
+
+		rdev = devm_regulator_register(&pdev->dev,
+					       &mt6392_regulators[i].desc,
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register %s\n",
+				mt6392_regulators[i].desc.name);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id mt6392_platform_ids[] = {
+	{"mt6392-regulator", 0},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6392_platform_ids);
+
+static struct platform_driver mt6392_regulator_driver = {
+	.driver = {
+		.name = "mt6392-regulator",
+	},
+	.probe = mt6392_regulator_probe,
+	.id_table = mt6392_platform_ids,
+};
+
+module_platform_driver(mt6392_regulator_driver);
+
+MODULE_AUTHOR("Chen Zhong <chen.zhong@mediatek.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6392 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/mt6392-regulator.h b/include/linux/regulator/mt6392-regulator.h
new file mode 100644
index 000000000000..dfcbcacb5ad4
--- /dev/null
+++ b/include/linux/regulator/mt6392-regulator.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Chen Zhong <chen.zhong@mediatek.com>
+ */
+
+#ifndef __LINUX_REGULATOR_MT6392_H
+#define __LINUX_REGULATOR_MT6392_H
+
+enum {
+	MT6392_ID_VPROC = 0,
+	MT6392_ID_VSYS,
+	MT6392_ID_VCORE,
+	MT6392_ID_VXO22,
+	MT6392_ID_VAUD22,
+	MT6392_ID_VCAMA,
+	MT6392_ID_VAUD28,
+	MT6392_ID_VADC18,
+	MT6392_ID_VCN35,
+	MT6392_ID_VIO28,
+	MT6392_ID_VUSB = 10,
+	MT6392_ID_VMC,
+	MT6392_ID_VMCH,
+	MT6392_ID_VEMC3V3,
+	MT6392_ID_VGP1,
+	MT6392_ID_VGP2,
+	MT6392_ID_VCN18,
+	MT6392_ID_VCAMAF,
+	MT6392_ID_VM,
+	MT6392_ID_VIO18,
+	MT6392_ID_VCAMD,
+	MT6392_ID_VCAMIO,
+	MT6392_ID_VM25,
+	MT6392_ID_VEFUSE,
+	MT6392_ID_RG_MAX,
+};
+
+#define MT6392_MAX_REGULATOR	MT6392_ID_RG_MAX
+
+#endif /* __LINUX_REGULATOR_MT6392_H */
-- 
2.43.0


