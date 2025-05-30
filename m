Return-Path: <linux-pm+bounces-27843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72016AC89DF
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E6A9E53B4
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879E2135DD;
	Fri, 30 May 2025 08:24:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97A2192FD
	for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748593475; cv=none; b=VXPXZZXNRz/svUzBPLJPNHDHsyUEusBcGjy5JWOiV3yX0c5QrtH7ZnjblrsxUajJ8afj14SZkrC5B1g3WqBHvVr9Vt4+s7OreJKc0EwakxhML9yJl2fXyeTrRs1zjgN57mq/GRFR5Wvtdj5ni7LdJZkluFIPSzUpQ8kU0zHHLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748593475; c=relaxed/simple;
	bh=dIjCl6o0TfYodjabNyfEGMF8XXW+Rj7la6/Se4FPLIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcjNzTVbQgTyv63GNqrSHLO7SMprIK1Lv2gIxG1QWB89DzOy2YZnrv7cy2LMTiccdyx9YzJsbD6kz4SyljWtuZrEZJd0bSMvyhm95Il8aRlcplUu9bvJtPClKcFcTSHrOGpVJx/v1MdEcZVDOPwibp6Qow1QFh8UYc1/q4Zl9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4b7x4b6grVzQjvN;
	Fri, 30 May 2025 16:20:15 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id B1E8118046A;
	Fri, 30 May 2025 16:24:23 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100006.china.huawei.com (7.202.195.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 May 2025 16:24:22 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <alireza.sanaee@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<liwei728@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v4 1/2] PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
Date: Fri, 30 May 2025 16:17:21 +0800
Message-ID: <20250530081722.280776-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250530081722.280776-1-zhanjie9@hisilicon.com>
References: <20250530081722.280776-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Extend the devfreq_dev_profile to allow drivers optionally create
device-specific sysfs ABIs together with other common devfreq ABIs under
the devfreq device path.

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


