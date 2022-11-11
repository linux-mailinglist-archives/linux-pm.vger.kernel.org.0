Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB336252E0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Nov 2022 05:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKKExL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Nov 2022 23:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKKExJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2022 23:53:09 -0500
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CDB18B21
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 20:53:08 -0800 (PST)
Received: by mail-pl1-f196.google.com with SMTP id io19so3352491plb.8
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 20:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wuj86cGn9Y3n9vIX3WOCltOvXF3Lm7Ajtz3DUHiTbVY=;
        b=VDILLh6ioLOUQGyZcFPft1Y3tWpnujmzBGBky3nqseoWg40aSmFGVLTCQzawumaRJm
         QlaYKKEnGa12hT5RFrvHaaHU5nqHCfibZemv8Jfjx9h1dlOq6Rbjr9JBuuK0Rt+sKFxG
         FFVyQkGy6D3Fw6lvIi6ChclEIZU70qca8JLgN+lL8JYm5YFvsfEAJUFHBOX6qfltUh+l
         mlOUrGeQevfvb9bc/sUu+CbSjhl9z5nXtjYc+JyJS4qESK+soebjO10tR8iXYB9N4j14
         ZF0fukuN13rADWDBfEuVLaZf+3awz3LDEybWIYPb4SfIZzapdhdaFem5v+dvCN/HtKby
         iuzw==
X-Gm-Message-State: ANoB5pmnvnjYbF3All9en2XkZfCZI9CqoaV7LO10fzqkHzDPDcPeQEwW
        eNU1lTX5JaCn7UlNAQaiVEY=
X-Google-Smtp-Source: AA0mqf5ee1SESj29J372oTVSMapa6otk7oSeltnQVBQyS5nGUaF0efe7Cad6V/LLz0cF4kBm/JDsUw==
X-Received: by 2002:a17:903:328c:b0:186:9c2b:3a39 with SMTP id jh12-20020a170903328c00b001869c2b3a39mr873274plb.115.1668142388379;
        Thu, 10 Nov 2022 20:53:08 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id k17-20020a63d851000000b004411a054d2dsm472900pgj.82.2022.11.10.20.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:53:07 -0800 (PST)
From:   Xueqin Luo <luoxueqin@kylinos.cn>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, xiongxin@kylinos.cn,
        Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] kernel/power : add pr_err() for debugging "Error -14 resuming" error
Date:   Fri, 11 Nov 2022 12:52:42 +0800
Message-Id: <20221111045242.530607-1-luoxueqin@kylinos.cn>
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

