Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B028625308
	for <lists+linux-pm@lfdr.de>; Fri, 11 Nov 2022 06:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKKFT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Nov 2022 00:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKFT4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2022 00:19:56 -0500
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006AE6B398
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 21:19:55 -0800 (PST)
Received: by mail-pj1-f65.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3779806pjc.5
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 21:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wuj86cGn9Y3n9vIX3WOCltOvXF3Lm7Ajtz3DUHiTbVY=;
        b=EIJFkupNf5Y7yvKCenbTpb2pYeeegbkWs+EdwTbOeyOeTeVc17NaubgqhxkE6+3Wrz
         tcTB1N0zyrLhvT6N5QgsIFc0oUrg/Cm2tizcp19gki8rwERH/HtRTlLE2VtvZhmesZMM
         JP5NKKdDZfYxXYWV/k7lsM7ZJnpBGrps4nwp6nWO9ceNgZjwnMXQ57mdx3rp1J8L4/vN
         yaGB6fE19/1CIuJRGAEu7hYwfP6c+xy7ZgcAzHohwyvYGWuSykXN4QUriB2N2YGi2hiq
         g8YoZ5tT1mLWdL87Svot5mkKYFxxcU4XUfvu+TxH1kwC1GDHbV+edxECQH1dPaXD1w4v
         /Htw==
X-Gm-Message-State: ANoB5pkWFhsU8cuM6krYv0NEk63ctRgCpmUjTSWae8McAbo0+gNzMdXi
        lgl09bIYT0hGO9Uaip7GnO4=
X-Google-Smtp-Source: AA0mqf5afPbkrXYcJ4EXc22soCo1rM8jBlgUl5h+r8XLjhDvZkPcEfwnDTimf8HkfVlsp14osqAvTA==
X-Received: by 2002:a17:90a:8990:b0:212:dc2f:7ee7 with SMTP id v16-20020a17090a899000b00212dc2f7ee7mr123396pjn.172.1668143995460;
        Thu, 10 Nov 2022 21:19:55 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id mu4-20020a17090b388400b00206023cbcc7sm4017785pjb.15.2022.11.10.21.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 21:19:55 -0800 (PST)
From:   Xueqin Luo <luoxueqin@kylinos.cn>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, xiongxin@kylinos.cn,
        Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3] kernel/power : add pr_err() for debugging "Error -14 resuming" error
Date:   Fri, 11 Nov 2022 13:19:49 +0800
Message-Id: <20221111051949.532274-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The system memory map can change over a hibernation-restore cycle due
to a defect in the platform firmware, and some of the page frames used
by the kernel before hibernation may not be available any more during
the subsequent restore which leads to the error below.

[  T357] PM: Image loading progress:   0%
[  T357] PM: Read 2681596 kbytes in 0.03 seconds (89386.53 MB/s)
[  T357] PM: Error -14 resuming
[  T357] PM: Failed to load hibernation image, recovering.
[  T357] PM: Basic memory bitmaps freed
[  T357] OOM killer enabled.
[  T357] Restarting tasks ... done.
[  T357] PM: resume from hibernation failed (-14)
[  T357] PM: Hibernation image not present or could not be loaded.

So, by adding an Error message to the unpack () function, you can quickly
navigate to the Error page number and analyze the cause when an "Error -14
resuming" error occurs in S4. This can save developers the cost of
debugging time.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
v3: Modify the pr_err() function output again

v2: Modify the commit message and pr_err() function output

 kernel/power/snapshot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c20ca5fb9adc..e7bd4531faf2 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2259,10 +2259,14 @@ static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
 		if (unlikely(buf[j] == BM_END_OF_MAP))
 			break;
 
-		if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j]))
+		if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j])) {
 			memory_bm_set_bit(bm, buf[j]);
-		else
+		} else {
+			if (!pfn_valid(buf[j]))
+				pr_err(FW_BUG "Memory map mismatch at 0x%llx after hibernation\n",
+						PFN_PHYS(buf[j]));
 			return -EFAULT;
+		}
 	}
 
 	return 0;
-- 
2.25.1

