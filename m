Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C96394858
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 23:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhE1Vbs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1Vbr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 17:31:47 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84DC06174A;
        Fri, 28 May 2021 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tV7/h+PoYnhcjXt3ZDp/OQdbyMacKrmbhRFsOIZmK+o=; b=hocPGQlgTIV8rAPLgGojTEtFGd
        x11BNmTZC6vm28gH+2HTJNeUpQQu7Al7oe/mBfh2YXYndxCPb+o3SCFhTlJCfE0IBGfaQ2HPflR+W
        Y1D7lJlMjC5+CbsEsLA1nYVJrjGoMzvR8LZ1JFwanxpnvoElBcO4cVb2ZA1xJetnd6Es=;
Received: from p200300ccff0cdc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lmk3U-00005h-Br; Fri, 28 May 2021 23:30:08 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lmk3U-0000yT-2u; Fri, 28 May 2021 23:30:08 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] power: supply: rn5t618: Add charger type detection
Date:   Fri, 28 May 2021 23:30:05 +0200
Message-Id: <20210528213006.3695-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210528213006.3695-1-andreas@kemnade.info>
References: <20210528213006.3695-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RC5T619 can detect SDP, CDP and DCP chargers, so let's add support
for it.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/power/supply/rn5t618_power.c | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index dee520f0fdf5..f8f00f67ce4c 100644
--- a/drivers/power/supply/rn5t618_power.c
+++ b/drivers/power/supply/rn5t618_power.c
@@ -37,6 +37,11 @@
 #define CHG_STATE_NO_BAT2	13
 #define CHG_STATE_CHG_READY_VUSB	14
 
+#define GCHGDET_TYPE_MASK 0x30
+#define GCHGDET_TYPE_SDP 0x00
+#define GCHGDET_TYPE_CDP 0x10
+#define GCHGDET_TYPE_DCP 0x20
+
 #define FG_ENABLE 1
 
 struct rn5t618_power_info {
@@ -48,8 +53,16 @@ struct rn5t618_power_info {
 	int irq;
 };
 
+static enum power_supply_usb_type rn5t618_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_SDP,
+	POWER_SUPPLY_USB_TYPE_DCP,
+	POWER_SUPPLY_USB_TYPE_CDP,
+	POWER_SUPPLY_USB_TYPE_UNKNOWN
+};
+
 static enum power_supply_property rn5t618_usb_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
@@ -372,6 +385,33 @@ static int rn5t618_adp_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int rc5t619_usb_get_type(struct rn5t618_power_info *info,
+				union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->rn5t618->regmap, RN5T618_GCHGDET, &regval);
+	if (ret < 0)
+		return ret;
+
+	switch (regval & GCHGDET_TYPE_MASK) {
+	case GCHGDET_TYPE_SDP:
+		val->intval = POWER_SUPPLY_USB_TYPE_SDP;
+		break;
+	case GCHGDET_TYPE_CDP:
+		val->intval = POWER_SUPPLY_USB_TYPE_CDP;
+		break;
+	case GCHGDET_TYPE_DCP:
+		val->intval = POWER_SUPPLY_USB_TYPE_DCP;
+		break;
+	default:
+		val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+	}
+
+	return 0;
+}
+
 static int rn5t618_usb_get_property(struct power_supply *psy,
 				    enum power_supply_property psp,
 				    union power_supply_propval *val)
@@ -401,6 +441,11 @@ static int rn5t618_usb_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 
 		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		if (!online || (info->rn5t618->variant != RC5T619))
+			return -ENODATA;
+
+		return rc5t619_usb_get_type(info, val);
 	default:
 		return -EINVAL;
 	}
@@ -427,6 +472,8 @@ static const struct power_supply_desc rn5t618_adp_desc = {
 static const struct power_supply_desc rn5t618_usb_desc = {
 	.name                   = "rn5t618-usb",
 	.type                   = POWER_SUPPLY_TYPE_USB,
+	.usb_types		= rn5t618_usb_types,
+	.num_usb_types		= ARRAY_SIZE(rn5t618_usb_types),
 	.properties             = rn5t618_usb_props,
 	.num_properties         = ARRAY_SIZE(rn5t618_usb_props),
 	.get_property           = rn5t618_usb_get_property,
-- 
2.29.2

