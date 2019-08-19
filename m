Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F400E94C18
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 19:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfHSRzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 13:55:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39920 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfHSRzB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 13:55:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so1592339pfn.6
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdtAV1xATKqzVzk/DbE+IGNr2mWwyW+FAULaw9PivyY=;
        b=k7y0Y8zjrpJBSAsXL0IKx0rACGq4A7Q7tkpgbaokOh9YtrZU7lwXxhZnJIoajPIXCE
         J5+CPvFXtrgrIOMZ7qhPnQYabXztxNSYPc9tuN8Or+v8VEiwXjPPtVWoVrVWFFCMqgQU
         DDZP6dUUBOwGCIDMKsL1RQdvGHfECORM1Sbog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdtAV1xATKqzVzk/DbE+IGNr2mWwyW+FAULaw9PivyY=;
        b=ZFDAtOxE38SHJxi/P2umC6YpsqsrUqHqH8Zbu2fVOnlyOw5u+YEoGtYmY36Xb6aQhS
         hFgQLt0oMBi9TYRg1Pyj7Wr2miN58PiRPlKMAmL6C8vnMTxTc4caJZEY2O4h45USZsEL
         tIdhCopVHUgYHD+qGmfkiE9v+ev56+zpc/hERZ9UXG9ZPIvdJwDCd8XnlZETIl3ovnOl
         RnyD/a4XVl1vwVeCeoy/3aBDc/Ju4o1LaCv3JINR5oA6XV4pGJp+JUbImVHvBivxEIFe
         KMSbxOv8gPbJnW3hL0Haa/URGaItAE6p1Y2FIQbN59P+6tBbDHkDlGOaF0f878PFTfG2
         iKIg==
X-Gm-Message-State: APjAAAViGydDLANdbX0ibX7qZYAfpaPXPx312Rmml1VFSKDyFCHrv6pF
        4NXGAeOc4w0qifPm05xPpnnF1KiGXTQLtQ==
X-Google-Smtp-Source: APXvYqzNjjUiIRP7t3A7+8awsygXwikF5otXIBfdzuPefg5wLRfX9kixkt9gNTcLWfFzgEqm87h08w==
X-Received: by 2002:a62:fb18:: with SMTP id x24mr24759894pfm.231.1566237300798;
        Mon, 19 Aug 2019 10:55:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h197sm18084237pfe.67.2019.08.19.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:55:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 2/2] PM / wakeup: Unexport pm_wakeup_sysfs_{add,remove}()
Date:   Mon, 19 Aug 2019 10:54:57 -0700
Message-Id: <20190819175457.231058-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190819175457.231058-1-swboyd@chromium.org>
References: <20190819175457.231058-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These functions are just used by the PM core, and that isn't modular so
these functions don't need to be exported. Drop the exports.

Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
Cc: Tri Vo <trong@android.com
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/power/wakeup_stats.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index bc5e3945f7a8..c7734914d914 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -182,7 +182,6 @@ int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
 
 /**
  * pm_wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs
@@ -205,7 +204,6 @@ void wakeup_source_sysfs_remove(struct wakeup_source *ws)
 {
 	device_unregister(ws->dev);
 }
-EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
 
 static int __init wakeup_sources_sysfs_init(void)
 {
-- 
Sent by a computer through tubes

