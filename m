Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94ECCACC5
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfJCR3J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 13:29:09 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:44004 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfJCR3G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Oct 2019 13:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570123745; x=1601659745;
  h=from:to:cc:subject:date:message-id;
  bh=Mr/HQci3u3rRGYq/s4Glr5VxHGEGmVqkkQJmECKmcB4=;
  b=AHQhjqzNc2UfyZ+3qMvQ+o4JhiYWCMHZ22bWMQAPB/yT4qS/kRwkPBkz
   Iaaxy9AguSgNBP3cNOTsIiD8KRETMC3PFqjh9TgjWJCc+O4f1yr+sE0UL
   E722nB85rpdORrt3Fztv0xtV+UV7aKSkbv66wNgfGEMzW1RVMuglCnbAo
   hy3wwv+2WT6XrRIjMdIotHRJ25T55sSRXTK5sFZSi0Lr5CAsssDgS3lYj
   9ymHRC0A24Xdl8ioklwkxcCnYmpPooTYLOFYn91AeXR5MyivdOgKk6QUw
   TiJ1vk39YgjizqwgapC72VVVm++UY4ObXeuWBCh3db3ENUN0h0fbB+01D
   w==;
IronPort-SDR: SHQkcty2nd13aj2jgZV9gm6zpauol2HntZBHbcWZsv1xraTufMJjBTpuWPYsiU3XYdwRJMmSrj
 rxJfivQ9iNI2rIisLLKqg5Mu3jkDvxs57aLxOhqIVuEgq8DfLrgmMg6szzpdNUpVgUveIUv9P8
 OraH7Fr0CBvPT9jZ+Gryqj0p32PUjArhl6RM8j0tIMzqDiKnvbqOG97CZhh26lu4YQMb8yYc/d
 AnXENRGg5CVVP/e3dRCapKUqTaR7JuCYbDZRK+c1I6/1XUKFLWILrdqSWzsx3Ye57KVy/HMH9s
 Vz0=
IronPort-PHdr: =?us-ascii?q?9a23=3AJbVZmRCVWRHzE4EUzQaMUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPvzocbcNUDSrc9gkEXOFd2Cra4d0KyK4+u5ADVIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+5oAjSucUanJZuJrsswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcVylAAoOndIsPDuwBPelFpIfjvlUFsBW+BQiyC+Pr1zBDm3v60KMm3+?=
 =?us-ascii?q?gkFwzNwQ4uEM8UsHnMrNv7KrocX+62wqfP1jjPc+9a1C3h5IXSbhwtvfeBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgVeRqY3kPzOVy+MNuHWc4utgVOOvi3QoqwBtrjSzyMohkZ?=
 =?us-ascii?q?TJiZ4Pylze6yp23Zs1KMS+RUVmYtCkCINduz+GO4ZyWM8vQGFltDwkxrEbuZ?=
 =?us-ascii?q?O3ZjUGxZAkyhLHdvCKcoyF7gj9WOufITp0nmxpdbOlixuw/kWtzPD3WNOu31?=
 =?us-ascii?q?ZQtCVFl8HBtnUK1xPO9MeKUuB9/kK92TaX0ADT9/1ELVg0laXFL54hxaY9lp?=
 =?us-ascii?q?8JvkTCGi/6gV32jKCLekk99Oik9uDqb7b8qp+TMI90jQ7+MqAwlcClHes4NQ?=
 =?us-ascii?q?0OU3Ca+eS6yrLj4VX0TKtWgvAyiKXUs5DXKd4FqqKkAwJZyJsv5hK8Aju+1d?=
 =?us-ascii?q?QXh3gHLFZLeBKdiIjpPknDIfD5DPe/mVuskStny+zIM7D6H5XCMmLDnK3/cr?=
 =?us-ascii?q?lg9k5Q0BAzwsxH55JIFrEBJ+r+WkvwtNzeEx84PBW4w/7iCNhmyIMeVnyAAr?=
 =?us-ascii?q?WDPKPRr1CI/OQvLPeIZIMPvzb9MfcltLbAl3g8zG4cb6m02tNDeWK4F/U+ex?=
 =?us-ascii?q?6xfHH2xNoNDDFZ7UIFUOX2hQjaAnZobHGoUvd5uWk2?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HdCgAaL5Zdh8bXVdFlHgEGEoFcCwK?=
 =?us-ascii?q?DXEwQjSSGLAEBBosmgQmFeoMLhSiBewEIAQEBDAEBLQIBAYRAgkgjNQgOAgM?=
 =?us-ascii?q?JAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAQgEMAYFqKYM1CxYVUoEVAQUBNSI?=
 =?us-ascii?q?5gkcBgXYUoimBAzyMJTOIZgEJDYFICQEIgSIBhzSEWYEQgQeEYYQogz2CRAS?=
 =?us-ascii?q?BNwEBAYs9B4lncJViAQYCghEUgXiTFCeEPIk/i0QBLYwSmx0CCgcGDyOBMAG?=
 =?us-ascii?q?CEE0lgWwKgURQEBSBWw4JFY4uITOBCIJzjWIB?=
X-IPAS-Result: =?us-ascii?q?A2HdCgAaL5Zdh8bXVdFlHgEGEoFcCwKDXEwQjSSGLAEBB?=
 =?us-ascii?q?osmgQmFeoMLhSiBewEIAQEBDAEBLQIBAYRAgkgjNQgOAgMJAQEFAQEBAQEFB?=
 =?us-ascii?q?AEBAhABAQEIDQkIKYVAQgEMAYFqKYM1CxYVUoEVAQUBNSI5gkcBgXYUoimBA?=
 =?us-ascii?q?zyMJTOIZgEJDYFICQEIgSIBhzSEWYEQgQeEYYQogz2CRASBNwEBAYs9B4lnc?=
 =?us-ascii?q?JViAQYCghEUgXiTFCeEPIk/i0QBLYwSmx0CCgcGDyOBMAGCEE0lgWwKgURQE?=
 =?us-ascii?q?BSBWw4JFY4uITOBCIJzjWIB?=
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="12600091"
Received: from mail-pg1-f198.google.com ([209.85.215.198])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 10:29:03 -0700
Received: by mail-pg1-f198.google.com with SMTP id a31so2406829pgm.20
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2019 10:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7xuYVaL6kMkVdyoXuZH4xe6VghxajLsnhwu8EUF2ekg=;
        b=kqauEgIkvu75usYfMypS499eB3HXZPFwERN4qWKqb7bATwx0rgnnMjtP6ZbZatIBW7
         6lh1PNwyzCm5CLp5H9QquJOHYjNXmRpq8lb7iPzkX0LLeh+kZP852xsqLWeF1Fz2ZPtM
         AtIrDiKH9Zz2r9WYCdlgTFw3JlBwkhmRjLpNMpGyUcljiyiIrfgMdMT3vsMB+uSwGI2o
         WcDbPeMp9yYq095MJOEVK6sYlOObC0uH6xNbeRaRs8s+HoYGbpepQvR5lZZmvaLyAjc8
         MyD+l3+26eOz/Jzv840f/PIiDnKw0W+uc2LIYwy/Hhdb+QssGmFElmjgJVy+6OG0/Icc
         JvXQ==
X-Gm-Message-State: APjAAAWaCkeYMmwBp7ZqpdCdqWjR+Ds5QQS5F1XR1PACwKQAt3GXd+0a
        0MZtqjcZoqAC5cWsPDIwQhF2GHR7HGTlNo1omCe5ulgnpLusqexLxHA81fWrfE/6GX4BL1vUt1O
        NJaC2leLrNrDhkojnWlMq
X-Received: by 2002:a17:902:82cb:: with SMTP id u11mr10426927plz.313.1570123743272;
        Thu, 03 Oct 2019 10:29:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSfAqTaew0JD5ZU0+Z9NkYE4T9Dt3wJBWjJZFhmQ0ZxSZ4KisCFXx7oPCag5yPjJxnTPRSIA==
X-Received: by 2002:a17:902:82cb:: with SMTP id u11mr10426899plz.313.1570123742854;
        Thu, 03 Oct 2019 10:29:02 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id c62sm4638873pfa.92.2019.10.03.10.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 10:29:01 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: max17042_battery: fix some usage of uninitialized variables
Date:   Thu,  3 Oct 2019 10:29:48 -0700
Message-Id: <20191003172948.15834-1-yzhai003@ucr.edu>
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
index e6a2dacaa730..b897776a2749 100644
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
+		return;
+
+	ret = regmap_read(map, MAX17042_VFSOC, &vfSoc);
+	if (ret)
+		return;
 
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

