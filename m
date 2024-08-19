Return-Path: <linux-pm+bounces-12423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC9F9569E9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB41C22ABC
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38558166F34;
	Mon, 19 Aug 2024 11:52:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64DB1552FA;
	Mon, 19 Aug 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068360; cv=none; b=tdo/BIJk/HxgqP/ZpcsnHjRkWz7crOn6Qe9t7BXzDCyBew/QPQg/If0RxSMmEgIigBSsgeE6evJ90+bdKM1dKChdFgK1gRH/cNZ4M093sbEp64Oy6IcO95rHrto21CfFR2n4JEF5dkO833C6Y9Yeq4fqYcZyZ7zgZgYE3vb+AMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068360; c=relaxed/simple;
	bh=FQtA+Tv0kyLSVsep2YXkfJzneaN094FWOsFFwVfoDyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fkHLN+/5zwO4b6JDEx2W1yIb5ZNK1kwEHulf/45wQZ2gg+N65fxaeLEkbqawR4hlgHwUGRB1586B0Ti05Yz3por/iytbQu5YAgfqIeqZ9nTjaEXzhYm+U0DiCoHYpMDeAInDRgfd8hl9OPTPV3oUg3nJT779a+MlW16JyzrLSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnWBz70TmzpTNw;
	Mon, 19 Aug 2024 19:51:07 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 60B0A1401F1;
	Mon, 19 Aug 2024 19:52:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:52:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>,
	<ulf.hansson@linaro.org>, <p.zabel@pengutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/8] pmdomain: Make apple_pmgr_reset_ops static
Date: Mon, 19 Aug 2024 19:59:56 +0800
Message-ID: <20240819115956.3884847-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/pmdomain/apple/pmgr-pwrstate.c:180:32: warning:
	symbol 'apple_pmgr_reset_ops' was not declared. Should it be static:

This symbol is not used outside of pmgr-pwrstate.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/pmdomain/apple/pmgr-pwrstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/apple/pmgr-pwrstate.c b/drivers/pmdomain/apple/pmgr-pwrstate.c
index d62a776c89a1..9467235110f4 100644
--- a/drivers/pmdomain/apple/pmgr-pwrstate.c
+++ b/drivers/pmdomain/apple/pmgr-pwrstate.c
@@ -177,7 +177,7 @@ static int apple_pmgr_reset_status(struct reset_controller_dev *rcdev, unsigned
 	return !!(reg & APPLE_PMGR_RESET);
 }
 
-const struct reset_control_ops apple_pmgr_reset_ops = {
+static const struct reset_control_ops apple_pmgr_reset_ops = {
 	.assert		= apple_pmgr_reset_assert,
 	.deassert	= apple_pmgr_reset_deassert,
 	.reset		= apple_pmgr_reset_reset,
-- 
2.34.1


