Return-Path: <linux-pm+bounces-8307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633B28D2570
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 22:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A441C2362C
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85DC17920E;
	Tue, 28 May 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bLejnAhw"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589C178398;
	Tue, 28 May 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926719; cv=none; b=stAvsiwMeMQ4SrKaEztJux32OhZDn+SlgHkrcGHYFwl5xoN1ExttL5HDNPHGYSN1JqWA5KJzPNu1yvwkHtlCMrpYPsOgztAHD2XVoX4axrwoXbUuz569N65Rp9BhuHmGI2SrT8zARbc0lWqXSMxGUPd3qx4XzAKQaq7CcM4FI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926719; c=relaxed/simple;
	bh=JbYQHnPT7R8bbx48TFbQXDrU5PRM/0uyA9vkGt576is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C9l7g8ScWBOraRJXd3UMj5TvTlNaN0X+TJQiMYOwXhxp6k3xh3T1KCUa+aLN0+bWtB1KdpFWRwO2qrX2xXcrkWct8psbXJ4daoC0eaTfipCoscrIxzajh5S+PRal9bwTy59vKDlyZ6LPFcKggG1Tb+bEKeSBoY6Mmv4SidRf+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bLejnAhw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716926707;
	bh=JbYQHnPT7R8bbx48TFbQXDrU5PRM/0uyA9vkGt576is=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bLejnAhw/GmdlkCX4xAaQFhl8q971F5D9s5s2sJfaHP2LYW4EVIsqkszh41oCkAI6
	 HwRsFZ048LqZmDKk9TdRdG6hjuisKnAV+5Ue/QT0lmqZYDjVku8SgDi2PK3mCV+WJK
	 xpNH0+PMQq7pe18XRGPrATOtH0MAOzr3US3noDlQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 May 2024 22:04:10 +0200
Subject: [PATCH v2 1/3] platform/chrome: Update binary interface for
 EC-based charge control
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240528-cros_ec-charge-control-v2-1-81fb27e1cff4@weissschuh.net>
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
In-Reply-To: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716926706; l=2691;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JbYQHnPT7R8bbx48TFbQXDrU5PRM/0uyA9vkGt576is=;
 b=LjM+FLqiJVMvC8n7q9IfHO2F4e28kIeTc3GEYi4cjWje8j1BOWTHVBIUy8s+td/vLjUkwO/wf
 RTidBOH6MsWDNekA/woovjb05qm2EtQ4GHn0mnMoK/llBztyUDRsXSM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The charge-control command v2/v3 is more featureful than v1, it
additionally supports charge thresholds.

The definitions were imported from ChromeOS EC commit
32870d602317 ("squirtle: modify motionsense rotation matrix")

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/platform_data/cros_ec_commands.h | 49 ++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ecc47d5fe239..c35e534e3c3d 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3809,16 +3809,61 @@ struct ec_params_i2c_write {
  * discharge the battery.
  */
 #define EC_CMD_CHARGE_CONTROL 0x0096
-#define EC_VER_CHARGE_CONTROL 1
+#define EC_VER_CHARGE_CONTROL 3
 
 enum ec_charge_control_mode {
 	CHARGE_CONTROL_NORMAL = 0,
 	CHARGE_CONTROL_IDLE,
 	CHARGE_CONTROL_DISCHARGE,
+	/* Add no more entry below. */
+	CHARGE_CONTROL_COUNT,
+};
+
+#define EC_CHARGE_MODE_TEXT                               \
+	{                                                 \
+		[CHARGE_CONTROL_NORMAL] = "NORMAL",       \
+		[CHARGE_CONTROL_IDLE] = "IDLE",           \
+		[CHARGE_CONTROL_DISCHARGE] = "DISCHARGE", \
+	}
+
+enum ec_charge_control_cmd {
+	EC_CHARGE_CONTROL_CMD_SET = 0,
+	EC_CHARGE_CONTROL_CMD_GET,
+};
+
+enum ec_charge_control_flag {
+	EC_CHARGE_CONTROL_FLAG_NO_IDLE = BIT(0),
 };
 
 struct ec_params_charge_control {
-	uint32_t mode;  /* enum charge_control_mode */
+	uint32_t mode; /* enum charge_control_mode */
+
+	/* Below are the fields added in V2. */
+	uint8_t cmd; /* enum ec_charge_control_cmd. */
+	uint8_t flags; /* enum ec_charge_control_flag (v3+) */
+	/*
+	 * Lower and upper thresholds for battery sustainer. This struct isn't
+	 * named to avoid tainting foreign projects' name spaces.
+	 *
+	 * If charge mode is explicitly set (e.g. DISCHARGE), battery sustainer
+	 * will be disabled. To disable battery sustainer, set mode=NORMAL,
+	 * lower=-1, upper=-1.
+	 */
+	struct {
+		int8_t lower; /* Display SoC in percentage. */
+		int8_t upper; /* Display SoC in percentage. */
+	} sustain_soc;
+} __ec_align4;
+
+/* Added in v2 */
+struct ec_response_charge_control {
+	uint32_t mode; /* enum charge_control_mode */
+	struct { /* Battery sustainer thresholds */
+		int8_t lower;
+		int8_t upper;
+	} sustain_soc;
+	uint8_t flags; /* enum ec_charge_control_flag (v3+) */
+	uint8_t reserved;
 } __ec_align4;
 
 /*****************************************************************************/

-- 
2.45.1


