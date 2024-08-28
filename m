Return-Path: <linux-pm+bounces-13032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B617D962682
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 14:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7454D28224E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 12:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73876173355;
	Wed, 28 Aug 2024 12:04:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ECD166F37
	for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846673; cv=none; b=h4DJdL7YmJQTT3B+uukRRCLhXVlByBqypYMsB+0II2ZfU39w1CRtlAzCrHT3R439HOIWadH/nUdYWy3INHvQEgviHLYbcNPCMYwgGS8azYknmtx1sBDzNvC4RCcLYCYUXWV8te7B2ztVRkOJ2zYk2rTG95FfeH1TJVhPw2SdJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846673; c=relaxed/simple;
	bh=QS+Jrc2+e2EYG0o89FRQIIoVx+VmvkoL5TDXERv9lLA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qM4ILBo7xS+lICKUQFnja1scxLXu2meMS9b0x5E/VT0XaNnOs3eqgA4b3NIbrZt9t75D+p4V8ljRm1eMu0gVt4cGk2zRhEbIYBld9ykVQKfmGX+eoxtLVTPS7yxx1NuRR8qXiW6G1pylgFIMK6i1xaMFca82xI4yYw37pikmsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wv2yf3nplzQqtV;
	Wed, 28 Aug 2024 19:59:38 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 62B2C14022E;
	Wed, 28 Aug 2024 20:04:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 20:04:28 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<ulf.hansson@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next] pmdomain: mediatek: make use of dev_err_cast_probe()
Date: Wed, 28 Aug 2024 20:12:30 +0800
Message-ID: <20240828121230.3696315-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Using dev_err_cast_probe() to simplify the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index e274e3315fe7..88406e9ac63c 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -398,12 +398,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		scpsys->dev->of_node = node;
 		pd->supply = devm_regulator_get(scpsys->dev, "domain");
 		scpsys->dev->of_node = root_node;
-		if (IS_ERR(pd->supply)) {
-			dev_err_probe(scpsys->dev, PTR_ERR(pd->supply),
+		if (IS_ERR(pd->supply))
+			return dev_err_cast_probe(scpsys->dev, pd->supply,
 				      "%pOF: failed to get power supply.\n",
 				      node);
-			return ERR_CAST(pd->supply);
-		}
 	}
 
 	pd->infracfg = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg");
-- 
2.34.1


