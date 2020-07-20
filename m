Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64DF22573A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 07:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGTFti (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 01:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGTFtf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 01:49:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D5C0619D2;
        Sun, 19 Jul 2020 22:49:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so9628850pjb.5;
        Sun, 19 Jul 2020 22:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rt6OILtoXvarYoblULhOIeiZp6zLUqn8NzrZ6DwL+ac=;
        b=RUh908du2UYyA6IAU3v8E23q04X07RbU6Iqf+AENKn17x7WSb6pMDGM+KXsWBnPVDJ
         Ig6+AyqAKKhSwOdViBOzzeGhuxX4Q1MdzQsDcd7jrW5D0YS9/YUqWo7YGzkG9zhInVWN
         m7Q5kroEBQHDw23B8F2h640vEP3HQWs6gcUUPnVFy32/u7TXEe3lrLn3Rsvfrir28Dgw
         cwaA7fkP6yndWgBGzOYL5yGQC1QT38DPnblesWeabs7qBMnu0SsghDgTaHZ2eTefLLOf
         hTpjorNWOTqaCDQe1n0R5IcNlITeyBrKsZEAPrjLr+/hsz/AWHT3UTlL5012NJFslBtK
         Yl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rt6OILtoXvarYoblULhOIeiZp6zLUqn8NzrZ6DwL+ac=;
        b=IutbSYQfg3d2L8MtwgFc6dH9G2lkfKrRJRFMNYzoq4tk+Dc103o9v0hwpEiyWT6RQ2
         ceOrdZm1hpbSvMIJGAvyIu7XUFFU1s7CeKBrFAq9svXvxlyW9zUr625yKKuipydq8/HF
         qPtpsc6hoGNLtvQvqqcDKqib6CdV/w5eyqh48gn9H8/D8w6tqO6yomVpTPYpq3vsdmMF
         IvDWlPFP64/35kwtaXtxIe1Zdypnkj/QSChZ0EuFwFmlR8DWtNtSx2+6ljuZrG3L1oC7
         IhfMei055Ozx7hiq2ejGOV332XbzERzkeqGUM88eK4SQAuvGsm507omQYevO5EN4pn0t
         dKsw==
X-Gm-Message-State: AOAM533vFkhn85fW7Y85zS/Im/G273oigsD9SuAtk7X6fsgduP9MKrvU
        yYI+v+QOTdxAifqdkPISvuQ=
X-Google-Smtp-Source: ABdhPJxsUWnVdZg6qm6GkcO+VPwBbwDSozWg2eYY+0aC+Mpp6qBWPWbs4nLwZzWuL0OyPQ+8+eW00Q==
X-Received: by 2002:a17:90a:f007:: with SMTP id bt7mr21843561pjb.214.1595224174619;
        Sun, 19 Jul 2020 22:49:34 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id i7sm13627833pgh.58.2020.07.19.22.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 22:49:34 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v4 4/4] power: supply: core: property to control reverse charge
Date:   Mon, 20 Jul 2020 13:47:17 +0800
Message-Id: <a4569ee18bddc8630317a047b91c55ba22b8d051.1595214246.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595214246.git.huangqiwu@xiaomi.com>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
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

