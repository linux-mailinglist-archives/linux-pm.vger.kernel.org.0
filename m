Return-Path: <linux-pm+bounces-14761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47206986AA8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 03:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E591C20830
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F217838D;
	Thu, 26 Sep 2024 01:40:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42B14D444
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314816; cv=none; b=PISJPwv/eYzrNX6BxQYpshGpk4770WVVTVbPMA3QJuba41+Yt0lZExpFQxgl7KqQc02dgYI2uI8jm3G73Xovq+sHaLag7JXYVH+bQysuKrV5ITMPuXgugj87WlXsPMfhrOq5D71DhKkLU7AlnuFnCATaxe+RCz3AYVwBUqHNKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314816; c=relaxed/simple;
	bh=7azim5hjllC69o+nlmeKdEbR3EOG0vGsv6tCoIMRY1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WAfAQ1iRv0ThC8Ib1XfOZpeS2lZ+N90IozaS73yHD+MljzOuYP1QbQoAw2x/GyqFh93XZIqhetTvPcZUVPPjSZ4RDvWoYSA7OxWBn7obk1qKpV8fJ8m+zeTfntkIMpRTBq4mmNbMI5UNhfd32sIxqxDsLhmZu6hBCJY56PPWWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XDbrW4YVsz1ymH0;
	Thu, 26 Sep 2024 09:40:11 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id C4DD61400D5;
	Thu, 26 Sep 2024 09:40:09 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Sep
 2024 09:40:09 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [RESEND PATCH v2 0/2] Some cleanup and fix the missing of_node_put()
Date: Thu, 26 Sep 2024 09:25:49 +0800
Message-ID: <20240926012551.31712-1-zhangzekun11@huawei.com>
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

v2: Add missing brackets in patch [1/2].

Zhang Zekun (2):
  pmdomain: ti-sci: Add missing of_node_put() for args.np
  pmdomain: ti-sci: Use scope based of_node_put() to simplify code.

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.17.1


