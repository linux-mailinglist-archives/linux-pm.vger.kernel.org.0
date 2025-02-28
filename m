Return-Path: <linux-pm+bounces-23163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214BA492D9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2849171375
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0C1DED60;
	Fri, 28 Feb 2025 08:04:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E291DED71;
	Fri, 28 Feb 2025 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729874; cv=none; b=KJaSyxExLG5sCZru735bPoVb9BaVeTtHtMtuyKqJP5YO74MUsF5olDtu7xgOp1L2Sp9nW6vxc4hBXZw4WjPiQUPnJgfZabdX+1JfUYasdxux4YmNG2LvoehgeNzjhbtG0orst0J7G8HHZy49bgfokWINjnUtsFA68Qu1DmlRvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729874; c=relaxed/simple;
	bh=cRraVrCsk7oih973hMyVgNXX546h2/sFoqEXMgAY73E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2iyUkj2Bccs5EMyHnjKL/gYPqpzRxwMX/aj9uGsNUUzLDENIzWFx0Uy1G4hAWJH9LDYPEpRkYZzNoUeyxPeoI1f1E1+CXVB0vK/wSZOaZaJCJlace19DPfN+1gSAvaQIKJKOQIJ1LjijwVQ2OXaF1n0A/jLQYiocifUPlH64vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202502281604121904;
        Fri, 28 Feb 2025 16:04:12 +0800
Received: from localhost.localdomain (10.94.16.254) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 28 Feb 2025 16:04:10 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sre@kernel.org>, <mazziesaccount@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 6/9] power: supply: ltc4162l: convert to use maple tree register cache
Date: Fri, 28 Feb 2025 03:02:33 -0500
Message-ID: <20250228080236.2759-7-liubo03@inspur.com>
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
tUid: 2025228160412efab2db1656c3b236493fa94adeef672
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/power/supply/ltc4162-l-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index 23eb426295db..99566f3c0946 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -1119,7 +1119,7 @@ static const struct regmap_config ltc4162l_regmap_config = {
 	.writeable_reg	= ltc4162l_is_writeable_reg,
 	.volatile_reg	= ltc4162l_is_volatile_reg,
 	.max_register	= LTC4162L_INPUT_UNDERVOLTAGE_DAC,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static void ltc4162l_clear_interrupts(struct ltc4162l_info *info)
-- 
2.31.1


