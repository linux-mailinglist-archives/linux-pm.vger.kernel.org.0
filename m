Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9938D285557
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 02:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJGAUJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 20:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJGAUJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 20:20:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C682DC0613D2
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 17:20:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e18so146007wrw.9
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CjEUI/O5nyKq05nG1WVXTi7g9bQBDlF9MtDWFFyQoGY=;
        b=szmKAa4h1nHPyu9kcgwhbnZwdWEom7YpolFcRBsSoQqYFmkDojdFrkPBDrQ6P1b1OE
         SDL4RKZBrZwXqPHgUvMGkC1lAl2laNSh3a+GQ9VABKqDmqmF/uCP7XgqLFoN3xuptB64
         0xb/cb3LTEyj24Lsv9JQqC9fac7s5gq/WWSJVWrWFsTgwMxzXEQNPY+FEQJ9GsXNmhL7
         Tez0OXL6tqaAQFOTNU60zjq9hfbFnHrNgCLoYtFggR0g4U+AX+JvNGhX3oNh/qE1Dw8g
         CrNjetASxcd+r8aXNDuXkHLvjaQZQPNOK7cdWpSczqXMBga/9flrOAJKfw7vayD0r54i
         J7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CjEUI/O5nyKq05nG1WVXTi7g9bQBDlF9MtDWFFyQoGY=;
        b=mcdEel5VxEhf8fuI9PiMk85zYe/WQE+l/1gM49KRZMg+M+NN3+4DQ+bxj+IpU6i/eq
         Gs+rNb2J2qcIvQqIhKjGxrdYQs52YGeSNr8+xKSEUgA+MEG+3uLjvQK9SD0fR/+uECQg
         sTrMj4xfmqi1cFJUD0FbdTMmMyyq2Zu17YXjmw14aJNnMAyhoC9TOQOmWXShO5nPBa4Z
         sfYHzjmjZRPtUMmWD/SPCvmiJUyib0SfzVEkxPRuo+k6+tavnNpRKz0sgzPGCsdihWBS
         H64d95sChGmeUaOm6Sd/jlPDk6RdXoVRGSkK37j4ixUFgk5GfSwbIa1FB2yoFss0/OPS
         Ds8A==
X-Gm-Message-State: AOAM531QCEC5RU7+lyA/yvUxeZ//tZ6Y2LsKEhqYqkty1tnMVt9nXYjT
        iythkiSZrv8DzPWbakFRjHdJMD3gz3zRzDg7
X-Google-Smtp-Source: ABdhPJwMVpbb8Q5c6eSA81jvzdixcDlAOogWa73AyGdsDDaLtZXN+sI+E2/WSNCMdFp/phA9SXN6eg==
X-Received: by 2002:adf:a418:: with SMTP id d24mr470329wra.80.1602030007166;
        Tue, 06 Oct 2020 17:20:07 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id 142sm402650wma.14.2020.10.06.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 17:20:06 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] PM: runtime: Use pmruntime sync variant to put suppliers
Date:   Wed,  7 Oct 2020 03:19:34 +0300
Message-Id: <20201007001934.18606-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Calling pm_runtime_put_sync over a device with suppliers with device
link flags PM_RUNTIME | RPM_ACTIVE it is observed that the supplier
is not put (turned off) at the end, but instead put asynchronously.
In some case This could lead to issues for the callers which expects
that the pmruntime sync variants should also put the suppliers
synchronously.

Also the opposite rpm_get_suppliers is already using pmruntime _sync
variant of the API.

Correct this by changing pmruntime_put to pmruntime_put_sync in
rpm_put_suppliers.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 6f605f7820bb..8dab4fcab4e8 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -313,7 +313,7 @@ static void rpm_put_suppliers(struct device *dev)
 				device_links_read_lock_held()) {
 
 		while (refcount_dec_not_one(&link->rpm_active))
-			pm_runtime_put(link->supplier);
+			pm_runtime_put_sync(link->supplier);
 	}
 }
 
-- 
2.17.1

