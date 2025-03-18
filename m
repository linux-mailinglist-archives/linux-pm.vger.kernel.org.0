Return-Path: <linux-pm+bounces-24256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01BA67A43
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013DA420220
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D1212F9F;
	Tue, 18 Mar 2025 17:02:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D7211A11;
	Tue, 18 Mar 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317358; cv=none; b=Oj8SDEqPgmGyuVa+q/6sdWVJyULGoBsAYk4uYGjlgI1GrqzQ4xEFznuOHIovm1/7xLs04cbT/l77nFJyW5W5z27GTl1eANSj5MOkBDLvy2ye5462A9PO5Q8idqP8juV++ffA59Re33dKiD72VZb4k6xuJzy8KYs4TvxfFHqLMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317358; c=relaxed/simple;
	bh=G9kihMReYnuSblQmsr+d7DA+5UjTgx2Nd7YXDM3E4H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nw6eFbSwFq/zZ8JtzAy032AGH25ugI/dJAb464FgzL+fK77uVDqeYVKEjSfavbRfasRIj9/12UlHtyUdeUhUX9mw4tQzb8ZKPLtb+1Qen3M7peb6BDEYgbnWAsTmfGZnt4ruqV3CZGceZzjYD1BwPeMmcdihT/Z3hA5CmRNVN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4183A16F3;
	Tue, 18 Mar 2025 10:02:41 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E1433F673;
	Tue, 18 Mar 2025 10:02:31 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 18 Mar 2025 17:01:40 +0000
Subject: [PATCH v2 2/8] cpuidle: psci: Transition to the faux device
 interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-plat2faux_dev-v2-2-e6cc73f78478@arm.com>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
In-Reply-To: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=G9kihMReYnuSblQmsr+d7DA+5UjTgx2Nd7YXDM3E4H0=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn2aciBJKtfha22avzC5Tb0MJbrWJtrCcKR73lA
 zXDzVm2dc6JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9mnIgAKCRAAQbq8MX7i
 mO1eD/49KrYE5mjwjUXjG2S0M+aANb+/iiS/cIYRvGYXLLQPp1kIWXtPQ/iftzPP+Q3k0KLe/7z
 fO4Kxg2+/PTc/mRXQdngAhSkkCF/ubc3w+KDtIj5kr1Jsc3NOqzut7UccjX6eY4kSEF6GyGacX0
 V17GO5wrgRP+RdE7kHoKV/a4hK+pkq2XhnSMW4ilPKOZOnJ6+9BQ7qC6SuqmgMpnhnUsASgOJP+
 gwfbUtnvdFsSzPjhd7iM4+uxdVR+KJjrAzlTQSKIYvHp0rNfzSQkIh0s5gy6OauH5Z93eA2qLYw
 vwm5YNPuNnWEFFFlbKcmqJd0X9G553fy0VPilq7xX7t9vQem8rQHm2WZf51Wk9Rlr6GFAPyfHk1
 MZlvI4+VD1F6qBoAzeGSp0T9Ukq9ilZDQgx/Bvx0updPl8BHRjgaeaQto+Tx/qAHKjd+GtMhFkW
 4H+ql2fBGOhT9eeBfJQkipnXTRk7rkcfvcCkiLrdr6+FfiMtIezHW4V70Gmbr+1ERhyXD9PTxy5
 ZJChxwrY3fgxxxDTaSjsWV/1oE4Z3WmnuTgYPwi8s+zLL03ObhX8KwCMEc6tJU01WOL9RplRo9o
 WlmGqDKpUAOOgMaV9vk9VrHI8yGzY0XnAm8hhdnZNFoiSv0r68AwviZ+taXa2XAYrFrpwizqpsV
 AwvPJ3djSTUp4mQ==
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
 drivers/cpuidle/cpuidle-psci.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 2562dc001fc1de69732ef28f383d2809262a3d96..5d4d6daed36d8540ba2ce3dc54a3180731b03d22 100644
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
@@ -431,28 +431,4 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_driver psci_cpuidle_driver = {
-	.probe = psci_cpuidle_probe,
-	.driver = {
-		.name = "psci-cpuidle",
-	},
-};
-
-static int __init psci_idle_init(void)
-{
-	struct platform_device *pdev;
-	int ret;
-
-	ret = platform_driver_register(&psci_cpuidle_driver);
-	if (ret)
-		return ret;
-
-	pdev = platform_device_register_simple("psci-cpuidle", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
-		platform_driver_unregister(&psci_cpuidle_driver);
-		return PTR_ERR(pdev);
-	}
-
-	return 0;
-}
-device_initcall(psci_idle_init);
+module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);

-- 
2.34.1


