Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3F570CB1
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 00:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbfGVWdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 18:33:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32805 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfGVWdp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 18:33:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so19708891plo.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4lqL/2aAtzva5ONR2wYj8ExU6ts1LC8Et+7vo27oAws=;
        b=UgtJJ8+GEd2dn01GyvwLu7NPJ9l2xm/KPnrLgHH0dI9GzIlXWZkmA+N1KTUF7r0G1A
         0MKQja2/FoG2oKE40jWNZvGiprQDfFP/jr/BSyVciwNIq95Iu6NjN3gB56GKdx0QgZky
         Kzg4GrGl+/m+dUUTzPW7iP/VH4CLaer9EdwLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4lqL/2aAtzva5ONR2wYj8ExU6ts1LC8Et+7vo27oAws=;
        b=a//PmpzIDc7/i8Sbb2WQgijIbtyYsLdYpc3xVu/h1vgbCqS0O4apAvH5PZkoL4S5rg
         Bj0qs01Eb/jXP9vNuOy7owwv8t9dmjqVR7t0LVV+dt94JhPREceFEiQ/KdC4WhZGbgLz
         w9gvsj1sr+TRlNCbSbUPIWPdGzBZ9XimtBBJcG0IOWKZOe0XuCaUH5H7U5oswrgHVxGQ
         /IgWtFiSySNfQCPjdVfJ0tHREeTgZ/dl+Aow6jwvDQjCxBNJTh975Ls+OYc2S70VZxXS
         9gcenSLUddjPL09/svqWbJUC+5lcNcCBTcRtNmLoftNGcJ2ibOzTTBmdFrr2ZRAbxO7X
         6S1w==
X-Gm-Message-State: APjAAAUt5FpWa6vfOHnHRUJdY47nW+vLL4f1SI7hpV3z0V+5H5xsytj+
        dVmZiCRnaRzigLt/ExupgGmbMw==
X-Google-Smtp-Source: APXvYqzm077YSy2G+QdxitaH1+UlqZ1igV+SV0DodJuzFm5hgnjFzjAwgaEvzXmLoOOyFMHuzWkCyA==
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr76220816plo.313.1563834824000;
        Mon, 22 Jul 2019 15:33:44 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id k186sm20614285pga.68.2019.07.22.15.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 15:33:43 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: [PATCH 2/2 V2] power:sysfs: Expose device wakeup_event_count.
Date:   Mon, 22 Jul 2019 15:33:37 -0700
Message-Id: <20190722223337.36199-3-ravisadineni@chromium.org>
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

Device level event_count can help user level daemon to track if a
praticular device has seen an wake interrupt during a suspend resume
cycle. Thus expose it via sysfs.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
V2: Address comments from patchset 1.

Documentation/ABI/testing/sysfs-devices-power | 11 ++++++++++
 drivers/base/power/sysfs.c                    | 21 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1ca04b4f0489..abae0e8106d2 100644
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
+		from sleep states, this attribute returns an empty line.
+
 What:		/sys/devices/.../power/wakeup_active_count
 Date:		September 2010
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index f42044d9711c..cbb9768b10e8 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -357,6 +357,26 @@ static ssize_t wakeup_count_show(struct device *dev,
 
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
+	if (enabled)
+		return sprintf(buf, "%lu\n", count);
+	else
+		return sprintf(buf, "\n");
+}
+
+static DEVICE_ATTR_RO(wakeup_event_count);
+
 static ssize_t wakeup_active_count_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -561,6 +581,7 @@ static struct attribute *wakeup_attrs[] = {
 #ifdef CONFIG_PM_SLEEP
 	&dev_attr_wakeup.attr,
 	&dev_attr_wakeup_count.attr,
+	&dev_attr_wakeup_event_count.attr,
 	&dev_attr_wakeup_active_count.attr,
 	&dev_attr_wakeup_expire_count.attr,
 	&dev_attr_wakeup_active.attr,
-- 
2.20.1

