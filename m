Return-Path: <linux-pm+bounces-31083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D073B0AFEE
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE847AA4FE
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D45220F33;
	Sat, 19 Jul 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtJpSztG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55079CD;
	Sat, 19 Jul 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928840; cv=none; b=OZ9X8kaX557zPEx3QGi1bYhM6LuL98ODYVMoFpavtsv8+PWfAnVSW8zeuQrzz1W1+BVmSto26GHTbCZtUdUDFeF7FU4FhQ5qHpPgrZBQxfW9lFaArwRxvP5DtLg68lhJtMAYz4CIpqpM2QwbZTbZGVih/9H94r1yTbSbIFa/MQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928840; c=relaxed/simple;
	bh=+fLtr4rONbtcCHYPhhgmSo7K9UPePuNcppB2opGmdM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hLgp2bC5PVpzc3YOD6WPD8LfA0rOWwKsxrbRCCLJVupMmcEu7ms6V+C3uCtg5vLXzBARUuQVX1UlwYl3dsifEryi2oIbVd6x6JWhAZyMFVWoYoQGOgDUFAzCRN/qmE7kSmM8V1hX0Coo4tkWW3VQ9/Xmn4J5rYz4e4XQzRLJDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtJpSztG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FFDC4CEE3;
	Sat, 19 Jul 2025 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752928840;
	bh=+fLtr4rONbtcCHYPhhgmSo7K9UPePuNcppB2opGmdM4=;
	h=From:To:Cc:Subject:Date:From;
	b=DtJpSztGjGE00I8RvxTMYC3bduQtTN70QmN7mcmSlm4eARxSVfQjyx2+XNR/mOVAV
	 xrIuQ7YXAN1hlrCK8Gt9xzPQRKCnRhgRFNZ0ivTeFhIpfYn9p8lKrOJvm2CSRhxSRg
	 QU6+nP92bpIl8f+exHmr68IXd7Zh1s27UFNu8rH/uZzHl3uD0uyRMYAKTwYEcf0WYB
	 Eoru1eV/oyn0TCW8zBPZieHZH0p1SfdehS33t6OIuFWbY8RrcKSPkQWc8U7eWTJWmF
	 kERQj4Dy8zQ8caS2o3GDVgJkxijieAMmIXKRF3swIV26wOC8D3F5oSTl0965usw/p+
	 lheKYuNLyBy6g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Kevin Hilman <khilman@kernel.org>
Subject:
 [PATCH v1] PM: docs: Use my kernel.org address in ABI docs and DT bindings
Date: Sat, 19 Jul 2025 14:40:31 +0200
Message-ID: <5911353.DvuYhMxLoT@rjwysocki.net>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael@kernel.org>

For the sake of consistency, use my kernel.org address in all Contact
records in sysfs-devices-power and sysfs-power, and in the power-domain
DT binding.

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---
 Documentation/ABI/testing/sysfs-devices-power             |   34 +++++++-------
 Documentation/ABI/testing/sysfs-power                     |   26 +++++-----
 Documentation/devicetree/bindings/power/power-domain.yaml |    2 
 3 files changed, 31 insertions(+), 31 deletions(-)

--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -1,6 +1,6 @@
 What:		/sys/devices/.../power/
 Date:		January 2009
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../power directory contains attributes
 		allowing the user space to check and modify some power
@@ -8,7 +8,7 @@
 
 What:		/sys/devices/.../power/wakeup
 Date:		January 2009
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../power/wakeup attribute allows the user
 		space to check if the device is enabled to wake up the system
@@ -34,7 +34,7 @@
 
 What:		/sys/devices/.../power/control
 Date:		January 2009
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../power/control attribute allows the user
 		space to control the run-time power management of the device.
@@ -53,7 +53,7 @@
 
 What:		/sys/devices/.../power/async
 Date:		January 2009
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../async attribute allows the user space to
 		enable or disable the device's suspend and resume callbacks to
@@ -79,7 +79,7 @@
 
 What:		/sys/devices/.../power/wakeup_count
 Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../wakeup_count attribute contains the number
 		of signaled wakeup events associated with the device.  This
@@ -90,7 +90,7 @@
 
 What:		/sys/devices/.../power/wakeup_active_count
 Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../wakeup_active_count attribute contains the
 		number of times the processing of wakeup events associated with
@@ -102,7 +102,7 @@
 
 What:		/sys/devices/.../power/wakeup_abort_count
 Date:		February 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../wakeup_abort_count attribute contains the
 		number of times the processing of a wakeup event associated with
@@ -114,7 +114,7 @@
 
 What:		/sys/devices/.../power/wakeup_expire_count
 Date:		February 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../wakeup_expire_count attribute contains the
 		number of times a wakeup event associated with the device has
@@ -126,7 +126,7 @@
 
 What:		/sys/devices/.../power/wakeup_active
 Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../wakeup_active attribute contains either 1,
 		or 0, depending on whether or not a wakeup event associated with
@@ -138,7 +138,7 @@
 
 What:		/sys/devices/.../power/wakeup_total_time_ms
 Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../wakeup_total_time_ms attribute contains
 		the total time of processing wakeup events associated with the
@@ -149,7 +149,7 @@
 
 What:		/sys/devices/.../power/wakeup_max_time_ms
 Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../wakeup_max_time_ms attribute contains
 		the maximum time of processing a single wakeup event associated
@@ -161,7 +161,7 @@
 
 What:		/sys/devices/.../power/wakeup_last_time_ms
 Date:		September 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../wakeup_last_time_ms attribute contains
 		the value of the monotonic clock corresponding to the time of
@@ -173,7 +173,7 @@
 
 What:		/sys/devices/.../power/wakeup_prevent_sleep_time_ms
 Date:		February 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../wakeup_prevent_sleep_time_ms attribute
 		contains the total time the device has been preventing
@@ -203,7 +203,7 @@
 
 What:		/sys/devices/.../power/pm_qos_resume_latency_us
 Date:		March 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../power/pm_qos_resume_latency_us attribute
 		contains the PM QoS resume latency limit for the given device,
@@ -223,7 +223,7 @@
 
 What:		/sys/devices/.../power/pm_qos_latency_tolerance_us
 Date:		January 2014
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../power/pm_qos_latency_tolerance_us attribute
 		contains the PM QoS active state latency tolerance limit for the
@@ -248,7 +248,7 @@
 
 What:		/sys/devices/.../power/pm_qos_no_power_off
 Date:		September 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../power/pm_qos_no_power_off attribute
 		is used for manipulating the PM QoS "no power off" flag.  If
@@ -263,7 +263,7 @@
 
 What:		/sys/devices/.../power/runtime_status
 Date:		April 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/devices/.../power/runtime_status attribute contains
 		the current runtime PM status of the device, which may be
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -1,6 +1,6 @@
 What:		/sys/power/
 Date:		August 2006
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power directory will contain files that will
 		provide a unified interface to the power management
@@ -8,7 +8,7 @@
 
 What:		/sys/power/state
 Date:		November 2016
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/state file controls system sleep states.
 		Reading from this file returns the available sleep state
@@ -23,7 +23,7 @@
 
 What:		/sys/power/mem_sleep
 Date:		November 2016
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/mem_sleep file controls the operating mode of
 		system suspend.  Reading from it returns the available modes
@@ -41,7 +41,7 @@
 
 What:		/sys/power/disk
 Date:		September 2006
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/disk file controls the operating mode of the
 		suspend-to-disk mechanism.  Reading from this file returns
@@ -90,7 +90,7 @@
 
 What:		/sys/power/image_size
 Date:		August 2006
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/image_size file controls the size of the image
 		created by the suspend-to-disk mechanism.  It can be written a
@@ -107,7 +107,7 @@
 
 What:		/sys/power/pm_trace
 Date:		August 2006
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/pm_trace file controls the code which saves the
 		last PM event point in the RTC across reboots, so that you can
@@ -156,7 +156,7 @@
 
 What:		/sys/power/pm_async
 Date:		January 2009
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/pm_async file controls the switch allowing the
 		user space to enable or disable asynchronous suspend and resume
@@ -169,7 +169,7 @@
 
 What:		/sys/power/wakeup_count
 Date:		July 2010
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/wakeup_count file allows user space to put the
 		system into a sleep state while taking into account the
@@ -184,7 +184,7 @@
 
 What:		/sys/power/reserved_size
 Date:		May 2011
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/reserved_size file allows user space to control
 		the amount of memory reserved for allocations made by device
@@ -198,7 +198,7 @@
 
 What:		/sys/power/autosleep
 Date:		April 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/autosleep file can be written one of the strings
 		returned by reads from /sys/power/state.  If that happens, a
@@ -215,7 +215,7 @@
 
 What:		/sys/power/wake_lock
 Date:		February 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/wake_lock file allows user space to create
 		wakeup source objects and activate them on demand (if one of
@@ -242,7 +242,7 @@
 
 What:		/sys/power/wake_unlock
 Date:		February 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/wake_unlock file allows user space to deactivate
 		wakeup sources created with the help of /sys/power/wake_lock.
@@ -283,7 +283,7 @@
 
 What:		/sys/power/pm_debug_messages
 Date:		July 2017
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Contact:	Rafael J. Wysocki <rafael@kernel.org>
 Description:
 		The /sys/power/pm_debug_messages file controls the printing
 		of debug messages from the system suspend/hiberbation
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -7,7 +7,7 @@
 title: Generic PM domains
 
 maintainers:
-  - Rafael J. Wysocki <rjw@rjwysocki.net>
+  - Rafael J. Wysocki <rafael@kernel.org>
   - Kevin Hilman <khilman@kernel.org>
   - Ulf Hansson <ulf.hansson@linaro.org>
 




