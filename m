Return-Path: <linux-pm+bounces-11870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D555A946835
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2024 08:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5EF1F219F2
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2024 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4C714D28E;
	Sat,  3 Aug 2024 06:37:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A00136350;
	Sat,  3 Aug 2024 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722667079; cv=none; b=kQ/0bjQ2yice8Uwl0RRI3tSFm/lNIgHUhW9/rDGKiuuGGFNnnon6ZfNNgYJ++4oUoZICyd6c7/dR7KpOQ+vGAqP9EHwwH0EiSN+9+ZbzUPuphsYG/QoAmRlnqBqkFQiub5uJJfLWLy87KRaMXi2YFOVWL+FG77QoopN8ISWFZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722667079; c=relaxed/simple;
	bh=qhvEFc+kU2nhVtJsl/07evnkLD5j58RU75DoN0k+7bc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W9rm/Sqo3YOUvc/MBJQK368T+bV+ioWx4n5xWRQvDc9fe7Rh1QCXc220KQegPM4G5TuepVpQnQADBMO3rShKP4EFu28knbhei0uamtqBPZBQfctS+iU77VgBvp/fcjxzXClGz0I+mhIh0/uK6Pcu9uzHTiwaBl8a0k0QcOevEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WbXvq1SwpzQnXr;
	Sat,  3 Aug 2024 14:33:27 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D2991800A4;
	Sat,  3 Aug 2024 14:37:49 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 3 Aug 2024 14:37:48 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <digetx@gmail.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <cuigaosheng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH -next] PM / devfreq: tegra30: Add missing clk_disable_unprepare in devm_tegra_devfreq_init_hw
Date: Sat, 3 Aug 2024 14:37:48 +0800
Message-ID: <20240803063748.325133-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Add the missing clk_disable_unprepare() before return in
devm_tegra_devfreq_init_hw().

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/devfreq/tegra30-devfreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4a4f0106ab9d..c19f8848d217 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -809,12 +809,15 @@ static int devm_tegra_devfreq_init_hw(struct device *dev,
 
 	err = devm_add_action_or_reset(dev, devm_tegra_devfreq_deinit_hw,
 				       tegra);
-	if (err)
+	if (err) {
+		clk_disable_unprepare(tegra->clock);
 		return err;
+	}
 
 	err = reset_control_reset(tegra->reset);
 	if (err) {
 		dev_err(dev, "Failed to reset hardware: %d\n", err);
+		clk_disable_unprepare(tegra->clock);
 		return err;
 	}
 
-- 
2.25.1


