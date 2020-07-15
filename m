Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF443220160
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 02:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGOAiE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 20:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgGOAiD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 20:38:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9FCC061755;
        Tue, 14 Jul 2020 17:38:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s189so557181pgc.13;
        Tue, 14 Jul 2020 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rt6OILtoXvarYoblULhOIeiZp6zLUqn8NzrZ6DwL+ac=;
        b=hAuSkYWLpepL/JQgoD2wPZ71HnWhAGnjXtBKgydftWueHQEOy8ys0qOvIfFgP6jV0M
         swauscu1gklSi/6BK7BrXT2fsdAbQPflj6noB804Gbe3+uvwMg98lli1Uvf/xQQtXLzC
         h/aBHaIrHgN74ZUzSc+qZBmP4K09djxQwyHvRdUEgAW8vp6X/zbG97egV8883SyRTFrP
         /CZpB8srEAPBNuQ3Y3dYr+C9+Fg2GMc4xTQT3Lp4RVYCvdRLUIfw1ZVxIvSZ5xsDgs0u
         001e1oT9mO92eywqfzr3XLCMPNN6STp9OPfkP/qzvtYocFK+s7b2J0bJ/oQjcEzX9C3X
         4orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rt6OILtoXvarYoblULhOIeiZp6zLUqn8NzrZ6DwL+ac=;
        b=CkMTS5R34KHSM2aO6mKyq7Djd9B/NWyx0P1ZjkB1INtkdq8hxj12yqEpVPNHqX77Ji
         +UTYMJ0hpW7wgwF1T9R3kKJeZhVtwkeYs9Xj1ksWvYQOLfFMUVd7F2Aa+ZhCUQa27eY+
         FM/Ob0J49t1BcuYzVbj7wkvml80IbiS2zourVsdJOd8ZHH2Po56hmZ9n4yqKhqwW3bwa
         h45RveY2buFtMjgQl5kXjD9b3aHAaQ5GiNg7w6YLsBRbaCuFcqs4rCdWQzHmmb0+eYIO
         LPftAOmSzdCwOwT6Lotvepn/uwexeuSLKbHHOUMnYsy2XiKqIjM6T9RU11FdGhWO0LMm
         +ISQ==
X-Gm-Message-State: AOAM533BSl0leORFl6JTb1VOxUt2o6Hgdj+2TAQy7ULlQuFufSCeZJFV
        a84DwkV6ru8g3ORh41SCTz0=
X-Google-Smtp-Source: ABdhPJzWBU0KP62MHedyapBfwilvgUrk17Yurf/rRBYmxzAHPBsCHLcaObPhXqqb2Wqaa8DQiLkfhg==
X-Received: by 2002:a63:e04c:: with SMTP id n12mr5278646pgj.388.1594773483237;
        Tue, 14 Jul 2020 17:38:03 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id t126sm266156pfd.214.2020.07.14.17.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 17:38:02 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v3 4/5] power: supply: core: property to control reverse charge
Date:   Wed, 15 Jul 2020 08:35:22 +0800
Message-Id: <b43693e2e39b453b5089839860473680733be12e.1594726859.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594726859.git.huangqiwu@xiaomi.com>
References: <cover.1594726859.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Interface to control wireless reverse charge.
Supply reverse charge function when enabled.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 12 ++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 75ec7de2fe78..54647d6995d3 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -767,3 +767,15 @@ Description:
 
 		Access: Read-Only
 		Valid values: 0 - 100
+
+What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Some phones support wireless reverse charge function which charge other phones.
+		The property supply interface to control wireless reverse charge.
+		If enabled, start TX mode and detect RX. Disabled when timeout or manual setting.
+
+		Valid values:
+		- 1: enabled
+		- 0: disabled
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index e420a453095e..81916b6b6ccf 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -209,6 +209,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
 	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
+	POWER_SUPPLY_ATTR(REVERSE_CHG_MODE),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 346c6c9c0737..a87ae1fff8d1 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -170,6 +170,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
 	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
+	POWER_SUPPLY_PROP_REVERSE_CHG_MODE,
 };
 
 enum power_supply_type {
-- 
2.27.0

