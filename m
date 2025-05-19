Return-Path: <linux-pm+bounces-27298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A1ABB4EA
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 08:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8FB1721D4
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 06:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3428F23D29E;
	Mon, 19 May 2025 06:16:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5723BCFD;
	Mon, 19 May 2025 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635384; cv=none; b=ZgenlXMgcf4UiAlRn1e3pKNL8qXQgSw8KtTRopmh06GKstPJGo7IHuM6BH58ZzuoHq9XjphgW5Qd07CRyzOIKOD1YxfVCRe0uQ3bVtA5vHwtIllub47sYwdeEcEFwJoKupyk5TdqpnKrl6KLaNABOxCI0qCgIyyf8uMcjnRkFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635384; c=relaxed/simple;
	bh=m5Tn8CjHHnOtYLSdE0w0aEoNDr6lwIYi+NqMXXuUMCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5VJXyl935sE6ZscaY86DmazNx8qg7dWYNWy/5/qJS+B47ypQxhA2PNEW3880GXmm1Z6a338P0nWR1KUrmrOGQIFHh2QR6UfjdlIixzaIAvmct5vMH+rWmUAWxPo84X5P2KxB4TVZjRJTZa5vRCuPnaUnNy6d/oBE8nonXMpem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202505191416040218;
        Mon, 19 May 2025 14:16:04 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 May 2025 14:16:04 +0800
Received: from locahost.localdomain.com (10.94.15.43) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 May 2025 14:16:04 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <krzk@kernel.org>, <sre@kernel.org>, <akpm@linux-foundation.org>,
	<lee@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH V3] charger: max14577: Handle NULL pdata when CONFIG_OF is not set
Date: Mon, 19 May 2025 14:16:01 +0800
Message-ID: <20250519061601.8755-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516095346.24169-1-hanchunchao@inspur.com>
References: <20250516095346.24169-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025519141604e672c54106362896fc7847b26d28777b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

When the kernel is not configured  CONFIG_OF, the max14577_charger_dt_init
function returns NULL. Fix the max14577_charger_probe functionby returning
 -ENODATA instead of potentially passing a NULL pointer to PTR_ERR.

Fix below smatch warning.
smatch warnings:
drivers/power/supply/max14577_charger.c:576 max14577_charger_probe() warn: passing zero to 'PTR_ERR'

Fixes: e30110e9c96f ("charger: max14577: Configure battery-dependent settings from DTS and sysfs")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/power/supply/max14577_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index 1cef2f860b5f..63077d38ea30 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -501,7 +501,7 @@ static struct max14577_charger_platform_data *max14577_charger_dt_init(
 static struct max14577_charger_platform_data *max14577_charger_dt_init(
 		struct platform_device *pdev)
 {
-	return NULL;
+	return ERR_PTR(-ENODATA);
 }
 #endif /* CONFIG_OF */
 
@@ -572,7 +572,7 @@ static int max14577_charger_probe(struct platform_device *pdev)
 	chg->max14577 = max14577;
 
 	chg->pdata = max14577_charger_dt_init(pdev);
-	if (IS_ERR_OR_NULL(chg->pdata))
+	if (IS_ERR(chg->pdata))
 		return PTR_ERR(chg->pdata);
 
 	ret = max14577_charger_reg_init(chg);
-- 
2.43.0


