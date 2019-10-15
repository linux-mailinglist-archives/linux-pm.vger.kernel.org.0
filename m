Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314FED7C8A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfJOQ5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 12:57:03 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:34079 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfJOQ5D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 12:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1571158622; x=1602694622;
  h=from:to:cc:subject:date:message-id;
  bh=tJT8udUe23SQ/yMvXD9JrhV+zdyow2x8Zk5qa/cM1lw=;
  b=kwqJI4LRtiIQgzIuaPaxiqVQ6q97bZxu/wAqXPeFJX38IhOeQafkWzGP
   Kn0ESeyReXnI8ajdYNebrTQPipm0n8yErhpxbeH8RXgz1Ki5uYRsgL6ds
   HFm9ISb5IU8ePXogqg9AN8jo85d90ziyXn5uuWwsOnFSSjeUYTy11Bt0e
   1LMcHuDzX3xDo9IEnFDbK9p4JB/Dn1J0vPoYKP/UIrTiCADIaXtE0Q+fU
   1dAgsDVYasHaANAapsAR59YwLlEfpLTmck7G/fKx5fn/AjMagmlXC5zsd
   S2VbNQ+iuDGMZ3bm9rw7Z+30cjgiwlU+Paty9DMgc02yHxBSAJBNuaELJ
   A==;
IronPort-SDR: IxMzZAf3dYGaOfkIgl7wP4cXtwvp8/75qQR1egV/l4w/BUHVolfZooDLUpq5g4oayn78+vDxqR
 h8BYYYT8vqCz+CT7Ko99+qio2mtodVGh/nkvEQ5f3+oJOHmbqbOsnX2ksTpVtirouVzr96COsz
 oFexY6Mx7nZNVPiXfRli5W61KkSR8VOp1fNeohEAYDjVIkTet30252E6NX2vswDNQy7W4aZMtu
 Oa42scBLQ+t6aNBqq9veKqJ+6OYB2W1lUZEiNiNOeWTRVRkQaWU/4Z/tdXXeDRUQQq+5Ro45oy
 2d8=
IronPort-PHdr: =?us-ascii?q?9a23=3ANlPahx3lLMXLwrbJsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8Zse0eLPad9pjvdHbS+e9qxAeQG9mCsLQb0KGP6/2ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalwIRi4ogndq9UajIt/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMXsNQVyxaGYO8bo0PD+UcNuhGtof2ulUOrRqgCgmoGezk1ztEi3Hq0aE/1e?=
 =?us-ascii?q?kqDAPI0xE6H98WsHrassj7OqkRX+6y16TE0SnPYulK1Trn9ITEbhYsquyMU7?=
 =?us-ascii?q?JqdsrRzFEiGAHEjlSRqYzlIjSV3fkKvmmb7utgVfigi287pw1trDWi3doshZ?=
 =?us-ascii?q?XTho4P1F/L6Dh5zZ8zKNalS0B7ecapHIVMuyyeLYd7QcMvT3t2tConxbAKo4?=
 =?us-ascii?q?C3cDQWxJg/2hLSaviKf5KW7h/tVOudOyl0iXN/dL+9iBu/91WrxPfmWcmuyl?=
 =?us-ascii?q?lKqzJIktzLtn8QyRPe8tOHSv5h/ke53jaPyhzT5vlEIU8qkarbLIYswrsqmZ?=
 =?us-ascii?q?oStUTPBzf2mEHrgKOPeEUo5PSk5/j9brXpoZ+cMIB0igXgPag0hsO/BuE4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VPlTLhOlPE7kanUvIrEKcgGqaO1GRFZ3po/5xqnCjepyt?=
 =?us-ascii?q?UYnX0JLFJffxKHipDkOlHPIfD4F/i/gkignCtlyv3dI73uHo/NImLdn7j8YL?=
 =?us-ascii?q?Zx81RcxxYrzdBD+5JUDakMIPbyWk/3qdzZAQY1MxSxw+v8FtV92Z0RWXiVDq?=
 =?us-ascii?q?+aLqzSq1mI6fwrI+WWY48Vojn9eLAL/fnr2E44i18AeuH9zIkXYXHgRq9OPk?=
 =?us-ascii?q?6DJ3fgn4FSQi8xogMiQbmy2xW5WjlJaiP3APox?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EvEgA1+qVdgMjWVdFmHgELHIFwC4N?=
 =?us-ascii?q?gTBCNJ4YzBospGHGFe4owAQgBAQEMAQEtAgEBhECCcSQ3Bg4CAwkBAQUBAQE?=
 =?us-ascii?q?BAQUEAQECEAEBCQ0JCCeFQoI6KYM1CxYVUoEVAQUBNSI5gkcBglIloguBAzy?=
 =?us-ascii?q?MJTOIYwEJDYFICQEIgSKHNYRZgRCBB4NuB2yEAwobgz6CSgSBOQEBAYtBiXJ?=
 =?us-ascii?q?wlWsBBgKCEBSBepMVJ4I6ggKJQDmLDAEtjBibJwIKBwYPI4FFgXxNJYFsCoF?=
 =?us-ascii?q?EUBAUggeOLiEzgQiNe4JUAQ?=
X-IPAS-Result: =?us-ascii?q?A2EvEgA1+qVdgMjWVdFmHgELHIFwC4NgTBCNJ4YzBospG?=
 =?us-ascii?q?HGFe4owAQgBAQEMAQEtAgEBhECCcSQ3Bg4CAwkBAQUBAQEBAQUEAQECEAEBC?=
 =?us-ascii?q?Q0JCCeFQoI6KYM1CxYVUoEVAQUBNSI5gkcBglIloguBAzyMJTOIYwEJDYFIC?=
 =?us-ascii?q?QEIgSKHNYRZgRCBB4NuB2yEAwobgz6CSgSBOQEBAYtBiXJwlWsBBgKCEBSBe?=
 =?us-ascii?q?pMVJ4I6ggKJQDmLDAEtjBibJwIKBwYPI4FFgXxNJYFsCoFEUBAUggeOLiEzg?=
 =?us-ascii?q?QiNe4JUAQ?=
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="15213564"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2019 09:57:01 -0700
Received: by mail-pl1-f200.google.com with SMTP id d1so12450044plj.9
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 09:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Oyyo8ueGcSv2C2YN7t5+4dy6tp5fxBoXld6XJLZPnpM=;
        b=BCEDxWcfAr9I1IzwCzysv9322c8KBFCZw53EL7cf5OiyI4mAoxju6RVHpAEP1wUOp4
         zmjKiZNEM1aiZndmQvvxWegjAoAQt73pGqEjNninz/qIa7KE3WUNcjM4bq0GOrTdkdf0
         9L15A4A2Yuuik4qiors93tlt5AUHZTJKAx0TY+j4zz2fKaJPQKw8De75Lif4W5RXAiNT
         2HQSqrWROJ1R5c05IbqxgFi1zmjX1iIO6i3k4qHiJamCrTtq7w2j4upN5QFq3okyXJx7
         0rb4vpiLxbkwKH7uNvo9j+EUYnSXXItPpKUYdmt/AsTyGcJk8lS/tqJqcJLyQhC8uOOE
         HTrQ==
X-Gm-Message-State: APjAAAW/PutWmyjadqD4jWOJZdgaN3ypiHcCGRVoUr5ARli/BjHWBLn1
        anBMnvkTeHdrLu4AHGN+P0V2ZBC6/MyFYIT/fMAHMh0PniqmmACd6/5ncRoyiLvjS1xtvyquGI/
        RkGxSJMB4iHCf8+ciDopN
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr37063838plp.218.1571158620567;
        Tue, 15 Oct 2019 09:57:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYM/sGx2FnwldouLf984y/BIUzeFauhYwXc+v3vyUmkpZ29mvFBQoj0yMfftTqU12/tZAZ2w==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr37063822plp.218.1571158620267;
        Tue, 15 Oct 2019 09:57:00 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id v19sm21864641pff.46.2019.10.15.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:56:59 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     zhiyunq@cs.ucr.edu, csong@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: rt5033_battery: Fix the usage of potential uninitialized variable
Date:   Tue, 15 Oct 2019 09:57:37 -0700
Message-Id: <20191015165737.658-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In function rt5033_battery_get_present(), variable "val" could be
uninitialized if regmap_read() returns -EINVAL. However, "val" is
used to decide the return value, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/power/supply/rt5033_battery.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index d8667a9fc49b..6a617531698c 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -26,8 +26,14 @@ static int rt5033_battery_get_present(struct i2c_client *client)
 {
 	struct rt5033_battery *battery = i2c_get_clientdata(client);
 	u32 val;
+	int ret;
 
-	regmap_read(battery->regmap, RT5033_FUEL_REG_CONFIG_L, &val);
+	ret = regmap_read(battery->regmap, RT5033_FUEL_REG_CONFIG_L, &val);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to read RT5033_FUEL_REG_CONFIG_L.\n");
+		return false;
+	}
 
 	return (val & RT5033_FUEL_BAT_PRESENT) ? true : false;
 }
-- 
2.17.1

