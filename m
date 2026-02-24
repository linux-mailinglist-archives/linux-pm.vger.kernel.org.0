Return-Path: <linux-pm+bounces-43082-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAzVHwgDnWkuMgQAu9opvQ
	(envelope-from <linux-pm+bounces-43082-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 02:46:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E5180AF6
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 02:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE5B311AE79
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4326738C;
	Tue, 24 Feb 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+uVTJIH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078F24A07C;
	Tue, 24 Feb 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897550; cv=none; b=IV8zjFGq/Q+VISHCn5xFC+z+BLsSCJT36axkOx46SH62CEfJupcc2x3qm7xhAVgva2BE/Wfd9Hg4hKrfsCXDywR9scrKgMpdv8E71+gVPQc5ly34Gmp7MQCT3Px30isTq9o8LdTMvN7g/Zx+KI70Vl5l3LtgixEEwZZ3y4uWJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897550; c=relaxed/simple;
	bh=lOXUdHAknlORz4WutDBBxQ6j9aq0kZdEzSPNA6F+0dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rmluALeMaeMPOOQTqjs/hg6kn2kDDjZ/5Bga82DhvxtX3Rgr/6nbyyBferINjEOQX3f4wNDKLjUPU4RXFoFLt/HULjc2HutybHahtULvvMsVqWxaXGEZpyHjizq9+cw6w8GBzn4n/MooC5hmAVTFZMtU9uRCqdo9daL/SIOdsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+uVTJIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0708CC4AF0F;
	Tue, 24 Feb 2026 01:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771897550;
	bh=lOXUdHAknlORz4WutDBBxQ6j9aq0kZdEzSPNA6F+0dU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I+uVTJIHP+ZDDlQ/KOiwLEIAa6BdI2G6Fc+3ZRIihnVrjyrJ8wSX8hjoFGydo7CbM
	 54byam3yvvcudJzlerXJbdOhx3uI+p+17GuSNs1QHCiiELeBs/h5xnmckAxDMVMAa2
	 GPGCmU1Goz0s9m6ASRsHKHrM/BwjS+6hEzkv9CpKQb7LBvDuSZxOiDYqB+/10IM9mS
	 e0BA2Wr8ktz1NKL6lNlVj8veB1zBjy53rNolA6R6bXQQWlQN1yYSC7oQpvqEG5sCXH
	 UHfygnS9VCAdXbrcGhHxHPOHVl+lOPrsiMko/DeuqPnO2u4xo2yR2tQ+CBP9+bH0Je
	 sb/Eby7/SIGug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B5EEC2BE;
	Tue, 24 Feb 2026 01:45:49 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 24 Feb 2026 01:45:36 +0000
Subject: [PATCH v8 6/6] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260224-max77759-charger-v8-6-eb86bd570e9c@google.com>
References: <20260224-max77759-charger-v8-0-eb86bd570e9c@google.com>
In-Reply-To: <20260224-max77759-charger-v8-0-eb86bd570e9c@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771897548; l=4045;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=mMnQywZ79m54T70kkS6R9rVtGFJGQ8QQS9OrefFa+7E=;
 b=Vbo0B2I/nwEwbqLC6gBrYXB5R07Va9I3qkpkxI4KgO6MbYtH1j180oL4AaqA+gtTnRYPwij5K
 /lYf1+FreblCsbwBnn2t1anY9pq95brB/G2CZ65/ZJ0pDASX8l1TcOY
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43082-lists,linux-pm=lfdr.de,amitsd.google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,gmail.com,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	HAS_REPLYTO(0.00)[amitsd@google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,intel.com:email]
X-Rspamd-Queue-Id: 227E5180AF6
X-Rspamd-Action: no action

From: Amit Sunil Dhamne <amitsd@google.com>

TCPCI maxim driver directly writes to the charger's register space to
set charger mode depending on the power role. As MAX77759 chg driver
exists, this WAR is not required.

Instead, use a regulator interface to source vbus when typec is in
source power mode. In other power modes, this regulator will be turned
off if active.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim.h      |  1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 54 +++++++++++++++++++------------
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index b33540a42a953dc6d8197790ee4af3b6f52791ce..b314606eb0f67ddbc80d8760244aa6dee61bebc1 100644
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
index 19f63865079658fb2a446dc390262d141b940e9a..c0ee7e6959edf9666e499a6fa085fbca9f2b07f3 100644
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
+				"Failed to get vbus regulator handle\n");
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
2.53.0.371.g1d285c8824-goog



