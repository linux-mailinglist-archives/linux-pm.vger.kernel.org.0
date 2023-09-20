Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E037A87B5
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjITO45 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjITO44 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 10:56:56 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584749F
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 07:56:50 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bba7717d3bso4477081fac.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695221809; x=1695826609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RN8EPDbLpzdHtT/0DurOJ41TFJv1ZWNalVJPdC8jaPc=;
        b=IOq6eMThw60uNDpIh62rfv4lscXyxIyK51JEW+ltmhNzvqK8eyf49Jz41ycl/DFIaJ
         r0KxxwhtKOETUXcvJcR9yzt8J6WuL+MIEAh5ximCFcusE8NmZLtx3vPMsUcBkKDN0OIP
         JpFOT0RUP2ksTWplM7G+k6qWmwF+mtr14XHPvVV22kVpPJQ2QdZ7NXNlkadcqE1Zfsh0
         8Ap8RxAH4fe+MXeB8FatmMNOCj3nI/XB2rEw7M10hRVlioVavVn9BNfjlEkRmFg+I/3P
         DuMh5llSxKNx7+IBmNj9qE4apaA3glpxVIpOH2mOoaWSnulgjxepmCkj4QxmBfQpRTSz
         ojyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695221809; x=1695826609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RN8EPDbLpzdHtT/0DurOJ41TFJv1ZWNalVJPdC8jaPc=;
        b=U5KhEZWFnSFMy/La5wrL9RusVpTHFsihH+ZvkZjZ6JXZgyU+BD1EillnrumTwogMAc
         6r+wqNLNlPRK9BjrH0nENFDalZH2qSVt4vM94RJP2u2PzVlI6Qw7qfsaHAG12SGUnv9L
         VbpMhGNdL5kn8wED8KFrmHabLgN9Nswcb+J5JzANTjeJGdxeTaUVxdCLnsM1yWQo+F0N
         4t3P51+KBhB5WmHuW4O1fscfKtWWYmw9iAEwhD+Y4cZitIdFrQ5AREqF5UmC4/iLJdgI
         DxavAkTuJxNuES4yapqM5M8+4cjN7OQY/0YVG3RZY+HOygMO8Auf1r0omCIzY+mkbpnF
         Rt5Q==
X-Gm-Message-State: AOJu0Yyja+tWdnPHIApIHcCdEaBlXG3y9DebPGTYLyEgtEXkzcoPFQib
        9IlII0S41mUUKzKOdd9W7WSKsIa2/ro=
X-Google-Smtp-Source: AGHT+IHkC08bhTGrlezaUIBgcRRgf29/p/ug2k13mpsopXuxjyKJNZWCKinXX/Dlp3Z0An72OVZmgg==
X-Received: by 2002:a05:6871:588:b0:1d5:21f9:7272 with SMTP id u8-20020a056871058800b001d521f97272mr2854523oan.23.1695221809291;
        Wed, 20 Sep 2023 07:56:49 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id fs6-20020a056870f78600b001d6adce894dsm4742773oab.17.2023.09.20.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:56:49 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linqiheng@huawei.com, sre@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH V2] power: supply: Fix additional refcount leak in rk817_charger_probe
Date:   Wed, 20 Sep 2023 09:56:44 -0500
Message-Id: <20230920145644.57964-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Dan Carpenter reports that the Smatch static checker warning has found
that there is another refcount leak in the probe function. While
of_node_put() was added in one of the return paths, it should in
fact be added for ALL return paths that return an error.

Changes Since V1:
 - Use devm_add_action_or_reset() to call of_node_put() instead of
   calling it in every single error path from the probe() function.

Fixes: 54c03bfd094f ("power: supply: Fix refcount leak in rk817_charger_probe")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Closes: https://lore.kernel.org/linux-pm/dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain/
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 8328bcea1a29..708689d34959 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1045,6 +1045,13 @@ static void rk817_charging_monitor(struct work_struct *work)
 	queue_delayed_work(system_wq, &charger->work, msecs_to_jiffies(8000));
 }
 
+static void rk817_cleanup_node(void *data)
+{
+	struct device_node *node = data;
+
+	of_node_put(node);
+}
+
 static int rk817_charger_probe(struct platform_device *pdev)
 {
 	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
@@ -1061,12 +1068,16 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	if (!node)
 		return -ENODEV;
 
-	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
-	if (!charger) {
+	ret = devm_add_action_or_reset(&pdev->dev, rk817_cleanup_node, node);
+	if (ret) {
 		of_node_put(node);
-		return -ENOMEM;
+		return ret;
 	}
 
+	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
 	charger->rk808 = rk808;
 
 	charger->dev = &pdev->dev;
-- 
2.34.1

