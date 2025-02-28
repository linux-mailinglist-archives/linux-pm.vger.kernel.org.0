Return-Path: <linux-pm+bounces-23156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03440A492CB
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FE21704BF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237A11D8DE1;
	Fri, 28 Feb 2025 08:04:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861310E5;
	Fri, 28 Feb 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729860; cv=none; b=bJxmQDMIEQQ23xx25827BlgoTSClUMOZ0U3nUhCZC5A5HAOEhDIffCpz6v2fZE4tQ9NnderaiQd6CMdLY+8yBYYn6y01sDRZXqPgenfiuEs6TV/xrTrvvjgJcdYm4QVRZF1X7u7KvLpHYjxeQotCN1R2Q05Hp5mu72c/ZvFMlR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729860; c=relaxed/simple;
	bh=GEvryLHMMg3AolUb29+/LBGN0pGCfWs+tn12IadqdDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tinQ4Q4CNaRfA1ClBDaMMH12g79O2cn43jBKO20lVA7ODFltsMCRLiHgk+C9m1Lg4RH47zfJBR3ZjLw/P1CwH1mrKkP+RLkTA9PfR7eVpfHV9dduzKCSOi8IS6jueksAFHoV67hTvNN9/J0fbEKqnl6DHRZgGzi0WNvgaj9a/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202502281604091828;
        Fri, 28 Feb 2025 16:04:09 +0800
Received: from localhost.localdomain (10.94.16.254) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 28 Feb 2025 16:04:08 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sre@kernel.org>, <mazziesaccount@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 3/9] power: supply: bq2515x: convert to use maple tree register cache
Date: Fri, 28 Feb 2025 03:02:30 -0500
Message-ID: <20250228080236.2759-4-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20250228080236.2759-1-liubo03@inspur.com>
References: <20250228080236.2759-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 202522816040988bf0c9f1a5945ecf11573d5ab4a34d6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/power/supply/bq2515x_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index a3424f67f2b1..6909b1322f0d 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -1060,7 +1060,7 @@ static const struct regmap_config bq25150_regmap_config = {
 	.max_register		= BQ2515X_DEVICE_ID,
 	.reg_defaults		= bq25150_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(bq25150_reg_defaults),
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 	.volatile_reg		= bq2515x_volatile_register,
 };
 
@@ -1071,7 +1071,7 @@ static const struct regmap_config bq25155_regmap_config = {
 	.max_register		= BQ2515X_DEVICE_ID,
 	.reg_defaults		= bq25155_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(bq25155_reg_defaults),
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 	.volatile_reg		= bq2515x_volatile_register,
 };
 
-- 
2.31.1


