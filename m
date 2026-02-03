Return-Path: <linux-pm+bounces-42009-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLgeO/B7gmnAVQMAu9opvQ
	(envelope-from <linux-pm+bounces-42009-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 23:51:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B59DF60A
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 23:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBC48300B298
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 22:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F6372B23;
	Tue,  3 Feb 2026 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEdLmLDM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ADE2F49FD;
	Tue,  3 Feb 2026 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159076; cv=none; b=LKAKPRcuQzAhX2vtMpk6JMpy3ilcc9Z+srzOQgBFUB2X4o+iiNDzgGhpqA0mmBLxC9WyCoUe+SwRXzGVb7VPDI2GiOVyzcBJ2Hi0i6mbhH5sbf6zUBio0qOfj9YtgY6R7IEaCoSOUJfXZQKMUSGRP0UnM057s/hjiaBkDgh037c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159076; c=relaxed/simple;
	bh=wHw8pVIgLJeCoJRpW72JqN3QVPbWqOXWks846PET0ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X8i8Er07nQPGzBTH3SUUm3HePKNn++YTzkwJvLLsOVYcpYeK68nTT+s5vEh7ploHWMYT32Hp0RmfWqmiVfr0MjB6jTfv2hlx1UD7IBpKtX/8HSUNguDuraYLG5NM8CqlOHknlgxbD6CZwOm5U7uc51yhACTDXcqIlR4zpQHtdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEdLmLDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 411D2C2BCB3;
	Tue,  3 Feb 2026 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770159076;
	bh=wHw8pVIgLJeCoJRpW72JqN3QVPbWqOXWks846PET0ek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dEdLmLDMZ2Hg3HPM/ahBvP3YXKKJq0RjvGNoR8tsGy1Dxsb2meQPeDv6Qoblwje9Z
	 7aEkbDJ0Trldf0dCVRSrWW3P7gBzKPfts+bEHTaIIjEJuy161OeIZzFSbBN86umqlx
	 dRL7LhPXR+WLmF60VnIXLVTr3CnEwC+OZCgoRdigHs0oWbqEsAyCHRQvZ7v5AghlVB
	 QvH9yE3WZ+v7/PUBxyKC4GV1k1PWB4oaXT02uvAZjXHPuj6JDAw3qrElnv6ib9ryUp
	 H8DAWSu6WYEyvSYHmog3X7viK7jCJB5PgafPBc2fUYI5TWMbXQNXldOZA1CTBIAGl3
	 mVo9lPN2jKHDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2976FE8B36B;
	Tue,  3 Feb 2026 22:51:16 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 03 Feb 2026 22:50:29 +0000
Subject: [PATCH v5 3/5] mfd: max77759: add register bitmasks and modify irq
 configs for charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-max77759-charger-v5-3-b50395376a5f@google.com>
References: <20260203-max77759-charger-v5-0-b50395376a5f@google.com>
In-Reply-To: <20260203-max77759-charger-v5-0-b50395376a5f@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770159074; l=16696;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=jxNkWUAs1mfqTsR35pZxF1JCI//jTCEDEfU34gEbLfk=;
 b=ndjlu3hz8F88JqjLOxGhUq7aPZg/1FR8E2cZp3m10pnFSo8eZAM+KJd1/0FVxoqyf+xuneoHn
 X49NzZMFIMKBwEFqrYlgqtKEMUDDl/U6cpkaOOzMJsmh5KOyCZ4R96+
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42009-lists,linux-pm=lfdr.de,amitsd.google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[amitsd@google.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63B59DF60A
X-Rspamd-Action: no action

From: Amit Sunil Dhamne <amitsd@google.com>

Add register bitmasks for charger function.
In addition split the charger IRQs further such that each bit represents
an IRQ downstream of charger regmap irq chip. In addition populate the
ack_base to offload irq ack to the regmap irq chip framework.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/mfd/max77759.c       |  91 +++++++++++++++++--
 include/linux/mfd/max77759.h | 204 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 258 insertions(+), 37 deletions(-)

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
index c6face34e38555cbc09db4131925b6ed781af511..2e2f7631356257303c6067b3cdb0dd0c0e7f5850 100644
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
@@ -101,6 +131,122 @@
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
+#define MAX77759_CHGR_CHGCC_MIN_REG                    0x2
+#define MAX77759_CHGR_CHGCC_MAX_REG                    0x3C
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
+#define MAX77759_CHGR_CHGIN_ILIM_MIN_REG               0x3
+#define MAX77759_CHGR_CHGIN_ILIM_MAX_REG               0x7F
+
 /**
  * struct max77759 - core max77759 internal data structure
  *

-- 
2.53.0.rc2.204.g2597b5adb4-goog



