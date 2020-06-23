Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C6204C35
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 10:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbgFWIUu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 04:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbgFWIUt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 04:20:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB266C061573;
        Tue, 23 Jun 2020 01:20:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 136so146851pfv.3;
        Tue, 23 Jun 2020 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koP8iiq5V0iYubfxxOW3PAl1D6rfdr+0Xi18OnqYrhU=;
        b=I56XCJ0vDD0cDoEgQpgYHW/BHpQ9bnklsZp6n/8/HDSB6VXansgA7Ue7eqljfBL0CZ
         ski930bwgB9uUU9KZkYjXuugjccej3VJhJ6JT2/99TK8luqVQziBr0H02+qUgy3cCKNH
         oKqh8sII74JNzA26dcHsRPDiPKRURQ5IBPIXy2PnpovyZ3BdjaN8A4c2URcacX//eNzm
         jOpob1lDVgexe9gg13v4dQYnGzyYDNIDDId7fWtM3NdyWyBb5XoLdvfyGE6GGOBzB/yR
         jK2ogsObfNR6Lf8XFxZKL3vijslvVwGg4HB51iPotTDaQsOJIUCfrnes06hF9T7aZHs2
         WtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koP8iiq5V0iYubfxxOW3PAl1D6rfdr+0Xi18OnqYrhU=;
        b=S2VTjisIZuYn/pFGU5DdboOe9LQbHGvYjCYLEA6HIiqYvoUDQfpTRx5jU9SnGef+M0
         adIBCGSPzaKurb0iCvh25cV5PqoDHtJ8otRHfZEI+gWXdYQ+XQNOZ6Pt7reyjj1UJ2cE
         RCn1KO2O6XsB33ImGfrSJOKllnVMQkvgElXpbyTM7L8zUEWvCEe9WvrBenFkIPaCDVFh
         AjUOTWH3ysQL6dfaD9Y579udO20+1UjqK2Rx/aRuTwgjTv521cD5DbOdg7qWlD8mrwNJ
         Tz2BDkB9gmnYog9sEaI7QFu5sc/gdAk+/aDu8eAYphDzf9uYKPkM6LFfaUmwOKb8Xu4S
         OMww==
X-Gm-Message-State: AOAM531vDRzSWt0rJ4qLxPwEPfEa6X6pskdbOvbKdiexYfegVuWpQeDh
        d8oq989dpr0qKD/69OeVO20=
X-Google-Smtp-Source: ABdhPJzax7O7TAjWcWEeKwyx1toVsaScBfLO1ubCoWtK/zQtkjSbtphT0GTTUg+j2reNUM1XLXYGSw==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr15989398pgb.250.1592900449076;
        Tue, 23 Jun 2020 01:20:49 -0700 (PDT)
Received: from localhost.localdomain (61-231-250-16.dynamic-ip.hinet.net. [61.231.250.16])
        by smtp.googlemail.com with ESMTPSA id g4sm4136602pgn.64.2020.06.23.01.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 01:20:48 -0700 (PDT)
From:   Crag Wang <crag0715@gmail.com>
X-Google-Original-From: Crag Wang <crag_wang@dell.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     mathewk@chromium.org, mario.limonciello@dell.com,
        Crag Wang <crag_wang@dell.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] power_supply: wilco_ec: Add permanent long life charging mode
Date:   Tue, 23 Jun 2020 16:20:16 +0800
Message-Id: <20200623082016.23188-1-crag_wang@dell.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a long life mode for extended warranty battery, switching
to a differnt mode selection is unavailable. The power charging rate
is customized so that battery at work last longer.

Signed-off-by: Crag Wang <crag_wang@dell.com>
---
 Documentation/ABI/testing/sysfs-class-power-wilco | 3 +++
 drivers/power/supply/power_supply_sysfs.c         | 1 +
 drivers/power/supply/wilco-charger.c              | 5 +++++
 include/linux/power_supply.h                      | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Documentation/ABI/testing/sysfs-class-power-wilco
index da1d6ffe5e3c..1c91b17b6fd4 100644
--- a/Documentation/ABI/testing/sysfs-class-power-wilco
+++ b/Documentation/ABI/testing/sysfs-class-power-wilco
@@ -14,6 +14,9 @@ Description:
 			Charging begins when level drops below
 			charge_control_start_threshold, and ceases when
 			level is above charge_control_end_threshold.
+		Permanent Long Life: Last longer battery life, this mode
+			is programmed once in the factory. Switching to a
+			different mode is unavailable.
 
 What:		/sys/class/power_supply/wilco-charger/charge_control_start_threshold
 Date:		April 2019
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bc79560229b5..af3884015ad8 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -87,6 +87,7 @@ static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
 	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	= "Standard",
 	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	= "Adaptive",
 	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
+	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	= "Permanent Long Life",
 };
 
 static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
diff --git a/drivers/power/supply/wilco-charger.c b/drivers/power/supply/wilco-charger.c
index b3c6d7cdd731..713c3018652f 100644
--- a/drivers/power/supply/wilco-charger.c
+++ b/drivers/power/supply/wilco-charger.c
@@ -27,6 +27,7 @@ enum charge_mode {
 	CHARGE_MODE_AC = 3,	/* Mostly AC use, used for Trickle */
 	CHARGE_MODE_AUTO = 4,	/* Used for Adaptive */
 	CHARGE_MODE_CUSTOM = 5,	/* Used for Custom */
+	CHARGE_MODE_LONGLIFE = 6, /* Used for Permanent Long Life */
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
2.20.1

