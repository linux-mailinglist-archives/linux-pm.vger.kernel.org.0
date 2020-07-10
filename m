Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE10121B1AD
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgGJIvY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 04:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgGJIvV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 04:51:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E7C08C5CE;
        Fri, 10 Jul 2020 01:51:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so2264410pfu.3;
        Fri, 10 Jul 2020 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTAVrRJ9QWhqud7VfQjqhWH/p7Udl1Qo+dA09f35eBs=;
        b=Kk9VzAp8Ns2yOLV1RhD6yz5VHbvKSLTX6eSyVMgUJXRx8lWCUawdekOYX5zcMooa/u
         BZzIz0Xct1mbzHdWsC2hqMTyuFpmq4DjDKgYD8o/yAgBJp2QBB+HT5bnZyYU2wgCOOxv
         5e8auVoIVVk5JLNm0M0ZMFNu4qsSrBMnQ+EBVUtA2fTjrbsxZHRBTEBxGbh1m3OfEkc+
         fDy3qWMgMI2WusTMfLIuVihs9kKG5eHBYAqsFJvVqDhqOyO0sl+Ar0+dEUSwTwwqeU+W
         6IokRPN9gUQ9CqLfhPLkSaeK8udQjFTZKshRwk4D8LxJyIEiRA4KjFi26kssKKKArqVI
         0hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTAVrRJ9QWhqud7VfQjqhWH/p7Udl1Qo+dA09f35eBs=;
        b=X4t5U8TePR2C6uyFkDCSu2xK24mQn1NPletFajo9SUBlqo8n97drpTIPmvp4DZIL9V
         1zgiroXrshX8oPlh/62a5SqsVAf6Dvy7Tqb2Q/7ClhybGBSgYzrvpb82z9xfk1veIryc
         D4jS/pHg+uv7T8NUdpCo2EehmFaNjAkuzVds+qbiqnXG1Zv3/Q+qK13HqL3SVlR6Vxhn
         TP4KmBgoQVuDLN0Bay35b3sDys6NTUIT/uvt+7FcAwdwv0Cvyff88r550gCJ+oEhDW26
         ZFwIT2YwNx+pM2KBPFSsjQqag93MW9ZgFJnke1QjXlIYx41QCSNvLHoNictZzvxARnxj
         BkYQ==
X-Gm-Message-State: AOAM5329lnk2qHxsmATuo0DQ2/KEFbrel/U0HjfS19ZOSwecstLjfHFI
        WAFiYRJNG94P+l+mpsfiFeI=
X-Google-Smtp-Source: ABdhPJyqCsONmXknLpBTIfwsQXGg9wqXJAQMiLN+AumEKJMuL7ghYkgeulfRg+AcJLNGcjwn8q/hCg==
X-Received: by 2002:aa7:8ac3:: with SMTP id b3mr65610184pfd.45.1594371080781;
        Fri, 10 Jul 2020 01:51:20 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id e8sm4734273pff.185.2020.07.10.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:51:20 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH 5/5] power: supply: core: supply battery soc with decimal form
Date:   Fri, 10 Jul 2020 16:48:41 +0800
Message-Id: <20200710084841.1933254-5-yanziily@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710084841.1933254-1-yanziily@gmail.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Broadcast battery soc with decimal form.
soc_decimal is the decimal part of battery soc.
soc_decimal_rate is update frequency of decimal
part of battery soc.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  2 ++
 include/linux/power_supply.h                |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 1f489a250c19..60c5a0dd1b98 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -349,6 +349,26 @@ Description:
 		Access: Read
 		Valid values: Represented in microvolts
 
+What:		/sys/class/power_supply/<supply_name>/soc_decimal,
+Date:		Jul 2020
+Contact:	jiangfei1@xiaomi.com
+Description:
+		Broadcast battery soc with decimal form.
+		soc_decimal is the start decimal part of battery soc.
+
+		Access: Read
+                Valid values: 0 - 100
+
+What:		/sys/class/power_supply/<supply_name>/soc_decimal_rate,
+Date:		Jul 2020
+Contact:	jiangfei1@xiaomi.com
+Description:
+		Broadcast battery soc with decimal form.
+		soc_decimal_rate is the decimal part of battery soc update freqency.
+
+		Access: Read
+                Valid values: 0 - 100
+
 ===== USB Properties =====
 
 What: 		/sys/class/power_supply/<supply_name>/current_avg
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 4be762abba89..8defc22e0d7f 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -210,6 +210,8 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(tx_adapter),
 	POWER_SUPPLY_ATTR(signal_strength),
 	POWER_SUPPLY_ATTR(reverse_chg_mode),
+	POWER_SUPPLY_ATTR(soc_decimal),
+	POWER_SUPPLY_ATTR(soc_decimal_rate),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 319bf6456867..d1aa5497938e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -171,6 +171,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_TX_ADAPTER,
 	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 	POWER_SUPPLY_PROP_REVERSE_CHG_MODE,
+	POWER_SUPPLY_PROP_SOC_DECIMAL,
+	POWER_SUPPLY_PROP_SOC_DECIMAL_RATE,
 };
 
 enum power_supply_type {
-- 
2.26.0

