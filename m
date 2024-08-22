Return-Path: <linux-pm+bounces-12723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5695B630
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBAF281F21
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D791C9EC4;
	Thu, 22 Aug 2024 13:14:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED761C9EAB
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332447; cv=none; b=CDOE9eUxy0kGxYp9ekB4QTD+i8963qLN5UFF35UIPR9hW426FwAl9oRLQjCkriTXIomrawWMsXUyHNTEJaHp4g3f0AMPqRY+jft5YXTUJMHxqzJ9aS4PUV5X4lb1zL1xcH0owY8wUze9ArG6ohC4egmdGumBgT6R/R/t6IvR+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332447; c=relaxed/simple;
	bh=YkQfVMFDiPciKtRHvs2GesCmkYo985odCCVOpIOJO7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hdEZ9x6mTax5nftzWaXg2SKde5VyYZdMMkm4LwaySso5x4f7OwZApN5TepNPvPcva9trf9zCtBAeU6bjxnhM8kQvS3om7CGUHSq6cab0dkgirkDF1IB5Cr75WE0mNjl7arzpKUEgeSb+IAD1O6oF48n1YMVKOH72BruHMlCgY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqNtq3lKGzyR2g;
	Thu, 22 Aug 2024 21:13:39 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AFE01800FF;
	Thu, 22 Aug 2024 21:14:03 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Aug
 2024 21:14:02 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 0/2] Some cleanup and fix the missing of_node_put()
Date: Thu, 22 Aug 2024 21:00:53 +0800
Message-ID: <20240822130055.50113-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Fix the missing of_node_put() of args.np and use the scoped
of_node_put() to simplify code.

Zhang Zekun (2):
  pmdomain: ti-sci: Add missing of_node_put() for args.np
  pmdomain: ti-sci: Use scope based of_node_put() to simplify code.

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

-- 
2.17.1


