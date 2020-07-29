Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97FD2327F4
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 01:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgG2XRv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 19:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgG2XRu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 19:17:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B612FC0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 16:17:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so13940584pfu.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9HgHOXqVNgKdIpZbWbUHoQKwYNiPIQ6hR37SC3F4W0=;
        b=F0/twXqvlLuXWYfAcB2/sK2KH7Vo0KM8YEPTPxzUM+c2KUAX7hft542jNg7au6To8O
         8PuIdaDMGVV5WZp/uxoUnbVtdsAVB/RUeKN8N5AUFaYRbM5lwNU1YrcS1zzoGccQpTVY
         MZ40lheu2dCFtdbdnR6bI6mqIJPN7Cj2Gfroc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9HgHOXqVNgKdIpZbWbUHoQKwYNiPIQ6hR37SC3F4W0=;
        b=fGCkuFEXLo3gGKezamTrydpHI2Z/FMgXKS8NZmBYEpt+Z/lWZVyxTWtaVdYEo/p6rW
         tNcLv7y7gYWuixZlYSYukwBSUx3ut8IgEeqw1C7GImfp3KUjAjqFj3J41aFjOoAxOvOe
         Sb2t0dETKteJGU3Ddk8WyUkQiQ8sMRA20uliOuAM8+0AeiKIIfXJJSzylcj+qGZfdwEF
         rGyOfCx4FKbdvC5LPlcKJ572QsLLNg5YE4tKnKsmLigZE7gtR+V+7S95xSih0upVKPot
         yo8hSJcwViDJ9zS1kKx7t2qy1vM890UJKhfyi6yUqY4Y4qSMhIIlJRR1XxrEHeSuQDaa
         PEQA==
X-Gm-Message-State: AOAM530vj+vk/VOT8pJ00nlxRXUF79WT2ASis90ur15GBp+CDbMYnhzS
        17OlEPajWJVQnmvUB6e+0w1GuA==
X-Google-Smtp-Source: ABdhPJxHKfvbjFH/RI2aP1uExJ+na8MkvlhpokW2aSYM8Li6Xk9CijHIwGwIwEeK6WqpBK5kymCzJQ==
X-Received: by 2002:aa7:93a6:: with SMTP id x6mr377357pff.37.1596064670156;
        Wed, 29 Jul 2020 16:17:50 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id x18sm3538093pfc.93.2020.07.29.16.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 16:17:49 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-bluetooth@vger.kernel.org, Alex Lu <alex_lu@realsil.com.cn>,
        linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "Bluetooth: btusb: Disable runtime suspend on Realtek devices"
Date:   Wed, 29 Jul 2020 16:17:43 -0700
Message-Id: <20200729161740.1.Ib03d0827c8e48fc3df887fec698f79fa335c9274@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit 7ecacafc240638148567742cca41aa7144b4fe1e.

Testing this change on a board with RTL8822CE, I found that enabling
autosuspend has no effect on the stability of the system. The board
continued working after autosuspend, suspend and reboot.

The original commit makes it impossible to enable autosuspend on working
systems so it should be reverted. Disabling autosuspend should be done
via module param or udev in userspace instead.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
We have a few Chromebooks using the RTL 8822CE part over USB and they
are running without problems with autosuspend enabled. While bringing up
a new board, I found some power regressions that I was able to narrow
down to this change so I'm requesting a revert.

I tested this on Hp Chromebook 14a (running 4.14 kernel and 5.4 kernel)
with this revert:
* Enabled autosuspend, used it normally with a HID device
* Suspended the Chromebook and verified it worked normally on resume
* Rebooted the Chromebook and verified Bluetooth was working on next
  boot

I didn't see the issue that was originally reported with this fix. For
the original reporter, if you're still seeing this issue, there are
other ways to disable autosuspend for your device:
* set module param: enable_autosuspend=0
* change your kconfig so BT_HCIBTUSB_AUTOSUSPEND=n
* use a udev rule to disable autosuspend for specific vid:pid

Keeping this change in the kernel makes it impossible to enable
autosuspend so it should be reverted.

 drivers/bluetooth/btusb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1f51494f581812..8d2608ddfd0875 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4086,10 +4086,6 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(BTUSB_USE_ALT1_FOR_WBS, &data->flags);
 		else
 			bt_dev_err(hdev, "Device does not support ALT setting 1");
-
-		err = usb_autopm_get_interface(intf);
-		if (err < 0)
-			goto out_free_dev;
 	}
 
 	if (!reset)
-- 
2.28.0.rc0.142.g3c755180ce-goog

