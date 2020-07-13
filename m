Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5846721CDF9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 06:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgGMEFz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 00:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGMEFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 00:05:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B3C061794;
        Sun, 12 Jul 2020 21:05:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g67so5466115pgc.8;
        Sun, 12 Jul 2020 21:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5R7hzyypnGq3WhOJ61fo7CojiGojEKPJSwB5iz81Lk=;
        b=ZZgfeNVtC6k4fhlSkgQJNlX/hEbJGwKkXV7vs6CZqEatjN39H4YYyqmrklxVsb1ria
         L720mzW6go2lhMqGaCve7L2JDAHYaDMOQI/zcTM8JHKlsCtP+lakGPsvunroFigkGf52
         O10qwFIK8N6fj+vnO5TT2FFUJ5C7L015hUYUwsRI2qNER5Yn3YTCbELjB22tLa1/YBgC
         R4jhZHsJq6TI9RJDenPODabS/gmFqJdJ4vfhnkh+4a8DJ17dCT9qOsx/VPZg2mASMKbd
         1wzTwnwAvnn8AuHiqjN+GHNs0TVCBwftQSd9AVCu5Je+K+cYSFEizjhgkPaeEbkDVYSA
         Z90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5R7hzyypnGq3WhOJ61fo7CojiGojEKPJSwB5iz81Lk=;
        b=Nd4JzF7jPecQbCyUaeBtbjjVzgJAxgcCpuwrK5ONbERZGRZLj3yUsGg3dYegd5rEUY
         Z7PlCd6ZvVxbkH5sopumR0vC1Omk7H3i2Y0I38KbYBYE0oP+XZC57sDc+Eam/xDPCeCY
         dIZOecwh3H9faHQhtYl37UTSVyXfh51lZgFn4kd8o10YvYZU0fBVyChXah/Hjk9slSYI
         5mLbwWoQKWIHnPnoe/1OTWgj3ToJyIXnjaFG3Uqm7v9Zi1pe3ZXtvnh73hkcVpih6MSx
         QVr7fFD8HRSeojQwkl3iZW9lu9MHGNoP7n4NmDdhk/ZV3pj+xyhznlcHsQMJLq4I3X+h
         ZUGw==
X-Gm-Message-State: AOAM531+BvRKOHg5St4fzAlx04NQxoFELWnZX2H8zHHF/TWFNhTvn2YV
        a/0IlDjTtqorFbvk5Q7Z1/A=
X-Google-Smtp-Source: ABdhPJya/ICi3/tZ8/h9Q6YJAQ8psI+InzDAsyw0+KXdZhhzoQcdTQTBOSzjCqY+3VF0fcYibr/6jw==
X-Received: by 2002:a62:8782:: with SMTP id i124mr72375030pfe.267.1594613154595;
        Sun, 12 Jul 2020 21:05:54 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id j13sm12561570pjz.8.2020.07.12.21.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 21:05:54 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v2 2/5] power: supply: core: add wireless charger adapter type property
Date:   Mon, 13 Jul 2020 12:03:37 +0800
Message-Id: <b20548fc825241c69878bfb05464b0e4f378f4ce.1594612572.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594612572.git.huangqiwu@xiaomi.com>
References: <cover.1594612572.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Reports what type of wireless adapter connection is
currently active forthe supply.
for example it can show if ADAPTER_PD capable source is attached.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 11 +++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index d3169d47e359..cd07d3f4e8b1 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -718,3 +718,14 @@ Contact:	Fei Jiang <jiangfei1@xiaomi.com>
 		Access: Read-Only
 		Valid values: Reported as integer
 
+===== Wireless Charger Properties =====
+What:		/sys/class/power_supply/<supply_name>/tx_adapter
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Reports what type of wireless adapter connection is currently active for
+		the supply, for example it can show if ADAPTER_PD capable source
+		is attached.
+
+		Access: Read-Only
+		Valid values: Reported as integer
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 9554d7907373..f2458e21d02b 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -207,6 +207,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
+	POWER_SUPPLY_ATTR(TX_ADAPTER),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3fe7e9ef2f0f..2de9a4c93723 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -168,6 +168,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_TX_ADAPTER,
 };
 
 enum power_supply_type {
-- 
2.27.0

