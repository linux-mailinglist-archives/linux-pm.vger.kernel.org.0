Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198D670657
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 19:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfGVREM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 13:04:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42279 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfGVREM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 13:04:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so17661326pff.9
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWFTKtpGRlvvtiWS/Mg0wAkpilGgkx7X1cSC4y5EWxE=;
        b=du5osR+He2HAKTRGmW3FOeBZejOAbBQOkVuMsgwwPWkeRv4a7wojPA5+LdyZg08Wg5
         tzU728HwZAkeDfe95pCJN7ToYUk7fmexYNBZyWCosm/S7LuY4CGsuo4jpB+k6bagp3dk
         2mPnv5bF2i4eq3Ep4KztV5O3NIeXpBlVAUoa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWFTKtpGRlvvtiWS/Mg0wAkpilGgkx7X1cSC4y5EWxE=;
        b=VBk/jtMP84uQJd0QbZzyg1V0eypekfWRygNk/zO5N5fh00B/dkdGaOh6rcsj8hLATg
         DMrl90l3FlFal1haYjDxH2ombGTCH7WfFanb1Pi3Lj9R6KISmQp0dHLLhxLDRT0YBkOU
         IybAzpaZbGOhpcPEurEm67SclWNN7zT6C/rXRg1SoBtysI4gTpMsW9q3LgeA8NxaW7Pd
         AdMg2jGLxTPla3a8CnmgAaNCnlzVXzXPSYh2YpLdaMbV+/60+PhRtZ909I7XTQ9X8GuI
         ItHHrVdURhTiuYkfwbJ3czZqq/Baq9Syxk0LFWR/HJpnZQYLexzTUG77IrMV9jE9ZsbZ
         W44Q==
X-Gm-Message-State: APjAAAUlDqKrxcOG8bHwNJnsmqPexqnLJ5LKlCgEkinXtaFo62QvQkF0
        4dfb9wQhmHh5fJZQijLhHsEIXQ==
X-Google-Smtp-Source: APXvYqxlj/J2j6uWfc7jAAwHoat3ILjgCIrx5nro6zq5E3M1SbkRlrMALfbedVc5mHph61eA00ezXQ==
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr75821273pjo.111.1563815051539;
        Mon, 22 Jul 2019 10:04:11 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id 196sm43122621pfy.167.2019.07.22.10.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 10:04:11 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: [PATCH] power: sysfs: Remove wakeup_abort_count attribute.
Date:   Mon, 22 Jul 2019 10:04:07 -0700
Message-Id: <20190722170407.217178-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
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

