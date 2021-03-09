Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AABC332C1A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCIQax (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 11:30:53 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:15597 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhCIQat (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 11:30:49 -0500
X-Halon-ID: f2346468-80f3-11eb-a542-005056917a89
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p54ac5521.dip0.t-ipconnect.de [84.172.85.33])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id f2346468-80f3-11eb-a542-005056917a89;
        Tue, 09 Mar 2021 17:24:45 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] thermal: rcar_gen3_thermal: Add support for up to five TSC nodes
Date:   Tue,  9 Mar 2021 17:24:19 +0100
Message-Id: <20210309162419.2621359-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for up to five TSC nodes. The new THCODE values are taken
from the example in the datasheet.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 75c69fe6e9553f25..e1e412348076b2ff 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -60,7 +60,7 @@
 #define MCELSIUS(temp)	((temp) * 1000)
 #define GEN3_FUSE_MASK	0xFFF
 
-#define TSC_MAX_NUM	4
+#define TSC_MAX_NUM	5
 
 /* default THCODE values if FUSEs are missing */
 static const int thcodes[TSC_MAX_NUM][3] = {
@@ -68,6 +68,7 @@ static const int thcodes[TSC_MAX_NUM][3] = {
 	{ 3393, 2795, 2216 },
 	{ 3389, 2805, 2237 },
 	{ 3415, 2694, 2195 },
+	{ 3356, 2724, 2244 },
 };
 
 /* Structure for thermal temperature calculation */
-- 
2.30.1

