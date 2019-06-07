Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8250138237
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 02:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfFGAhm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 20:37:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34945 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfFGAhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 20:37:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so119567plo.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2019 17:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPh979OTEDBlqzDsha7tZRbPvm/W8T1Wq4fFMxgOKCw=;
        b=WnIK3WDSj+tNSnPRX1JFAN3QoQrVIpqZZsgUtiajYmMztmzHkO161AaxUs1TW99jlv
         B4p+oHV5G4TuDRgnmMc5qeUM3pEKKUGGHdc5k+5iCA+BHLnMwWYBU29S0XNzUDdqvtK8
         XoD8Iy7v8rvqw+ZRgtCY5DSxhPayYWddkhcvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPh979OTEDBlqzDsha7tZRbPvm/W8T1Wq4fFMxgOKCw=;
        b=FzJe75DiORcECsuikOQUMIx93+sskivVoj2erRhjbhPpgkNJBdiP+ryldLseiwFfmq
         +e3dJCJnBG5VrhaCIufXWTtD1062NRWvw/0wfAWvTivG6Ua2nJ11u1x5t5h2WzqNYScM
         1Dted4ld1hov+U3mGfrgQfZXy0RmFrIo2Asvpq7dsMoCoToZqD65m/akJXj1RKEX0CIQ
         QKSOKCsh2tkEEhag0PRu6Sd1yFsjfvrAiSvadMf+wx/PpkJz+uczzNYDK2jYCwgVqjdM
         G3Id5/IdH+mgVY9YPSHnDiVO/w6u79GNQvLHzNyJ1ETZnBEROnQfUdMc+9q/Emiy7Rde
         3pqA==
X-Gm-Message-State: APjAAAVC2t2xLHyIWMem/l3YGFhtwJyNWis1Jx7yjk2dzetUs3J9cREh
        /G6VqBqN2pixl6KZdEwVRhjYnw==
X-Google-Smtp-Source: APXvYqwhgaSCJuK02sFJeKMDa/ScQ0C45NRKM9CO3oRvpqT7gT2kFrFkK+DmuENbAOftfT0TxUq20g==
X-Received: by 2002:a17:902:e2:: with SMTP id a89mr53481733pla.210.1559867861536;
        Thu, 06 Jun 2019 17:37:41 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id s1sm283209pgp.94.2019.06.06.17.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Jun 2019 17:37:41 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tbroch@google.com, ravisadineni@chromium.org, rajatja@google.com
Subject: [PATCH] power: Do not clear events_check_enabled in pm_wakeup_pending()
Date:   Thu,  6 Jun 2019 17:37:35 -0700
Message-Id: <20190607003735.212291-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

events_check_enabled bool is set when wakeup_count sysfs attribute
is written. User level daemon is expected to write this attribute
just before suspend.

When this boolean is set, calls to pm_wakeup_event() will result in
increment of per device and global wakeup count that helps in
identifying the wake source. global wakeup count is also used by
pm_wakeup_pending() to identify if there are any pending events that
should result in an suspend abort.

Currently calls to pm_wakeup_pending() also clears events_check_enabled.
This can be a problem when there are multiple wake events or when the
suspend is aborted due to an interrupt on a shared interrupt line.
For example an Mfd device can create several platform devices which
might fetch the state on resume in the driver resume method and increment
the wakeup count if needed. But if events_check_enabled is cleared before
resume methods get to execute, wakeup count will not be incremented. Thus
let us not reset the bool here.

Note that events_check_enabled is also cleared in suspend.c/enter_state()
on every resume at the end.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/base/power/wakeup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5b2b6a05a4f3..88aade871589 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -838,7 +838,6 @@ bool pm_wakeup_pending(void)
 
 		split_counters(&cnt, &inpr);
 		ret = (cnt != saved_count || inpr > 0);
-		events_check_enabled = !ret;
 	}
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 
-- 
2.20.1

