Return-Path: <linux-pm+bounces-23159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2ABA492D5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621673AFA8D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B961CAA93;
	Fri, 28 Feb 2025 08:04:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC901DE2D7;
	Fri, 28 Feb 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729865; cv=none; b=gLttFB47ig8xKpga7hl6NhFH7nU9lCQfWtR3W7T8j1pYElS7GUx+KX8Esmkef9mEjMCOCaBBWOI5ErsIi2QH1QYAsr3c4858q37ZDfwnPW8x2YPqxb2/1cX9RxVnJoXduumullQzNQ6LalkyEJJKDxrlsTb98TfsvMCMM1tcAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729865; c=relaxed/simple;
	bh=bTW5lHMAe3sUEa49Ua+XwSqzM0Gt6INQVEE0T+NIjrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0GBaTiwaaKjKNs7Cos61IlaLuedzELrYRKEH+WFzCXpAm+5UswaRmALzhi4NL4rQyw7Mr/Ei85zSKclcNs2uL/54yrYZHU4J3PkFpVIcxd+nzzK5T5Dp/DK0eMrD5D+6HUDwxnYOTzG5qafNEdxRDvRX84YYWqVhr0L6gNBrrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202502281604141935;
        Fri, 28 Feb 2025 16:04:14 +0800
Received: from localhost.localdomain (10.94.16.254) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 28 Feb 2025 16:04:13 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sre@kernel.org>, <mazziesaccount@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 8/9] power: supply: rt9455: convert to use maple tree register cache
Date: Fri, 28 Feb 2025 03:02:35 -0500
Message-ID: <20250228080236.2759-9-liubo03@inspur.com>
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
tUid: 2025228160414b0ae14750ff103693320210b413a027c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/power/supply/rt9455_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 64a23e3d7bb0..ff15e20ec70a 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1579,7 +1579,7 @@ static const struct regmap_config rt9455_regmap_config = {
 	.writeable_reg	= rt9455_is_writeable_reg,
 	.volatile_reg	= rt9455_is_volatile_reg,
 	.max_register	= RT9455_REG_MASK3,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static int rt9455_probe(struct i2c_client *client)
-- 
2.31.1


