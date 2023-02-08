Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEB68E6E2
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 05:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjBHEAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 23:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBHEAs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 23:00:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9CC233E9
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 20:00:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so1029603pjp.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 20:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrSasTHUWHyknm8t+OqzpF7esMFl5X5VPv7s+9gtrSQ=;
        b=yYLsC+a9foAgx0/qG8Tynxa2rhnjlf4m5wChT5u7ipx2Pv7z7GJg7Fhuaj+HXPgLmc
         IK93iXYHKD3TDgXWyIh/N1lLqhMwjwXdcVe4e6UQiRxWpB4HvvcU7F6z24IHrBr/jq1q
         sJRBVKkXc+Jx9FMfiMdVQcXgJ5kDOPZ6U7VNISWtNtFidCktQCxbHPnen/2hWNCpuZAJ
         Tn/qQOS1joFqlima6k1jSIKJF28c79UJSGv2ZXdNNIyM/xSTD2h88B4Mmoa19A/9s+sG
         i0z6m7moGYBvsxE6dNc2uVDxvDYKW50H+sc4Wl7V2t3On7dbKLK3og4TskrjE/FZM2rn
         Suzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrSasTHUWHyknm8t+OqzpF7esMFl5X5VPv7s+9gtrSQ=;
        b=DttEG574DpkoRDiTGUZFIY4J6RtgJ9nzlWOSEcs13SLAEcOvyjIoQms6l8s4NuVFdG
         vugAz34HsSCyC5J1gP0tdFrbd2HgGUrCmmS5tlRsZ6H5T3OMDfB5KppESWgSpQG1yiBR
         sNhkmbwR2yytgaGQs3ca05kt3x56uU8vlovkWfclyEDk8LODtM+jT3njcEtPpXiV8Cs/
         SMY4MIs2m+mumFv6aJ4Ls3DZbt2W1QbAl284cGUQ/wmmo2+wkFYR2ZUlVidP5EkVtMJj
         o7GtFQXOo+dLcS8mG3iH60WdEFOGfaawmH2tF2zoMHooF8YehliQW3WDn2WvoOpUyo2S
         6qGg==
X-Gm-Message-State: AO0yUKU2QNTPNBLKwM9+ZIgviuPzk6TRPD0VgrLDm9AnhPbwiAKdxqpS
        P/N95AdfwZhqfuS0ZoIpWtVL8A==
X-Google-Smtp-Source: AK7set/9qgEiwKvOj6aKp/6/q1tqJKLwJbNI8/zG/1M/qdwzDsD/oda/vOdT5Psnro5Bo6OfF669mg==
X-Received: by 2002:a17:902:d505:b0:198:e8c6:859a with SMTP id b5-20020a170902d50500b00198e8c6859amr5908845plg.0.1675828846121;
        Tue, 07 Feb 2023 20:00:46 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id p6-20020a170903248600b00198b0fd363bsm9753879plw.45.2023.02.07.20.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 20:00:45 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH RESEND] PM/OPP: fix error checking in opp_migrate_dentry()
Date:   Wed,  8 Feb 2023 12:00:37 +0800
Message-Id: <20230208040037.60305-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Resend as a separate patch.

 drivers/opp/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 96a30a032c5f..2c7fb683441e 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -235,7 +235,7 @@ static void opp_migrate_dentry(struct opp_device *opp_dev,
 
 	dentry = debugfs_rename(rootdir, opp_dev->dentry, rootdir,
 				opp_table->dentry_name);
-	if (!dentry) {
+	if (IS_ERR(dentry)) {
 		dev_err(dev, "%s: Failed to rename link from: %s to %s\n",
 			__func__, dev_name(opp_dev->dev), dev_name(dev));
 		return;
-- 
2.20.1

