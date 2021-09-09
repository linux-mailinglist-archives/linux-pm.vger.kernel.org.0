Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E756405997
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhIIOsQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbhIIOru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39065C0698DB
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:41 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyelhIVlczKhhf0IFRn/DI600Onyf5ztzQI6u+eD0kE=;
        b=KF71p/AD+RKCm2baApwd2a+3jGFLv+ng+drRFHBXVBlH0/9X0i6R16dFivxQbJDZx/9Y7o
        XblEM3na30NWVgcPfDWM1+yE/sAHSryJw1EXPSxte4i9CwDD96gnsOX+IYNtukho8+xFBd
        +M47zQ+4PqETkScufXBI9ocEeIpUdmkKPWVnaqHi64L+fFNH7snS+nel0MV/MTxSc+nlE+
        QYSK7vsMisG1jR7OT8PmjU7lu00/l/ZLjAvudqL6DqofroJo8stax4bCny7seuvtbVUWtO
        GvmDMJjd+FTW04WEoayiYfVxyqTSx40IMHx5vVKMRH9xpfz8fqba42ZQIXRcgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyelhIVlczKhhf0IFRn/DI600Onyf5ztzQI6u+eD0kE=;
        b=xGpTbmTuB6txhwZ0/UqzGc0NU7ABysbN3gyKbmW2A7LMaVMvcErxGk2Fa5MFW/bCqc6Qu6
        HtF3XF83EBGViPBg==
From:   "thermal-bot for Sumeet Pawnikar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/int340x: Use IMOK independently
Cc:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org
In-Reply-To: <20210716163946.3142-1-sumeet.r.pawnikar@intel.com>
References: <20210716163946.3142-1-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Message-ID: <163119831911.25758.10236238464567355110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f1b07a14694be02b2b87e2fe6def6cff2f4bd452
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f1b07a14694be02b2b87e2fe6def6cff2f4bd452
Author:        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
AuthorDate:    Fri, 16 Jul 2021 22:09:46 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 15:39:13 +02:00

thermal/drivers/int340x: Use IMOK independently

Some chrome platform requires IMOK method in coreboot. But these platforms
don't use GDDV data vault in coreboot. As per current code flow, to enable
and use IMOK only, we need to have GDDV support as well in coreboot. This
patch removes the dependency for IMOK from GDDV to enable and use IMOK
independently.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210716163946.3142-1-sumeet.r.pawnikar@intel.com
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 14 +++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 823354a..19926be 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -108,9 +108,12 @@ static struct attribute *imok_attr[] = {
 	NULL
 };
 
+static const struct attribute_group imok_attribute_group = {
+	.attrs = imok_attr,
+};
+
 static const struct attribute_group data_attribute_group = {
 	.bin_attrs = data_attributes,
-	.attrs = imok_attr,
 };
 
 static ssize_t available_uuids_show(struct device *dev,
@@ -522,6 +525,12 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (result)
 		goto free_rel_misc;
 
+	if (acpi_has_method(priv->adev->handle, "IMOK")) {
+		result = sysfs_create_group(&pdev->dev.kobj, &imok_attribute_group);
+		if (result)
+			goto free_imok;
+	}
+
 	if (priv->data_vault) {
 		result = sysfs_create_group(&pdev->dev.kobj,
 					    &data_attribute_group);
@@ -545,6 +554,8 @@ free_sysfs:
 	}
 free_uuid:
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
+free_imok:
+	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
 free_rel_misc:
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
@@ -573,6 +584,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	if (priv->data_vault)
 		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
+	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
 	thermal_zone_device_unregister(priv->thermal);
 	kfree(priv->data_vault);
 	kfree(priv->trts);
