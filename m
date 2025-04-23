Return-Path: <linux-pm+bounces-25991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0100CA97C60
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 03:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B121460085
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BBD266EE2;
	Wed, 23 Apr 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1GkWr2H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D3266B70;
	Wed, 23 Apr 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372835; cv=none; b=pyVJBXXlNKN0ccx0NAjsuACV22+zpCt3KLsCrPUIZ2WxUz7uegl5nQECj1mLr8vbgY+zQce8ytKibsODdyA9utfnx6XuutIgG69dBn8uO1FI3eod3g8Dd7vRL759dX3BWujqQ/omv60fshDMASYhWM93GnsIDkdIlLgHp79F4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372835; c=relaxed/simple;
	bh=wxhYEGNpiWIhzH7Mo/pycoZJIumcH7mRdwRvDFsadCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDLJcj7cdk5NHo1jnvwbbsWo9LE4jMXqnqjAq8TaJ/PvB9IOzFLuhKcQEANx8etUvsDTwnxLZcNldlpjxWKQiicik81MJa9jLxDnq8OFSjDseQRxz9pU09kLiza9v8yTFV1ipUQF7634AnMoD4Q30X9GsDoEFj5O9j7s8cC8PWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1GkWr2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1242BC4CEF4;
	Wed, 23 Apr 2025 01:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372833;
	bh=wxhYEGNpiWIhzH7Mo/pycoZJIumcH7mRdwRvDFsadCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1GkWr2HtfPvlp7gx9RIk+ZqkOGkf5AQDc+aerOShcv61LLvUSxbYdUpjSixX8rfT
	 hpM6Bx7od1VYiroaeMl25fM9Jd4izV6CqZaNru0YPCTZ6LzOFUgPERF2cYdue918lf
	 J+MxFNk79vKHK+zGJc5c7pLrsZFvMmZhKHrt0lTorJ+7JYYCzC9gJnjAnvzpX0BEI2
	 4vDlV4CGnFQKLGdYvTnUkT6BV+WC7rNUW59qcdWcphYhYGeuV4VHpgIGd7F2oZdGsi
	 559qqHmBCBtIOw+v5lIqklJR4Ne/T3PQVtnFLdqiR3+JbyQPzPhirxHXWnJpELKDjh
	 4RVWpRmdjWEPQ==
From: Mario Limonciello <superm1@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	platform-driver-x86@vger.kernel.org (open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER),
	Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v9 08/13] platform/x86: hfi: add power management callback
Date: Tue, 22 Apr 2025 20:46:26 -0500
Message-ID: <20250423014631.3224338-9-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423014631.3224338-1-superm1@kernel.org>
References: <20250423014631.3224338-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Perry Yuan <Perry.Yuan@amd.com>

Introduces power management callbacks for the `amd_hfi` driver.
Specifically, the `suspend` and `resume` callbacks have been added
to handle the necessary operations during system low power states
and wake-up.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 1472214dc809f..921e07acf2ff1 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -384,6 +384,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	return ret;
 }
 
+static int amd_hfi_pm_resume(struct device *dev)
+{
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		ret = amd_hfi_set_state(cpu, true);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable workload class config: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int amd_hfi_pm_suspend(struct device *dev)
+{
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		ret = amd_hfi_set_state(cpu, false);
+		if (ret < 0) {
+			dev_err(dev, "failed to disable workload class config: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_hfi_pm_ops, amd_hfi_pm_suspend, amd_hfi_pm_resume);
+
 static const struct acpi_device_id amd_hfi_platform_match[] = {
 	{"AMDI0104", 0},
 	{ }
@@ -433,6 +465,7 @@ static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
 		.owner = THIS_MODULE,
+		.pm = &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
-- 
2.43.0


