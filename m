Return-Path: <linux-pm+bounces-35755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1943ABBFD05
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 02:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA2EC4F33C4
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2727B218AB9;
	Tue,  7 Oct 2025 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUI/xleg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821462192F2
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795222; cv=none; b=tFDQFNNsOHc0IW4hNJj9xg2NnrBtxcq43hNdR5Bbpnj0F2Y0RhACpeYUiF6el/COARW264+ZIJPkVaC7qUF6a8C3GmuX8z6MaDcr6q4eIMZT1QgHIthzPBEu/RZ15BZEe5znHolwD6kdKBz7kGpRgxdC8tOVGS7EtxJoCaaN0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795222; c=relaxed/simple;
	bh=Str9fH8hydrNHWjtKguZVPS+zITiFbgB/SOHaQ7ym60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHeZk0UDfj88ysFwiv8YmHw6HhkL5sAI/z8kgIP78E72KrstbB/vKdCG8IZMVGv2Rny7B5ycjsqo5Btsjt5Ah19eyd2MmBAtBAfCz6QeUTEFw4xmO7dffcwcWLJKqkjsxujv9Te7oDdP10OCNHB419zVR+5HiIjeJB+vSemEj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUI/xleg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28eb14e3cafso42171575ad.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 17:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795220; x=1760400020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/Ntr7wFteVMdK8qe86TO1gtoCOtxfr/CBl4A1p6Hm4=;
        b=eUI/xlegB2JXM9JWFGmDeRla2Ixt/2WrSKCQOBblp3R0vf8vPV3giV2NFSk3w+1a+F
         lVRurb8rlAc5/xkzHYfCPoqtq1xkUK/0Ex+PPhYDa+reSSL7OfBLWHLyP9mLOeLFeggm
         Np6Yj1smpoA1cxTU8HQ90lrzQddbVIZHuGdt7ReFZFpPr+NZk0rwON44IUpy8xcjJInH
         AwQQgtn4JsLP6jkz61aIp6GjU5X5BjAlRIX+ySuTqRC/HuNsehqKkxBnUoAYjxxrylZX
         Zhd6kq5EWzTwEJhhPWWP80yS3RU47roWkbEkInrRgtE/W2xo0JYpoWJq2aOLViemiRp6
         ZLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795220; x=1760400020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/Ntr7wFteVMdK8qe86TO1gtoCOtxfr/CBl4A1p6Hm4=;
        b=iUGej9nkw9HstZrOM6M+PqASaOz19ZeZE+1mZj0xP5dqQcY/FHm+CDa6fZ/A8OAqY0
         5r5S0KaA2PB3VeVlP6SapD/hxn4DCnFqc8tVQ0z9rgk8b+p9gUkp9cscldRmoh2VtKO4
         V82bz6H82JsJ4QwQ2QDiwYMArJocQeccMIdCtIsCKZQNHZuY6xv799OX7y3f7O9YIdDK
         koMU40iZBXRfoLz/yFlEb9UZano8DZbrpVtN0xdpIJWroaTIo4fg8+VF8Sv0EJs8rLYg
         Lbz2XUiJfvVRI8chl+mKtWIhUjYMf8MuC3ewoe8Rb4DCi5FL6K20FyEAeGHaC3tyN1kQ
         lo9g==
X-Forwarded-Encrypted: i=1; AJvYcCXDA000slxg557tbM2PscIoAZdmC+IKIesLng5let2iDO/gt8rbiiXcEXOjoUCFkeV6SL5thbCQog==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOk0dkXnOHnS65bOcwI+wxJ9B9rE0iYthKpenmLnjmNT99HZD
	eF/bQ3sCC3orauAh/mh/HszXp71c7b69WvMNPmVBDQ6aRbwGSKWfVFipR6fqElMxLrav0bbQdEi
	rXffzdg==
X-Google-Smtp-Source: AGHT+IGtj1LUUjLYbsIMAV2GwYOXjjJ8onhXCjB5EWGPd6ipgp/twyTqetktTXVYLm7pESak4E3PvR4IS0U=
X-Received: from plcs4.prod.google.com ([2002:a17:903:30c4:b0:28e:cc8d:f602])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b63:b0:281:613:844b
 with SMTP id d9443c01a7336-28e9a6b1988mr189582965ad.52.1759795219487; Mon, 06
 Oct 2025 17:00:19 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:00:02 +0000
In-Reply-To: <20251007000007.3724229-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007000007.3724229-2-jthies@google.com>
Subject: [PATCH 1/6] usb: typec: ucsi: psy: Add power supply status
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jthies@google.com, dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for power supply status. If a port is acting as a sink
with the sink path enabled, report it is charging. If a port is
source, report it is discharging. If there is no connection or the
port hasn't enabled the sink path, report not charging.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/psy.c  | 26 ++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 62a9d68bb66d..2b0225821502 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -29,6 +29,7 @@ static enum power_supply_property ucsi_psy_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
 };
 
 static int ucsi_psy_get_scope(struct ucsi_connector *con,
@@ -51,6 +52,29 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
 	return 0;
 }
 
+static int ucsi_psy_get_status(struct ucsi_connector *con,
+			       union power_supply_propval *val)
+{
+	bool is_sink = UCSI_CONSTAT(con, PWR_DIR) == TYPEC_SINK;
+	bool sink_path_enabled = true;
+
+	val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	if (con->ucsi->version >= UCSI_VERSION_2_0)
+		sink_path_enabled =
+			UCSI_CONSTAT(con, SINK_PATH_STATUS_V2_0) ==
+			UCSI_CONSTAT_SINK_PATH_ENABLED;
+
+	if (UCSI_CONSTAT(con, CONNECTED)) {
+		if (is_sink && sink_path_enabled)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (!is_sink)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+	}
+
+	return 0;
+}
+
 static int ucsi_psy_get_online(struct ucsi_connector *con,
 			       union power_supply_propval *val)
 {
@@ -245,6 +269,8 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
 		return ucsi_psy_get_current_now(con, val);
 	case POWER_SUPPLY_PROP_SCOPE:
 		return ucsi_psy_get_scope(con, val);
+	case POWER_SUPPLY_PROP_STATUS:
+		return ucsi_psy_get_status(con, val);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index e301d9012936..cce93af7461b 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -360,6 +360,9 @@ struct ucsi_cable_property {
 #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
 #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
 #define UCSI_CONSTAT_PD_VERSION_V1_2		UCSI_DECLARE_BITFIELD_V1_2(70, 16)
+#define UCSI_CONSTAT_SINK_PATH_STATUS_V2_0	UCSI_DECLARE_BITFIELD_V2_0(87, 1)
+#define   UCSI_CONSTAT_SINK_PATH_DISABLED   0
+#define   UCSI_CONSTAT_SINK_PATH_ENABLED    1
 #define UCSI_CONSTAT_PWR_READING_READY_V2_1	UCSI_DECLARE_BITFIELD_V2_1(89, 1)
 #define UCSI_CONSTAT_CURRENT_SCALE_V2_1		UCSI_DECLARE_BITFIELD_V2_1(90, 3)
 #define UCSI_CONSTAT_PEAK_CURRENT_V2_1		UCSI_DECLARE_BITFIELD_V2_1(93, 16)
-- 
2.51.0.618.g983fd99d29-goog


