Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4254D4C052
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 19:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFSRwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 13:52:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39340 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfFSRwl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 13:52:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so115439pls.6
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPh979OTEDBlqzDsha7tZRbPvm/W8T1Wq4fFMxgOKCw=;
        b=J76s7YUKSydhifETM39Ra9xqyqSDYhxzCJ8pt1NbE6vBQzrBx0wywICvMob6i2OngJ
         yTLzAz2Mhoiv49XA5rWlJ9N2nA2RokV7fttXzt2fSapVyzWhmeRCQ/dPhNy6ZV42KxvF
         Qnkr3LEpu85AxfItu7v7+DK+z+C4+0JaukWuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPh979OTEDBlqzDsha7tZRbPvm/W8T1Wq4fFMxgOKCw=;
        b=UBYLUK+E5JvO+nOTl8WVReunAEFhCdMg2k0wQuf/cXQtaHcgfw45VZ8rK2ZThix3xl
         +1t2UiFS8gsTFN4MUf82BCpz1l09wu/Y/ak4rr1/nfjAAudzJ6nLQV9weT/2sttjgTvB
         UmDYK7bBDZC6vBk9dKdrbe9POL3Mp5l0IvpZsnsR7ONstDhzzY1UVoRLDy16hdJ7Xdyt
         kAS3Gvhu98LzdKgQe+S+e5Cw+0EJS9c92iy1r9HslB0NNhqlZeXGNY1e1LPJ8pUqoxMp
         mxgLD68Keuhgv8qgl4oDTbkxskN2d59+xg/FmHd4Gm9vYzwle6UWb2CeNIBHUnGoU3ca
         4/Xg==
X-Gm-Message-State: APjAAAVJfgcOmpNXPFZ4YUo/dBQRh3Vt+wFqpXnam7R/5B3DyBlTjQgN
        MAbhX6ADwNNSN9e2Blx2ZAgX0g==
X-Google-Smtp-Source: APXvYqyRjxchfLX9OSQjCZluovaPf7iMErEJ69AWLt4/j9kWBwlmF7FXXOPzzy70wsXcdi0lScLGgA==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33mr40835768pld.174.1560966760531;
        Wed, 19 Jun 2019 10:52:40 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id c130sm11905368pfc.184.2019.06.19.10.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Jun 2019 10:52:40 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, tbroch@google.com,
        ravisadineni@chromium.org, rajatja@google.com
Subject: [PATCH] power: Do not clear events_check_enabled in pm_wakeup_pending()
Date:   Wed, 19 Jun 2019 10:51:42 -0700
Message-Id: <20190619175142.237794-1-ravisadineni@chromium.org>
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

