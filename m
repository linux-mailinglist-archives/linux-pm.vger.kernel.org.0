Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB35104913
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 04:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKUDTU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 22:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKUDTT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:19 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DF520721;
        Thu, 21 Nov 2019 03:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306358;
        bh=HEUpb8bNwc8SarAfdtsw12BjG6dRX4eNspNtneMvqTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UVa/7Q5rZROQia7OQ2qGtMmzIqt/reLDb7O4T6Y9egPwaYhpIYwO3MnREteXgE4ms
         wdeZln250gAydvCr91UpTgl9Cdlcz0lFKU3CGw8IW10rZTCCiZVJ3rOlVY2dAscNy3
         NqGFkDTuEQcaZXM4oyvc3bo67yB42BkFoHkFEiYo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] cpufreq: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:15 +0100
Message-Id: <1574306355-29316-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/cpufreq/Kconfig.powerpc |  8 ++++----
 drivers/cpufreq/Kconfig.x86     | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index 35b4f700f054..58151ca56695 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -48,9 +48,9 @@ config PPC_PASEMI_CPUFREQ
 	  PWRficient processors.
 
 config POWERNV_CPUFREQ
-       tristate "CPU frequency scaling for IBM POWERNV platform"
-       depends on PPC_POWERNV
-       default y
-       help
+	tristate "CPU frequency scaling for IBM POWERNV platform"
+	depends on PPC_POWERNV
+	default y
+	help
 	 This adds support for CPU frequency switching on IBM POWERNV
 	 platform
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index dfa6457deaf6..a6528388952e 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -4,17 +4,17 @@
 #
 
 config X86_INTEL_PSTATE
-       bool "Intel P state control"
-       depends on X86
-       select ACPI_PROCESSOR if ACPI
-       select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
-       help
-          This driver provides a P state for Intel core processors.
+	bool "Intel P state control"
+	depends on X86
+	select ACPI_PROCESSOR if ACPI
+	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
+	help
+	  This driver provides a P state for Intel core processors.
 	  The driver implements an internal governor and will become
-          the scaling driver and governor for Sandy bridge processors.
+	  the scaling driver and governor for Sandy bridge processors.
 
 	  When this driver is enabled it will become the preferred
-          scaling driver for Sandy bridge processors.
+	  scaling driver for Sandy bridge processors.
 
 	  If in doubt, say N.
 
-- 
2.7.4

