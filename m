Return-Path: <linux-pm+bounces-24146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A1AA6491D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 11:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276EB16D384
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906DC23371D;
	Mon, 17 Mar 2025 10:13:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE222CBCB;
	Mon, 17 Mar 2025 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206435; cv=none; b=N0a+C6qIcMHPA+dY4eI3QChpLBaIt6E5T/EPcIBJ/Z7qMDrogBY8GO0HyfsA+YjZPur0DiU9YUFrYz8Mwmjxqwits/L+md0DACKqoq5J4gxJkuEIH6PbRkmsdCgWqmFch5QLBC2ifvNV1AykYEatlGvGsHHymW90x+mkTEUoDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206435; c=relaxed/simple;
	bh=CI87/B0Z+bu/xDS4edBZdD4AK/oZaz/fs000mRMbt+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLp9rHBYTHTPvxS78ay1bXvpwyYVJWPl7fyro0hZ7d2ni6UDG1+N+u3gsDwXioU//7jIU+wizL72NN2Zwkh/h/vuDyFlS061H9miDVw/awQ9gvMlOYNSjs8y56cZCllKDCiXyWu32X/Cd/HIzg9YrXEParbqYh8+iwIwnBK07kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E6A169E;
	Mon, 17 Mar 2025 03:14:02 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02BD43F673;
	Mon, 17 Mar 2025 03:13:51 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Mar 2025 10:13:13 +0000
Subject: [PATCH 1/9] cpuidle: psci: Transition to the faux device interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-plat2faux_dev-v1-1-5fe67c085ad5@arm.com>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=CI87/B0Z+bu/xDS4edBZdD4AK/oZaz/fs000mRMbt+U=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn1/XaZ+U6uYLveI1x2mPg1VMHlAy/5EmFDW6ki
 UUkAdRCsUeJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9f12gAKCRAAQbq8MX7i
 mAZAEACbwv+dihKcag5jpxHMiyu2m1tRcIhD3ISHTbNxkv4JJPcLPZ0C5U6Zxk3ubxo2O5yNx5O
 zmuft6lLuUIPHFTbHPA1mMHxtL3Jv6Bgmr/hg54CREtWOEIrJbpbu8NYVXKjBNn7cfdxOw9xMti
 x6m+2zCOM/22nDJgRDg40HFMEBKuvf08hl/shDtJMSULUwRXHehbGCP5ADE8L8bEZ2nv7Y++MmB
 rectjYgKvEFvZZqcBh3svsU13HPf2oCDJcaAjbQsIt9q8SLCZR/w+EP4ABRdTfoaXHWI2gjmvL4
 Gts2p0FO7A6DSvPLVyh4gAspH+nRuxH5XOStdgDXfmefCl1P/aPLFER4VgH+LgVp7Srkw8u3iGE
 fDPolaWURybWKp92n+4eEJo0ybIxzA5GzWmbFYq/w/yqyP/Ka6RV+p42gGjfFVWFLe5luhfbI7j
 JoFZDl5uzhjiFuMCz5o87CgLRPUf62N6S79Khkbkq5Tdc8TCu4bnxQl0g868gnWHl/cjmRP1ph3
 Es56Jyan+ewb9aRvp0xOGb30yh9aSghwwg2m61FegFXSTObTxy7mDM1GV12GUiey6PHPeEAFb0P
 VYEhCnFWBzFAUchrmzyqPlJz1SVle7YqIFS06lj+zFbwt8WH0I8wKtLzGCMcRXRjPw0mfZEEi1A
 RQv2dLcNIgXb/Zw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The PSCI cpuidle driver does not require the creation of a platform
device. Originally, this approach was chosen for simplicity when the
driver was first implemented.

With the introduction of the lightweight faux device interface, we now
have a more appropriate alternative. Migrate the driver to utilize the
faux bus, given that the platform device it previously created was not
a real one anyway. This will simplify the code, reducing its footprint
while maintaining functionality.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpuidle/cpuidle-psci.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 2562dc001fc1de69732ef28f383d2809262a3d96..3e38f712dab3785d5caa8d103fd0146156005921 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/psci.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -404,14 +404,14 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
  * to register cpuidle driver then rollback to cancel all CPUs
  * registration.
  */
-static int psci_cpuidle_probe(struct platform_device *pdev)
+static int psci_cpuidle_probe(struct faux_device *fdev)
 {
 	int cpu, ret;
 	struct cpuidle_driver *drv;
 	struct cpuidle_device *dev;
 
 	for_each_possible_cpu(cpu) {
-		ret = psci_idle_init_cpu(&pdev->dev, cpu);
+		ret = psci_idle_init_cpu(&fdev->dev, cpu);
 		if (ret)
 			goto out_fail;
 	}
@@ -431,26 +431,18 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_driver psci_cpuidle_driver = {
+static struct faux_device_ops psci_cpuidle_ops = {
 	.probe = psci_cpuidle_probe,
-	.driver = {
-		.name = "psci-cpuidle",
-	},
 };
 
 static int __init psci_idle_init(void)
 {
-	struct platform_device *pdev;
-	int ret;
+	struct faux_device *fdev;
 
-	ret = platform_driver_register(&psci_cpuidle_driver);
-	if (ret)
-		return ret;
-
-	pdev = platform_device_register_simple("psci-cpuidle", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
-		platform_driver_unregister(&psci_cpuidle_driver);
-		return PTR_ERR(pdev);
+	fdev = faux_device_create("psci-cpuidle", NULL, &psci_cpuidle_ops);
+	if (!fdev) {
+		pr_err("Failed to create psci-cpuidle device\n");
+		return -ENODEV;
 	}
 
 	return 0;

-- 
2.34.1


