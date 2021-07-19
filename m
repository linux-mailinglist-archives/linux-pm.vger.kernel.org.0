Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601433CCE7A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhGSHar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jul 2021 03:30:47 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:58579 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234816AbhGSHaq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Jul 2021 03:30:46 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jul 2021 03:30:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1626679666; x=1658215666;
  h=from:to:cc:subject:date:message-id;
  bh=CVGDaZsDY4PME7/N9mVxnymCvLoRHKYhnkmhynFbYZ0=;
  b=qgVWG/HqUeQQY10CzxRhZvejEJa6vbyAR39InHDwMB1vdDdEK7AIewG7
   onttWGp0dkYwzGCXA5HWGlBKfYUImFLZ814u+I1jmR4hCxhMcuIW0SUS9
   KZIv6L0Y+VWY70w8aRBS4Dh6Z5LYAzMDIehPFfeuDSOpsgVwq3IBtRRPB
   UqroLVT6UHp46+z3nHhVcaXXBwaq/V2qL9aeBkLI8rRqlIisVHOfrd9AF
   82SVgi8MMMLaLcBtlWkjsfkP3pKHUkfTS/M/II2CHvDn5jTfWK7svq4VX
   1PFMzyHy5VMApWTjVbL+J1YHJ1ya3Zbz9mbgf2ig2RViwuD6VcuwuTHDY
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,251,1620684000"; 
   d="scan'208";a="18512868"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 19 Jul 2021 09:20:36 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 19 Jul 2021 09:20:36 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 19 Jul 2021 09:20:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1626679236; x=1658215236;
  h=from:to:cc:subject:date:message-id;
  bh=CVGDaZsDY4PME7/N9mVxnymCvLoRHKYhnkmhynFbYZ0=;
  b=l4VOYMr1/2JFvY5GLPRMcqzAeXcOiDKfkBKWh/T5jlnZDiNsjnmNYjMA
   rRCkO3EC4/uKTlE6kY79ssSWmWYojXSfua11AoBK8wAr+HIWicxkK456h
   ry32UZ9P/AD+7pCe3ogNREtGW7TbV/gSPtYo97v1fjAARN5w4f3OC8t5H
   iAau17G5GoBcSOk9kyNdQFslkjpDkdYxqh0Su3ykqYQ15qViBcyieBLF0
   6yH/yhe/qCznkmDNV9Ed1nQW7NNmNEZEAQzkrw0s/pPiLvP/uFMC01IaZ
   bMEJIZ/HhMjbF8MeismwMYY8SlAGHomB2lIP+SSMvHgaXrkifMdtb0P3M
   w==;
X-IronPort-AV: E=Sophos;i="5.84,251,1620684000"; 
   d="scan'208";a="18512862"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Jul 2021 09:20:36 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E2568280070;
        Mon, 19 Jul 2021 09:20:35 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/2] power: supply: sbs-battery: relax voltage limit
Date:   Mon, 19 Jul 2021 09:20:18 +0200
Message-Id: <cd466515301fcb19e9b858b2287d8bcc10cc3de1.1626678985.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Smart Battery Data Specification allows for values 0..65535 mV,
there is no reason to limit the value to 20000.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/power/supply/sbs-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index f84dbaab283a..3d6b8247d450 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -102,7 +102,7 @@ static const struct chip_data {
 	[REG_TEMPERATURE] =
 		SBS_DATA(POWER_SUPPLY_PROP_TEMP, 0x08, 0, 65535),
 	[REG_VOLTAGE] =
-		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_NOW, 0x09, 0, 20000),
+		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_NOW, 0x09, 0, 65535),
 	[REG_CURRENT_NOW] =
 		SBS_DATA(POWER_SUPPLY_PROP_CURRENT_NOW, 0x0A, -32768, 32767),
 	[REG_CURRENT_AVG] =
-- 
2.17.1

