Return-Path: <linux-pm+bounces-23162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D3A492F3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E767A8622
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF651DE8BF;
	Fri, 28 Feb 2025 08:04:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307281DE88E;
	Fri, 28 Feb 2025 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729870; cv=none; b=P6W97zIBkdl7JbEyufRhbSzGipsi87tJTeVR+d7ydTv84xQgHEbwDP4WtgG1otUqjqfuvAh9i72/HbWYs0Dr72GgiM5qkpwd6AqN6SPXwnwmV0je/484X7Y8TuYCHZKEKypDVLCievaDQm7w6DcPZplPDBmHW15sdrKVsohqi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729870; c=relaxed/simple;
	bh=Ds9eQPcw+VivkTdp9zgd6Mv0zpmocJfs2zDzJmaboVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZrcvr5f3BeFq49HPSvXqVQIl0FsdnC6JXUZFm7lNS4o3se9OAWVex0RC6kk7lNQNSA9frUPA9ms7GjgAFrdO7cXUo7pEzgwPbdHoNqUq79F7n2GgSCgszFNop0pg1UkxsWHJt/K+df60Q9rfSBOhDjEKYeh42qjaaPfMwZedQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202502281604111894;
        Fri, 28 Feb 2025 16:04:11 +0800
Received: from localhost.localdomain (10.94.16.254) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 28 Feb 2025 16:04:10 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sre@kernel.org>, <mazziesaccount@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 5/9] power: supply: bq25980: convert to use maple tree register cache
Date: Fri, 28 Feb 2025 03:02:32 -0500
Message-ID: <20250228080236.2759-6-liubo03@inspur.com>
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
tUid: 2025228160411dc3146e8d022b94fc58968a4e9d8490b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/power/supply/bq25980_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 0c5e2938bb36..8fdcd55ab775 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -932,7 +932,7 @@ static const struct regmap_config bq25980_regmap_config = {
 	.max_register = BQ25980_CHRGR_CTRL_6,
 	.reg_defaults	= bq25980_reg_defs,
 	.num_reg_defaults = ARRAY_SIZE(bq25980_reg_defs),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = bq25980_is_volatile_reg,
 };
 
@@ -943,7 +943,7 @@ static const struct regmap_config bq25975_regmap_config = {
 	.max_register = BQ25980_CHRGR_CTRL_6,
 	.reg_defaults	= bq25975_reg_defs,
 	.num_reg_defaults = ARRAY_SIZE(bq25975_reg_defs),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = bq25980_is_volatile_reg,
 };
 
@@ -954,7 +954,7 @@ static const struct regmap_config bq25960_regmap_config = {
 	.max_register = BQ25980_CHRGR_CTRL_6,
 	.reg_defaults	= bq25960_reg_defs,
 	.num_reg_defaults = ARRAY_SIZE(bq25960_reg_defs),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = bq25980_is_volatile_reg,
 };
 
-- 
2.31.1


