Return-Path: <linux-pm+bounces-38411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E95C7DE3B
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 09:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18DFF4E2C2E
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816542D2397;
	Sun, 23 Nov 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDDOfLXj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE02C21EB;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763886985; cv=none; b=rx1Y5j4CWy1qAzmN7YVHx4JaB1YBPTBPfN8ClV4txWoRZ7qyfdynrb5gn+nK8zHhHUpEnyyLGvqynoUPFHZ03mIuLELYh0ST+Htw4LF5rk1K4tm0EAuCMdI+UdDaQorecBz8f2rvqpKrpKAB7+zHvpZTw4VYir9uC6A2JTadDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763886985; c=relaxed/simple;
	bh=NSXCge/2gK6HdCYnUhX0JsiC+V4/sPRuifzpNu302Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHxk0WO0bn2Lf6FKwW9xT6n9Zo+BzXAnhpOloTW1b2ucy9R4ZokIuKb9ccd8jdiVtr+tca4jHVj0vpwZkIDYq5vHL4ap7WoUs8mZol5wCW4us6Oj/7TtJ2wMWosyApc4X61AcxB+9qvV12x3u8MIyPlyR2Al6MATQiV9wrHnGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDDOfLXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAC6BC2BC87;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763886984;
	bh=NSXCge/2gK6HdCYnUhX0JsiC+V4/sPRuifzpNu302Ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MDDOfLXjbmK38iMwtpv6T+bQBMaPpsLpgMksu5fELVHyZ820IvLrQnw+PZH0wa83y
	 wnb2Ykq+mVTRaPXV9J2FpJDH2S6FWJQ42WWb1CWRq5NdkM7nVCiDLHOOYzk30KY3m5
	 CPCcikTJO8F8Qg1e18utO4Xvk5dSYfgGVpm4hNnNEhdtQL7YY/96vbfMGEaqzsbmGA
	 3gsSackEVWpGLUrbFdWOdXM4ZXXiv/O44vEvMHsVm4309As/yAtJcSfDbkwCFQAyEa
	 iGDlczPC2/iDwa/LX3sFRS7ArN4IqpnojB7LbMlzF+JA6y0ql2z4ASyobZKg/bJyDH
	 WPX44rAYqnPxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE24DCFA46B;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sun, 23 Nov 2025 08:35:53 +0000
Subject: [PATCH 6/6] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-max77759-charger-v1-6-6b2e4b8f7f54@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
In-Reply-To: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763886983; l=3355;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=/TCo7ex1368Y86Fyq12+zxO0JMAaguRjxNQAlVy2Xs4=;
 b=AbMrYbmLH+QdUL9CL7s7kJK/2G1npTiYCzh32EVJI3e7OLGe8+jBNNLdNv4i9tXM4szINi7cR
 4GPEFAgPppFBIjWh14daHEhdhLZRZLO/6tuefrflLnuJBp85smrtfj/
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

TCPCI maxim driver directly writes to the charger's register space to
set charger mode depending on the power role. As MAX77759 chg driver
exists, this WAR is not required.

Instead, use a regulator interface to set OTG Boost mode.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/usb/typec/tcpm/tcpci_maxim.h      |  1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 48 +++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index b33540a42a95..6c82a61efe46 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -60,6 +60,7 @@ struct max_tcpci_chip {
 	struct tcpm_port *port;
 	enum contamiant_state contaminant_state;
 	bool veto_vconn_swap;
+	struct regulator *otg_reg;
 };
 
 static inline int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 19f638650796..6d819a762fa1 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
@@ -202,32 +203,49 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	tcpm_pd_receive(chip->port, &msg, rx_type);
 }
 
+static int get_otg_regulator_handle(struct max_tcpci_chip *chip)
+{
+	if (IS_ERR_OR_NULL(chip->otg_reg)) {
+		chip->otg_reg = devm_regulator_get_exclusive(chip->dev,
+							     "otg-vbus");
+		if (IS_ERR_OR_NULL(chip->otg_reg)) {
+			dev_err(chip->dev,
+				"Failed to get otg regulator handle");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
 static int max_tcpci_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata, bool source, bool sink)
 {
 	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
-	u8 buffer_source[2] = {MAX_BUCK_BOOST_OP, MAX_BUCK_BOOST_SOURCE};
-	u8 buffer_sink[2] = {MAX_BUCK_BOOST_OP, MAX_BUCK_BOOST_SINK};
-	u8 buffer_none[2] = {MAX_BUCK_BOOST_OP, MAX_BUCK_BOOST_OFF};
-	struct i2c_client *i2c = chip->client;
 	int ret;
 
-	struct i2c_msg msgs[] = {
-		{
-			.addr = MAX_BUCK_BOOST_SID,
-			.flags = i2c->flags & I2C_M_TEN,
-			.len = 2,
-			.buf = source ? buffer_source : sink ? buffer_sink : buffer_none,
-		},
-	};
-
 	if (source && sink) {
 		dev_err(chip->dev, "Both source and sink set\n");
 		return -EINVAL;
 	}
 
-	ret = i2c_transfer(i2c->adapter, msgs, 1);
+	ret = get_otg_regulator_handle(chip);
+	if (ret) {
+		/*
+		 * Regulator is not necessary for sink only applications. Return
+		 * success in cases where sink mode is being modified.
+		 */
+		return source ? ret : 1;
+	}
+
+	if (source) {
+		if (!regulator_is_enabled(chip->otg_reg))
+			ret = regulator_enable(chip->otg_reg);
+	} else {
+		if (regulator_is_enabled(chip->otg_reg))
+			ret = regulator_disable(chip->otg_reg);
+	}
 
-	return  ret < 0 ? ret : 1;
+	return ret < 0 ? ret : 1;
 }
 
 static void process_power_status(struct max_tcpci_chip *chip)

-- 
2.52.0.rc2.455.g230fcf2819-goog



