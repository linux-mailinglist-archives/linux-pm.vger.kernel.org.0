Return-Path: <linux-pm+bounces-12594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B213959374
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 05:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2641C20E70
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 03:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020C157E62;
	Wed, 21 Aug 2024 03:53:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70455158521
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724212412; cv=none; b=DQHXbUftl0Fp+IVx4ZOB/udciOWyyWv0FuvcLznPiwffOIUYFl1SXoZd0CYiYTt3DhTSTzSpfAOyXYx6fzy9wdBYquvGn21wMfLvXqIhkd7c0xKE7nIeoXp+jNd01Ml0nudMGg6v9pkf7a+UKHx9q7whgEkFPJI9pztxgI/cFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724212412; c=relaxed/simple;
	bh=LwIocD+Bj7ufNqJaTemsHCdmz6J/0XvcIDHX8Trd+3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ujhxDKgbDl9F2rk22p4HonNVLVpT13pLzwUJge2q8NQ5Bheb+j1mGj3hymZrsIg60FXpGXkCULQ3rrplVXo80QeBrcDzwSmxEBWmI15KaNbY0Oy4nSV3khAnLFduNw+m9ovper8chm8yWM4wOdXazhUcV8zKuktkhGHmbTuuohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WpXV842PSz13bLF;
	Wed, 21 Aug 2024 11:52:48 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 165471800A4;
	Wed, 21 Aug 2024 11:53:27 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 11:53:26 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 0/2] Some cleanup with use of helper functions
Date: Wed, 21 Aug 2024 11:40:20 +0800
Message-ID: <20240821034022.27394-1-zhangzekun11@huawei.com>
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

Using for_each_available_child_of_node() and scoped of_node_put() to
do some cleanup, this can make code more simple.

Zhang Zekun (2):
  pmdomain: qcom-cpr: Use helper function
    for_each_available_child_of_node()
  pmdomain: qcom-cpr: Use scope based of_node_put() to simplify code.

 drivers/pmdomain/qcom/cpr.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

-- 
2.17.1


