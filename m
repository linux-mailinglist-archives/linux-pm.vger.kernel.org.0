Return-Path: <linux-pm+bounces-41203-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJksITclcGmuWwAAu9opvQ
	(envelope-from <linux-pm+bounces-41203-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:00:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B744ECCA
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87A86669066
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DCC2EDD63;
	Wed, 21 Jan 2026 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdXM2acl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A82E6CDE;
	Wed, 21 Jan 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957214; cv=none; b=PMZtC/bXgJfu7vzPQi0ivLtN5Dr4sw0NwvTE0ptXCCjhhv2uKfJYhZi3LQgKXwqSCPpySbhcD+XCNidkY+Zp/4YEjOvbvfFh442ozVINU4wYwnhrSm5fUAODT2QVqDg7u++9PLaWq8BQUTUivVHr25KocSojPzBmkjHP5NLXfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957214; c=relaxed/simple;
	bh=AS+F9ndhvkvc0CKB7Y9PBoehgBOVsID9ExovknmqsOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XazuSIJnHPxCoCqYuXAJqr8+IG9qX4kd8yc1dRWaHqCukIGAhssQfASxvvO2RdPVo1ADdruND/1dcUOSegUGUlW2QiR0dz7m2Mjc46nRQU8yRGKu0jyil00lscByrmEl5MlL7Hty7wgJGR4e2slHh9ThotioFeS1jIwNX5wGGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdXM2acl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E972C2BCAF;
	Wed, 21 Jan 2026 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957214;
	bh=AS+F9ndhvkvc0CKB7Y9PBoehgBOVsID9ExovknmqsOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gdXM2aclb1vmNNH7vvUg/450LU+nA6KU9wo76K6GYSmnqhxgB69rebgY7yeXnmOHQ
	 MVW3StTzb8wBVmFktXi6ke9iwfFlWNeqDG43sxrCPxKS7hJx9auCiW+fJxXu+tvBt+
	 1clQB9atviJbxOGMhm+XU6+/7dIv85ezXK8/rYHEX/QubbpJr+sOu27uHf+Ru9jMKd
	 TiDRspA37m89DL8HQFQ2tWFmRvdquO3HkRep+izSYktRh01GCgk3xAEmwP7mbV8Rw5
	 4ya4VR6PIPjAi50YQmng6a0prbkPn+QcJJhjouUkHQ/VDxKXhXOqXCchwsOeJoCMRR
	 IVAV3Rf6V85Lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44625D262B4;
	Wed, 21 Jan 2026 01:00:14 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 21 Jan 2026 00:59:37 +0000
Subject: [PATCH v4 3/5] mfd: max77759: add register bitmasks and modify irq
 configs for charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260121-max77759-charger-v4-3-694234c8ded1@google.com>
References: <20260121-max77759-charger-v4-0-694234c8ded1@google.com>
In-Reply-To: <20260121-max77759-charger-v4-0-694234c8ded1@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768957213; l=16624;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=utQmiZTms1uQNn2iP7hjcj2YDyPYXuFj5Ps3nEvTmV4=;
 b=qm1slPracvWpzsFfGeVO/YFZrOwYyK8/nnVf++EBqEmC+8AMPIVDDa1YVVIHnO4nnt24ZH25v
 hE9M8QH/WQGDZdQ8Zwe5cQfypGJSCt62sOu3WqDfXvqaU+yBhJAQ+kD
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41203-lists,linux-pm=lfdr.de,amitsd.google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[amitsd@google.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linaro.org:email]
X-Rspamd-Queue-Id: 67B744ECCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Sunil Dhamne <amitsd@google.com>

Add register bitmasks for charger function.
In addition split the charger IRQs further such that each bit represents
an IRQ downstream of charger regmap irq chip. In addition populate the
ack_base to offload irq ack to the regmap irq chip framework.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/max77759.c       |  91 +++++++++++++++++--
 include/linux/mfd/max77759.h | 202 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 256 insertions(+), 37 deletions(-)

diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
index 6cf6306c4a3b25655ff08077b6f94316ab8cae04..a5f7da003edd43f1917da428025dd10fee9211ce 100644
--- a/drivers/mfd/max77759.c
+++ b/drivers/mfd/max77759.c
@@ -201,8 +201,24 @@ static const struct regmap_config max77759_regmap_config_charger = {
  *         - SYSUVLO_INT
  *         - FSHIP_NOT_RD
  *     - CHGR_INT: charger
- *       - CHG_INT
- *       - CHG_INT2
+ *       - INT1
+ *         - AICL
+ *         - CHGIN
+ *         - WCIN
+ *         - CHG
+ *         - BAT
+ *         - INLIM
+ *         - THM2
+ *         - BYP
+ *       - INT2
+ *         - INSEL
+ *         - SYS_UVLO1
+ *         - SYS_UVLO2
+ *         - BAT_OILO
+ *         - CHG_STA_CC
+ *         - CHG_STA_CV
+ *         - CHG_STA_TO
+ *         - CHG_STA_DONE
  */
 enum {
 	MAX77759_INT_MAXQ,
@@ -228,8 +244,22 @@ enum {
 };
 
 enum {
-	MAX77759_CHARGER_INT_1,
-	MAX77759_CHARGER_INT_2,
+	MAX77759_CHGR_INT1_AICL,
+	MAX77759_CHGR_INT1_CHGIN,
+	MAX77759_CHGR_INT1_WCIN,
+	MAX77759_CHGR_INT1_CHG,
+	MAX77759_CHGR_INT1_BAT,
+	MAX77759_CHGR_INT1_INLIM,
+	MAX77759_CHGR_INT1_THM2,
+	MAX77759_CHGR_INT1_BYP,
+	MAX77759_CHGR_INT2_INSEL,
+	MAX77759_CHGR_INT2_SYS_UVLO1,
+	MAX77759_CHGR_INT2_SYS_UVLO2,
+	MAX77759_CHGR_INT2_BAT_OILO,
+	MAX77759_CHGR_INT2_CHG_STA_CC,
+	MAX77759_CHGR_INT2_CHG_STA_CV,
+	MAX77759_CHGR_INT2_CHG_STA_TO,
+	MAX77759_CHGR_INT2_CHG_STA_DONE,
 };
 
 static const struct regmap_irq max77759_pmic_irqs[] = {
@@ -256,8 +286,38 @@ static const struct regmap_irq max77759_topsys_irqs[] = {
 };
 
 static const struct regmap_irq max77759_chgr_irqs[] = {
-	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0, GENMASK(7, 0)),
-	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1, GENMASK(7, 0)),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_AICL, 0,
+		       MAX77759_CHGR_REG_CHG_INT_AICL),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_CHGIN, 0,
+		       MAX77759_CHGR_REG_CHG_INT_CHGIN),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_WCIN, 0,
+		       MAX77759_CHGR_REG_CHG_INT_WCIN),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_CHG, 0,
+		       MAX77759_CHGR_REG_CHG_INT_CHG),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_BAT, 0,
+		       MAX77759_CHGR_REG_CHG_INT_BAT),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_INLIM, 0,
+		       MAX77759_CHGR_REG_CHG_INT_INLIM),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_THM2, 0,
+		       MAX77759_CHGR_REG_CHG_INT_THM2),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_BYP, 0,
+		       MAX77759_CHGR_REG_CHG_INT_BYP),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_INSEL, 1,
+		       MAX77759_CHGR_REG_CHG_INT2_INSEL),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_SYS_UVLO1, 1,
+		       MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO1),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_SYS_UVLO2, 1,
+		       MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO2),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_BAT_OILO, 1,
+		       MAX77759_CHGR_REG_CHG_INT2_BAT_OILO),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_CC, 1,
+		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_CV, 1,
+		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_TO, 1,
+		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO),
+	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_DONE, 1,
+		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE),
 };
 
 static const struct regmap_irq_chip max77759_pmic_irq_chip = {
@@ -302,6 +362,7 @@ static const struct regmap_irq_chip max77759_chrg_irq_chip = {
 	.domain_suffix = "CHGR",
 	.status_base = MAX77759_CHGR_REG_CHG_INT,
 	.mask_base = MAX77759_CHGR_REG_CHG_INT_MASK,
+	.ack_base = MAX77759_CHGR_REG_CHG_INT,
 	.num_regs = 2,
 	.irqs = max77759_chgr_irqs,
 	.num_irqs = ARRAY_SIZE(max77759_chgr_irqs),
@@ -325,8 +386,22 @@ static const struct resource max77759_gpio_resources[] = {
 };
 
 static const struct resource max77759_charger_resources[] = {
-	DEFINE_RES_IRQ_NAMED(MAX77759_CHARGER_INT_1, "INT1"),
-	DEFINE_RES_IRQ_NAMED(MAX77759_CHARGER_INT_2, "INT2"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_AICL,         "AICL"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_CHGIN,        "CHGIN"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_WCIN,         "WCIN"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_CHG,          "CHG"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_BAT,          "BAT"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_INLIM,        "INLIM"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_THM2,         "THM2"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_BYP,          "BYP"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_INSEL,        "INSEL"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_SYS_UVLO1,    "SYS_UVLO1"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_SYS_UVLO2,    "SYS_UVLO2"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_BAT_OILO,     "BAT_OILO"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_CC,   "CHG_STA_CC"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_CV,   "CHG_STA_CV"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_TO,   "CHG_STA_TO"),
+	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_DONE, "CHG_STA_DONE"),
 };
 
 static const struct mfd_cell max77759_cells[] = {
diff --git a/include/linux/mfd/max77759.h b/include/linux/mfd/max77759.h
index c6face34e38555cbc09db4131925b6ed781af511..c0ade494eb8275bb217f15eb98814eab52805293 100644
--- a/include/linux/mfd/max77759.h
+++ b/include/linux/mfd/max77759.h
@@ -59,35 +59,65 @@
 #define MAX77759_MAXQ_REG_AP_DATAIN0            0xb1
 #define MAX77759_MAXQ_REG_UIC_SWRST             0xe0
 
-#define MAX77759_CHGR_REG_CHG_INT               0xb0
-#define MAX77759_CHGR_REG_CHG_INT2              0xb1
-#define MAX77759_CHGR_REG_CHG_INT_MASK          0xb2
-#define MAX77759_CHGR_REG_CHG_INT2_MASK         0xb3
-#define MAX77759_CHGR_REG_CHG_INT_OK            0xb4
-#define MAX77759_CHGR_REG_CHG_DETAILS_00        0xb5
-#define MAX77759_CHGR_REG_CHG_DETAILS_01        0xb6
-#define MAX77759_CHGR_REG_CHG_DETAILS_02        0xb7
-#define MAX77759_CHGR_REG_CHG_DETAILS_03        0xb8
-#define MAX77759_CHGR_REG_CHG_CNFG_00           0xb9
-#define MAX77759_CHGR_REG_CHG_CNFG_01           0xba
-#define MAX77759_CHGR_REG_CHG_CNFG_02           0xbb
-#define MAX77759_CHGR_REG_CHG_CNFG_03           0xbc
-#define MAX77759_CHGR_REG_CHG_CNFG_04           0xbd
-#define MAX77759_CHGR_REG_CHG_CNFG_05           0xbe
-#define MAX77759_CHGR_REG_CHG_CNFG_06           0xbf
-#define MAX77759_CHGR_REG_CHG_CNFG_07           0xc0
-#define MAX77759_CHGR_REG_CHG_CNFG_08           0xc1
-#define MAX77759_CHGR_REG_CHG_CNFG_09           0xc2
-#define MAX77759_CHGR_REG_CHG_CNFG_10           0xc3
-#define MAX77759_CHGR_REG_CHG_CNFG_11           0xc4
-#define MAX77759_CHGR_REG_CHG_CNFG_12           0xc5
-#define MAX77759_CHGR_REG_CHG_CNFG_13           0xc6
-#define MAX77759_CHGR_REG_CHG_CNFG_14           0xc7
-#define MAX77759_CHGR_REG_CHG_CNFG_15           0xc8
-#define MAX77759_CHGR_REG_CHG_CNFG_16           0xc9
-#define MAX77759_CHGR_REG_CHG_CNFG_17           0xca
-#define MAX77759_CHGR_REG_CHG_CNFG_18           0xcb
-#define MAX77759_CHGR_REG_CHG_CNFG_19           0xcc
+#define MAX77759_CHGR_REG_CHG_INT                      0xb0
+#define   MAX77759_CHGR_REG_CHG_INT_AICL               BIT(7)
+#define   MAX77759_CHGR_REG_CHG_INT_CHGIN              BIT(6)
+#define   MAX77759_CHGR_REG_CHG_INT_WCIN               BIT(5)
+#define   MAX77759_CHGR_REG_CHG_INT_CHG                BIT(4)
+#define   MAX77759_CHGR_REG_CHG_INT_BAT                BIT(3)
+#define   MAX77759_CHGR_REG_CHG_INT_INLIM              BIT(2)
+#define   MAX77759_CHGR_REG_CHG_INT_THM2               BIT(1)
+#define   MAX77759_CHGR_REG_CHG_INT_BYP                BIT(0)
+#define MAX77759_CHGR_REG_CHG_INT2                     0xb1
+#define   MAX77759_CHGR_REG_CHG_INT2_INSEL             BIT(7)
+#define   MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO1         BIT(6)
+#define   MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO2         BIT(5)
+#define   MAX77759_CHGR_REG_CHG_INT2_BAT_OILO          BIT(4)
+#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC        BIT(3)
+#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV        BIT(2)
+#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO        BIT(1)
+#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE      BIT(0)
+#define MAX77759_CHGR_REG_CHG_INT_MASK                 0xb2
+#define MAX77759_CHGR_REG_CHG_INT2_MASK                0xb3
+#define MAX77759_CHGR_REG_CHG_INT_OK                   0xb4
+#define MAX77759_CHGR_REG_CHG_DETAILS_00               0xb5
+#define   MAX77759_CHGR_REG_CHG_DETAILS_OO_CHGIN_DTLS  GENMASK(6, 5)
+#define MAX77759_CHGR_REG_CHG_DETAILS_01               0xb6
+#define   MAX77759_CHGR_REG_CHG_DETAILS_01_BAT_DTLS    GENMASK(6, 4)
+#define   MAX77759_CHGR_REG_CHG_DETAILS_01_CHG_DTLS    GENMASK(3, 0)
+#define MAX77759_CHGR_REG_CHG_DETAILS_02               0xb7
+#define   MAX77759_CHGR_REG_CHG_DETAILS_02_CHGIN_STS   BIT(5)
+#define MAX77759_CHGR_REG_CHG_DETAILS_03               0xb8
+#define MAX77759_CHGR_REG_CHG_CNFG_00                  0xb9
+#define   MAX77759_CHGR_REG_CHG_CNFG_00_MODE           GENMASK(3, 0)
+#define MAX77759_CHGR_REG_CHG_CNFG_01                  0xba
+#define MAX77759_CHGR_REG_CHG_CNFG_02                  0xbb
+#define   MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC          GENMASK(5, 0)
+#define MAX77759_CHGR_REG_CHG_CNFG_03                  0xbc
+#define MAX77759_CHGR_REG_CHG_CNFG_04                  0xbd
+#define   MAX77759_CHGR_REG_CHG_CNFG_04_CHG_CV_PRM     GENMASK(5, 0)
+#define MAX77759_CHGR_REG_CHG_CNFG_05                  0xbe
+#define MAX77759_CHGR_REG_CHG_CNFG_06                  0xbf
+#define   MAX77759_CHGR_REG_CHG_CNFG_06_CHGPROT        GENMASK(3, 2)
+#define MAX77759_CHGR_REG_CHG_CNFG_07                  0xc0
+#define MAX77759_CHGR_REG_CHG_CNFG_08                  0xc1
+#define MAX77759_CHGR_REG_CHG_CNFG_09                  0xc2
+#define   MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM     GENMASK(6, 0)
+#define MAX77759_CHGR_REG_CHG_CNFG_10                  0xc3
+#define MAX77759_CHGR_REG_CHG_CNFG_11                  0xc4
+#define MAX77759_CHGR_REG_CHG_CNFG_12                  0xc5
+/* Wireless Charging input channel select */
+#define   MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL        BIT(6)
+/* CHGIN/USB input channel select */
+#define   MAX77759_CHGR_REG_CHG_CNFG_12_CHGINSEL       BIT(5)
+#define MAX77759_CHGR_REG_CHG_CNFG_13                  0xc6
+#define MAX77759_CHGR_REG_CHG_CNFG_14                  0xc7
+#define MAX77759_CHGR_REG_CHG_CNFG_15                  0xc8
+#define MAX77759_CHGR_REG_CHG_CNFG_16                  0xc9
+#define MAX77759_CHGR_REG_CHG_CNFG_17                  0xca
+#define MAX77759_CHGR_REG_CHG_CNFG_18                  0xcb
+#define   MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN          BIT(0)
+#define MAX77759_CHGR_REG_CHG_CNFG_19                  0xcc
 
 /* MaxQ opcodes for max77759_maxq_command() */
 #define MAX77759_MAXQ_OPCODE_MAXLENGTH (MAX77759_MAXQ_REG_AP_DATAOUT32 - \
@@ -101,6 +131,120 @@
 #define MAX77759_MAXQ_OPCODE_USER_SPACE_READ     0x81
 #define MAX77759_MAXQ_OPCODE_USER_SPACE_WRITE    0x82
 
+/*
+ * Charger Input Status
+ * @MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE:
+ *     Charger input voltage (Vchgin) < Under Voltage Threshold (Vuvlo)
+ * @MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE: Vchgin > Vuvlo and
+ *     Vchgin < (Battery Voltage (Vbatt) + system voltage (Vsys))
+ * @MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE:
+ *     Vchgin > Over Voltage threshold (Vovlo)
+ * @MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID:
+ *     Vchgin > Vuvlo, Vchgin < Vovlo and Vchgin > (Vsys + Vbatt)
+ */
+enum max77759_chgr_chgin_dtls_status {
+	MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE,
+	MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE,
+	MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE,
+	MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID,
+};
+
+/*
+ * Battery Details
+ * @MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP:
+ *     No battery and the charger suspended
+ * @MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY: Vbatt < Vtrickle
+ * @MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT:
+ *     Charging suspended due to timer fault
+ * @MAX77759_CHGR_BAT_DTLS_BAT_OKAY:
+ *     Battery okay and Vbatt > Min Sys Voltage (Vsysmin)
+ * @MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE:
+ *     Battery is okay. Vtrickle < Vbatt < Vsysmin
+ * @MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE:
+ *     Battery voltage > Overvoltage threshold
+ * @MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT:
+ *     Battery current exceeds overcurrent threshold
+ * @MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE:
+ *     Battery only mode and battery level not available
+ */
+enum max77759_chgr_bat_dtls_states {
+	MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP,
+	MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY,
+	MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT,
+	MAX77759_CHGR_BAT_DTLS_BAT_OKAY,
+	MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE,
+	MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE,
+	MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT,
+	MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE,
+};
+
+/*
+ * Charger Details
+ * @MAX77759_CHGR_CHG_DTLS_PREQUAL: Charger in prequalification mode
+ * @MAX77759_CHGR_CHG_DTLS_CC:      Charger in fast charge const curr mode
+ * @MAX77759_CHGR_CHG_DTLS_CV:      Charger in fast charge const voltage mode
+ * @MAX77759_CHGR_CHG_DTLS_TO:      Charger is in top off mode
+ * @MAX77759_CHGR_CHG_DTLS_DONE:    Charger is done
+ * @MAX77759_CHGR_CHG_DTLS_RSVD_1:  Reserved
+ * @MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:   Charger is in timer fault mode
+ * @MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:
+ *     Charger is suspended as bettery removal detected
+ * @MAX77759_CHGR_CHG_DTLS_OFF:
+ *     Charger is off. Input invalid or charger disabled
+ * @MAX77759_CHGR_CHG_DTLS_RSVD_2:  Reserved
+ * @MAX77759_CHGR_CHG_DTLS_RSVD_3:  Reserved
+ * @MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:
+ *     Charger is off as watchdog timer expired
+ * @MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:    Charger is in JEITA control mode
+ */
+enum max77759_chgr_chg_dtls_states {
+	MAX77759_CHGR_CHG_DTLS_PREQUAL,
+	MAX77759_CHGR_CHG_DTLS_CC,
+	MAX77759_CHGR_CHG_DTLS_CV,
+	MAX77759_CHGR_CHG_DTLS_TO,
+	MAX77759_CHGR_CHG_DTLS_DONE,
+	MAX77759_CHGR_CHG_DTLS_RSVD_1,
+	MAX77759_CHGR_CHG_DTLS_TIMER_FAULT,
+	MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM,
+	MAX77759_CHGR_CHG_DTLS_OFF,
+	MAX77759_CHGR_CHG_DTLS_RSVD_2,
+	MAX77759_CHGR_CHG_DTLS_RSVD_3,
+	MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER,
+	MAX77759_CHGR_CHG_DTLS_SUSP_JEITA,
+};
+
+enum max77759_chgr_mode {
+	MAX77759_CHGR_MODE_OFF,
+	MAX77759_CHGR_MODE_CHG_BUCK_ON = 0x5,
+	MAX77759_CHGR_MODE_OTG_BOOST_ON = 0xA,
+};
+
+/* Fast charge current limits */
+#define MAX77759_CHGR_CHGCC_MIN_UA                     133330
+#define MAX77759_CHGR_CHGCC_MAX_UA                     4000000
+#define MAX77759_CHGR_CHGCC_STEP_UA                    66670
+#define MAX77759_CHGR_CHGCC_REG_OFFSET                 0x2
+
+/* Charge Termination Voltage Limits (in 2 ranges) */
+/* [3.8, 3.9] V range */
+#define MAX77759_CHGR_CHG_CV_PRM_LO_MIN_MV             3800
+#define MAX77759_CHGR_CHG_CV_PRM_LO_MAX_MV             3900
+#define MAX77759_CHGR_CHG_CV_PRM_LO_STEP_MV            100
+#define MAX77759_CHGR_CHG_CV_PRM_LO_MIN_REG            0x38
+#define MAX77759_CHGR_CHG_CV_PRM_LO_MAX_REG            0x39
+/* [4, 4.5] V range */
+#define MAX77759_CHGR_CHG_CV_PRM_HI_MIN_MV             4000
+#define MAX77759_CHGR_CHG_CV_PRM_HI_MAX_MV             4500
+#define MAX77759_CHGR_CHG_CV_PRM_HI_STEP_MV            10
+#define MAX77759_CHGR_CHG_CV_PRM_HI_MIN_REG            0x0
+#define MAX77759_CHGR_CHG_CV_PRM_HI_MAX_REG            0x32
+
+/* USB input current limits */
+#define MAX77759_CHGR_CHGIN_ILIM_MIN_UA                100000
+#define MAX77759_CHGR_CHGIN_ILIM_MAX_UA                3200000
+#define MAX77759_CHGR_CHGIN_ILIM_STEP_UA               25000
+#define MAX77759_CHGR_CHGIN_ILIM_REG_OFFSET            0x3
+
 /**
  * struct max77759 - core max77759 internal data structure
  *

-- 
2.52.0.457.g6b5491de43-goog



