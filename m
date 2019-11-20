Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32CE1103C4B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfKTNmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 08:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbfKTNmc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:32 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7986A22506;
        Wed, 20 Nov 2019 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257351;
        bh=4mdIlVqSgF5W1fbW6Lu5ti5hA+egq0Vt8toWgDFv8p8=;
        h=From:To:Cc:Subject:Date:From;
        b=znZIqKyzvoikMA6PHYEFYl0pYg+VwaWWg5d+LhBI8E7xMnffdz6iseITwUDgeQoqG
         yiETnrIC/q+8i7yrmiTwdMeh6fQXJW7rDCwqGolywWYIAzOrYuaiA0v/10hoysB4TA
         mu2h6WRl5nbNLtiONAnLUIN2+BBMhlflS/hkfeV8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:28 +0800
Message-Id: <20191120134228.15838-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/cpuidle/Kconfig     |  8 ++++----
 drivers/cpuidle/Kconfig.arm | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 88727b7c0d59..1b8614d1c696 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -16,7 +16,7 @@ config CPU_IDLE
 if CPU_IDLE
 
 config CPU_IDLE_MULTIPLE_DRIVERS
-        bool
+	bool
 
 config CPU_IDLE_GOV_LADDER
 	bool "Ladder governor (for periodic timer tick)"
@@ -67,9 +67,9 @@ config HALTPOLL_CPUIDLE
        depends on X86 && KVM_GUEST
        default y
        help
-         This option enables halt poll cpuidle driver, which allows to poll
-         before halting in the guest (more efficient than polling in the
-         host via halt_poll_ns for some scenarios).
+	 This option enables halt poll cpuidle driver, which allows to poll
+	 before halting in the guest (more efficient than polling in the
+	 host via halt_poll_ns for some scenarios).
 
 endif
 
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index d8530475493c..e91ab792d14d 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -3,15 +3,15 @@
 # ARM CPU Idle drivers
 #
 config ARM_CPUIDLE
-        bool "Generic ARM/ARM64 CPU idle Driver"
-        select DT_IDLE_STATES
+	bool "Generic ARM/ARM64 CPU idle Driver"
+	select DT_IDLE_STATES
 	select CPU_IDLE_MULTIPLE_DRIVERS
-        help
-          Select this to enable generic cpuidle driver for ARM.
-          It provides a generic idle driver whose idle states are configured
-          at run-time through DT nodes. The CPUidle suspend backend is
-          initialized by calling the CPU operations init idle hook
-          provided by architecture code.
+	help
+	  Select this to enable generic cpuidle driver for ARM.
+	  It provides a generic idle driver whose idle states are configured
+	  at run-time through DT nodes. The CPUidle suspend backend is
+	  initialized by calling the CPU operations init idle hook
+	  provided by architecture code.
 
 config ARM_PSCI_CPUIDLE
 	bool "PSCI CPU idle Driver"
-- 
2.17.1

