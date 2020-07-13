Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4D21CDFA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 06:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGMEGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 00:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGMEGA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 00:06:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E812C061794;
        Sun, 12 Jul 2020 21:06:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so5481310pgq.1;
        Sun, 12 Jul 2020 21:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IR3Q2ifTEIte01Ao7ilzSnaC7L5tdVO4iWlQq9Q0/S8=;
        b=XR6Xp0196Dy2say8OvOlRMTRloGBNZ3H5SV4W/AW1Wyn3H4mtwZAHeBHUkdccnSY3e
         lSF+MjAdelZ5d0wCEW6GpHR3Tcd4Ap0RQgKkkGBiolCMmx2wXIJFm2DWH7sfZCOhcR97
         E1jKIfUuRfyO4KD1AVOFtURk/25MzlJDSqkJSPIXZJSWUgd6y/I+R3ynBdkJJErUjpKD
         d2mWinXPg7jguDUpwRCnVU+Q6NG2yZhVxv1jAqsdjkA0RuSh2ykCexNKM5y9btR9UZ0x
         EmBzRdaydUPk83mgjrKHwP4Ly9wUqHcRPZ0sJIxQKQcDE3iRArHguIDHz7z4KKDJv7zz
         UMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IR3Q2ifTEIte01Ao7ilzSnaC7L5tdVO4iWlQq9Q0/S8=;
        b=j37aujWmNkgzHWm2tdx+75vlSHHNrEzV/hiJfaMzcU6XCI7Vpb94Md27efCshOX8jE
         B5O2yzqrkaWXNzfCbHZG8aTSstzN6zXNx2a36gjuILYh2lGmFr6rvZgH3Hb1uEvWdJ1n
         HuKgar3agQ8AbYGF7l4U0HEwIYnwKKEBvxPuvfxV8xxkcup3m0ORlZHHjUTNdOifvKqg
         iOPtFOKTtEEGcWqnYnJgxhFXJJeaRGKDo6xPld7M0Z9TrU3OhLT57zbj5F5a0upgeH7B
         cHukTuRQ2lpiwHjU7IG67ToTOeSKZD98VZ70UpWbbDvCiZtzTuNK6+c2g63sznh/i/57
         EnNQ==
X-Gm-Message-State: AOAM530EKWielP0GlgoyB8jnb/YKNslmtAlt1HS5+OKX7qqk3NyhZN0j
        tLjodnyCltQ0AwNW99KiT4k=
X-Google-Smtp-Source: ABdhPJziXpnINHmunYM+pyjTkL6SNHn4QEC3bAfMBwOOYgz8KLwB3PfI0/rtiUqOuTKVWpOOL+z60w==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr65861849pgh.309.1594613159656;
        Sun, 12 Jul 2020 21:05:59 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id j13sm12561570pjz.8.2020.07.12.21.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 21:05:59 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v2 3/5] power: supply: core: add wireless signal strength property
Date:   Mon, 13 Jul 2020 12:03:38 +0800
Message-Id: <bb8a46e8091fb4b376c42a7e3de676dc3a0acfea.1594612572.git.huangqiwu@xiaomi.com>
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

reports wireless signal strength.
The value show degree of coupling between tx and rx.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 11 +++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index cd07d3f4e8b1..f10780be2732 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -729,3 +729,14 @@ Description:
 
 		Access: Read-Only
 		Valid values: Reported as integer
+
+What:		/sys/class/power_supply/<supply_name>/signal_strength
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Reports wireless signal strength.The value show degree of coupling.
+		Unit is KHZ,the "value" means the working frequency of receiver
+		chip of wireless charging.
+
+		Access: Read-Only
+		Valid values: Reported as integer
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f2458e21d02b..e420a453095e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -208,6 +208,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
+	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 2de9a4c93723..397fb8e96b03 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -169,6 +169,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
+	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 };
 
 enum power_supply_type {
-- 
2.27.0

