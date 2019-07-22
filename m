Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B470816
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfGVSDD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 14:03:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33654 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfGVSDD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 14:03:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so17752550pfq.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIELoiHmUXbL92hfI4jx59Ucqj3uQlhVaER6uive5Ys=;
        b=a7sa0xB7N1zI4giKvX+hX0rZUsGTQ3c97nDQz9rPEqS5bJbiXAOzcsCVWSAE21tV7U
         xxSfAzXEFYiRBTBUp/RzwpwAa7hFrG1Ib9gJJX5DqjkFQGhmQhlLOOfD3BdZ4cVdCKuQ
         aZOgwhswHMeoXf1TpRHtVPRuKBUusrF+g+kCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIELoiHmUXbL92hfI4jx59Ucqj3uQlhVaER6uive5Ys=;
        b=Q7tZlvvTQW8Wp2gocYMxsXMAXGB3+t53nuUqd482pyCg0qo4e37PzbG69nubXmorPO
         fU3BTFHNgc+bVbKQwW4EPOQie27ihKcj49IGMIUHKRszatfjK+fdNydSePvNX9OOk7uR
         fS6a1huGCD11qmYDiAP3eliTkO1JzNHcypXIJt6NphUUnIkhNwDYqolRnC1lPNf5oENd
         UdGLBaEdBi/Yf5oNbVGNSvvYkoo1MF8UmEfiTp+WtJpARfDS0E8QUwP2YCqJ4cQM57qS
         ox1Lx0PeNKt9AWfS6MD/EsekvWFs0To8CmtddG0CnpMLWYyIQkMTFgeKFqfYXH+7Ch66
         WTxw==
X-Gm-Message-State: APjAAAX0zzmj13vhTySopMsT0YsKpIIwYPoYMMIeEMyUzNsqioV3uCGf
        SWnGUl4Y/0GFWb+QRv5K+P+ybg==
X-Google-Smtp-Source: APXvYqzibWslj1pTQSkPXyE2c+my91uF4qoKosp6UK4IjdzVt6vasU1KnIS+MlF88yziGLDwI41ULw==
X-Received: by 2002:a63:2364:: with SMTP id u36mr70401607pgm.449.1563818582230;
        Mon, 22 Jul 2019 11:03:02 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id p187sm62203415pfg.89.2019.07.22.11.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 11:03:01 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: [PATCH] power:sysfs: Expose device wakeup_event_count.
Date:   Mon, 22 Jul 2019 11:02:58 -0700
Message-Id: <20190722180258.255949-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Device level event_count can help user level daemon to track if a
praticular device has seen an wake interrupt during a suspend resume
cycle. Thus expose it via sysfs.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 Documentation/ABI/testing/sysfs-devices-power | 11 ++++++++++
 drivers/base/power/sysfs.c                    | 20 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1ca04b4f0489..344549f4013f 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -89,6 +89,17 @@ Description:
 		attribute is not present. If the device is not enabled to wake
 		up the system from sleep states, this attribute is empty.
 
+What:		/sys/devices/.../power/wakeup_event_count
+Date:		July 2019
+Contact:	Ravi Chandra sadineni <ravisadineni@chromium.org>
+Description:
+		The /sys/devices/.../wakeup_event_count attribute contains the
+		number of signaled wakeup events associated with the device.
+		This attribute is read-only. If the device is not capable to
+		wake up the system from sleep states, this attribute is not
+		present. If the device is not enabled to wake up the system
+		from sleep states, this attribute is empty.
+
 What:		/sys/devices/.../power/wakeup_active_count
 Date:		September 2010
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index f42044d9711c..8dc1235b9784 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -357,6 +357,25 @@ static ssize_t wakeup_count_show(struct device *dev,
 
 static DEVICE_ATTR_RO(wakeup_count);
 
+static ssize_t wakeup_event_count_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	unsigned long count = 0;
+	bool enabled = false;
+
+	spin_lock_irq(&dev->power.lock);
+	if (dev->power.wakeup) {
+		count = dev->power.wakeup->event_count;
+		enabled = true;
+	}
+	spin_unlock_irq(&dev->power.lock);
+	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
+}
+
+static DEVICE_ATTR_RO(wakeup_event_count);
+
+
+
 static ssize_t wakeup_active_count_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -561,6 +580,7 @@ static struct attribute *wakeup_attrs[] = {
 #ifdef CONFIG_PM_SLEEP
 	&dev_attr_wakeup.attr,
 	&dev_attr_wakeup_count.attr,
+	&dev_attr_wakeup_event_count.attr,
 	&dev_attr_wakeup_active_count.attr,
 	&dev_attr_wakeup_expire_count.attr,
 	&dev_attr_wakeup_active.attr,
-- 
2.20.1

