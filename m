Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C7B42C5BA
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 18:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhJMQDe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 12:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234299AbhJMQDd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Oct 2021 12:03:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 420FD61163;
        Wed, 13 Oct 2021 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634140890;
        bh=ZcDHjeRbgYldiN+EnZbgK8dxzhD9aFEKrAyPnXY8lPY=;
        h=From:To:Cc:Subject:Date:From;
        b=ABu1UtyAkUZRQbClGExgGowpLgosEe5Hj5VWtx3iYLctEXI9CAU9Sb7I1zpAg7Ob+
         0l1C6OCCsVq0y5YSAZGFBvAFNgypdmqSHUqATY3WKOWHFaacZIQPZiO5X/8TLtk3Df
         GYW03I3i59UJ+fPp1Buwhd4W4t5f0FpJqC5Z0YIx/IBDdyWS+9ka9BaKZG2nYbiEO2
         daY2q7H/qwNRe4mKqnCeulT9PFllORoXxhUQ03ITerAdlCf/9WxfS5zt74Bw0iK7Kr
         B1ldeb1igpHSZDCj8KkAguDmwYQFgjxV5o9sOoqC3SlDgfpXPCyqNbBqls+5mE+77T
         0YA2wzbPkaHTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        He Ying <heying24@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: tegra: add ARCH_SUSPEND_POSSIBLE dependency
Date:   Wed, 13 Oct 2021 18:01:19 +0200
Message-Id: <20211013160125.772873-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some StrongARM processors don't support suspend, which leads
to a build failure with the tegra cpuidle driver:

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
  Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
  Selected by [y]:
  - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

arch/arm/kernel/sleep.o: in function `__cpu_suspend':
(.text+0x68): undefined reference to `cpu_sa110_suspend_size'

Add an explicit dependency to make randconfig builds avoid
this combination.

Fixes: faae6c9f2e68 ("cpuidle: tegra: Enable compile testing")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpuidle/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 2cc3c208a180..af97992eaa82 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -100,6 +100,7 @@ config ARM_MVEBU_V7_CPUIDLE
 config ARM_TEGRA_CPUIDLE
 	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
 	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
+	depends on ARCH_SUSPEND_POSSIBLE
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_CPU_SUSPEND
 	help
-- 
2.29.2

