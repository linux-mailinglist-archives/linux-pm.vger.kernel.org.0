Return-Path: <linux-pm+bounces-7975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAFF8C93BF
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 09:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB1A281732
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE418AE4;
	Sun, 19 May 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nl6VUzoc"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441611CB8;
	Sun, 19 May 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716105051; cv=none; b=TwEU3W/shZbf15o9Qk2RbWoHiCCyl/j4iYotH91/7rDQwTCUFnW8jp+Xs9jC88km8xV3xzwip9JiXizZsOKnUBv48qYfsWyQxbwmMqn0R3xgVMVAVu9zp8m2wZSLc8kEc8gYftu+pyKEsog8AQXhUZnU7vABPmGRo5WuGTadk7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716105051; c=relaxed/simple;
	bh=8zoXWW/KCYUKh14/dNRlyIaqgaRJX+6Od+vCBRNCh/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hisaJKtcTRFqDsmcmomhQfIOJSssLrQxxdgTrv03gsmsWBgZ3DNQEX98O0W9s9c6DwFgITAElvqOptr3fBEGyE0J/D7PGOkiz6Xsabi8WabJnGAOJnp0iVvpdVeyNG849Va3o6EmV9T7NEp6PSAqUa9sT9CUBgP4aOq0+hmNmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nl6VUzoc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716105046;
	bh=8zoXWW/KCYUKh14/dNRlyIaqgaRJX+6Od+vCBRNCh/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nl6VUzocFU4nYWYUKV8Nv5kQBo2QwFbPajhJpSbp6FmyOiIl8kJclGGCS/5ByWNVJ
	 MbIIh5Mis/gM0JQ7EwRAHAg76vkABVODkaIAUvx+RcxY/FhIL2ThaYr/O3z6+DOFNu
	 Vwvc19cdws+yCjcOF/nekdBPUnPWM0WRW4ae7J0Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 19 May 2024 09:50:19 +0200
Subject: [PATCH 1/3] platform/chrome: Update binary interface for EC-based
 charge control
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240519-cros_ec-charge-control-v1-1-baf305dc79b8@weissschuh.net>
References: <20240519-cros_ec-charge-control-v1-0-baf305dc79b8@weissschuh.net>
In-Reply-To: <20240519-cros_ec-charge-control-v1-0-baf305dc79b8@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716105045; l=2666;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8zoXWW/KCYUKh14/dNRlyIaqgaRJX+6Od+vCBRNCh/c=;
 b=zBLC3ct47lR3zGCZw7jl1ii/wPZuSphkaefJSTbaB8d3ObqpdkEyhFabMSV746kRlr04fQSVS
 nUJ/pm8hMtwCLXKXSlojkYOmF4jXsrwPiS6j0P/KY6fkDkmCvaFFzn2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The charge-control command v2 is more featureful than v1, it
additionally supports charge thresholds.

While v3 is also defined, it is very recent and not implemented widely.

The definitions were imported from ChromeOS EC commit
9de7e85d14fb ("test/timer: Increase sleep time error for Helipilot"),
which is the commit just before the introduction of v3 of the protocol.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/platform_data/cros_ec_commands.h | 44 ++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ecc47d5fe239..75521e2b9bb4 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3809,16 +3809,56 @@ struct ec_params_i2c_write {
  * discharge the battery.
  */
 #define EC_CMD_CHARGE_CONTROL 0x0096
-#define EC_VER_CHARGE_CONTROL 1
+#define EC_VER_CHARGE_CONTROL 2
 
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
 };
 
 struct ec_params_charge_control {
-	uint32_t mode;  /* enum charge_control_mode */
+	uint32_t mode; /* enum charge_control_mode */
+
+	/* Below are the fields added in V2. */
+	uint8_t cmd; /* enum ec_charge_control_cmd. */
+	uint8_t reserved;
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
+	uint16_t reserved;
 } __ec_align4;
 
 /*****************************************************************************/

-- 
2.45.1


