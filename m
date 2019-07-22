Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1470CB3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 00:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfGVWdn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 18:33:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35902 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfGVWdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 18:33:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so18055365pfl.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WWFTKtpGRlvvtiWS/Mg0wAkpilGgkx7X1cSC4y5EWxE=;
        b=R2/O16xw6Vk/KNoxUlhUa5Y+bXgLiwKgbdav7p8y4DZGly/uyjCTGTMmALhIz+umS2
         BzWjpf90ZaYSY/iJRimrYmRKxNKa5lfLyYlUtkqPpeXJE1zQboA2EQf93zE2W+kDjXt5
         XiLOxoYWuYSBNhATVp5D+auF3i3e+jHCk2Ttg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWFTKtpGRlvvtiWS/Mg0wAkpilGgkx7X1cSC4y5EWxE=;
        b=cqaRmDgYyj/zeHrZFPdkdTwj+o06CLg/9Jxp6iBw9AEMkN3SmRIdNF+hg7vFSDBcQY
         2DP6HNvCXsYLXYofzfQZ8wzknrwo1DPGVrrSEBlplbOm5lT0E/hAn3iDwoAnrqKtChAw
         +Opan8JkYFBAD+/Pzdgg68HXe5HxyLXSHsq/JKXeIBFobq43qEkJpZ857L/CpCpPBbrV
         oI4gG6YSB6n9Dda09MgfBA+DGovlxVZII3IWE2XKHDEr+86lbIbxtv7k2hK1jtu04yzb
         PL878YoCObfwvCxKdrnx87TGDtIHrUkxvKMHg/aplbZdLJP2g83XapTNmXNSVicD3LIp
         GIdA==
X-Gm-Message-State: APjAAAUH9ds07HLN9BAbl/k4kKxh8e1Nxwardhm/SWu8jPamIsLWIbVA
        SZZu1qZ3WdKhXhmxt33/1yh7Rg==
X-Google-Smtp-Source: APXvYqzjNkKn9xJVfs5xGw8cpI55YmF3SpQ0/H+z0hmLe5p5Yj86uEZ+s3rh1vxlzdvzJ8lbYTj9ug==
X-Received: by 2002:a17:90a:b011:: with SMTP id x17mr79797580pjq.113.1563834822065;
        Mon, 22 Jul 2019 15:33:42 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id k186sm20614285pga.68.2019.07.22.15.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 15:33:41 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: [PATCH 1/2 V2] power: sysfs: Remove wakeup_abort_count attribute.
Date:   Mon, 22 Jul 2019 15:33:36 -0700
Message-Id: <20190722223337.36199-2-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722223337.36199-1-ravisadineni@chromium.org>
References: <20190722182451.GB24412@kroah.com>
 <20190722223337.36199-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

wakeup_abort_count and wakeup_count sysfs entries print the
same (wakeup_count) attribute. This patch removes the duplicate
wakeup_abort_count sysfs entry.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 Documentation/ABI/testing/sysfs-devices-power | 25 ++++++-------------
 drivers/base/power/sysfs.c                    | 19 --------------
 2 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 80a00f7b6667..1ca04b4f0489 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -81,12 +81,13 @@ What:		/sys/devices/.../power/wakeup_count
 Date:		September 2010
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
 Description:
-		The /sys/devices/.../wakeup_count attribute contains the number
-		of signaled wakeup events associated with the device.  This
-		attribute is read-only.  If the device is not capable to wake up
-		the system from sleep states, this attribute is not present.
-		If the device is not enabled to wake up the system from sleep
-		states, this attribute is empty.
+		The /sys/devices/.../wakeup_count attribute contains the
+		number of times the processing of a wakeup event associated with
+		the device might have aborted system transition into a sleep
+		state in progress. This attribute is read-only. If the device
+		is not capable to wake up the system from sleep states, this
+		attribute is not present. If the device is not enabled to wake
+		up the system from sleep states, this attribute is empty.
 
 What:		/sys/devices/.../power/wakeup_active_count
 Date:		September 2010
@@ -100,18 +101,6 @@ Description:
 		the device is not enabled to wake up the system from sleep
 		states, this attribute is empty.
 
-What:		/sys/devices/.../power/wakeup_abort_count
-Date:		February 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
-Description:
-		The /sys/devices/.../wakeup_abort_count attribute contains the
-		number of times the processing of a wakeup event associated with
-		the device might have aborted system transition into a sleep
-		state in progress.  This attribute is read-only.  If the device
-		is not capable to wake up the system from sleep states, this
-		attribute is not present.  If the device is not enabled to wake
-		up the system from sleep states, this attribute is empty.
-
 What:		/sys/devices/.../power/wakeup_expire_count
 Date:		February 2012
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 1b9c281cbe41..f42044d9711c 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -375,24 +375,6 @@ static ssize_t wakeup_active_count_show(struct device *dev,
 
 static DEVICE_ATTR_RO(wakeup_active_count);
 
-static ssize_t wakeup_abort_count_show(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	unsigned long count = 0;
-	bool enabled = false;
-
-	spin_lock_irq(&dev->power.lock);
-	if (dev->power.wakeup) {
-		count = dev->power.wakeup->wakeup_count;
-		enabled = true;
-	}
-	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
-}
-
-static DEVICE_ATTR_RO(wakeup_abort_count);
-
 static ssize_t wakeup_expire_count_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -580,7 +562,6 @@ static struct attribute *wakeup_attrs[] = {
 	&dev_attr_wakeup.attr,
 	&dev_attr_wakeup_count.attr,
 	&dev_attr_wakeup_active_count.attr,
-	&dev_attr_wakeup_abort_count.attr,
 	&dev_attr_wakeup_expire_count.attr,
 	&dev_attr_wakeup_active.attr,
 	&dev_attr_wakeup_total_time_ms.attr,
-- 
2.20.1

