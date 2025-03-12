Return-Path: <linux-pm+bounces-23943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B06A5E88C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 00:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC32172F7C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 23:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC31F2BAE;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFHqe11m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C301F0E48;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823000; cv=none; b=kRd6Fmc1jJLyQbi2sWlKG1utbfvC8MwpjWWwR7Cp12VIKdFAm2js033tnZRJozvTZTZnx6/DPibc6MChvvICFvuhm+85xix32nMMcHx7yzirUEO94nq7INM0eLfuVJE6tr7qrp1buijJFJxyrAorCG5/ehBXj5Q05ASBvd45tMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823000; c=relaxed/simple;
	bh=afE7iqHaEzszgRWnZVNiYr+rdCf5/b897AXjXV5srUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N92rPpKvcui5lEkS9I5cEwqzNSwEp3G0l0Pto3v3zyETwkL0WnvIT7ls2S44RlxbglRUBdrnQoHBjuT/EIDDWs1y6jYCpY19x7Tep+pDWELKDuAenM8uTMucHMtA6a/X06oaNBgZprbuggmeWGZGyVlHp83m5hMQWk2tnFhsC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFHqe11m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04ADAC4CEF2;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741823000;
	bh=afE7iqHaEzszgRWnZVNiYr+rdCf5/b897AXjXV5srUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tFHqe11mwcv1xnMg4dOaVKHIuTTIJozwQZXOtN8Mz8zcjBgLHLrFdhAA7qV68QysQ
	 szIBs/LTI8cd7NJyBaz++N+XGqq1hCIfp2zoU7QsUvCcIhgflnsYc4mcF7dnxbQUDW
	 B0YQE0GeLLPIHW0V6DqVyzvv7vN5gwEACxIxkswWMhdBkGq2m+dNX7wBxKDWxXxSpP
	 xitnvNhOc3rMu2nT7YPcWGUFO7RDoWP2CO0a/fVcOf8xImh7wZWYvTilq3ee8JQrh+
	 fvl1b8fpihb+wO/797m+MclQQnJxsh4jSHMZMbUXXEE0vq5cgDE+nJJpSJni8nzTcp
	 11N+yc6OUVHXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8ADC28B2E;
	Wed, 12 Mar 2025 23:43:19 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 12 Mar 2025 16:42:03 -0700
Subject: [PATCH 3/5] usb: typec: tcpm: Add support for Battery Status
 response message
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-batt_ops-v1-3-88e0bb3129fd@google.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
In-Reply-To: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
 Pavel Machek <pavel@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741822998; l=9539;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=R3bHGGUWI+arh8+QWnfjJz8sHg4WRzXg+q2l4c+Ptkk=;
 b=NyUSf7Rjfz8NXScDvzgLTUDmO3O9pDM+TSPJAY/fzhxq4HQkzEELnqGT+oYq+in9Awv+7e3uN
 PdJFIhBht5dD/Jz2IWokHjh4id8+7pCUmd2ELwbuaID/cBAv5KFUMwy
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add support for responding to Get_Battery_Status (extended) request with
a Battery_Status (data) msg. The requester shall request the status of
an individual battery by providing an index in Get_Battery_Status. In
case of failure to identify battery, the responder shall reply with an
appropriate message indicating so.

Battery status support is only provided for fixed batteries indexed from
0 - 3.

Support for Battery_Status message is required for sinks that contain
battery as specified in USB PD Rev3.1 v1.8
("Applicability of Data Messages" section).

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Kyle Tso <kyletso@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 127 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/usb/pd.h        |  34 +++++++++++
 2 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6bf1a22c785aff6b1ad77a20d85e22580527f5b1..2d0dcb998608e25c308159873c6b10e178e0a7a1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -228,6 +228,7 @@ enum pd_msg_request {
 	PD_MSG_DATA_SINK_CAP,
 	PD_MSG_DATA_SOURCE_CAP,
 	PD_MSG_DATA_REV,
+	PD_MSG_DATA_BATT_STATUS
 };
 
 enum adev_actions {
@@ -332,6 +333,15 @@ struct pd_timings {
 	u32 snk_bc12_cmpletion_time;
 };
 
+/*
+ * As per USB PD Spec Rev 3.18 (Sec. 6.5.13.11), a sink can have a maximum
+ * of 4 fixed batteries indexed [0, 3].
+ */
+#define MAX_NUM_FIXED_BATT				4
+
+/* Convert microwatt to watt */
+#define UWH_TO_WH(pow)					((pow) / 1000000)
+
 struct tcpm_port {
 	struct device *dev;
 
@@ -580,6 +590,15 @@ struct tcpm_port {
 
 	/* Indicates maximum (revision, version) supported */
 	struct pd_revision_info pd_rev;
+
+	struct power_supply *fixed_batt[MAX_NUM_FIXED_BATT];
+	u8 fixed_batt_cnt;
+
+	/*
+	 * Variable used to store battery_ref from the Get_Battery_Status
+	 * request to process Battery_Status messages.
+	 */
+	u8 batt_request;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -1339,6 +1358,62 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
 	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
 }
 
+#define BATTERY_PROPERTY_UNKNOWN			0xffff
+
+static int tcpm_pd_send_batt_status(struct tcpm_port *port)
+{
+	struct pd_message msg;
+	struct power_supply *batt;
+	u32 bsdo;
+	u32 batt_id = port->batt_request;
+	union power_supply_propval val;
+	int ret;
+	bool batt_present = false;
+	u8 charging_status = BSDO_BATTERY_INFO_RSVD;
+	u16 present_charge = BATTERY_PROPERTY_UNKNOWN;
+
+	memset(&msg, 0, sizeof(msg));
+	if (batt_id < MAX_NUM_FIXED_BATT && port->fixed_batt[batt_id]) {
+		batt_present = true;
+		batt = port->fixed_batt[batt_id];
+		ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_ENERGY_NOW, &val);
+		/* Battery Present Charge is reported in increments of 0.1WH */
+		if (!ret)
+			present_charge = (u16)(UWH_TO_WH(val.intval) * 10);
+
+		ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_STATUS,
+						&val);
+		if (!ret) {
+			switch (val.intval) {
+			case POWER_SUPPLY_STATUS_CHARGING:
+			case POWER_SUPPLY_STATUS_FULL:
+				charging_status = BSDO_BATTERY_INFO_CHARGING;
+				break;
+			case POWER_SUPPLY_STATUS_DISCHARGING:
+				charging_status = BSDO_BATTERY_INFO_DISCHARGING;
+				break;
+			case POWER_SUPPLY_STATUS_NOT_CHARGING:
+				charging_status = BSDO_BATTERY_INFO_IDLE;
+				break;
+			default:
+				charging_status = BSDO_BATTERY_INFO_RSVD;
+				break;
+			}
+		}
+	}
+
+	bsdo = BSDO(present_charge, batt_present ? charging_status : 0,
+		    batt_present, !batt_present);
+	msg.payload[0] = cpu_to_le32(bsdo);
+	msg.header = PD_HEADER_LE(PD_DATA_BATT_STATUS,
+				  port->pwr_role,
+				  port->data_role,
+				  port->negotiated_rev,
+				  port->message_id,
+				  1);
+	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
+}
+
 static void mod_tcpm_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
 {
 	if (delay_ms) {
@@ -3597,6 +3672,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 {
 	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
 	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
+	const struct pd_chunked_ext_message_data *ext_msg = &msg->ext_msg;
 
 	/* stopping VDM state machine if interrupted by other Messages */
 	if (tcpm_vdm_ams(port)) {
@@ -3605,7 +3681,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 		mod_vdm_delayed_work(port, 0);
 	}
 
-	if (!(le16_to_cpu(msg->ext_msg.header) & PD_EXT_HDR_CHUNKED)) {
+	if (!(le16_to_cpu(ext_msg->header) & PD_EXT_HDR_CHUNKED)) {
 		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
 		tcpm_log(port, "Unchunked extended messages unsupported");
 		return;
@@ -3630,9 +3706,13 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 					     NONE_AMS, 0);
 		}
 		break;
+	case PD_EXT_GET_BATT_STATUS:
+		port->batt_request = ext_msg->data[0];
+		tcpm_pd_handle_msg(port, PD_MSG_DATA_BATT_STATUS,
+				   GETTING_BATTERY_STATUS);
+		break;
 	case PD_EXT_SOURCE_CAP_EXT:
 	case PD_EXT_GET_BATT_CAP:
-	case PD_EXT_GET_BATT_STATUS:
 	case PD_EXT_BATT_CAP:
 	case PD_EXT_GET_MANUFACTURER_INFO:
 	case PD_EXT_MANUFACTURER_INFO:
@@ -3833,6 +3913,14 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 					 ret);
 			tcpm_ams_finish(port);
 			break;
+		case PD_MSG_DATA_BATT_STATUS:
+			ret = tcpm_pd_send_batt_status(port);
+			if (ret)
+				tcpm_log(port,
+					 "Failed to send battery status ret=%d",
+					 ret);
+			tcpm_ams_finish(port);
+			break;
 		default:
 			break;
 		}
@@ -7164,6 +7252,35 @@ static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fw
 		port->timings.snk_bc12_cmpletion_time = val;
 }
 
+static void tcpm_fw_get_batt(struct tcpm_port *port, struct fwnode_handle *fwnode)
+{
+	int i, ret;
+	enum power_supply_type psy_type;
+
+	ret = power_supply_get_by_fwnode_reference_array(fwnode,
+							 "fixed-batteries",
+							 port->fixed_batt,
+							 MAX_NUM_FIXED_BATT);
+	if (ret < 0) {
+		tcpm_log(port,
+			 "Unable to parse or find batteries property, ret=%d",
+			 ret);
+		return;
+	}
+
+	port->fixed_batt_cnt = ret;
+	for (i = 0; i < port->fixed_batt_cnt; i++) {
+		if (!port->fixed_batt[i])
+			continue;
+
+		psy_type = port->fixed_batt[i]->desc->type;
+		if (psy_type != POWER_SUPPLY_TYPE_BATTERY)
+			tcpm_log(port,
+				 "Wrong power supply type (%u) at idx:%d. Should be battery type.",
+				 psy_type, i);
+	}
+}
+
 static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *capabilities, *child, *caps = NULL;
@@ -7746,6 +7863,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 	tcpm_fw_get_timings(port, tcpc->fwnode);
 	tcpm_fw_get_pd_revision(port, tcpc->fwnode);
+	tcpm_fw_get_batt(port, tcpc->fwnode);
 
 	port->try_role = port->typec_caps.prefer_role;
 
@@ -7827,6 +7945,11 @@ void tcpm_unregister_port(struct tcpm_port *port)
 	hrtimer_cancel(&port->vdm_state_machine_timer);
 	hrtimer_cancel(&port->state_machine_timer);
 
+	for (i = 0; i < port->fixed_batt_cnt; i++) {
+		if (port->fixed_batt[i])
+			power_supply_put(port->fixed_batt[i]);
+	}
+
 	tcpm_reset_port(port);
 
 	tcpm_port_unregister_pd(port);
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 3068c3084eb6176d7d9184c3959a4110282a9fa0..299e7c20127cd5b7dcdae4f24468df4b34b072b5 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -553,4 +553,38 @@ void usb_power_delivery_unlink_device(struct usb_power_delivery *pd, struct devi
 
 #endif /* CONFIG_TYPEC */
 
+/* Battery Status Data Object */
+#define BSDO_PRESENT_CAPACITY_SHIFT			16
+#define BSDO_PRESENT_CAPACITY_MASK			GENMASK(31, 16)
+#define BSDO_CHG_STATUS_SHIFT				10
+#define BSDO_CHG_STATUS_MASK				GENMASK(11, 10)
+#define BSDO_BATTERY_PRESENT				BIT(9)
+#define BSDO_INVALID_BATTERY_REFERENCE			BIT(8)
+
+/*
+ * Battery Charge Status: Battery Charging Status Values as defined in
+ * "USB PD Spec Rev3.1 Ver1.8", "Table 6-46 Battery Status Data Object (BSDO)".
+ */
+#define BSDO_BATTERY_INFO_CHARGING			0x1
+#define BSDO_BATTERY_INFO_DISCHARGING			0x2
+#define BSDO_BATTERY_INFO_IDLE				0x3
+#define BSDO_BATTERY_INFO_RSVD				0x4
+
+/**
+ * BSDO() - Pack data into Battery Status Data Object format
+ * @batt_charge: Battery's present state of charge in 0.1WH increment
+ * @chg_status: Battery charge status
+ * @batt_present: When set, this indicates battery is present/attached.
+ *   Otherwise:
+ *     - Non hot-swappable battery: Indicates absence of battery
+ *     - Hot-swappable battery: Indicates battery is unattached
+ * @invalid_ref: Set when invalid battery reference is made in
+ *   Get_Battery_Status request, else 0
+ */
+#define BSDO(batt_charge, chg_status, batt_present, invalid_ref)				\
+	((((batt_charge) << BSDO_PRESENT_CAPACITY_SHIFT) & BSDO_PRESENT_CAPACITY_MASK) |	\
+	 (((chg_status) << BSDO_CHG_STATUS_SHIFT) & BSDO_CHG_STATUS_MASK) |			\
+	 ((batt_present) ? BSDO_BATTERY_PRESENT : 0) |						\
+	 ((invalid_ref) ? BSDO_INVALID_BATTERY_REFERENCE : 0))
+
 #endif /* __LINUX_USB_PD_H */

-- 
2.49.0.rc0.332.g42c0ae87b1-goog



