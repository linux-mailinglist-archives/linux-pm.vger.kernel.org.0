Return-Path: <linux-pm+bounces-23945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F89A5E894
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 00:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DB9172E72
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 23:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4A1F3BB5;
	Wed, 12 Mar 2025 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ucxyt6vW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C41F2C3B;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823000; cv=none; b=Lmvo9oXxWq5qzaKE14wfVzr8aqzzcwNJyeYHnzBmTFiyy7MV+F7UlFPCnJ0qDqqVwvX3Tfm53iLIv+M9RVRTlJr4JeWNsEvhC6BA7mlcxYsZ4UUETBCQ4TxJ2yZkYckNc7fEzOOgmDw30jHmwZZR3YKBnOViHA7FyVH59PdUWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823000; c=relaxed/simple;
	bh=2bA2EGf65pJlOWExavnBkLXzvsRgKvhpp4DQILDFGmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dp0YxoTQV6Y0HHndDonJymS7kzwrT3y0qAkENW7Oj66PkR9/K8oMxjSfHoDvoeau+aYXm5GlVgFtvg0s6vq4mbgG/lDaw3qwAHMxVpK6vs+nw9nz4ZKstqwZCFdilBGlM18PfI/L6xe5AddSpBM4PEhADPEPH2xqBMvAWG/JskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ucxyt6vW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C41FC4CEFD;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741823000;
	bh=2bA2EGf65pJlOWExavnBkLXzvsRgKvhpp4DQILDFGmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ucxyt6vWdpKB4cnlLzoyXSYw+g8pzq87rPj6iZ35bnmPlIgM5RlsW1DA0M9/oYQEZ
	 gPdQpSXGGOF8fYIWymBxH1SR2iMTyfijwoBBsBdlSQlayKFQsCYBwEUFwE7JmO1HG/
	 7xV0xxoMgPtzq5lTgZcHRWjRWj4zka6LuRN3ieLz2R16foYOMHjdxm0kRFJmY3U0dt
	 /4uBs+e77ehKC8wuWQzW37T2pPiYm6VDIP3MtbUJ4AZ34xhmPqfy5jtehh+HnnTf+P
	 8bFs/QKnHG4fguPyVgSSzfJZIJ6+eQP3w+k9VMACHfD34a/hpjQAmR5SM+MVeaAoyf
	 GhEiaF3/Dicdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313A3C28B2E;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 12 Mar 2025 16:42:05 -0700
Subject: [PATCH 5/5] usb: typec: tcpm: Add support for Battery Cap response
 message
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-batt_ops-v1-5-88e0bb3129fd@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741822998; l=6790;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=0Lu/D0Fl96RaaPPHoSMV9B9kZVmVEN77JVQOeODSfIQ=;
 b=0K5DuxJ6366+M06TTECI+vhtR57ZydL0Iv3549e6hZtapSUyxuhzcxvc+QaXrwK1A5/bO7GST
 /e7NHyWB5MDBGNdUJuyW7btkH5QC4ZLmfvBpXkJEvlUQ4RVHhtMWv54
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add support for responding to Get_Battery_Cap (extended) request with a
a Battery_Capabilities (extended) msg. The requester will request
Battery Cap for a specific battery using an index in Get_Battery_Cap. In
case of failure to identify battery, TCPM shall reply with an
appropriate message indicating so.

Support has been added only for fixed batteries and not hot swappable
ones.

As the Battery Cap Data Block size is 9 Bytes (lesser than
MaxExtendedMsgChunkLen of 26B), only a single chunk is required to
complete the AMS.

Support for Battery_Capabilities message is required for sinks that
contain battery as specified in USB PD Rev3.1 v1.8
("Applicability of Data Messages" section).

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Kyle Tso <kyletso@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 96 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/usb/pd.h        | 31 ++++++++++++++
 2 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 2d0dcb998608e25c308159873c6b10e178e0a7a1..22a5a0d463c8738d2160cbe9472207b8053f99b8 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -228,7 +228,8 @@ enum pd_msg_request {
 	PD_MSG_DATA_SINK_CAP,
 	PD_MSG_DATA_SOURCE_CAP,
 	PD_MSG_DATA_REV,
-	PD_MSG_DATA_BATT_STATUS
+	PD_MSG_DATA_BATT_STATUS,
+	PD_MSG_EXT_BATT_CAP,
 };
 
 enum adev_actions {
@@ -595,8 +596,8 @@ struct tcpm_port {
 	u8 fixed_batt_cnt;
 
 	/*
-	 * Variable used to store battery_ref from the Get_Battery_Status
-	 * request to process Battery_Status messages.
+	 * Variable used to store battery_ref from the Get_Battery_Status &
+	 * Get_Battery_Caps request to process Battery_Status messages.
 	 */
 	u8 batt_request;
 #ifdef CONFIG_DEBUG_FS
@@ -1414,6 +1415,81 @@ static int tcpm_pd_send_batt_status(struct tcpm_port *port)
 	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
 }
 
+static int tcpm_pd_send_batt_cap(struct tcpm_port *port)
+{
+	struct pd_message msg;
+	struct power_supply *batt;
+	struct batt_cap_ext_msg bcdb;
+	u32 batt_id = port->batt_request;
+	int ret;
+	union power_supply_propval val;
+	bool batt_present = false;
+	u16 batt_design_cap = BATTERY_PROPERTY_UNKNOWN;
+	u16 batt_charge_cap = BATTERY_PROPERTY_UNKNOWN;
+	u8 data_obj_cnt;
+	/*
+	 * As per USB PD Rev3.1 v1.8, if battery reference is incorrect,
+	 * then set the VID field to 0xffff.
+	 * If VID field is set to 0xffff, always set the PID field to
+	 * 0x0000.
+	 */
+	u16 vid = BATTERY_PROPERTY_UNKNOWN;
+	u16 pid = 0x0;
+
+	memset(&msg, 0, sizeof(msg));
+
+	if (batt_id < MAX_NUM_FIXED_BATT && port->fixed_batt[batt_id]) {
+		batt_present = true;
+		batt = port->fixed_batt[batt_id];
+		ret = power_supply_get_property(batt,
+						POWER_SUPPLY_PROP_USBIF_VENDOR_ID,
+						&val);
+		if (!ret)
+			vid = val.intval;
+
+		if (vid != BATTERY_PROPERTY_UNKNOWN) {
+			ret = power_supply_get_property(batt,
+							POWER_SUPPLY_PROP_USBIF_PRODUCT_ID,
+							&val);
+			if (!ret)
+				pid = val.intval;
+		}
+
+		ret = power_supply_get_property(batt,
+						POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+						&val);
+		if (!ret)
+			batt_design_cap = (u16)(UWH_TO_WH(val.intval) * 10);
+
+		ret = power_supply_get_property(batt,
+						POWER_SUPPLY_PROP_ENERGY_FULL,
+						&val);
+		if (!ret)
+			batt_charge_cap = (u16)(UWH_TO_WH(val.intval) * 10);
+	}
+
+	bcdb.vid = cpu_to_le16(vid);
+	bcdb.pid = cpu_to_le16(pid);
+	bcdb.batt_design_cap = cpu_to_le16(batt_design_cap);
+	bcdb.batt_last_chg_cap = cpu_to_le16(batt_charge_cap);
+	bcdb.batt_type = !batt_present ? BATT_CAP_BATT_TYPE_INVALID_REF : 0;
+	memcpy(msg.ext_msg.data, &bcdb, sizeof(bcdb));
+	msg.ext_msg.header = PD_EXT_HDR_LE(sizeof(bcdb),
+					   0, /* Denotes if request chunk */
+					   0, /* Chunk number */
+					   1  /* Chunked */);
+
+	data_obj_cnt = count_chunked_data_objs(sizeof(bcdb));
+	msg.header = cpu_to_le16(PD_HEADER(PD_EXT_BATT_CAP,
+					   port->pwr_role,
+					   port->data_role,
+					   port->negotiated_rev,
+					   port->message_id,
+					   data_obj_cnt,
+					   1 /* Denotes if ext header */));
+	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
+}
+
 static void mod_tcpm_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
 {
 	if (delay_ms) {
@@ -3711,8 +3787,12 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 		tcpm_pd_handle_msg(port, PD_MSG_DATA_BATT_STATUS,
 				   GETTING_BATTERY_STATUS);
 		break;
-	case PD_EXT_SOURCE_CAP_EXT:
 	case PD_EXT_GET_BATT_CAP:
+		port->batt_request = ext_msg->data[0];
+		tcpm_pd_handle_msg(port, PD_MSG_EXT_BATT_CAP,
+				   GETTING_BATTERY_CAPABILITIES);
+		break;
+	case PD_EXT_SOURCE_CAP_EXT:
 	case PD_EXT_BATT_CAP:
 	case PD_EXT_GET_MANUFACTURER_INFO:
 	case PD_EXT_MANUFACTURER_INFO:
@@ -3921,6 +4001,14 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 					 ret);
 			tcpm_ams_finish(port);
 			break;
+		case PD_MSG_EXT_BATT_CAP:
+			ret = tcpm_pd_send_batt_cap(port);
+			if (ret)
+				tcpm_log(port,
+					 "Failed to send battery cap ret=%d",
+					 ret);
+			tcpm_ams_finish(port);
+			break;
 		default:
 			break;
 		}
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 299e7c20127cd5b7dcdae4f24468df4b34b072b5..791f58b7d1de6c4093fcf38b298e7051ebb6e98c 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -204,6 +204,37 @@ struct pd_message {
 	};
 } __packed;
 
+/*
+ * count_chunked_data_objs: Helper to calculate number of Data Objects on a 4
+ *   byte boundary.
+ * @size: Size of data block for extended message. Should *not* include extended
+ *   header size.
+ */
+static inline u8 count_chunked_data_objs(u32 size)
+{
+	size += offsetof(struct pd_chunked_ext_message_data, data);
+	return ((size / 4) + (size % 4 ? 1 : 0));
+}
+
+/**
+ * batt_cap_ext_msg - Battery capability extended PD message
+ * @vid: Battery Vendor ID (assigned by USB-IF)
+ * @pid: Battery Product ID (assigned by battery or device vendor)
+ * @batt_design_cap: Battery design capacity in 0.1Wh
+ * @batt_last_chg_cap: Battery last full charge capacity in 0.1Wh
+ * @batt_type: Battery Type. bit0 when set indicates invalid battery reference.
+ *             Rest of the bits are reserved.
+ */
+struct batt_cap_ext_msg {
+	__le16 vid;
+	__le16 pid;
+	__le16 batt_design_cap;
+	__le16 batt_last_chg_cap;
+	u8 batt_type;
+} __packed;
+
+#define BATT_CAP_BATT_TYPE_INVALID_REF			BIT(0)
+
 /* PDO: Power Data Object */
 #define PDO_MAX_OBJECTS		7
 

-- 
2.49.0.rc0.332.g42c0ae87b1-goog



