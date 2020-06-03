Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200421ED1DE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgFCOOz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 10:14:55 -0400
Received: from foss.arm.com ([217.140.110.172]:34004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgFCOOz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jun 2020 10:14:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3134E55D;
        Wed,  3 Jun 2020 07:14:55 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93E753F52E;
        Wed,  3 Jun 2020 07:14:52 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        Chris.Redpath@arm.com, javi.merinocacho@arm.com,
        lukasz.luba@arm.com
Subject: [PATCH] MAINTAINERS: Add maintenance information for IPA
Date:   Wed,  3 Jun 2020 15:14:20 +0100
Message-Id: <20200603141420.15274-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add entry for ARM Intelligent Power Allocation - thermal governor.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi Daniel,

Could you pick it up, please?

Regards,
Lukasz

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..8ce4677477a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16699,6 +16699,14 @@ F:	drivers/thermal/cpufreq_cooling.c
 F:	drivers/thermal/cpuidle_cooling.c
 F:	include/linux/cpu_cooling.h
 
+THERMAL/POWER_ALLOCATOR
+M:	Lukasz Luba <lukasz.luba@arm.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/driver-api/thermal/power_allocator.rst
+F:	drivers/thermal/power_allocator.c
+F:	include/trace/events/thermal_power_allocator.h
+
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
 L:	ibm-acpi-devel@lists.sourceforge.net
-- 
2.17.1

