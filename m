Return-Path: <linux-pm+bounces-23158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC4DA492EC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2133E7A9FDB
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F45C1DE2A6;
	Fri, 28 Feb 2025 08:04:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636014B092;
	Fri, 28 Feb 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729862; cv=none; b=e2I+BjHBPcaw+3rme9VjPEauLMmhHg7DZnb04+j1lLHIPHOi9Mmmeth40/W8j7VqPN3+4bkRomjEqOETBvxwtmGSJk2tmUMSDDPcKuERs0IK3J/P8D4iTHqEUipF5Th43RQK5TIMtzivEzzu1/VCLw0MaGsgqUWVv945CkZD5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729862; c=relaxed/simple;
	bh=R3L4bOwybWTMyEUF1rBddcs02NJZoKzJVudoG7RGb5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2dDItqXRQJHbx29rObrWMgwWNwbJzy+PtdChzz5pnXWn0jG8ZMTkFIIdaThIOtL05GTKVZ6m4IjAauStyItUBmQ+V0z3x6565JeiIMTJmUraCMV9JqlORquwVCt6Ww4+QTnyKQP6RzDje5alP4Wnwfx413v9a0mY5RNK4D2uvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202502281604081799;
        Fri, 28 Feb 2025 16:04:08 +0800
Received: from localhost.localdomain (10.94.16.254) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 28 Feb 2025 16:04:08 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sre@kernel.org>, <mazziesaccount@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 2/9] power: supply: bq24257: convert to use maple tree register cache
Date: Fri, 28 Feb 2025 03:02:29 -0500
Message-ID: <20250228080236.2759-3-liubo03@inspur.com>
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
tUid: 2025228160408da40222ee3984afbbfd2f4c4bef53ba0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/power/supply/bq24257_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 1416586f2459..766eecb35694 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -113,7 +113,7 @@ static const struct regmap_config bq24257_regmap_config = {
 	.val_bits = 8,
 
 	.max_register = BQ24257_REG_7,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.volatile_reg = bq24257_is_volatile_reg,
 };
-- 
2.31.1


