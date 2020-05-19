Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A107B1D901F
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgESGcd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 02:32:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbgESGcd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 02:32:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BF7CDC5C189C60C7DFAA;
        Tue, 19 May 2020 14:32:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 14:32:18 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 5/6] Documentation: cpuidle: update the document
Date:   Tue, 19 May 2020 14:25:24 +0800
Message-ID: <1589869525-29893-6-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1589869525-29893-1-git-send-email-guohanjun@huawei.com>
References: <1589869525-29893-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the document after the remove of cpuidle_sysfs_switch.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Doug Smythies <dsmythies@telus.net>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 24 ++++++++--------------
 Documentation/admin-guide/pm/cpuidle.rst           | 20 ++++++++----------
 Documentation/driver-api/pm/cpuidle.rst            |  5 ++---
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 2e0e3b4..6b5dafa 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -106,10 +106,10 @@ Description:	CPU topology files that describe a logical CPU's relationship
 		See Documentation/admin-guide/cputopology.rst for more information.
 
 
-What:		/sys/devices/system/cpu/cpuidle/current_driver
-		/sys/devices/system/cpu/cpuidle/current_governer_ro
-		/sys/devices/system/cpu/cpuidle/available_governors
+What:		/sys/devices/system/cpu/cpuidle/available_governors
+		/sys/devices/system/cpu/cpuidle/current_driver
 		/sys/devices/system/cpu/cpuidle/current_governor
+		/sys/devices/system/cpu/cpuidle/current_governer_ro
 Date:		September 2007
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Discover cpuidle policy and mechanism
@@ -119,24 +119,18 @@ Description:	Discover cpuidle policy and mechanism
 		consumption during idle.
 
 		Idle policy (governor) is differentiated from idle mechanism
-		(driver)
-
-		current_driver: (RO) displays current idle mechanism
-
-		current_governor_ro: (RO) displays current idle policy
-
-		With the cpuidle_sysfs_switch boot option enabled (meant for
-		developer testing), the following three attributes are visible
-		instead:
-
-		current_driver: same as described above
+		(driver).
 
 		available_governors: (RO) displays a space separated list of
-		available governors
+		available governors.
+
+		current_driver: (RO) displays current idle mechanism.
 
 		current_governor: (RW) displays current idle policy. Users can
 		switch the governor at runtime by writing to this file.
 
+		current_governor_ro: (RO) displays current idle policy.
+
 		See Documentation/admin-guide/pm/cpuidle.rst and
 		Documentation/driver-api/pm/cpuidle.rst for more information.
 
diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 5605cc6..a96a423 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -159,17 +159,15 @@ governor uses that information depends on what algorithm is implemented by it
 and that is the primary reason for having more than one governor in the
 ``CPUIdle`` subsystem.
 
-There are three ``CPUIdle`` governors available, ``menu``, `TEO <teo-gov_>`_
-and ``ladder``.  Which of them is used by default depends on the configuration
-of the kernel and in particular on whether or not the scheduler tick can be
-`stopped by the idle loop <idle-cpus-and-tick_>`_.  It is possible to change the
-governor at run time if the ``cpuidle_sysfs_switch`` command line parameter has
-been passed to the kernel, but that is not safe in general, so it should not be
-done on production systems (that may change in the future, though).  The name of
-the ``CPUIdle`` governor currently used by the kernel can be read from the
-:file:`current_governor_ro` (or :file:`current_governor` if
-``cpuidle_sysfs_switch`` is present in the kernel command line) file under
-:file:`/sys/devices/system/cpu/cpuidle/` in ``sysfs``.
+There are four ``CPUIdle`` governors available, ``menu``, `TEO <teo-gov_>`_,
+``ladder`` and ``haltpoll``.  Which of them is used by default depends on the
+configuration of the kernel and in particular on whether or not the scheduler
+tick can be `stopped by the idle loop <idle-cpus-and-tick_>`_.  Available
+governors can be read from the :file:`available_governors`, and the governor
+can be changed at runtime.  The name of the ``CPUIdle`` governor currently
+used by the kernel can be read from the :file:`current_governor_ro` or
+:file:`current_governor` file under :file:`/sys/devices/system/cpu/cpuidle/`
+in ``sysfs``.
 
 Which ``CPUIdle`` driver is used, on the other hand, usually depends on the
 platform the kernel is running on, but there are platforms with more than one
diff --git a/Documentation/driver-api/pm/cpuidle.rst b/Documentation/driver-api/pm/cpuidle.rst
index 006cf6d..3588bf0 100644
--- a/Documentation/driver-api/pm/cpuidle.rst
+++ b/Documentation/driver-api/pm/cpuidle.rst
@@ -68,9 +68,8 @@ only one in the list (that is, the list was empty before) or the value of its
 governor currently in use, or the name of the new governor was passed to the
 kernel as the value of the ``cpuidle.governor=`` command line parameter, the new
 governor will be used from that point on (there can be only one ``CPUIdle``
-governor in use at a time).  Also, if ``cpuidle_sysfs_switch`` is passed to the
-kernel in the command line, user space can choose the ``CPUIdle`` governor to
-use at run time via ``sysfs``.
+governor in use at a time).  Also, user space can choose the ``CPUIdle``
+governor to use at run time via ``sysfs``.
 
 Once registered, ``CPUIdle`` governors cannot be unregistered, so it is not
 practical to put them into loadable kernel modules.
-- 
1.7.12.4

