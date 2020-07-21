Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08E227F87
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 14:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgGUMCA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbgGUMB7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 08:01:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7357FC061794;
        Tue, 21 Jul 2020 05:01:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so10167519ple.0;
        Tue, 21 Jul 2020 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAZYRb+PrT/mXje3lSf2lwL9NTMcJfHXcPNcCCFolq0=;
        b=EL3PWDB/nmsb+QCJsVBuhywoXEwMPV30+j6BfgpVi3YHLRUXYqnwcatQKBI7bh+Qak
         gF2s0MJE+r+MMaNr3XXHfrn/GfuAXSRX5EI/8H6HlVQnY/VK9YEfE9xEIrj1NC033pBb
         wukGEsk30IdYq+zfFq4/RpYdJDSvshTuBGHOSZX5Rf1ceTHArzrjFg9xCkGpu3L9/ZC3
         W+LaRrc16n8yCOjJcyBkYLP2moBn5pYbzkGqrTkrb6SIVXxUB+lIESKUzWEuyl8xRnka
         eQOfWh2Wb9jRDIDjpG6BNWX0DC4lCYcusYLfwVrDzRdlaqAT7zkNpRsEfvO8l46dEfKw
         ggeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAZYRb+PrT/mXje3lSf2lwL9NTMcJfHXcPNcCCFolq0=;
        b=OiSVQh/NehJf5n0Swg8SqjsZX7JChtsesKs/upfeQzPkMkDI0yv4NnCmF7VDy21Pgw
         lEKRFR158WgbBZn7Vz5O7eYeuQ61ccRYud57dh/bJsdrguvLf47v20zumI4QlwW4Wnxo
         c4vaDLLFojJz3WA5hEi7J77rdq20QVK/L0vEI7eoD58CGg/bn/CGwkxe5wDRCYiRrsP9
         hdE3V/3kq0lvzJ2zXWOuvV9Y169qgVtFEDwYLn+mKjK7jKjGUDIT49uHnk052OlUdI6T
         U3wf8j+ZTzvTWhxB7kEaHF9GyyjG9wAIoplNNVFfvsT60cDcQ58tIWYTPvEP/F4rGicd
         aAMw==
X-Gm-Message-State: AOAM532jPkZx0/CidEEIuTy7iOkqwvS/HQI+JkpTCHucA9gkGf6kEWnC
        Vrn0q9nuPZZ+QeExstGEM0w=
X-Google-Smtp-Source: ABdhPJzWzYDhxhhJf5lsmqAlkWLVIr00WE0HO4SCNt+5bGtB1hLn4G8zjd1T5r+bu7V5zKblDaGY1g==
X-Received: by 2002:a17:90a:e981:: with SMTP id v1mr4380038pjy.130.1595332919084;
        Tue, 21 Jul 2020 05:01:59 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id t73sm20542041pfc.78.2020.07.21.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 05:01:58 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v7 4/4] power: supply: core: property to control reverse charge
Date:   Tue, 21 Jul 2020 19:59:42 +0800
Message-Id: <4be88d40096623f9e6c498880db0cb3c8fe057ff.1595332392.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595332392.git.huangqiwu@xiaomi.com>
References: <cover.1595332392.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Interface to control wireless reverse charge.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 4459b720feb2..8840fdf483a7 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -779,3 +779,17 @@ Description:
 
 		Access: Read-Only
 		Valid values: 0 - 100
+
+What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Some devices support wireless reverse charge function which
+		charge other devices.The property provider interface to
+		enable/disable wireless reverse charge.If enabled, start TX
+		mode and detect RX. Disabled when timeout or manual setting.
+
+		Access: Read, Write
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

