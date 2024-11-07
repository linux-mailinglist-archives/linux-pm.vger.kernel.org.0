Return-Path: <linux-pm+bounces-17097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624B99BFD06
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 04:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947C51C21C49
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 03:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C618FDA3;
	Thu,  7 Nov 2024 03:37:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A84364D6;
	Thu,  7 Nov 2024 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950653; cv=none; b=vCn0Vwce7LicmGgiyE3322DLVDhK413/sZ1me95cez1fR2iym1z5OHTHV5YwH2+Bri9JQNQMtRWYZ3+PZeSpeSkhdIPBHUBQE4kXY6E2TkIa9QagqeJL9uRUSCHIkJsZaaJzz2iByLm8LfNpv9IyEXsMl+rvMIW4s+b1aaPIUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950653; c=relaxed/simple;
	bh=NwOubgdHIIpjYC991G4+DrMfD8Gc/C2T1lYTvXvcmLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPvd3VhgYsBOB6VynIXmy6+RFnwbtP1zYmyR5rA2Z45cRf0azsilCT3rUHn79JXY05l06ROVtTQFj61xEf9HYHhnNnw7n/Mq//ZVdwnKla1DZzINBanS8Dp7V7YeJSkZHs0c97+4lpqmLr3Vzdvu1UcwUuqobtjV+TEFAaewRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XkSQS1GwXz1SG9b;
	Thu,  7 Nov 2024 11:35:44 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B4E601401F4;
	Thu,  7 Nov 2024 11:37:26 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 11:37:26 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 11:37:25 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-pm@vger.kernel.org>, <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 2/2] hwmon: (acpi_power_meter) Fix fail to load module on platform without _PMD method
Date: Thu, 7 Nov 2024 11:26:26 +0800
Message-ID: <20241107032626.16682-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20241107032626.16682-1-lihuisong@huawei.com>
References: <20241107032626.16682-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)

As ACPI spec said, _PMD method is optional. The acpi_power_meter
shouldn't fail to load when the platform hasn't _PMD method.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/acpi_power_meter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 6c8a9c863528..2f1c9d97ad21 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -680,8 +680,9 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
 {
 	int res = 0;
 
+	/* _PMD method is optional. */
 	res = read_domain_devices(resource);
-	if (res)
+	if (res != -ENODEV)
 		return res;
 
 	if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
-- 
2.22.0


