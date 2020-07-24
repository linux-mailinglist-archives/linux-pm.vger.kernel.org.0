Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440D222CCC6
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgGXSJP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXSJP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:09:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57AC220674;
        Fri, 24 Jul 2020 18:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595614155;
        bh=WKWTRR3OpiM//OpvSkAaN+ab6FB8ru2WmmhyV77aIRk=;
        h=From:To:Subject:Date:From;
        b=2gPXnyeEqHeBv1avgOINVK3OnB1zXEJC7lajj6Dv/xOENZqwz9h58oaGxlkTc/rEN
         nMGB/wuDe4JEhjQaFydwD/rKx0y/lVH7PA8Vz3TJ25/LRo10tcPGyZ+rz2yb5nxqXa
         Vq9x1oqEh/EjnsOgRGQTr0husbnavBANkD/fZc1w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC] memory: exynos5422-dmc: Document mutex scope
Date:   Fri, 24 Jul 2020 20:08:57 +0200
Message-Id: <20200724180857.22119-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document scope of the mutex used by driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

It seems mutex was introduced to protect:
1. setting actual frequency/voltage,
2. dmc->curr_rate (in exynos5_dmc_get_cur_freq()).

However dmc->curr_rate in exynos5_dmc_get_status() is not protected. Is
it a bug?
---
 drivers/memory/samsung/exynos5422-dmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 93e9c2429c0d..0388066a7d96 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -114,6 +114,7 @@ struct exynos5_dmc {
 	void __iomem *base_drexi0;
 	void __iomem *base_drexi1;
 	struct regmap *clk_regmap;
+	/* Protects curr_rate and frequency/voltage setting section */
 	struct mutex lock;
 	unsigned long curr_rate;
 	unsigned long curr_volt;
-- 
2.17.1

