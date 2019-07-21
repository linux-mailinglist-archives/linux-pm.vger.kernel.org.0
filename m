Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61786F41D
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2019 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfGUQe0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jul 2019 12:34:26 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:48977 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfGUQeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jul 2019 12:34:25 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d01 with ME
        id fUaM2000F4n7eLC03UaN3G; Sun, 21 Jul 2019 18:34:24 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 18:34:24 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, wni@nvidia.com, tiny.windzz@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] thermal: tegra: Fix a typo
Date:   Sun, 21 Jul 2019 18:33:58 +0200
Message-Id: <20190721163358.2377-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

s/sochterm/soctherm/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index fcf70a3728b6..0ff4b22ddca7 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -202,7 +202,7 @@
 /* get dividend from the depth */
 #define THROT_DEPTH_DIVIDEND(depth)	((256 * (100 - (depth)) / 100) - 1)
 
-/* gk20a nv_therm interface N:3 Mapping. Levels defined in tegra124-sochterm.h
+/* gk20a nv_therm interface N:3 Mapping. Levels defined in tegra124-soctherm.h
  * level	vector
  * NONE		3'b000
  * LOW		3'b001
-- 
2.20.1

