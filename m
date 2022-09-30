Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04C95F021B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Sep 2022 03:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiI3BJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Sep 2022 21:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiI3BJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2022 21:09:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86971F9CA2
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 18:09:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e129so2871344pgc.9
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 18:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6zu5cVI+Iv4TX95Z1+VgZcFJI+6VGuo5ryEev6S/5uI=;
        b=SnJ/Jtg3RazQ9gNhdKrL3gyO519IiQc6cLPl5gGLJz7PRYIPKfUMH2JgklRvwY+Arg
         0uGyw7ei+yvJLj6oUEXDyNKodcAw589RRZ+ujujCDyWUQ04IWOJod+A7wmANXJo7KzdK
         LT1nwBix2KUU6O5kuD5qiogwdt3Wg0q9h+SNmDB1MBA9+wZR7P/OD71SWoIXb9gcwf9p
         1tk1UeTdpAUeOP3dPMohW9QM+BFIufjp9My+jrGLFE+JT5XvhFb+MswsPzodcheofoDs
         U2QUKMl7DJXD249XLBTF/4BR0c0DIHPvp6bD68rcVp/MhGQQXSLZRr0k+F4Jsrq7CDhs
         o5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6zu5cVI+Iv4TX95Z1+VgZcFJI+6VGuo5ryEev6S/5uI=;
        b=SMqss44c+EbHfnxhmiWjjVIjx3YNonnqQ+bp7SZjsyiJDZ3EYJy/BSMaymOP73Rus1
         RL2UAV9lQorpBVs2Yt5IeoEpZvlrBSV0RpRcOAXp6L3N1nME3hCfz/UkOS3Uwy3rciNK
         MvD1uQgk16cZwNG2D9z7zB8u6rPk1V727Jgnv06wFyaloVA5jzkDaLJ2YTWvM932Q/Hy
         UVCd+zlrIXNA4gDRn1RXQE9duM1429XciI6xLD8slLKiweQ7n4nhiqZreS0e/RvhDEPC
         pnqZsGCuR7hdhmNKrW+aQr2iiAPoMs7JAUWTqUsdCmd0PzOM5iDgAZ0dNTlwdonqURSd
         p6pA==
X-Gm-Message-State: ACrzQf1qHjqv3ICujP0SeQGzvIPl1VaKAImbChAuC5lWSyjKF+4wSS66
        UyVrthjqdHSrmc6ATxa6aqL4ojOFYvGxbw==
X-Google-Smtp-Source: AMsMyM4UtUlLgi+3fqld4Zj7FhgnpcOhnEqfAN82PoLjF02QBbUkSUfcMcmBXsie22Mun/uEtk5aDQ==
X-Received: by 2002:a05:6a00:1d26:b0:54e:8c81:9f64 with SMTP id a38-20020a056a001d2600b0054e8c819f64mr6214406pfx.58.1664500151431;
        Thu, 29 Sep 2022 18:09:11 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id l188-20020a6225c5000000b005411a68fe74sm315179pfl.183.2022.09.29.18.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 18:09:11 -0700 (PDT)
From:   Xueqin Luo <luoxueqin66@gmail.com>
X-Google-Original-From: Xueqin Luo <luoxueqin@kylinos.cn>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH -next] kernel/power : add pr_err() for debugging "Error -14 resuming" error
Date:   Fri, 30 Sep 2022 09:08:21 +0800
Message-Id: <20220930010821.221381-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As the machine boots normally, bios initializes the memblock and sets the
flags of some memblocks to 0x1. During the S4, the bios once again
initializes the memblock.This initialization may change the flags value
of some blocks, for example, changing the flags value from 0x1 to 0x4.
0x4 means do not add to kernel direct mapping. These changed addresses do
not pass the validity check of the pfn_valid() function, resulting in the
following "Error -14 resuming" error.

[  T357] PM: Image loading progress:   0%
[  T357] PM: Read 2681596 kbytes in 0.03 seconds (89386.53 MB/s)
[  T357] PM: Error -14 resuming
[  T357] PM: Failed to load hibernation image, recovering.
[  T357] PM: Basic memory bitmaps freed
[  T357] OOM killer enabled.
[  T357] Restarting tasks ... done.
[  T357] PM: resume from hibernation failed (-14)
[  T357] PM: Hibernation image not present or could not be loaded.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
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
+				pr_err("Address %lx is not valid.\n", buf[j]);
 			return -EFAULT;
+		}
 	}
 
 	return 0;
-- 
2.25.1

