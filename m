Return-Path: <linux-pm+bounces-1454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D85081AAFA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 00:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A241F247EE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 23:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE084D105;
	Wed, 20 Dec 2023 23:17:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148DE4CDF8;
	Wed, 20 Dec 2023 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FA8F2F4;
	Wed, 20 Dec 2023 15:17:50 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62D2E3F64C;
	Wed, 20 Dec 2023 15:17:04 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 8/9] thermal/sysfs: Update governors when the 'weight' has changed
Date: Wed, 20 Dec 2023 23:17:52 +0000
Message-Id: <20231220231753.1824364-9-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220231753.1824364-1-lukasz.luba@arm.com>
References: <20231220231753.1824364-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support governors update when the thermal instance's weight has changed.
This allows to adjust internal state for the governor.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_sysfs.c | 3 +++
 include/linux/thermal.h         | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 299c0fb16593..5abf6d136c24 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -940,6 +940,9 @@ ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 	/* Don't race with governors using the 'weight' value */
 	mutex_lock(&instance->tz->lock);
 	instance->weight = weight;
+
+	thermal_governor_update_tz(instance->tz,
+				   THERMAL_INSTANCE_WEIGHT_CHANGED);
 	mutex_unlock(&instance->tz->lock);
 
 	return count;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1b76878cea46..a759570de364 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -53,6 +53,7 @@ enum thermal_notify_event {
 	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
 	THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal zone */
 	THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal zone */
+	THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight changed */
 };
 
 /**
-- 
2.25.1


