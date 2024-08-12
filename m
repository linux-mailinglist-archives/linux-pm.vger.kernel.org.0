Return-Path: <linux-pm+bounces-12069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527294EDA7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C07B23AEE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E284175D45;
	Mon, 12 Aug 2024 13:05:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6872170A1C
	for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467940; cv=none; b=dKnSyG3ENMrn3pLOjg29PoAemQxamBIqrqeFRcYnc5n9jkxL9bMQW5ZNb2tR4AU2yrl8kqNMo/oEj1ltX9liaIMaK1wppnbDGPcamW0yBlo4z9SPppzYLLOar1ZnclwH6ATGH0ZC64qUC1lUCY9ZQmBH84g/ZRTEs28o1vJIe+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467940; c=relaxed/simple;
	bh=3YZGrATrWGMLpL8Yt8zup8dGYkARJRmgRgZIhZd885w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tFpRS5D8OyGlk45loJHJ5YvBFSUSU0DpXfIADsSNSr/JbWNRSufoA7fS/RXf8MfUJGqR8AvPWIeQp5vACGsZvJU1xt1n1bO0CurAPn5pIbsyfE2yJxJc4OhSSjKUl4veULetFTnhTk3zCjlRJ110mKqOqrKc7QWF4DD5IX5FlpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WjF3q4Thyz2CmdS;
	Mon, 12 Aug 2024 21:00:07 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D05014035E;
	Mon, 12 Aug 2024 21:04:57 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 Aug
 2024 21:04:56 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <edubezval@gmail.com>, <j-keerthy@ti.com>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <linux-pm@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH] thermal: ti-soc-thermal: Remove unused declarations
Date: Mon, 12 Aug 2024 20:52:10 +0800
Message-ID: <20240812125210.94280-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500003.china.huawei.com (7.202.181.241)

The functions definition of ti_bandgap_read_thot(),
ti_bandgap_write_thot(), ti_bandgap_read_tcold() and
ti_bandgap_write_tcold() has been removed since commit 9bebf3485c6a
("thermal: ti-soc-thermal: remove dead code"), remain the declarations
untouched in the header files. So, clean up this unused declarations.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 1f4bbaf31675..46263c1da8b6 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -336,10 +336,6 @@ struct ti_bandgap_data {
 	struct ti_temp_sensor		sensors[];
 };
 
-int ti_bandgap_read_thot(struct ti_bandgap *bgp, int id, int *thot);
-int ti_bandgap_write_thot(struct ti_bandgap *bgp, int id, int val);
-int ti_bandgap_read_tcold(struct ti_bandgap *bgp, int id, int *tcold);
-int ti_bandgap_write_tcold(struct ti_bandgap *bgp, int id, int val);
 int ti_bandgap_read_update_interval(struct ti_bandgap *bgp, int id,
 				    int *interval);
 int ti_bandgap_write_update_interval(struct ti_bandgap *bgp, int id,
-- 
2.17.1


