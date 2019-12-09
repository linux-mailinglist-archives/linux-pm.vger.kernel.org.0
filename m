Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC4116976
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 10:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfLIJg3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 04:36:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38190 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfLIJg3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 04:36:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id o8so5566375pls.5;
        Mon, 09 Dec 2019 01:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pETZ4CibeP0YCb58ZGv2YCw0xeRD6VlQA38o4DT/lXo=;
        b=d1ABfhM9pbHlHmcr8qboRgUeErg+kOipi+ttbNVZXOZ/ClflbuFye++XDsWz5icQFC
         pgVH/bD1aakZ8HF1stw8tYKxpUjrI5dU62OUgV0OcuYMF45oklxHA/+prsLoyijJ4eUJ
         U1qD6kCQ68VXVdkv6Y0um0zB6f9MyeC+umE9B8pAeuWyNHCfQXyFBxW8lsv4kj8qoptl
         3bOtZACYO+yOyT5FGV3O5CAaa0wQPAKz20cKLVkEGVLdhQKOJfG698RX+XURs7+HjRqs
         N+DGS/8VA2kOj90rTF9oJMiL+AoFo1GFviM7wN5Vj+g1zJbhb2X/U/MA+Tc1UZ92Ox23
         ItDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pETZ4CibeP0YCb58ZGv2YCw0xeRD6VlQA38o4DT/lXo=;
        b=B68+L1nTlcvFfyA1RAoAoM2OnGPiCXjLYpK6wVCXD7aPqn+iRYgPMgM2UinXAwt28E
         KpbrDomgMJYz4C28ZKIRg98BM+WE1Q3T1Q5CR1d0pdTjXvjf93A5GhaTbS6K9UFl/qtO
         HP64FTDdk8nIQkBNqrR9P7OKmXFYsEwAcFahJQPqK/lEFb1W10lawD5P4ulMkenouaa9
         LqB5UgPJZjpEfI1UAU+kHl15i/I7eO2Ss7PHTbekhxMDaekIBf1PzvhtKBLV3RnSy8DR
         v9Uj2vaAEFUwb+n7wIJ4QNowbOuKp90cEK1mGjLGkEtJX4SqdGD0Uwe8cMh9enrL3CmV
         i+Cw==
X-Gm-Message-State: APjAAAXdzEvRLn8p31MBpc4THMCmrmIrci133MVPZ+nwEugoVgk/p0W6
        GIrOMlZZMeuWnYAg6W+qhvUQC3nB
X-Google-Smtp-Source: APXvYqw8XXjTPUZkYWrEdJNdbogtS/K2qEMV6M/kszxNMIYzF3sDABSoESBKujIUr5SG17GZ5wQ3XA==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr28852177pld.244.1575884188836;
        Mon, 09 Dec 2019 01:36:28 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id m14sm12431975pjf.10.2019.12.09.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 01:36:28 -0800 (PST)
From:   zhuguangqing83@gmail.com
To:     rjw@rjwysocki.net
Cc:     pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: [PATCH v2]PM/wakeup: Add print_wakeup_source_stats(m, &deleted_ws)
Date:   Mon,  9 Dec 2019 17:35:23 +0800
Message-Id: <20191209093523.15752-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

After commit 00ee22c28915 (PM / wakeup: Use seq_open()
to show wakeup stats), print_wakeup_source_stats(m, &deleted_ws)
is deleted in function wakeup_sources_stats_seq_show().

Because deleted_ws is one of wakeup sources, so it should
also be showed. This patch add it to the end of all other
wakeup sources.

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
v2: modify judegment condition according to the advice of Rafael J.

 drivers/base/power/wakeup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5817b51d2b15..53c0519da1e4 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1071,6 +1071,9 @@ static void *wakeup_sources_stats_seq_next(struct seq_file *m,
 		break;
 	}
 
+	if (!next_ws)
+		print_wakeup_source_stats(m, &deleted_ws);
+
 	return next_ws;
 }
 
-- 
2.17.1

