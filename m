Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F441538D5
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 20:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBETQC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 14:16:02 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51245 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBETQB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Feb 2020 14:16:01 -0500
Received: by mail-pj1-f67.google.com with SMTP id fa20so1390936pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Feb 2020 11:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPp9Gmhj2cF1IstMivGoYruay4MMAEySBBRvQNc3tFE=;
        b=UEshAyi20/ovB4AxFE5PMGgdWWjm1e6fSbVxqLH+Vc0w3jDG0CRuwUd53cu3vjWKDV
         qEX0mY7n4YVjHxxztnnK9GewKRucMde/wvX3qH8eaRXe44/SnFb/ML1Ep+EecP8W4RKq
         OmI9jFyX42JmSPFGUlgU+41In0Ykg3M0YrteY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPp9Gmhj2cF1IstMivGoYruay4MMAEySBBRvQNc3tFE=;
        b=o3FF9NOq8UQv6YCUe2qCNsa5fpfvwwPPWNUNzcyeVx2LvO+K4ys5BFHCKbRY6ywlPq
         vsCgOzTCk7CrRlqHDq8Nmol4f1HrB4/+aycp+AlCO8ks1Z720GZxdiUrL6wNrs0Ulg4V
         6aLUWnmKz1PNgAv9axtlrvmzrxhobc97gxP87QNSBl8nTpKa82hb30aJEZuini3wbmMu
         lKwY1nz+NFfnsqk2HKSxfVnEjsgiH7/etrtk9i1NniQywHHD2LiBHLI2b9ZLFl3D4dCL
         yVXWBWz3I8jsWSVfBHtWtLL93SVbASB0b5BPthMqLHQ9Hgp+on1wNdSiC5HSAwDDCGOV
         sfTw==
X-Gm-Message-State: APjAAAXm77XUjlPZ6/op76bwO1dzJslWGVxiX4fV1LgBp61L0hnf9W/6
        iUtyrzJA18CCHbib8IBxjBAjtg==
X-Google-Smtp-Source: APXvYqxC0Noni/S+rU8ziz+O05CShNRqv+NSDgJXcxj2zTEN9E28pPbFTiQFfO34L5qiSP7/GxbTUA==
X-Received: by 2002:a17:902:7790:: with SMTP id o16mr35507957pll.271.1580930160932;
        Wed, 05 Feb 2020 11:16:00 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:16:00 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and
        DRIVERS)
Subject: [PATCH v2 12/17] power: supply: cros: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:18 -0800
Message-Id: <20200205190028.183069-13-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace cros_usbpd_charger_ec_command() with cros_ec_cmd() which does
the same thing, but is defined in a common location in platform/chrome
and exposed for other modules to use. This allows us to remove
cros_usbpd_charger_ec_command() entirely.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/power/supply/cros_usbpd-charger.c | 58 ++++-------------------
 1 file changed, 10 insertions(+), 48 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 30c3d37511c9e1..4631d96fda2ca1 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -91,46 +91,13 @@ static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
 	return port->port_number >= port->charger->num_usbpd_ports;
 }
 
-static int cros_usbpd_charger_ec_command(struct charger_data *charger,
-					 unsigned int version,
-					 unsigned int command,
-					 void *outdata,
-					 unsigned int outsize,
-					 void *indata,
-					 unsigned int insize)
-{
-	struct cros_ec_dev *ec_dev = charger->ec_dev;
-	struct cros_ec_command *msg;
-	int ret;
-
-	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->version = version;
-	msg->command = ec_dev->cmd_offset + command;
-	msg->outsize = outsize;
-	msg->insize = insize;
-
-	if (outsize)
-		memcpy(msg->data, outdata, outsize);
-
-	ret = cros_ec_cmd_xfer_status(charger->ec_device, msg);
-	if (ret >= 0 && insize)
-		memcpy(indata, msg->data, insize);
-
-	kfree(msg);
-	return ret;
-}
-
 static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
 {
 	struct ec_response_charge_port_count resp;
 	int ret;
 
-	ret = cros_usbpd_charger_ec_command(charger, 0,
-					    EC_CMD_CHARGE_PORT_COUNT,
-					    NULL, 0, &resp, sizeof(resp));
+	ret = cros_ec_cmd(charger->ec_device, 0, EC_CMD_CHARGE_PORT_COUNT, NULL,
+			  0, &resp, sizeof(resp), NULL);
 	if (ret < 0)
 		return ret;
 
@@ -142,8 +109,8 @@ static int cros_usbpd_charger_get_usbpd_num_ports(struct charger_data *charger)
 	struct ec_response_usb_pd_ports resp;
 	int ret;
 
-	ret = cros_usbpd_charger_ec_command(charger, 0, EC_CMD_USB_PD_PORTS,
-					    NULL, 0, &resp, sizeof(resp));
+	ret = cros_ec_cmd(charger->ec_device, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
+			  &resp, sizeof(resp), NULL);
 	if (ret < 0)
 		return ret;
 
@@ -159,10 +126,8 @@ static int cros_usbpd_charger_get_discovery_info(struct port_data *port)
 
 	req.port = port->port_number;
 
-	ret = cros_usbpd_charger_ec_command(charger, 0,
-					    EC_CMD_USB_PD_DISCOVERY,
-					    &req, sizeof(req),
-					    &resp, sizeof(resp));
+	ret = cros_ec_cmd(charger->ec_device, 0, EC_CMD_USB_PD_DISCOVERY, &req,
+			  sizeof(req), &resp, sizeof(resp), NULL);
 	if (ret < 0) {
 		dev_err(charger->dev,
 			"Unable to query discovery info (err:0x%x)\n", ret);
@@ -189,10 +154,8 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
 	int ret;
 
 	req.port = port->port_number;
-	ret = cros_usbpd_charger_ec_command(charger, 0,
-					    EC_CMD_USB_PD_POWER_INFO,
-					    &req, sizeof(req),
-					    &resp, sizeof(resp));
+	ret = cros_ec_cmd(charger->ec_device, 0, EC_CMD_USB_PD_POWER_INFO, &req,
+			  sizeof(req), &resp, sizeof(resp), NULL);
 	if (ret < 0) {
 		dev_err(dev, "Unable to query PD power info (err:0x%x)\n", ret);
 		return ret;
@@ -334,9 +297,8 @@ static int cros_usbpd_charger_set_ext_power_limit(struct charger_data *charger,
 	req.current_lim = current_lim;
 	req.voltage_lim = voltage_lim;
 
-	ret = cros_usbpd_charger_ec_command(charger, 0,
-					    EC_CMD_EXTERNAL_POWER_LIMIT,
-					    &req, sizeof(req), NULL, 0);
+	ret = cros_ec_cmd(charger->ec_device, 0, EC_CMD_EXTERNAL_POWER_LIMIT,
+			  &req, sizeof(req), NULL, 0, NULL);
 	if (ret < 0)
 		dev_err(charger->dev,
 			"Unable to set the 'External Power Limit': %d\n", ret);
-- 
2.25.0.341.g760bfbb309-goog

