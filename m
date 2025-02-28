Return-Path: <linux-pm+bounces-23157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40FFA492CC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2C8188DB28
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C753D1D9595;
	Fri, 28 Feb 2025 08:04:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE71D63FD;
	Fri, 28 Feb 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729860; cv=none; b=K5hH9QouWKVjKwpzE8casO1Hn3JHyazJDcIUxwOQp+JREAhZVS91mCXIaGzmTH0qEGqhJObLNbLxdJz12vjHhBZDLi1EbcLoXcjnkn24h6lV+wp5r4iy8tdVEpq5IbP8U8aXax/0EDiWUOfm7Dcu43aDwR6egRXWx2pV21DlHOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729860; c=relaxed/simple;
	bh=OiBZCj1VeC6RNWslHH4cbUhWynS1YXoc3+w5Uzr+jTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDPE6Ruqn0rupe77n1w7nyPpjQ69Nhw8rFSG3QVax0un0MWcev3xHvvoigkcMK3NyPpHg5zLrubm5o1QDyF/Tvt6wOIjrBgEYzeEh/QecEQPysyQbDnR9z5ZH1K68FQOPZqUr6V8MNY3gvp+MQLXJw0UF68QXvRdkloaPy3OKbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202502281604131922;
        Fri, 28 Feb 2025 16:04:13 +0800
Received: from localhost.localdomain (10.94.16.254) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 28 Feb 2025 16:04:12 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sre@kernel.org>, <mazziesaccount@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 7/9] power: supply: max1720x: convert to use maple tree register cache
Date: Fri, 28 Feb 2025 03:02:34 -0500
Message-ID: <20250228080236.2759-8-liubo03@inspur.com>
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
tUid: 20252281604131971bab0f3dd17d86cda873d344aa8c6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/power/supply/max1720x_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index c1eaf3f7a782..ea3912fd1de8 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -119,7 +119,7 @@ static const struct regmap_config max1720x_regmap_cfg = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 	.rd_table = &max1720x_readable_regs,
 	.volatile_table = &max1720x_volatile_regs,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct regmap_range max1720x_nvmem_allow[] = {
-- 
2.31.1


