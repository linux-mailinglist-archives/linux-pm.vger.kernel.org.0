Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B66F03DF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Apr 2023 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbjD0KBH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Apr 2023 06:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243136AbjD0KBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2023 06:01:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A88D1991
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 03:01:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a69f686345so64311525ad.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1682589664; x=1685181664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9mOuUkhnwntmiMJZCh4kgvplTAXhV1xgo2sdUsRp4E=;
        b=H3P7NwYuB35IHIsCq1x7d0AnmUoCg1MOfVetmnmXeLL/hjuZvDTcJow+MCS+SFLN8F
         b+hMvRaQpfFxfi19GkOihP7GTGdydBKRMFh6gYyE5UVFtra3QUX8U0sGJQUQjuPQpVJa
         l+TElK7z5G3Ef7yKDxbkiTTTDkFc1FaeoCgGH4tP/GH30aK8/E290DLdbjiDkYl4/Wnz
         WL/nxpEFQtuWp/5OZ4z4o51EwAMpO+STong6rC4Yes8NSSBTPovxk9Dmnr9a1hXFSv4r
         pMDWCZLeA1h7QIJhW6puZCDFrXQW9XXOzonTuW1VvEhpCFYDpZYBpsOKd0H9bsc4vlRU
         xcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682589664; x=1685181664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9mOuUkhnwntmiMJZCh4kgvplTAXhV1xgo2sdUsRp4E=;
        b=jOunVuLoQQz4kxRvdyYxC9zoNSEjgq5guEkP2m/PYRKIXFz08zlFidiyp1EOJ0IXgG
         D8hlxt4Rpd8Qm2+6j7sZrMLj11O08TxiSwZ7UUh0mUFuOBCQZOO67vm+0/M+bCUllUv8
         8rWGfvHwoaEqbsgMSakP31FFdPA5wTwVnqb/lYayqhcocXZ9GT3caljxZJdcEMq8ohLy
         /MT9PSFFdKckdR6iq5tUH9k1hASfM/76WvW437sDaxWcRqCN7aZls/cJHLRjw9a66eQJ
         qvYkVvjRNywkViP4fvHRdn4r1cQRlDLVUwQeAkuFf7lUjjidWIVLHsIVmF1I+J1Opj3O
         jiLw==
X-Gm-Message-State: AC+VfDw8B+dejjss8SyiqfgWfhucbDvIIIeZu3vK+qXsD1TQAwd7RqYv
        lZz0tLabWfXxEUu6sLyFRppJDg==
X-Google-Smtp-Source: ACHHUZ6iMKV8sKifSn/PKDp8xiDUoGRtRtuBPGj8FFt801gaMLUFRpqt5TSY/E6n9lTtZfNxyy8dxg==
X-Received: by 2002:a17:903:22d2:b0:19e:ad18:da5c with SMTP id y18-20020a17090322d200b0019ead18da5cmr1114789plg.37.1682589663819;
        Thu, 27 Apr 2023 03:01:03 -0700 (PDT)
Received: from paddy.. ([101.78.151.194])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ab8300b0019a97a4324dsm11366104plr.5.2023.04.27.03.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:01:03 -0700 (PDT)
From:   tongjian <tongjian@huaqin.corp-partner.google.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tongjian <tongjian@huaqin.corp-partner.google.com>
Subject: [PATCH] power: supply: sbs-battery: return -EPROBE_DEFER when battery err
Date:   Thu, 27 Apr 2023 17:57:49 +0800
Message-Id: <20230427095747.3889718-1-tongjian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some batteries are not init complete when the first poweron, this cause
the devm_power_supply cannt be registered. we will return -EPROBE_DEFER
for probe retry.

Signed-off-by: tongjian <tongjian@huaqin.corp-partner.google.com>
---
 drivers/power/supply/sbs-battery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index f84dbaab283a..0669c1bc1e4f 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1187,7 +1187,8 @@ static int sbs_probe(struct i2c_client *client)
 skip_gpio:
 	/*
 	 * Before we register, we might need to make sure we can actually talk
-	 * to the battery.
+	 * to the battery. If a failure occurs when talking to the battery, we
+	 * will return -EPROBE_DEFER for probe retry.
 	 */
 	if (!(force_load || chip->gpio_detect)) {
 		union power_supply_propval val;
@@ -1195,7 +1196,7 @@ static int sbs_probe(struct i2c_client *client)
 		rc = sbs_get_battery_presence_and_health(
 				client, POWER_SUPPLY_PROP_PRESENT, &val);
 		if (rc < 0 || !val.intval)
-			return dev_err_probe(&client->dev, -ENODEV,
+			return dev_err_probe(&client->dev, -EPROBE_DEFER,
 					     "Failed to get present status\n");
 	}
 
-- 
2.34.1

