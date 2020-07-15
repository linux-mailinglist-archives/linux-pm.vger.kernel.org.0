Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B986F22101C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgGOPAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgGOPAs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 11:00:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB01EC061755;
        Wed, 15 Jul 2020 08:00:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x9so2508798plr.2;
        Wed, 15 Jul 2020 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyZvckAjalYpEVUTRpJhb3SKOfP7lUmnicUZX0+4jdM=;
        b=pve2dJx83Ddjv6Utq4oCow6ZdxjjT1Kqmy/tJLv/iVdTWP5yQlY+o63YQUcrr8odBs
         8ud0mWoQzd7MIbt96Bl0r3/v82OPy60LAX+DnIsHOVyLcumwfkbOpMjSCNzNmx6xp+PP
         O3YXpBk7PTsgFrkhbMR98nPYS1L2iihLDc4tZySrMr7Mla5tbj6IOQRwLVUX4CY4pb9S
         egFhHQ8eFTCQZQ/LyDQN2rJE/L8lCJkMZeprrOlTgrGwcz4GHg6L8WmXs78eF5w71vu7
         OGv0xH+2FAnhCwhFtnC84WtUz07W+gNJnuuBhiV7w+e4tOF+p6+TS+LiOieqxYWHKFsj
         LkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyZvckAjalYpEVUTRpJhb3SKOfP7lUmnicUZX0+4jdM=;
        b=d89P4XvnDFD8ZR88DVLuzmFEPgWZgqD3VtQVjLYKJkfvWKcZ4PAR/VUZjR54lJciYY
         ZckuTarFisVXIPBXzMSOj2DSW7utXH4Hw6HgYEVowxc7gIEpy/BROrnR5Hd0PrEnFvJr
         AS7gM6/ygJ3b1g3lZYK+M6wD/cz8SkTXTwCBNkeP/VgqHv/pKRHF5qPqY6wPN4B2wF3g
         +ZxnrXbzP0DTzqW+BgxXLzfxxAezYxaJhqDZVwBqvGmQreOiuiPxkmcQJ52wnpjZJRMS
         Axxw94GYXGhSXEGrUrA6PdqG9NerLdENtquXEIvAe3avAny1oxro9b7B3CbqJ8COwirI
         p3sA==
X-Gm-Message-State: AOAM5305lTMRkxy0/3YpymJJ/v3GRty3C7aG2Vd7rad89VXUCH1ZV9yG
        CqOQz+be3p56dmYJ4nYd2tM=
X-Google-Smtp-Source: ABdhPJyUw09w57UjhtR78T3NcaMKWAbNcNl9uUQJklcEpqGfP5VCZY2ZOvRoRgaFPoXrJagLon1rWw==
X-Received: by 2002:a17:902:9f8e:: with SMTP id g14mr5873452plq.248.1594825248042;
        Wed, 15 Jul 2020 08:00:48 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-5c02-f0e1-dcc0-f223-b5cd-3164.dynamic-ip6.hinet.net. [2001:b011:5c02:f0e1:dcc0:f223:b5cd:3164])
        by smtp.googlemail.com with ESMTPSA id j2sm2665pjy.1.2020.07.15.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:00:47 -0700 (PDT)
From:   Crag Wang <crag0715@gmail.com>
X-Google-Original-From: Crag Wang <crag.wang@dell.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     mathewk@chromium.org, mario.limonciello@dell.com,
        campello@google.com, Crag Wang <crag.wang@dell.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/1] power_supply: wilco_ec: Add permanent long life charging mode
Date:   Wed, 15 Jul 2020 22:55:12 +0800
Message-Id: <20200715145511.9464-1-crag.wang@dell.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.17.1

---
The original author, Nick no longer being around and that's why he's not on CC.
