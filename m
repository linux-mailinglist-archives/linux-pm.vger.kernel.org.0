Return-Path: <linux-pm+bounces-29100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA1AE0A3C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 17:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EB97A2B26
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA7221D98;
	Thu, 19 Jun 2025 15:22:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D21B3923
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346538; cv=none; b=DeyplPUFvackCcaF6Wo89HaAhLZqpFF2DOh/drZi6+8JTvoHjvowDOMvaA8lW9RnKVthWD77foT53qOrYt+fJveU3fhcAe+GW/yIKfXB4HLWCnlQ1MH/Wb/AftCvyFSErKv2+afHDU6FSf9xlnqo7XGjkm9SVm+iJzRUNV8uSmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346538; c=relaxed/simple;
	bh=gWiaIKikxlyF4B6j96M3BYTe02cI9VvBhMmLWvZbgWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJHAUL00wEmtCuHlZjCCLc30P4OArj6agAXC6Vk+CAEOQI4XOAfQalrcTlWaP9Wzp/2PYzxe1Lu5C/aDcRbdprPIMdE+6s+6wpHMxHHz0DguhmCiJ40Qa4DgIsZyEig0cH9e6AMleiuosvPpwCUKQ4Iw0gP+R8VZvMfgdIRsYXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bNPWD71gcz2y8x5;
	Thu, 19 Jun 2025 23:23:04 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id D86C9140113;
	Thu, 19 Jun 2025 23:22:10 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100006.china.huawei.com (7.202.195.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 23:22:10 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <jonathan.cameron@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>, <alireza.sanaee@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<liwei728@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v5 1/2] PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
Date: Thu, 19 Jun 2025 23:14:55 +0800
Message-ID: <20250619151456.3328624-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250619151456.3328624-1-zhanjie9@hisilicon.com>
References: <20250619151456.3328624-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Extend the devfreq_dev_profile to allow drivers optionally create
device-specific sysfs ABIs together with other common devfreq ABIs under
the devfreq device path.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 1 +
 include/linux/devfreq.h   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 46f3a8053197..59f4656f5ed6 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -831,6 +831,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
+	devfreq->dev.groups = profile->dev_groups;
 	devfreq->dev.release = devfreq_dev_release;
 	INIT_LIST_HEAD(&devfreq->node);
 	devfreq->profile = profile;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d312ffbac4dd..dc1075dc3446 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -103,6 +103,8 @@ struct devfreq_dev_status {
  *
  * @is_cooling_device: A self-explanatory boolean giving the device a
  *                     cooling effect property.
+ * @dev_groups:		Optional device-specific sysfs attribute groups that to
+ *			be attached to the devfreq device.
  */
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
@@ -119,6 +121,8 @@ struct devfreq_dev_profile {
 	unsigned int max_state;
 
 	bool is_cooling_device;
+
+	const struct attribute_group **dev_groups;
 };
 
 /**
-- 
2.33.0


