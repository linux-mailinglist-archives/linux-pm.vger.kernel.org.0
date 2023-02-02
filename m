Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C866878F5
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjBBJe5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 04:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjBBJeW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 04:34:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B805A3250F
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 01:33:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r8so1263834pls.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 01:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM2J8wywmFAkpO23AWoNhmUW5UYZgKdN8YXNnF3yVyM=;
        b=Wo251TnMqE/xUy53nVYNHNixxFzGh7uMlcDfpYQ+hGF2EY+SJzxpkjwBz48HPc7PdI
         mCFS238qz28Vl58shnx7iHLNFk04lJSx6DBPVu/g0MdME9NBiPwyf8pcdWn948EQ+b1X
         3L4mbybXZoI3HB7ZZ11CWlSWrV874N3enXLiqrQs+JVJQpWroJo70oWsm4M3ixY85h6Y
         1V3zFiUAuGXxynacB3GnOZ6Fk43JZUw388DSIibs9r7coNVmhMD43BAonOhmqrwmwsyY
         kIwSbkbWIdAIBN/o2wG9FPcqHZz+60XzLDiKc1sesKImRjuPrXft04vWwuh90EckuM8P
         +84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM2J8wywmFAkpO23AWoNhmUW5UYZgKdN8YXNnF3yVyM=;
        b=5rxdNbSD9kfyjnWS1ed3N9gCFR9ZcY7p1l7NPW1hY7iRTSZqN+YVv7KIUoRzB7Np3s
         WihPWjWSBNIWb/Kr6FyEAMLoSruA/KQb3hd9p5ELqwEi2XPqUXsLw0cJbeE0Coxke/fE
         DKuYY02Zs57K0kDszWG8NPPuGlGGiNmcUDs1B02Z7sXLtVUKZZSX0mX56rYzndNwOyLw
         FO5rFDTnDFUAwNO7BpVO24qAkQIg0hNEw7OBcUuNVqmIap9HZ3Kt0XrgSdyhqVpTt5St
         drb8OSb/ISSaBL7l0VZal7ZUwKaSF84hNI/F2Go7w0GbP0qkxVz3Je/CNzTAzB4Rk46v
         +mtg==
X-Gm-Message-State: AO0yUKWzGrlhAVYrwBbMxAuztNX579ur6C3zPxVZ92GWFDQbFsmnaCTR
        g0OJPq2c4TOezZvWAhhyIXlHPQ==
X-Google-Smtp-Source: AK7set+6yxCwb4C8Sjo5cbMP62x/cHWST+OuLy22i2oHl2I2Ffq042rnTbWnJNsZq82jcV0XES36RQ==
X-Received: by 2002:a17:902:cecb:b0:196:86c2:ee89 with SMTP id d11-20020a170902cecb00b0019686c2ee89mr6913134plg.3.1675330402292;
        Thu, 02 Feb 2023 01:33:22 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902848a00b0019254c19697sm13153343plo.289.2023.02.02.01.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:33:21 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/3] bonding: fix error checking in bond_debug_reregister()
Date:   Thu,  2 Feb 2023 17:32:55 +0800
Message-Id: <20230202093256.32458-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230202093256.32458-1-zhengqi.arch@bytedance.com>
References: <20230202093256.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit ff9fb72bc077 ("debugfs: return error values,
not NULL") changed return value of debugfs_rename() in
error cases from %NULL to %ERR_PTR(-ERROR), we should
also check error values instead of NULL.

Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/net/bonding/bond_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 4f9b4a18c74c..594094526648 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -76,7 +76,7 @@ void bond_debug_reregister(struct bonding *bond)
 
 	d = debugfs_rename(bonding_debug_root, bond->debug_dir,
 			   bonding_debug_root, bond->dev->name);
-	if (d) {
+	if (!IS_ERR(d)) {
 		bond->debug_dir = d;
 	} else {
 		netdev_warn(bond->dev, "failed to reregister, so just unregister old one\n");
-- 
2.20.1

