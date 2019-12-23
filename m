Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1F129731
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLWOUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 09:20:54 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:33576 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLWOUx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 09:20:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 5B4DB3FBB5;
        Mon, 23 Dec 2019 15:20:51 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=uwCzjfwz;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Pbe8qgPEIJXl; Mon, 23 Dec 2019 15:20:50 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 954F83F9B3;
        Mon, 23 Dec 2019 15:20:50 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id 2E6401451; Mon, 23 Dec 2019 15:20:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1577110850; bh=/NaZ4QhQ5cY2pUTKpzcqxJ2i6ObcICdssifaM7FEZ+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwCzjfwzllktrytOnuE9inUUFoOHSCo5gP+2ONct/Y4nqO9JSBG1ekvY0Oq7660U0
         AepLJOticuJIciiMqVbtbuRplpbV4dfUqX1ga/ZQPI/spuN2gjcP1vdJaq9vtAJv4u
         KQUZ8LVoo6Q2yEUBDCGH3ntXOvXGVznQNcQ3z66k=
From:   Niklas Cassel <nks@flawful.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [PATCH 2/5] power: avs: qcom-cpr: fix unsigned expression compared with zero
Date:   Mon, 23 Dec 2019 15:19:31 +0100
Message-Id: <20191223141934.19837-3-nks@flawful.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191223141934.19837-1-nks@flawful.org>
References: <20191223141934.19837-1-nks@flawful.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

drivers/power/avs/qcom-cpr.c:1539:5-21:
warning: unsigned expression compared with zero: drv->num_corners < 0

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Niklas Cassel <nks@flawful.org>
---
 drivers/power/avs/qcom-cpr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index a52d2cef1300..232836a1ef27 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -1535,11 +1535,13 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 	 * The reason for this is that we need to know the highest
 	 * frequency associated with each fuse corner.
 	 */
-	drv->num_corners = dev_pm_opp_get_opp_count(&drv->pd.dev);
-	if (drv->num_corners < 0) {
-		ret = drv->num_corners;
+	ret = dev_pm_opp_get_opp_count(&drv->pd.dev);
+	if (ret < 0) {
+		dev_err(drv->dev, "could not get OPP count\n");
 		goto unlock;
 	}
+	drv->num_corners = ret;
+
 	if (drv->num_corners < 2) {
 		dev_err(drv->dev, "need at least 2 OPPs to use CPR\n");
 		ret = -EINVAL;
-- 
2.24.1

