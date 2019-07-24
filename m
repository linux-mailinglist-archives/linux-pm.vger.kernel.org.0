Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7978C735BF
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfGXRoN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 13:44:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37199 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbfGXRoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 13:44:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so22291483plr.4
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s/3YQsGCF6NcH7//5dLBEIyds71Voj/jHOMhbKfkGR4=;
        b=Kb8GVwAZza6hl3PZCnzUeA6hURNZbH3CVLF9QNPts0osPXZ/qQcCHLa11D2eSP3eom
         WvZIYX8BphU9gF1A19ypTMKgYAG1S1/LnmCgSn3dTDzfYOKHg4hxLcho0BKIMJpZBnsL
         80JBEeef77z883yBAqjewhYvjeLZbT5tCkB/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/3YQsGCF6NcH7//5dLBEIyds71Voj/jHOMhbKfkGR4=;
        b=fTADoSiqdMy4Nnv8QTTylTbR20f/QLc576aBSCkb8P6RkJo8AG0UCKtPU7zUTTt16v
         RdK+YVtaNwbHsadZxEuKRLmD3Zc3jE/cDKO95QE2ewKn6znfgTHWZiXsIGhsAXbNdLOV
         CH/vN9gE4YWY/qWpaIvJVU1qYzDrnTeva76ytso0L7+EAyGUt48kH8t9kk+GITCnXJsD
         kmEyMAkZ37fOKqh7KVAwGahYZtRKFQw7gI5YptdExaGECdmWr/SastPVc3NTKMpjB6DW
         7sRdNrmsd9k8hk7M6SRpHrn29FHtMFQtqI9jd1EXJIXj0/pYd4dvKxtUXcEdo+ufFkC2
         JWlw==
X-Gm-Message-State: APjAAAVK+gRgo4U6q6Fl7Bgd6Yh6YMhZRv889UvsS75xxp+GMPp2Apvf
        Pgt6l/SJSWqtLHEdpTO1u4E83Q==
X-Google-Smtp-Source: APXvYqwZwdbAwPGWjut8Is7iEGbkQyyvb+T46yB205plqWrKtD5lC6OdGPpoAeEgDzuwT0dUwJ4aEQ==
X-Received: by 2002:a17:902:b905:: with SMTP id bf5mr81267550plb.342.1563990251878;
        Wed, 24 Jul 2019 10:44:11 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id r6sm37620080pgl.74.2019.07.24.10.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jul 2019 10:44:11 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org, trong@google.com
Subject: [PATCH 2/2] power: sysfs: move wakeup related nodes in power dir to obselete.
Date:   Wed, 24 Jul 2019 10:43:55 -0700
Message-Id: <20190724174355.255314-3-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724174355.255314-1-ravisadineni@chromium.org>
References: <20190724174355.255314-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As we have a new wakeup_source sub directory under power/ that
exposes all the wakeup_source related attributes, move the
documentation pointing to the existing attributes directly
under power/ directory to obselete.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 Documentation/ABI/obsolete/sysfs-device-power |  93 ++++++++++++++++
 Documentation/ABI/testing/sysfs-devices-power | 102 ++----------------
 2 files changed, 101 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-device-power

diff --git a/Documentation/ABI/obsolete/sysfs-device-power b/Documentation/ABI/obsolete/sysfs-device-power
new file mode 100644
index 000000000000..fd780cdcf2c3
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-device-power
@@ -0,0 +1,93 @@
+What:		/sys/devices/.../power/wakeup_count
+Date:		September 2010
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/devices/.../wakeup_count attribute contains the number
+		of signaled wakeup events associated with the device.  This
+		attribute is read-only.  If the device is not capable to wake up
+		the system from sleep states, this attribute is not present.
+		If the device is not enabled to wake up the system from sleep
+		states, this attribute is empty.
+
+What:		/sys/devices/.../power/wakeup_active_count
+Date:		September 2010
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/devices/.../wakeup_active_count attribute contains the
+		number of times the processing of wakeup events associated with
+		the device was completed (at the kernel level).  This attribute
+		is read-only.  If the device is not capable to wake up the
+		system from sleep states, this attribute is not present.  If
+		the device is not enabled to wake up the system from sleep
+		states, this attribute is empty.
+
+What:		/sys/devices/.../power/wakeup_abort_count
+Date:		February 2012
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/devices/.../wakeup_abort_count attribute contains the
+		number of times the processing of a wakeup event associated with
+		the device might have aborted system transition into a sleep
+		state in progress.  This attribute is read-only.  If the device
+		is not capable to wake up the system from sleep states, this
+		attribute is not present.  If the device is not enabled to wake
+		up the system from sleep states, this attribute is empty.
+
+What:		/sys/devices/.../power/wakeup_expire_count
+Date:		February 2012
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/devices/.../wakeup_expire_count attribute contains the
+		number of times a wakeup event associated with the device has
+		been reported with a timeout that expired.  This attribute is
+		read-only.  If the device is not capable to wake up the system
+		from sleep states, this attribute is not present.  If the
+		device is not enabled to wake up the system from sleep states,
+		this attribute is empty.
+
+What:		/sys/devices/.../power/wakeup_total_time_ms
+Date:		September 2010
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/devices/.../wakeup_total_time_ms attribute contains
+		the total time of processing wakeup events associated with the
+		device, in milliseconds.  This attribute is read-only.  If the
+		device is not capable to wake up the system from sleep states,
+		this attribute is not present.  If the device is not enabled to
+		wake up the system from sleep states, this attribute is empty.
+
+What:		/sys/devices/.../power/wakeup_max_time_ms
+Date:		September 2010
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/devices/.../wakeup_max_time_ms attribute contains
+		the maximum time of processing a single wakeup event associated
+		with the device, in milliseconds.  This attribute is read-only.
+		If the device is not capable to wake up the system from sleep
+		states, this attribute is not present.  If the device is not
+		enabled to wake up the system from sleep states, this attribute
+		is empty.
+
+What:		/sys/devices/.../power/wakeup_last_time_ms
+Date:		September 2010
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/devices/.../wakeup_last_time_ms attribute contains
+		the value of the monotonic clock corresponding to the time of
+		signaling the last wakeup event associated with the device, in
+		milliseconds.  This attribute is read-only.  If the device is
+		not enabled to wake up the system from sleep states, this
+		attribute is not present.  If the device is not enabled to wake
+		up the system from sleep states, this attribute is empty.
+
+What:		/sys/devices/.../power/wakeup_prevent_sleep_time_ms
+Date:		February 2012
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/devices/.../wakeup_prevent_sleep_time_ms attribute
+		contains the total time the device has been preventing
+		opportunistic transitions to sleep states from occurring.
+		This attribute is read-only.  If the device is not capable to
+		wake up the system from sleep states, this attribute is not
+		present.  If the device is not enabled to wake up the system
+		from sleep states, this attribute is empty.
\ No newline at end of file
diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 80a00f7b6667..30aff73c1dbd 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -77,53 +77,6 @@ Description:
 		device drivers and in that cases it should be safe to leave the
 		default value.
 
-What:		/sys/devices/.../power/wakeup_count
-Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
-Description:
-		The /sys/devices/.../wakeup_count attribute contains the number
-		of signaled wakeup events associated with the device.  This
-		attribute is read-only.  If the device is not capable to wake up
-		the system from sleep states, this attribute is not present.
-		If the device is not enabled to wake up the system from sleep
-		states, this attribute is empty.
-
-What:		/sys/devices/.../power/wakeup_active_count
-Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
-Description:
-		The /sys/devices/.../wakeup_active_count attribute contains the
-		number of times the processing of wakeup events associated with
-		the device was completed (at the kernel level).  This attribute
-		is read-only.  If the device is not capable to wake up the
-		system from sleep states, this attribute is not present.  If
-		the device is not enabled to wake up the system from sleep
-		states, this attribute is empty.
-
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
-What:		/sys/devices/.../power/wakeup_expire_count
-Date:		February 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
-Description:
-		The /sys/devices/.../wakeup_expire_count attribute contains the
-		number of times a wakeup event associated with the device has
-		been reported with a timeout that expired.  This attribute is
-		read-only.  If the device is not capable to wake up the system
-		from sleep states, this attribute is not present.  If the
-		device is not enabled to wake up the system from sleep states,
-		this attribute is empty.
-
 What:		/sys/devices/.../power/wakeup_active
 Date:		September 2010
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
@@ -136,53 +89,6 @@ Description:
 		enabled to wake up the system from sleep states, this attribute
 		is empty.
 
-What:		/sys/devices/.../power/wakeup_total_time_ms
-Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
-Description:
-		The /sys/devices/.../wakeup_total_time_ms attribute contains
-		the total time of processing wakeup events associated with the
-		device, in milliseconds.  This attribute is read-only.  If the
-		device is not capable to wake up the system from sleep states,
-		this attribute is not present.  If the device is not enabled to
-		wake up the system from sleep states, this attribute is empty.
-
-What:		/sys/devices/.../power/wakeup_max_time_ms
-Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
-Description:
-		The /sys/devices/.../wakeup_max_time_ms attribute contains
-		the maximum time of processing a single wakeup event associated
-		with the device, in milliseconds.  This attribute is read-only.
-		If the device is not capable to wake up the system from sleep
-		states, this attribute is not present.  If the device is not
-		enabled to wake up the system from sleep states, this attribute
-		is empty.
-
-What:		/sys/devices/.../power/wakeup_last_time_ms
-Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
-Description:
-		The /sys/devices/.../wakeup_last_time_ms attribute contains
-		the value of the monotonic clock corresponding to the time of
-		signaling the last wakeup event associated with the device, in
-		milliseconds.  This attribute is read-only.  If the device is
-		not enabled to wake up the system from sleep states, this
-		attribute is not present.  If the device is not enabled to wake
-		up the system from sleep states, this attribute is empty.
-
-What:		/sys/devices/.../power/wakeup_prevent_sleep_time_ms
-Date:		February 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
-Description:
-		The /sys/devices/.../wakeup_prevent_sleep_time_ms attribute
-		contains the total time the device has been preventing
-		opportunistic transitions to sleep states from occurring.
-		This attribute is read-only.  If the device is not capable to
-		wake up the system from sleep states, this attribute is not
-		present.  If the device is not enabled to wake up the system
-		from sleep states, this attribute is empty.
-
 What:		/sys/devices/.../power/autosuspend_delay_ms
 Date:		September 2010
 Contact:	Alan Stern <stern@rowland.harvard.edu>
@@ -260,3 +166,11 @@ Description:
 
 		This attribute has no effect on system-wide suspend/resume and
 		hibernation.
+
+What:		/sys/devices/.../power/wakeup_source
+Date:		July 2019
+Contact:	Ravi Chandra Sadineni <ravisadineni@chromium.org>
+Description:
+		The /sys/devices/.../power/wakeup_source directory contains
+		attributes allowing the user space to read several wakeup
+		related statistics of the device.
-- 
2.20.1

