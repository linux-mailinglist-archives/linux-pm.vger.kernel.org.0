Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A74C8D92
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 18:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfJBQCJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 12:02:09 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:50124 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfJBQCI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 12:02:08 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 12:02:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570032128; x=1601568128;
  h=from:to:cc:subject:date:message-id;
  bh=bj0cxGKPfe8MhxQf55HPC2pGXsBBiMQq3I7Z648xezQ=;
  b=pO0Xj03Mn7atZ/N6InooVeh1EIHaeXfZkPDJ8ByiywubshWwelcJq0x+
   c4fs3bPvIl4dp1z8U4j+z3IIKnjkNxKU7cLxIsR08GRMnBzArmpi8OEcX
   QJWswwNSAdTDqNsbop+gwbxUeUr2/oXc3I7seSb5PcfR1eynmT6Gtt55I
   dFBXli6dXfWwpuYw4O0gkVsRKe3o803Dpu2QTXknLDeogfvjTrJIXOh7Y
   N6jUd5BNkmJf5qJd4rvQTllMBejTo2+UMILxBb9KmEV1ZtxcoHI469CXW
   K9XSq/WSmdntXILWWL88DeXVHyaPGdyWS8ixK4gEqUVwJSFSsvR5CyJ4C
   A==;
IronPort-SDR: DuufbJ7kQjYW5ENwpLLNr3HwERPNGAvc2eyTbqIkjf1vXA3VG29s5X2NikNr95ttzpviCvToYb
 Me4CatKN+yp+t3w4kbasVBbNeQ12bgeUHSNuGHAY66LpegUkAlXWxD1wddeQ2HfBoZ0Bmz0uT2
 ow/o0c5gzxZzImWL+n8awnnUWOJi+KdlVTUdqS5GWkrkEIm3JIoFX9MzdeBX2YVuzDSdZFAoFx
 OYJUqnlrLehdMVtiIER6CldTCrh2Bowki4d4OGGrFAHeoPPPCqkqf3vv8cd9ekMsXVvQ12iuD5
 bSk=
IronPort-PHdr: =?us-ascii?q?9a23=3ApSmMQxDR0dTHWgDyHceyUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPvzpMbcNUDSrc9gkEXOFd2Cra4d0KyK7euxAiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nhq7oATeusQSj4ZpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLzhSwZKzA27n3Yis1ojKJavh2hoQB/w5XJa42RLfZyY7/Rcc8fSW?=
 =?us-ascii?q?dHW8ZRVjdBApi9b4sJAOoKIPhWoZDgrFsArBuxGw2sC/7ywTNMiHL6wag23u?=
 =?us-ascii?q?I8Gg/EwQMgBcoDvnTKotvoOqkcUue7wbLUwTnfdf5axS3w5JTUfh0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3FQzFj1SRqYz4PzOSy+8AtGia7utgVe21im4rtx19rza0y8cxlo?=
 =?us-ascii?q?bJnJgZxU7Z+iVk2Ys4I8CzRk1jYdO8DpdcqyWXO5F1T84iWW1kpjs2xqEctZ?=
 =?us-ascii?q?KmeCUHzIwrywPeZvGDaYSE/BzuWeaLLTtmhX9pYrCyihm0/EO90OPzTNO030?=
 =?us-ascii?q?xPriddl9nMsW0C2ALL58icT/t94l+h2TGS1wDP8u1EIV47la7cK5M5x74/jJ?=
 =?us-ascii?q?sTsUDaEi/ulkX6kbaadks59uWs7+nreLrmppibN497jgHxLL4ildC4AeQ9Kg?=
 =?us-ascii?q?QOXm6b9vqg1LD740H1XLFHguc1n6TZqpzWO9kXqrKjDwNI1osu7w6zDzK839?=
 =?us-ascii?q?QZmXkHIkhFeBWCj4XxO1DPIfD4Au2+g1iwjDtmyevLPqD9DZXXNHTMjqrufa?=
 =?us-ascii?q?tl505G1AUz1cxf545TCrwZJPLzW0nxtMHXDxMgKwy0xv3qCMty1owAQ2KDGK?=
 =?us-ascii?q?yZP73IsV+O+O0vJ/OAZIgPuDbyeLAL/fnr2E44i18AeuH9zIkXYXHgRq9OPk?=
 =?us-ascii?q?6DJ3fgn4FSQi8xogMiQbmy2xW5WjlJaiP3APox?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2F4BADUx5RdgMfSVdFmHgEGEoVFTBC?=
 =?us-ascii?q?NIIYoBos+cYV6gwuHIgEIAQEBDAEBLQIBAYRAgkAjOBMCAwkBAQUBAQEBAQU?=
 =?us-ascii?q?EAQECEAEBCQ0JCCeFQoI6KYM1CxYVUoEVAQUBNSI5gkcBgXYUpAKBAzyMJTO?=
 =?us-ascii?q?IYwEJDYFICQEIgSKHNYRZgRCBB4RhhCiDPYJEBIE3AQEBizsHiWFwlV0BBgK?=
 =?us-ascii?q?CEBSBeJMSJ4Q6iT2LQQEtjA2bGAIKBwYPI4FGgXtNJYFsCoFEUBAUgVsXFY4?=
 =?us-ascii?q?uITOBCJA8AQ?=
X-IPAS-Result: =?us-ascii?q?A2F4BADUx5RdgMfSVdFmHgEGEoVFTBCNIIYoBos+cYV6g?=
 =?us-ascii?q?wuHIgEIAQEBDAEBLQIBAYRAgkAjOBMCAwkBAQUBAQEBAQUEAQECEAEBCQ0JC?=
 =?us-ascii?q?CeFQoI6KYM1CxYVUoEVAQUBNSI5gkcBgXYUpAKBAzyMJTOIYwEJDYFICQEIg?=
 =?us-ascii?q?SKHNYRZgRCBB4RhhCiDPYJEBIE3AQEBizsHiWFwlV0BBgKCEBSBeJMSJ4Q6i?=
 =?us-ascii?q?T2LQQEtjA2bGAIKBwYPI4FGgXtNJYFsCoFEUBAUgVsXFY4uITOBCJA8AQ?=
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="11591438"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2019 08:55:03 -0700
Received: by mail-pf1-f199.google.com with SMTP id x10so12895796pfr.20
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2019 08:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j3XM934BgcvR4S3GWK972GfeJ1Pu9gnBBD2xLxEu5nI=;
        b=deJhh1HDXA66TqQVK9NweBd7jLdZGSfyrYLiRdVAlL85a7hnhNoW3JOIF83hbV9WwF
         +8Klkx7wkRsdPOYCstQgXycRoHuUl75qBnSXvDm2/gr10aPO+RbSVzafi1jYFysX0pYn
         h4AAVBS0ZcFKEoz+Hza8ufthmhJaTJ8yJboOpTgUA/XaLteomnH1NxIkucTiW9M8FFq0
         +iFBGTWh6A5fx00AXkWGFtwrDW5XgL/FbtQhWmUrQEGAAR5FwYHsznIOAvX167Mg/0xX
         rCHq1vcSRRcvYuIsIc8ZikxzIC++TslLUaUE7a+S5e1tPJGgAi0yHVVnt8qTAmK6v2/U
         lLww==
X-Gm-Message-State: APjAAAW84jFCJX/dUfvFyASzzK/EuX8Z7n+NSg/autNMVgW18VOuTddD
        jQP3OzLA7avbPNpB2pQvkRTXmbJXMjVdkqUSFRiY2pWbBokh4NmEcPFOszHBxZR9ig52DUf0OWp
        S5K/xnKQU+fQXmUsaoq9H
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr5190849pjr.116.1570031700664;
        Wed, 02 Oct 2019 08:55:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzaceMrlI3m0IF4H1HJAHPFI0DTM8kNCQIWt1N9YAjTQ/sgOnhDPuMQdGUPQsL0yw7vmAbfzA==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr5190829pjr.116.1570031700402;
        Wed, 02 Oct 2019 08:55:00 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id p17sm18198326pfn.50.2019.10.02.08.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:54:59 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: max17042_battery: fix some usage of uninitialized variables
Date:   Wed,  2 Oct 2019 08:55:47 -0700
Message-Id: <20191002155547.9137-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Several functions in this file are trying to use regmap_read() to
initialize the specific variable, however, if regmap_read() fails,
the variable could be uninitialized but used directly, which is
potentially unsafe. The return value of regmap_read() should be
checked and handled. The same case also happens in function
max17042_thread_handler() but it needs more effort to patch.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/power/supply/max17042_battery.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index e6a2dacaa730..8e5727010ed2 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -675,8 +675,12 @@ static void max17042_reset_vfsoc0_reg(struct max17042_chip *chip)
 {
 	unsigned int vfSoc;
 	struct regmap *map = chip->regmap;
+	int ret;
+
+	ret = regmap_read(map, MAX17042_VFSOC, &vfSoc);
+	if (ret)
+		return;
 
-	regmap_read(map, MAX17042_VFSOC, &vfSoc);
 	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_UNLOCK);
 	max17042_write_verify_reg(map, MAX17042_VFSOC0, vfSoc);
 	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_LOCK);
@@ -686,12 +690,18 @@ static void max17042_load_new_capacity_params(struct max17042_chip *chip)
 {
 	u32 full_cap0, rep_cap, dq_acc, vfSoc;
 	u32 rem_cap;
+	int ret;
 
 	struct max17042_config_data *config = chip->pdata->config_data;
 	struct regmap *map = chip->regmap;
 
-	regmap_read(map, MAX17042_FullCAP0, &full_cap0);
-	regmap_read(map, MAX17042_VFSOC, &vfSoc);
+	ret = regmap_read(map, MAX17042_FullCAP0, &full_cap0);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, MAX17042_VFSOC, &vfSoc);
+	if (ret)
+		return ret;
 
 	/* fg_vfSoc needs to shifted by 8 bits to get the
 	 * perc in 1% accuracy, to get the right rem_cap multiply
@@ -1108,7 +1118,12 @@ static int max17042_probe(struct i2c_client *client,
 	if (!client->irq)
 		regmap_write(chip->regmap, MAX17042_SALRT_Th, 0xff00);
 
-	regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	ret = regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	if (ret) {
+		dev_err(&client->dev, "Failed to get MAX17042_STATUS.\n");
+		return ret;
+	}
+
 	if (val & STATUS_POR_BIT) {
 		INIT_WORK(&chip->work, max17042_init_worker);
 		ret = devm_add_action(&client->dev, max17042_stop_work, chip);
-- 
2.17.1

