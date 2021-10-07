Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67671425B67
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 21:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243875AbhJGTPj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbhJGTPj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 15:15:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC98C061755
        for <linux-pm@vger.kernel.org>; Thu,  7 Oct 2021 12:13:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j21so11199231lfe.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Oct 2021 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjDe0yIphZCEaHpy1akQDBeuu+tsHx+ZeFrUoh9wGPM=;
        b=jgrcGzrjOxMDM93NIaXnv2tlQHrXOQHWIyxyZHpPdUpdOzemNbpBZhMsFaYppOX3GO
         0vyUYYwwXjXPLxtSHi21GDI11YGPcx60ph5sCXQ6Vf52w1UdoLqv9kVlbShoYFU2DpNn
         IahKp6bS8ouGV8PHoL0SYFBjvd2VuMTfyTyF+B/gBYUflP6//SbgOBW+NPUjHFGv2aLF
         oLlU9/3sBODrBzuYpuCHVFv0PVZvGYFbXVo++04FSgQymfOCRgmrG2oYslptjIzyMDDB
         T01TE9M9r9TsVWR5Q9Nl8eNufYWAecst8G5Y+fwTC0jQVhBQKKogp+XLHUEE+2R4O9Fe
         nXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjDe0yIphZCEaHpy1akQDBeuu+tsHx+ZeFrUoh9wGPM=;
        b=yz4gDE/jL7GzwsMewDZ2O5SKB+rdIkkI3hjFVV/fWcMfowWg9ASnrBNvkGiJVYIBur
         NSpBzIZyxN9NGyFzYt/dhD5MLNMcz2fwD/GjZVAc11V2j5YhpvstwUQJyghSa3Yss04S
         kWTEWqm0ZScHu3O0GNNK5behDpJJPYJMqUhmcHl/ggE2K97qQmzn4Q+N0kWdwkTYKWWj
         hloldYtCIFBRkwRGlnkZRnLwHrNv6mTrQXA9POFMzdzIT0WBYm063jGu7HZA2QorvoZA
         8zM2mNGNX/TyqpoSNbRKX5MQJAw4A1CDm7+enFrbIeoLkQDQiDYj5aGgKXOmZfYXStfk
         YY2Q==
X-Gm-Message-State: AOAM530wVS8CMm8w0JeB9fWKnzJZwMXV4XuSDB9pMsnAjeLax50ll2H9
        agpyofHdpdmh2L27PJhTvelRKQ==
X-Google-Smtp-Source: ABdhPJxrEBInRzsE3BldocF5inO7S4oRD+hMRpwcZSl9jLJXmhn/vYyqN3TKhnotFt5LUwIDJbHuZw==
X-Received: by 2002:a19:5e56:: with SMTP id z22mr5822395lfi.146.1633634023417;
        Thu, 07 Oct 2021 12:13:43 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id b12sm16677lfe.253.2021.10.07.12.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:13:43 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] kernel: power: swap: fix sparse warnings
Date:   Thu,  7 Oct 2021 21:13:37 +0200
Message-Id: <20211007191337.540058-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When building the kernel with sparse enabled 'C=1' the following
warnings shows up:

kernel/power/swap.c:390:29: warning: incorrect type in assignment (different base types)
kernel/power/swap.c:390:29:    expected int ret
kernel/power/swap.c:390:29:    got restricted blk_status_t

This is due to function hib_wait_io() returns a 'blk_status_t' which is
a bitwise u8. Commit 5416da01ff6e ("PM: hibernate: Remove
blk_status_to_errno in hib_wait_io") seemed to have mixed up the return
type. However, the 4e4cbee93d56 ("block: switch bios to blk_status_t")
actually broke the behaviour by returning the wrong type.

Rework so function hib_wait_io() returns a 'int' instead of
'blk_status_t' and make sure to call function
blk_status_to_errno(hb->error)' when returning from function
hib_wait_io() a int gets returned.

Fixes: 4e4cbee93d56 ("block: switch bios to blk_status_t")
Fixes: 5416da01ff6e ("PM: hibernate: Remove blk_status_to_errno in hib_wait_io")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/power/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 9ec418955556..47107f9cd14c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -299,14 +299,14 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
 	return error;
 }
 
-static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
+static int hib_wait_io(struct hib_bio_batch *hb)
 {
 	/*
 	 * We are relying on the behavior of blk_plug that a thread with
 	 * a plug will flush the plug list before sleeping.
 	 */
 	wait_event(hb->wait, atomic_read(&hb->count) == 0);
-	return hb->error;
+	return blk_status_to_errno(hb->error);
 }
 
 /*
-- 
2.33.0

