Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC72F947
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfE3JUu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 05:20:50 -0400
Received: from foss.arm.com ([217.140.101.70]:33018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfE3JUu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 May 2019 05:20:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A5EB15A2;
        Thu, 30 May 2019 02:20:50 -0700 (PDT)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2193F59C;
        Thu, 30 May 2019 02:20:47 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quentin.perret@arm.com
Subject: [PATCH v5 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
Date:   Thu, 30 May 2019 10:20:36 +0100
Message-Id: <20190530092038.12020-2-quentin.perret@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530092038.12020-1-quentin.perret@arm.com>
References: <20190530092038.12020-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The recently introduced Energy Model (EM) framework manages power cost
tables for the CPUs of the system. Its only user right now is the
scheduler, in the context of Energy Aware Scheduling (EAS).

However, the EM framework also offers a generic infrastructure that
could replace subsystem-specific implementations of the same concepts,
as this is the case in the thermal framework.

So, in order to prepare the migration of the thermal subsystem to use
the EM framework, enable it in the default arm64 defconfig, which is the
most commonly used architecture for IPA. This will also compile-in all
of the EAS code, although it won't be enabled by default -- EAS requires
to use the 'schedutil' CPUFreq governor while arm64 defaults to
'performance'.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..58792e6a06da 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -70,6 +70,7 @@ CONFIG_XEN=y
 CONFIG_COMPAT=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
+CONFIG_ENERGY_MODEL=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
-- 
2.21.0

