Return-Path: <linux-pm+bounces-27230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D3AB997B
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 11:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B16E7A4B60
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C63235063;
	Fri, 16 May 2025 09:54:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6D231858;
	Fri, 16 May 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389242; cv=none; b=XjQe2gi15frYhGC2e/RfXPLzqjATpJ+C6W2eHejSo7eCxWXE0shkqwNgFeSKW0PKnWBiyEaWoCofA79YqYaOJ+09wIOcwnUJ91e8LoM913lGJzlAH8hLyyvL/gSJQUYiPK6jeb+Bypr1mUm75Vrj/TtAZ+MuLzVrI9bu9YV6iqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389242; c=relaxed/simple;
	bh=q0ACZUFrY5UcA6zkdpN4QJxoZ852bW+WRHVN5OX318Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qs3fp+4s7H4VuwNorN16rcT1Mq67mRqb5tBc/OOeKZpKiznL2nC0qVllYkNfUs5e+HJleFgoXPpahm/fEzmquiwxWly9wmt0xNvTu4XTvVEBzn0mUcH7z8wRSovhHXf2d4tOcV8I0AA93swc+2X638cw9DDZr8sxWQv2TDnvfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202505161753474539;
        Fri, 16 May 2025 17:53:47 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 May 2025 17:53:49 +0800
Received: from locahost.localdomain.com (10.94.6.108) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 May 2025 17:53:48 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <krzk@kernel.org>, <sre@kernel.org>, <akpm@linux-foundation.org>,
	<lee@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] charger: max14577: Handle NULL pdata when CONFIG_OF is not set
Date: Fri, 16 May 2025 17:53:46 +0800
Message-ID: <20250516095346.24169-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
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
tUid: 2025516175347009ab4415561c54360ebd2bbe3d44228
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
 drivers/power/supply/max14577_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index 1cef2f860b5f..ed6f5a584c2c 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -572,8 +572,10 @@ static int max14577_charger_probe(struct platform_device *pdev)
 	chg->max14577 = max14577;
 
 	chg->pdata = max14577_charger_dt_init(pdev);
-	if (IS_ERR_OR_NULL(chg->pdata))
+	if (IS_ERR(chg->pdata))
 		return PTR_ERR(chg->pdata);
+	else if (!chg->pdata)
+		return -ENODATA;
 
 	ret = max14577_charger_reg_init(chg);
 	if (ret)
-- 
2.43.0


