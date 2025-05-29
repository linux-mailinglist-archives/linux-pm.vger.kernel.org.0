Return-Path: <linux-pm+bounces-27786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8FAC75D1
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 04:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94213AB5A1
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF6E24418E;
	Thu, 29 May 2025 02:20:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4A243387;
	Thu, 29 May 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748485225; cv=none; b=EW/6TXtNzGwBKDvpkKU8qxSF5Kcvu8k797jEKHTt5fmEI+uKav8+qjWpyuUiGKlxSfH+VXX3YQUHnLjokbNOJGDK/cBGQn2gBDcGxCDc8f8970AOTMMIchehQO4HfeDcNURzVV/rRqWyHtYrY8bejbn7Z5CxQKrJT8IRV1gzDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748485225; c=relaxed/simple;
	bh=tEolrqcCuhXAu9I1vJ4rGsJwBc9CSCyq+vYYgFFWVSQ=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=HkSBwhmwT+SqB73LkpE8BYZHrLgxXK+5HbY/fEGfYZZ3fR/ZH+q59Br0kKLEIahat6emXdSbyMWOJlZ4LTto1QZ7KLXY32UfHHck+WkULKjiJrQo7YPoNOzPa0mscWTv+VVSt+pFAq10FhZcKvBp/e66BpWL6gPPlThPBtUn6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4b797d2Qrpz5B1J6;
	Thu, 29 May 2025 10:20:13 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 54T2K3oB033259;
	Thu, 29 May 2025 10:20:03 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 29 May 2025 10:20:05 +0800 (CST)
Date: Thu, 29 May 2025 10:20:05 +0800 (CST)
X-Zmail-TransId: 2afc6837c4557a9-4fe71
X-Mailer: Zmail v1.0
Message-ID: <20250529102005168oXmW54srQ-rBCEFa12u1U@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <walker.chen@starfivetech.com>
Cc: <changhuang.liang@starfivetech.com>, <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.tao172@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?cG1kb21haW46IHN0YXJmaXZlOiBVc2Ugc3RyX29uX29mZigpIGhlbHBlciBpbiBqaDcxMTBfcG11X3NldF9zdGF0ZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 54T2K3oB033259
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6837C45D.000/4b797d2Qrpz5B1J6

From: Shao Mingyin <shao.mingyin@zte.com.cn>

Remove hard-coded strings by using the str_on_off() helper function.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/pmdomain/starfive/jh71xx-pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/starfive/jh71xx-pmu.c b/drivers/pmdomain/starfive/jh71xx-pmu.c
index 74720c09a6e3..30c29ac9391f 100644
--- a/drivers/pmdomain/starfive/jh71xx-pmu.c
+++ b/drivers/pmdomain/starfive/jh71xx-pmu.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/string_choices.h>
 #include <dt-bindings/power/starfive,jh7110-pmu.h>

 /* register offset */
@@ -155,7 +156,7 @@ static int jh7110_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)

 	if (ret) {
 		dev_err(pmu->dev, "%s: failed to power %s\n",
-			pmd->genpd.name, on ? "on" : "off");
+			pmd->genpd.name, str_on_off(on));
 		return -ETIMEDOUT;
 	}

-- 
2.25.1

