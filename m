Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706E0591B2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 04:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfF1Cun (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 22:50:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41780 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF1Cun (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 22:50:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so2349998pls.8;
        Thu, 27 Jun 2019 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kZvSDPnTtOxLbMDPEXnpm6sLyBBXwA46ly2h0O68PCk=;
        b=HFw4hy7WUjehvH70HQZA83Hapl2b6ErS5Eyr6EtNlOs4TTpNVp3VRivsKDtYR9U6v+
         7uzR4PtpfOvzebJsYV74p0IVfxK6SY/xiIMx5wmyVQrZQAiyrVgjDuwPOe5LaudyaX4p
         pbbAKfHNPzzuRFugzIzNqGfkS4kKjh989sfYcvhiL/qEHnjlwgRCMiZVZco8BD1x9MGq
         BwJxBeARAL60wGMEwpWBfOxv62VXPNm6QlA2sZynZ6w5y3cGDTqsKDuEYAxcGxO0hvB6
         Mf8eYa2pT36ppb9pmxH5ZvUT7q+rhsaotWO8eMLW28k/cGBhT0zUx9c92P3WwzOn4z21
         lTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kZvSDPnTtOxLbMDPEXnpm6sLyBBXwA46ly2h0O68PCk=;
        b=M9h6eI3lSIgnm0oKfUzHzsOh7pGVoi/5bLwBs2uTQrZC/o5CXVbWCM95nXtlx/nyxG
         xeUSzMleNFp6Kx53KefWWfrNtBzbs3wU6OvBsSXxPhqTKjJBptRgcVzf384BXjNI0bBm
         vdufFXnx6cxYYwfITTDjxerhM0IqpE+okTQQKVUTvrakj3FfV1Za/myBDP3WMNVH6rJG
         FfTk/pg/rdZPPn0Zl68WAMOZKm+Jw7sj0bnbC9/9J+kZqrRQvXVA9mdpZl4BkwX7/9Uq
         bQ4zXL6t8dEAMvE2eY9b2jc50/uZSuyy9MTtg2xDyOwIg7bP39Yd6k6aHsA0kzLm8hV/
         4j/A==
X-Gm-Message-State: APjAAAWAoFWA/AXohY8YgQ0Var1LyBGTv7uJ6DEY+YV6EttAN9h3//dP
        wdRJHoYVMXP3t1M5C+HBEiY=
X-Google-Smtp-Source: APXvYqwjjFvze9x1JjkGgkUjQpg0jjHQoXXuVuwHIwqRDwokSNkW3/DPomI3dloZJRS8eLX/EEqddA==
X-Received: by 2002:a17:902:296a:: with SMTP id g97mr8426196plb.115.1561690242212;
        Thu, 27 Jun 2019 19:50:42 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 11sm472340pfw.33.2019.06.27.19.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:50:41 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/27] kernel: power: use kzalloc rather than kmalloc followed with memset
Date:   Fri, 28 Jun 2019 10:50:35 +0800
Message-Id: <20190628025036.16135-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use zeroing allocator instead of using allocator
followed with memset with 0

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 kernel/power/swap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index e1912ad13bdc..ca0fcb5ced71 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -974,12 +974,11 @@ static int get_swap_reader(struct swap_map_handle *handle,
 	last = handle->maps = NULL;
 	offset = swsusp_header->image;
 	while (offset) {
-		tmp = kmalloc(sizeof(*handle->maps), GFP_KERNEL);
+		tmp = kzalloc(sizeof(*handle->maps), GFP_KERNEL);
 		if (!tmp) {
 			release_swap_reader(handle);
 			return -ENOMEM;
 		}
-		memset(tmp, 0, sizeof(*tmp));
 		if (!handle->maps)
 			handle->maps = tmp;
 		if (last)
-- 
2.11.0

