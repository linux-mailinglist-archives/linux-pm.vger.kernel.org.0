Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F457DE71D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 10:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfJUIxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 04:53:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43199 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfJUIxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 04:53:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so2435795pgh.10;
        Mon, 21 Oct 2019 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u3GkSh6skTm5HOlc/wq9xoD88bjzQ0R9DkkA2ZRPPdk=;
        b=T+7sOib+SuriFwd7n5LEhx60pWKe61RQsopiCFmStyvhMtdN/m9U2XJn4eIZpt0yQO
         Lc5N7Bma9whc6k5myK1IsYgMqzbf54FPYYo44moKkvoER6q1Z/XLuY2JiNQHAcHRGqnp
         25FHgZMdQgs0IYDnG+vWku4sXml1DAjSVUnT7zobYCtW46GA03TyWzg+MAu6FIqr+Zf+
         cEHMqfzQLfGeIaqscI4Gl/nPaWjcJU4G5BViA+j+FipNtOiMR9QBZIM3rhdPoKt/nZAh
         zkONJgCIzKF2qeEXlOdRSCiscLKdbBiSZL/OL1gO39P5zTW7sPgVDIwfXI6kMyTGJf6y
         RsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u3GkSh6skTm5HOlc/wq9xoD88bjzQ0R9DkkA2ZRPPdk=;
        b=GWxqDpZp6HTszMhl1287aF6KXF8h8CLEZfYt0DNW6kk+PFhVcMcmx2esX5iwp4Dvfi
         jiUp4n7MgPYQBYZhT2ToggmCqNx6ugDtlfIjmZxux9hlnlX+kS3FfVlK1bNHZf1lg/kb
         +eJEGS9kBUQkg2fo4pzoNGXutxRVLZW5m11WQPmNez7fsAmiXsv0mHUal+0ITM70ap0y
         xzboWMzOrAUYqk7tqWXNjEecQNsKf0J+C/QNYpOAqRVztOil49l0JDMZYA/MgX5a9RJq
         okFQRjmTnbsAsRwJgu78gwnMo0/XeLr1DSlhnJ8m0Zlw+rWcZNe8guId5g+ZOmrEqD/S
         9fcw==
X-Gm-Message-State: APjAAAWUAGHguZpyFPYd9dJFiNOUOk91jE3ItIELgr8Ig9OoOLhQrncj
        ogBUL0kkUdWgouadWzMYbOMm+c9az4w=
X-Google-Smtp-Source: APXvYqyCd5hT7NT0a4iSqjBMlQaHxRp65a/h/UNgaqRP2F5gggeMuNrgZR495f2F342nCAilsmSKrA==
X-Received: by 2002:a63:7006:: with SMTP id l6mr10112522pgc.244.1571647982786;
        Mon, 21 Oct 2019 01:53:02 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id k31sm16031524pjb.14.2019.10.21.01.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 01:53:02 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: [PATCH] PM/wakeup: Add print_wakeup_sour_stats(m, &deleted_ws)
Date:   Mon, 21 Oct 2019 16:51:40 +0800
Message-Id: <20191021085140.14030-1-zhuguangqing83@gmail.com>
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
 drivers/base/power/wakeup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5817b51d2b15..29e9434ccaaa 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1071,6 +1071,9 @@ static void *wakeup_sources_stats_seq_next(struct seq_file *m,
 		break;
 	}
 
+	if (&ws->entry == &wakeup_sources)
+		print_wakeup_source_stats(m, &deleted_ws);
+
 	return next_ws;
 }
 
-- 
2.17.1

