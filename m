Return-Path: <linux-pm+bounces-13820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D809700DD
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 10:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABFE1F22A5B
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F310614A605;
	Sat,  7 Sep 2024 08:20:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD01D29E
	for <linux-pm@vger.kernel.org>; Sat,  7 Sep 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697248; cv=none; b=iS265B7PAQVnd2hBQhaND8yts6H7Y2n52azqNCNulzAUa4RxKvyEJZ7z5H+UHhYWtJtVq1U+3cviu00+vJweBlex1kREC3yDKl3teb2+92WeFjehJQNhNKarg9X2PHctLTINZmVp6rdjl56ydrNmOd1DCQzB1zoOSBodWWQvqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697248; c=relaxed/simple;
	bh=Qvuv23+trl8kbf5QGuEFnyvvCLnLOOeB356Qcbw09iQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fLqqx6aN/azFhGh2+zjcqSK55ajTqIJDbHqFEz9C37V0bkWUJXgc7carWvre9bLqyKa5Qwu4Wt30LzoBbAGXdp2jpc0nAhUjMoDCSBMHmo5zHxP2p3fuuKBGy6X5yGg44Vpu7jna7mx3C6dIWRbqR5O50wP+kmFepaLBmBpiE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X15bB2CsbzpVPS;
	Sat,  7 Sep 2024 16:18:46 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 5882B14022D;
	Sat,  7 Sep 2024 16:20:43 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Sep
 2024 16:20:40 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH] OPP: Remove unused declarations in header file
Date: Sat, 7 Sep 2024 16:07:01 +0800
Message-ID: <20240907080701.102266-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)

The definition of _update_set_required_opps() has been removed since
commit e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required
OPPs").

Besides, the definition of _put_opp_list_kref() has been removed since
commit 03758d60265c ("opp: Replace list_kref with a local counter").
Let's remove the empty declarations in header file.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/opp/opp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 318a4ecbabf1..641e4bccf68e 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -263,9 +263,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *o
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, struct dev_pm_opp_data *data, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
 struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
-void _put_opp_list_kref(struct opp_table *opp_table);
 void _required_opps_available(struct dev_pm_opp *opp, int count);
-void _update_set_required_opps(struct opp_table *opp_table);
 
 static inline bool lazy_linking_pending(struct opp_table *opp_table)
 {
-- 
2.17.1


