Return-Path: <linux-pm+bounces-23632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E02A568E5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 14:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F497A3C52
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E800219A91;
	Fri,  7 Mar 2025 13:27:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE48A219A94;
	Fri,  7 Mar 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354036; cv=none; b=qO9EZ1g8DatqlBeOHnKoA14VBGpGCwmiCJ8lm+kFD2B84lCXwTJWSEVYUcMcq86ROwCIF+KLihgSxHIzXQYPg4gAhoeuImgNsRcvl/Is5lcbC8njZAkz1jhtG2Q47eYva5ntzzGmWopB2RyjbkvtX0fBH4lN86Ht1+CfRQ77x+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354036; c=relaxed/simple;
	bh=kxF+meGrN+Y9nPfgY7RbqYnONmGGuWPNBl9Jkuv/GYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBvNNt6RrcmzMiGIUgipmjwDjYvBpTjOedL/5DbV8kol7X/+z0Hv+wEFpxc3OLj7QXmlu7ECgy7pvML9g8PI3567f0MGcGGqG4Erzj8ygCfrN+DApupchq+f/7bB2XAb17B/tIl95f09Tp9CUchdcADyGrqHaycqZXC7Nml9mR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D67A51424;
	Fri,  7 Mar 2025 05:27:25 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.84.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D18E13F66E;
	Fri,  7 Mar 2025 05:27:11 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: lukasz.luba@arm.com,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com,
	jeson.gao@unisoc.com
Subject: [RESEND][PATCH] power: energy_model: Rework the depends on for CONFIG_ENERGY_MODEL
Date: Fri,  7 Mar 2025 13:23:49 +0000
Message-ID: <20250307132649.4056210-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeson Gao <jeson.gao@unisoc.com>

Now not only CPUs can use energy efficiency models, but GPUs
can also use. On the other hand, even with only one CPU, we can also
use energy_model to align control in thermal.
So remove the dependence of SMP, and add the DEVFREQ.

Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
[Added missing SMP config option in DTPM_CPU dependency]
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---

Hi Rafael,

This fixes the issue in the former patch with the DTMP_CPU
implicit build dependencies on SMP.
The original patch can be found here [1] (the one that you had to revert).

Regards,
Lukasz Luba

[1] https://lore.kernel.org/lkml/20241219091109.10050-1-xuewen.yan@unisoc.com/


 drivers/powercap/Kconfig | 2 +-
 kernel/power/Kconfig     | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 69ef8d081c98b..03c4c796d9931 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -82,7 +82,7 @@ config DTPM
 
 config DTPM_CPU
 	bool "Add CPU power capping based on the energy model"
-	depends on DTPM && ENERGY_MODEL
+	depends on DTPM && ENERGY_MODEL && SMP
 	help
 	  This enables support for CPU power limitation based on
 	  energy model.
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index ca947ed32e3dd..54a6236800194 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -380,8 +380,7 @@ config CPU_PM
 
 config ENERGY_MODEL
 	bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
-	depends on SMP
-	depends on CPU_FREQ
+	depends on CPU_FREQ || PM_DEVFREQ
 	help
 	  Several subsystems (thermal and/or the task scheduler for example)
 	  can leverage information about the energy consumed by devices to
-- 
2.48.1


