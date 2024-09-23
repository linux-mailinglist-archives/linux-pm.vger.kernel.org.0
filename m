Return-Path: <linux-pm+bounces-14548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF797E4BE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 04:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656251F21015
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 02:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB6184;
	Mon, 23 Sep 2024 02:02:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBF2564
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727056968; cv=none; b=ge9/5sZ3jGeW6CLByh0lb4hlcD8mtQ7X2r7OPOf/EUaZlvhlzyzVg1NCxJ60i7Y895PSufXhfFB1KK1HFrLY8bs7JHDd1jQIv3xawuZc8MRiGKLk8yBmHaXN4ZjvwRZONu5taritTFRlcWFK2rsMJ7R9JJBTAdrAkvPRoXwRtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727056968; c=relaxed/simple;
	bh=7azim5hjllC69o+nlmeKdEbR3EOG0vGsv6tCoIMRY1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tNCtfA3qbKVVDgYHfb45WQnwMiCNX/LsJF5XLCFbU10Xkt2eUfcM4oQ6YPqc2mTNxTJiOpN/oKQlo1P1V4ByPZS35pGnEfIwoO9+o2xkKuRr1Knt+juv0xZ0HaGmwnCLOMO9hn90OvIAwnoyBJxsGRn1GusT0arF1c7Oo5dnP3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XBmPP3DY8z1HFmy;
	Mon, 23 Sep 2024 09:58:49 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 468691400F4;
	Mon, 23 Sep 2024 10:02:37 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 10:02:36 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.or>, <linux-pm@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH v2 0/2] Some cleanup and fix the missing of_node_put()
Date: Mon, 23 Sep 2024 09:48:23 +0800
Message-ID: <20240923014825.85176-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Fix the missing of_node_put() of args.np and use the scoped
of_node_put() to simplify code.

v2: Add missing brackets in patch [1/2].

Zhang Zekun (2):
  pmdomain: ti-sci: Add missing of_node_put() for args.np
  pmdomain: ti-sci: Use scope based of_node_put() to simplify code.

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.17.1


