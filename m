Return-Path: <linux-pm+bounces-26576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A301AAA7550
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AE61C05678
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008325484E;
	Fri,  2 May 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JkeJGGuL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448C156C63;
	Fri,  2 May 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746197315; cv=none; b=VI3VD2BWZUkYPEePjk0qQ6aC6IrXyBcHIb/DJdyByxCDuEarxdelWN3dVVLjHMyCaoDkS+T7IQ/gm2TxcaW79wmnHhg3vhBgwcdPTow5tCR+j9jBov7WfSPxy8V2wI7nVyRlnCD+7cJZBuf5ybbfpefG6J6a2eH2qENZa1jkKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746197315; c=relaxed/simple;
	bh=aMDQ00u2wosG5a5L/sZxauH/kaOwW41FVU7iQGC3+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqKLSutoJ3CD6eVDsTmpC2DptRXX0nyU9aMHaEBOGpXQcpGrWTFbxMdwye0ujDUDuWw8zv0j8/IJqHp/IEqnoXk2PvY/2uCR3hXe/KDS90jfGiUlDZNzn+di/kNrezCkSA8w4LoydUW5aCsihh1dLoXLifWh9PXp0ECN2BAyarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JkeJGGuL; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Argfun5tGUaXGArgjuvzTQ; Fri, 02 May 2025 16:48:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746197309;
	bh=z7PvPH21b7p3LF3KjHizHHBNzX3Lf8Zcuuw5tyiAQ20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JkeJGGuL2VRUic3wRhPh5uUEyrYHXa/Jp5uzt28yvzkWr57tMrBLHBbn6E+vRQFOR
	 W0RI0+cwQR4ux3soIwWrnfPidVj8bAysRfcChbt3rXIXT9Ug5RyryzpQN225BMP/uU
	 CgbcSZZXvETgmRq5xjR2LgNnTbK/FMaMijBDncBlbr4KJL38jINVxVhhCs5GbhVWRA
	 aFEatJnJ+kwS9iginwqRefNIknwAwpBm5FbnMH1t/HDCzBubv2Q1LNeP8f3IN0xVri
	 cHphIVwdOxoxQSoV91t1kxc4c5laWUQ8BF4LQ44E67aAuj9OsZsPjX9ZP2OSM1P/Yd
	 TOk3OK2626AFw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 May 2025 16:48:29 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: rt9471: Simplify definition of some struct linear_range
Date: Fri,  2 May 2025 16:48:09 +0200
Message-ID: <0da94193c5f8b35fa98f25a852d74b841670bd6e.1746197233.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use LINEAR_RANGE() instead of hand-writing it. It is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/rt9471.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index bd966abb4df5..e7f843f12c98 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -192,12 +192,12 @@ static const struct reg_field rt9471_reg_fields[F_MAX_FIELDS] = {
 };
 
 static const struct linear_range rt9471_chg_ranges[RT9471_MAX_RANGES] = {
-	[RT9471_RANGE_AICR] = { .min = 50000,	.min_sel = 1, .max_sel = 63, .step = 50000 },
-	[RT9471_RANGE_MIVR] = { .min = 3900000,	.min_sel = 0, .max_sel = 15, .step = 100000 },
-	[RT9471_RANGE_IPRE] = { .min = 50000,	.min_sel = 0, .max_sel = 15, .step = 50000 },
-	[RT9471_RANGE_VCHG] = { .min = 3900000,	.min_sel = 0, .max_sel = 80, .step = 10000 },
-	[RT9471_RANGE_ICHG] = { .min = 0,	.min_sel = 0, .max_sel = 63, .step = 50000 },
-	[RT9471_RANGE_IEOC] = { .min = 50000,	.min_sel = 0, .max_sel = 15, .step = 50000 },
+	[RT9471_RANGE_AICR] = LINEAR_RANGE(50000,	1, 63, 50000),
+	[RT9471_RANGE_MIVR] = LINEAR_RANGE(3900000,	0, 15, 100000),
+	[RT9471_RANGE_IPRE] = LINEAR_RANGE(50000,	0, 15, 50000),
+	[RT9471_RANGE_VCHG] = LINEAR_RANGE(3900000,	0, 80, 10000),
+	[RT9471_RANGE_ICHG] = LINEAR_RANGE(0,		0, 63, 50000),
+	[RT9471_RANGE_IEOC] = LINEAR_RANGE(50000,	0, 15, 50000),
 };
 
 static int rt9471_set_value_by_field_range(struct rt9471_chip *chip,
-- 
2.49.0


