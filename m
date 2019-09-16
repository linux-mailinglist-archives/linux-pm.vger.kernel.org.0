Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE62B36E1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfIPJM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 05:12:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34455 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfIPJMz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2019 05:12:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i9n3x-0003F5-RD; Mon, 16 Sep 2019 09:12:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] memory: exynos5422: fix spelling mistake "counld" -> "could"
Date:   Mon, 16 Sep 2019 10:12:49 +0100
Message-Id: <20190916091249.31950-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 8c2ec29a7d57..ac5f55813900 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1078,7 +1078,7 @@ static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
 	ret = exynos5_counters_set_event(dmc);
 	if (ret < 0) {
 		exynos5_counters_disable_edev(dmc);
-		dev_err(dmc->dev, "counld not set event counter\n");
+		dev_err(dmc->dev, "could not set event counter\n");
 		return ret;
 	}
 
-- 
2.20.1

