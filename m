Return-Path: <linux-pm+bounces-16336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22369ADA41
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 05:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1AA1C21603
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 03:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD815B543;
	Thu, 24 Oct 2024 03:09:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C242158DD8
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739374; cv=none; b=DxyWSHwUuir4nVTOm5WKc2aEM3pIqBnt9lB40ccFaD1el9C3d2Wi4WpacNk2oSd7pf2b4j640bUDHHxkIKlCTwOsidhITZGT5C/qrXkt1xwaZUtEXX7W/SnW5ezNpP5aSrYK72PiK6KuHjbLSfxzCZgG4HtJmYszdbwrDhbA5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739374; c=relaxed/simple;
	bh=QBTj/kKbITc4XAvlmUd/dhwm2RoK/ZtoeCiBQf8lTJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzBNWa1Z4hikq5VDSJKqMoxdHiJk1XZ4vxNx+i+4bNX6FrcObR25ASlxzRxs0LOxFc6C78cxSWal9Cp1wASv231rNpt9jRGjZbCWrAJk3yJP8wqFhuAkMv8pc0sgSLktRCmCQHhaxyw9PKO01foR3PsCdqETrLdJtXiLCnSRtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XYrT172ybz1jvrv;
	Thu, 24 Oct 2024 11:08:05 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id D02E31A0188;
	Thu, 24 Oct 2024 11:09:29 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 11:09:28 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.org>, <d-gole@ti.com>, <linux-pm@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH v3 0/2] Some cleanup and fix the missing of_node_put()
Date: Thu, 24 Oct 2024 11:04:40 +0800
Message-ID: <20241024030442.119506-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Fix the missing of_node_put() of args.np and use the scoped
of_node_put() to simplify code.

v3:
- Improve the commit message.
- Link to v2:
  https://lore.kernel.org/all/20240926012551.31712-1-zhangzekun11@huawei.com/

v2:
- Add missing brackets in patch [1/2].
- Link to v1:
  https://lore.kernel.org/all/20240822130055.50113-1-zhangzekun11@huawei.com/

Zhang Zekun (2):
  pmdomain: ti-sci: Add missing of_node_put() for args.np
  pmdomain: ti-sci: Use scope based of_node_put() to simplify code.

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.17.1


