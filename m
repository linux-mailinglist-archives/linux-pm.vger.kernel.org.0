Return-Path: <linux-pm+bounces-41205-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFWUFjUlcGmuWwAAu9opvQ
	(envelope-from <linux-pm+bounces-41205-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:00:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A34ECC2
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4505D4EDC86
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A4B2ED848;
	Wed, 21 Jan 2026 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY9lYTlB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167132EA168;
	Wed, 21 Jan 2026 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957215; cv=none; b=Fz9YkKC8j1+VSyn1H1NU9cnIqoZ+Djk1nFhV+6g2XMMtjkVfKHv45myOhDeEXPYXKFG/2TMoGCCMJHGLXZhedAdHIPKITVSli6uDUZcR2/u64svhjY9gXBzSLafdsus3yDn/TeXHvidawtJx91IRReAvLUs7XTzcsD789JPpro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957215; c=relaxed/simple;
	bh=XsHeBPquA+X8hq4tjBVOXmmlym62FAzaGNliMr6+S5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKyfbMHnQsGgHOvcARcYd1Dapb3J6zmyEXvgK4iwcB5xa6Jk4F1zX0HSH6ki7bJ0wFI9m4k9ZSW/kgYQtmdGWUDz6I5VxyfX7hpGqXLl69P7ql4wXdMF0gO+xJrYDuhEEBKODBQEYnG9fmXCanqW7uzMaL/UKvaf1c3pymeUul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY9lYTlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AA1CC2BCB0;
	Wed, 21 Jan 2026 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957214;
	bh=XsHeBPquA+X8hq4tjBVOXmmlym62FAzaGNliMr6+S5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lY9lYTlBwe/NqvbZHlCG8DaF//A9Eu1wnFVse0PYXzztteMvSDk0jScClDcKsAC/6
	 wPhFHGX4Oy20mllT6jtxevO66Lyw8hjX4f3VhOks7wB6rGH8VM5vAXkecxHaUCbsD9
	 RWclnzqP9Aj6g+qHt7tpVHjUKPLayDZFJkRenKQ1Cm+9YkDhHe6rQGElypK26d2qV9
	 xZpieJsgF8LpREnjOasz52LWKKZNYBLcV45r+K3V9OG0CJQf6obyunnsrCfkZIMDyN
	 7RCGz51Kcplx7egceqq9uY4ugjSw3A0259mvgpJOmPTM9l2Fg1e5qFUdqOk2vUoAUe
	 fRegVYTicwsLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70161D262B3;
	Wed, 21 Jan 2026 01:00:14 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 21 Jan 2026 00:59:39 +0000
Subject: [PATCH v4 5/5] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260121-max77759-charger-v4-5-694234c8ded1@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768957213; l=4043;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=gNnVByQLieKyAsnu80J6+t0cbNJjF7NR+Dggwv66Dvg=;
 b=a2qWTsPaLRBPgYtyC9nrykgm9MHHNBIWDmGasd1ExwNCbAyccZMhE6yNyVEzqdxwL276xA5mi
 177B1gJG8FpDcyyKsX8HymqgZ4ttdGoNiryQwI+aNtGjKCKqqsTyt3Y
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
	TAGGED_FROM(0.00)[bounces-41205-lists,linux-pm=lfdr.de,amitsd.google.com];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linaro.org:email]
X-Rspamd-Queue-Id: 2C4A34ECC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 19f63865079658fb2a446dc390262d141b940e9a..e9e2405c5ca036e28c307088d4b785726834e71f 100644
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
2.52.0.457.g6b5491de43-goog



