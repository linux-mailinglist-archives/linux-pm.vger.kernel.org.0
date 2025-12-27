Return-Path: <linux-pm+bounces-39961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423ABCDF2AB
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 01:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4F7E301A1DD
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 00:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2729B195FE8;
	Sat, 27 Dec 2025 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvB2cSfK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F432A1AA;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766793899; cv=none; b=eMOOaXeNzchSM9QNDQSRswisSclpb2c2PmlK4CFZAhDSG72qKO8RwMkGmzbPDkN3Dwyrpitr/jILK4xvRoMMKo/pU+Y3l5NhQFPgZGVzf/yfEkNhDkQab09vOyUGdF2xUrpyDiI9Nvk83cFZ6F6dVF+qy4FnPuwpFoEolS9FHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766793899; c=relaxed/simple;
	bh=oRU7q7IHQJ9WucDmI6BRrNEB61T/nFZp3Dt1jCwmm7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=puy8Jvu0OsYLdSPjVe3ELADCerM0Cahg1RqzRjQLuEh469eU4yCkv9DWz3Mik0taJ6TjAhz5YzmLAm2uJGLT0F5h4YMki9ytu6iZehzzifs2GaakqqC+JjSIVCINhlMAsmWkvqYTdF/GnvIo7udTzZQBOlmZDxtupBwvjBOVhoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvB2cSfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42916C2BC86;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766793899;
	bh=oRU7q7IHQJ9WucDmI6BRrNEB61T/nFZp3Dt1jCwmm7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UvB2cSfKP4sMFBTN7lZ+y+o9Fw2DUCiFJgiTgPX9TAe2/RBYL+O3iFaA//Yhm1y53
	 TqSZYaTL9+fPzUfOt+D50wh9Hk7d/LyFmMMxQC9iu57YrlFDcxCOl/D8P2NQvijRLE
	 0UlSYZYHiLToiK37rxe+zvXlDQikAR8Fi4as2N+oZk6tRWVtA4jOzKuzNt5XUhaBvD
	 HR2M4e25CcBxAv16hSux0ztTtQjbIJKh3wMisrSAYa3+O/F6J/zFNDwbNnWuHgBZxz
	 CbAXncslbR29cgm2KY1N6m6tKDV5rWmcGrgAvQpW0OoLzJrUW2jTJwvlqollsQD99Z
	 NhhvImlBb8MEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A78E8FDB8;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sat, 27 Dec 2025 00:04:25 +0000
Subject: [PATCH v3 5/5] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
In-Reply-To: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766793897; l=3811;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=MT44N2zv9M1kJDU04IDvsZ4Ub4KamRLbZfq7XeF0PrU=;
 b=Z/afSjmgIdyXCBiail76lX4kKhQKrYUwnFb0dimHzrbD1ik3XAzmX3xKyBoKQHPnTHiU9mwqH
 qUSUNLCIRhmBAYeWbCC3E73Si/t/lmitnuEB15+C1tOGF2K/6JJmGcf
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

Instead, use a regulator interface to source vbus when typec is in
source power mode. In other power modes, this regulator will be turned
off if active.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/usb/typec/tcpm/tcpci_maxim.h      |  1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 54 +++++++++++++++++++------------
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index b33540a42a95..b314606eb0f6 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -60,6 +60,7 @@ struct max_tcpci_chip {
 	struct tcpm_port *port;
 	enum contamiant_state contaminant_state;
 	bool veto_vconn_swap;
+	struct regulator *vbus_reg;
 };
 
 static inline int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 19f638650796..e9e2405c5ca0 100644
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
@@ -35,12 +36,6 @@
  */
 #define TCPC_RECEIVE_BUFFER_LEN				32
 
-#define MAX_BUCK_BOOST_SID				0x69
-#define MAX_BUCK_BOOST_OP				0xb9
-#define MAX_BUCK_BOOST_OFF				0
-#define MAX_BUCK_BOOST_SOURCE				0xa
-#define MAX_BUCK_BOOST_SINK				0x5
-
 static const struct regmap_range max_tcpci_tcpci_range[] = {
 	regmap_reg_range(0x00, 0x95)
 };
@@ -202,32 +197,49 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	tcpm_pd_receive(chip->port, &msg, rx_type);
 }
 
+static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
+{
+	if (IS_ERR_OR_NULL(chip->vbus_reg)) {
+		chip->vbus_reg = devm_regulator_get_exclusive(chip->dev,
+							      "vbus");
+		if (IS_ERR_OR_NULL(chip->vbus_reg)) {
+			dev_err(chip->dev,
+				"Failed to get vbus regulator handle");
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
+	ret = get_vbus_regulator_handle(chip);
+	if (ret) {
+		/*
+		 * Regulator is not necessary for sink only applications. Return
+		 * success in cases where sink mode is being modified.
+		 */
+		return source ? ret : 1;
+	}
+
+	if (source) {
+		if (!regulator_is_enabled(chip->vbus_reg))
+			ret = regulator_enable(chip->vbus_reg);
+	} else {
+		if (regulator_is_enabled(chip->vbus_reg))
+			ret = regulator_disable(chip->vbus_reg);
+	}
 
-	return  ret < 0 ? ret : 1;
+	return ret < 0 ? ret : 1;
 }
 
 static void process_power_status(struct max_tcpci_chip *chip)

-- 
2.52.0.351.gbe84eed79e-goog



