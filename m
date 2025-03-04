Return-Path: <linux-pm+bounces-23355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C2EA4DE66
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 13:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CE93B3547
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C994202960;
	Tue,  4 Mar 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bPLXE3IP"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C520127D;
	Tue,  4 Mar 2025 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092826; cv=none; b=DCwHFqnBZBjokAP2lgOmAZ05Ez5/UWbrOqhq0YR0tbeOvMdTEQtMbEaThslHFDHEiRVy8PwvRmlT/vP3aqxvYUFvvQ0YKNcnoiEBLfz4um23MAKMl6p3LYjfEyAZb5LOYFDUovFWkxO4OyWfEUtM6jhXVRodgQjNRvrSqqlhIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092826; c=relaxed/simple;
	bh=SroIqtwDcZBI6USYWmrVQHd45regAWwrIk5senY15hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VMTYzYUIvx/P3H9WjkdnZgwe9rBtNRXso1nOiqGphw203VkyO2Gi7fEM46KtOUCZAPbDhN22Q6LNAo4BRRLOdQbIFRlvIMIxdGWJVcZi3EhvEDS8pl2wKVokGSieb1XigRO8iTmLqhcmlQI10ECS3c1rB8UxuGGRxMhOCDCr3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bPLXE3IP; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5VkIE
	0q8S0ZH3DD+BjbROvAubXkdtsXQCphn+uhJwiI=; b=bPLXE3IPi323vSZzaXpr1
	AcrNetLkSrc5iEnoOUJAT+eKukbXYOsb8zfX2Vt5LLiV6yZbEbIXvqwLeg55hUmG
	utV7jb1YCd2BdWa9YVJombNPeI1BdE/I7JP0JBc1U2jSTiOLCTh4lMOP4BgALBL0
	x1YLTDG8i4QV/JcckGrH8M=
Received: from zhuxin.hobot.cc (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAn7ISw98ZnSRmsPg--.2684S2;
	Tue, 04 Mar 2025 20:53:16 +0800 (CST)
From: Zxyan Zhu <zxyan20@163.com>
To: vireshk@kernel.org
Cc: nm@ti.com,
	sboyd@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan20@163.com>
Subject: [PATCH 1/1] OPP: Support multiple frequency points with opp-hz-<name>
Date: Tue,  4 Mar 2025 20:52:56 +0800
Message-Id: <20250304125256.3361648-1-zxyan20@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn7ISw98ZnSRmsPg--.2684S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWxJF4UAFWkJF13trW5ZFb_yoW8uryfpF
	43J398CrZ7J3y2gF97Ja1vvryavF4kXFWxKFy7C34jva17JF95Xw47tFyjq3Zayry7Z3y5
	tayqgFy0ka10kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piYhF7UUUUU=
X-CM-SenderInfo: p201t0isq6il2tof0z/1tbioBQGXmfG7SDRDAAAsd

Current OPP driver only supports a single frequency value per OPP
entry using `opp-hz`. This patch extends the functionality to allow
retrieving named frequency points using `opp-hz-<name>`, improving
flexibility for different operating modes.

Signed-off-by: Zxyan Zhu <zxyan20@163.com>
---
 drivers/opp/of.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a24f76f5fd01..d20802b0f89c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -752,18 +752,30 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 static int _read_rate(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
 		      struct device_node *np)
 {
-	struct property *prop;
+	struct property *prop = NULL;
 	int i, count, ret;
 	u64 *rates;
+	char name[NAME_MAX];
 
-	prop = of_find_property(np, "opp-hz", NULL);
-	if (!prop)
-		return -ENODEV;
+	/* Search for "opp-hz-<name>" */
+	if (opp_table->prop_name) {
+		snprintf(name, sizeof(name), "opp-hz-%s",
+			 opp_table->prop_name);
+		prop = of_find_property(np, name, NULL);
+	}
+
+	if (!prop) {
+		/* Search for "opp-hz" */
+		sprintf(name, "opp-hz");
+		prop = of_find_property(np, name, NULL);
+		if (!prop)
+			return -ENODEV;
+	}
 
 	count = prop->length / sizeof(u64);
 	if (opp_table->clk_count != count) {
-		pr_err("%s: Count mismatch between opp-hz and clk_count (%d %d)\n",
-		       __func__, count, opp_table->clk_count);
+		pr_err("%s: Count mismatch between %s and clk_count (%d %d)\n",
+		       __func__, name, count, opp_table->clk_count);
 		return -EINVAL;
 	}
 
@@ -771,9 +783,9 @@ static int _read_rate(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
 	if (!rates)
 		return -ENOMEM;
 
-	ret = of_property_read_u64_array(np, "opp-hz", rates, count);
+	ret = of_property_read_u64_array(np, name, rates, count);
 	if (ret) {
-		pr_err("%s: Error parsing opp-hz: %d\n", __func__, ret);
+		pr_err("%s: Error parsing %s: %d\n", __func__, name, ret);
 	} else {
 		/*
 		 * Rate is defined as an unsigned long in clk API, and so
-- 
2.34.1


