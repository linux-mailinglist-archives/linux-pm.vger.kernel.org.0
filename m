Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8669D232A5B
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 05:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgG3D0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 23:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgG3D0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 23:26:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1FBC061794;
        Wed, 29 Jul 2020 20:26:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d4so15745693pgk.4;
        Wed, 29 Jul 2020 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D3DSMcxAJBfVCzQ9tsL41B8n4WlMAXQgIZRXZY0d2fk=;
        b=nhdvWdsp7OTR0ia6J6e7mP+rRJPbscgtYGVXox9eFXX3AXYXtIFRhNtuIFMGwApCRt
         R/F6hAs2mBWQWItzVF85rWwDmVd3czfqDU9hK2Wsc68Ko/7JhV+teJiyvZqirGcD44gq
         e191U0iXU/NNh6ZNa7ZrVVQr8AFex6SGGl674lMl4e4hNY+CTRetN/xafVmD31u7fGIH
         dBwp3Yrx9uZjeoOLJhYD6FGXrMSJBh8QBkTUbZKjVCbn58scMKJ4ua99D/BL0OAz5fT9
         yE6obEuznxRklacfwVrGi7TEu12I4q6jyRNm5sfG0eHWrK5n2lgxg0fwEYiLCTKUF1T3
         nX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D3DSMcxAJBfVCzQ9tsL41B8n4WlMAXQgIZRXZY0d2fk=;
        b=MCsuFLkeyk59Xbhs2bQc7g8isG3xByhoF2WWkY9LQjhk/fSslgOb7fzRJhC9PbEwqF
         nFddEE5KqavOiq+ySZc9sGfi7uLUHl2pdrh4SwRfQnYsT9ifCxSL7e/QEIyasXI+w9YP
         FE6UqNTuTtDKnqbBz3X0iScfzVOubDNHxI2dyn7EZ/dVBDPkn8fAVErU0euMLV3prGEW
         gJkaG/x3EUX09ItJcs2f6VjPO6PaYU2rsZdWy4TP9UzVZeFV8J1yXnT2eEGPo17tpi3/
         zS20/uuB+00HlkQkwNV2VWjEvQrRk/aRm191M/TZ4XdigySANEXAhmMmFIr2B+5XXMfa
         N2BQ==
X-Gm-Message-State: AOAM530+jqc8K3Pd2QWcVR6ehJFETkqwFvkqFBwgDlXPeEFIJo+WLBd1
        SB7JQtFyqN8j1JvoiCt8LLk=
X-Google-Smtp-Source: ABdhPJw1twExWZX4O4IqbAvyOz0gO0V+d8bMgclMUGMPZ3r6fvpxEQH8YriW+0ywdxR5zw0JVoXY6Q==
X-Received: by 2002:a63:215e:: with SMTP id s30mr30435034pgm.87.1596079602914;
        Wed, 29 Jul 2020 20:26:42 -0700 (PDT)
Received: from localhost.localdomain ([132.237.175.251])
        by smtp.googlemail.com with ESMTPSA id d29sm3978964pgb.54.2020.07.29.20.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 20:26:42 -0700 (PDT)
From:   Crag Wang <crag0715@gmail.com>
X-Google-Original-From: Crag Wang <crag.wang@dell.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     mario.limonciello@dell.com, mathewk@chromium.org,
        campello@google.com, crag.wang@dell.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] power_supply: wilco_ec: Add long life charging mode
Date:   Thu, 30 Jul 2020 11:26:09 +0800
Message-Id: <20200730032609.20330-1-crag.wang@dell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715145511.9464-1-crag.wang@dell.com>
References: <20200715145511.9464-1-crag.wang@dell.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a long life mode set in the factory for extended warranty
battery, the power charging rate is customized so that battery at
work last longer.

Presently switching to a different battery charging mode is through
EC PID 0x0710 to configure the battery firmware, this operation will
be blocked by EC with failure code 0x01 when PLL mode is already
in use.

Signed-off-by: Crag Wang <crag.wang@dell.com>
Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
---
 Documentation/ABI/testing/sysfs-class-power-wilco | 4 ++++
 drivers/power/supply/power_supply_sysfs.c         | 1 +
 drivers/power/supply/wilco-charger.c              | 5 +++++
 include/linux/power_supply.h                      | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Documentation/ABI/testing/sysfs-class-power-wilco
index da1d6ffe5e3c..84fde1d0ada0 100644
--- a/Documentation/ABI/testing/sysfs-class-power-wilco
+++ b/Documentation/ABI/testing/sysfs-class-power-wilco
@@ -14,6 +14,10 @@ Description:
 			Charging begins when level drops below
 			charge_control_start_threshold, and ceases when
 			level is above charge_control_end_threshold.
+		Long Life: Customized charge rate for last longer battery life.
+			On Wilco device this mode is pre-configured in the factory
+			through EC's private PID. Swiching to a different mode will
+			be denied by Wilco EC when Long Life mode is enabled.
 
 What:		/sys/class/power_supply/wilco-charger/charge_control_start_threshold
 Date:		April 2019
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bc79560229b5..cfb87b8b8392 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -87,6 +87,7 @@ static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
 	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	= "Standard",
 	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	= "Adaptive",
 	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
+	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	= "Long Life",
 };
 
 static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
diff --git a/drivers/power/supply/wilco-charger.c b/drivers/power/supply/wilco-charger.c
index b3c6d7cdd731..98ade073ef05 100644
--- a/drivers/power/supply/wilco-charger.c
+++ b/drivers/power/supply/wilco-charger.c
@@ -27,6 +27,7 @@ enum charge_mode {
 	CHARGE_MODE_AC = 3,	/* Mostly AC use, used for Trickle */
 	CHARGE_MODE_AUTO = 4,	/* Used for Adaptive */
 	CHARGE_MODE_CUSTOM = 5,	/* Used for Custom */
+	CHARGE_MODE_LONGLIFE = 6, /* Used for Long Life */
 };
 
 #define CHARGE_LOWER_LIMIT_MIN	50
@@ -48,6 +49,8 @@ static int psp_val_to_charge_mode(int psp_val)
 		return CHARGE_MODE_AUTO;
 	case POWER_SUPPLY_CHARGE_TYPE_CUSTOM:
 		return CHARGE_MODE_CUSTOM;
+	case POWER_SUPPLY_CHARGE_TYPE_LONGLIFE:
+		return CHARGE_MODE_LONGLIFE;
 	default:
 		return -EINVAL;
 	}
@@ -67,6 +70,8 @@ static int charge_mode_to_psp_val(enum charge_mode mode)
 		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
 	case CHARGE_MODE_CUSTOM:
 		return POWER_SUPPLY_CHARGE_TYPE_CUSTOM;
+	case CHARGE_MODE_LONGLIFE:
+		return POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ac1345a48ad0..528a3eaa2320 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -48,6 +48,7 @@ enum {
 	POWER_SUPPLY_CHARGE_TYPE_STANDARD,	/* normal speed */
 	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
 	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
+	POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,	/* slow speed, longer life */
 };
 
 enum {
-- 
2.17.1

---
The original author, Nick no longer being around and that's why he's not on CC.
