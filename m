Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201C9103C4E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfKTNmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 08:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbfKTNmg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:36 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF08F22528;
        Wed, 20 Nov 2019 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257356;
        bh=zx31EvXJSrPvIZNUnpzsdNJ1bY9onSBR7VNrN6mC6WI=;
        h=From:To:Cc:Subject:Date:From;
        b=TrnrKIHzgXXYdi+5nPmPs/ScaG6071kY6vHoapRWHJenm8mMr6uFZl+WiI/e7M2sf
         oBm5Y+Emp3PCODq4Fe16WC3HXlY2y1b4ixtHQEDAcK0G3hB/t7LFEc5UsFIu+OIW30
         sAV5qaGA6NzMbkpYki2U/fjMkGC2vthPzTMxK8Co=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:32 +0800
Message-Id: <20191120134232.15900-1-krzk@kernel.org>
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
 drivers/cpufreq/Kconfig.x86 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index dfa6457deaf6..6eec6ccb14cb 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -9,12 +9,12 @@ config X86_INTEL_PSTATE
        select ACPI_PROCESSOR if ACPI
        select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
        help
-          This driver provides a P state for Intel core processors.
+	  This driver provides a P state for Intel core processors.
 	  The driver implements an internal governor and will become
-          the scaling driver and governor for Sandy bridge processors.
+	  the scaling driver and governor for Sandy bridge processors.
 
 	  When this driver is enabled it will become the preferred
-          scaling driver for Sandy bridge processors.
+	  scaling driver for Sandy bridge processors.
 
 	  If in doubt, say N.
 
-- 
2.17.1

