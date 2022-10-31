Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE60C6138DD
	for <lists+linux-pm@lfdr.de>; Mon, 31 Oct 2022 15:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJaOU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Oct 2022 10:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJaOU1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2022 10:20:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC252AE3
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 07:20:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so16078440pji.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tp0QiSBdZdiXa8cwFCJwUm8BCXpyKQ7PA7+Rn1wVHI=;
        b=ZlterBN8j5z9aCBCd3xzR1G0p0WtZP0lKGBfQ5mxN6Wls6pszmTeX+S3sRqxr9x3Ng
         zS/PlUqLaljKBdhVjmn1JuYopxUAtIekItZ4zGgLzywII9wo84cj/rKUXS+L6vXwZd0s
         SFT2dY+9Yqwt0tnBW2EfbF7QnhjAdXgcOzoFnbP/2QE5kX0n5r+hZcxoK6wOnxzZIWEx
         IvJPk+y0S7Qe4BFLNsta71IWi+JoCGiLFEJ585LQ1ZOG6DJLUzGUhHCuAsn4/TlXB8bS
         F2JKVOJs/9D0vPWAV9PuYrRWJAZHXi6zcAaVVzSLixgN+9eaboCRU/0hwj+A+oz5xzqS
         VmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tp0QiSBdZdiXa8cwFCJwUm8BCXpyKQ7PA7+Rn1wVHI=;
        b=xoqOt2pLiMfj4s1jgoIr2i6HkA5sljnM3Avo4WtfaLCtbvqdxAP0b4w5bFJwJm2kZL
         kDH2ZAXxAZ5aR2kEUzf+qbfpn15lqzSxTihY1l6hDJHTpqZodbxc9v1xdHhI/uxamgHS
         R6zSOSymRA/ZC8XqDkJDD4ojfPkdeDTGA86Duv89eqJmfRauEElKb0Ew3xT+kzas7jbb
         KewNyKU1Pc0bwogUXGvIsgyMj416c1zn1YyoRbN4D9g4p0PRBkhJZlRH5dej2OiS1DAH
         /2XTS6HFhl0WdjMPI5wf3H53QPHxGMCmKy8bkxF3vIzDcf67zBuhQeBmZUgOL3ldIb43
         TyIA==
X-Gm-Message-State: ACrzQf3ku0Lfa/n/JO3MOTiLzL9MCoy8DXCIyBgrVQoIBwf4YKMEOLM8
        h9JuQ7jYDi+UmuRhj5nGn86bw0eUHNPe+Q==
X-Google-Smtp-Source: AMsMyM6k7C0MwEKOHw5epCpKdTuNMLevkfLYB2ZByQNcF8Sc4nkuQRf0jypCa+GGqVfzPf+C7N+awA==
X-Received: by 2002:a17:902:6ac5:b0:187:25be:5dc2 with SMTP id i5-20020a1709026ac500b0018725be5dc2mr3888217plt.155.1667226025955;
        Mon, 31 Oct 2022 07:20:25 -0700 (PDT)
Received: from localhost.localdomain ([120.227.32.166])
        by smtp.gmail.com with ESMTPSA id n126-20020a622784000000b00562ef28aac6sm4618427pfn.185.2022.10.31.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:20:25 -0700 (PDT)
From:   Luo Xueqin <luoxueqin66@gmail.com>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, xiongxin@kylinos.cn,
        Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2] kernel/power : add pr_err() for debugging "Error -14 resuming" error
Date:   Mon, 31 Oct 2022 22:20:17 +0800
Message-Id: <20221031142017.26750-1-luoxueqin66@gmail.com>
X-Mailer: git-send-email 2.15.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Xueqin Luo <luoxueqin@kylinos.cn>

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

v2: Modify the commit message and pr_err() function output

 kernel/power/snapshot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 2a406753af90..2be2e9f5a060 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2259,10 +2259,13 @@ static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
 		if (unlikely(buf[j] == BM_END_OF_MAP))
 			break;
 
-		if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j]))
+		if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j])) {
 			memory_bm_set_bit(bm, buf[j]);
-		else
+		} else {
+			if (!pfn_valid(buf[j]))
+				pr_err("The page frame number: %lx is not valid.\n", buf[j]);
 			return -EFAULT;
+		}
 	}
 
 	return 0;
-- 
2.25.1

