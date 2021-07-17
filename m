Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59373CC571
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhGQS0f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbhGQS0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E00C061762;
        Sat, 17 Jul 2021 11:23:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u14so18912952ljh.0;
        Sat, 17 Jul 2021 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tx+FBtsIpk7hvxer7pRAYtZGSgLlz0FVqFktBev8H5o=;
        b=WUkZ7L1aFpSV4IcE+DJt5e9kryyvHROr0ZULRcSNnoH/FtV5XBJwoEE/LsbRYyfXSX
         LvFGSNLstUwnYzXY1z76ngNsT/XJTdYjY5W+WJoz5bUnBraw614hMDFxFE0RbK0iolGb
         dnXpKeVWAi44b3/jUARtJrwfVSwiChSMGj4zmHAGRL1jsOZH/jFA3jC5NFdbNX7TOxrR
         V0VD4efiWBGKdVT68t6pw5RRHzAgqQ55kVfd/tKo587NS4q2iDMbhlvl+dQETtW3OGnw
         HLiHSRWwNJOBciUJ5jsnrfbUHCgTw2D4wdijlJb33w+coqGHt03w2BFMl3fTwFdF7+Uw
         Pu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tx+FBtsIpk7hvxer7pRAYtZGSgLlz0FVqFktBev8H5o=;
        b=abyAHLOu7Q5B640m3859FPffjPxWNk0owPy533L7iWpymyWTsNqeD1DvFLOvhQ0d8p
         D/TCY849+aeWRwgb9KBxT2SK0BwxNtl+BHRABnHZzNPidbq0PCB0FH4k08SnId3i7+Rm
         cV1fE+PEK2x/hZKbhNcJLn9Y0M6r7ebcoWIklvx3m5MYr0fJF6Dgj5V4zwigkZoTYrii
         e4FPyq3RW7eWJKwwEQxtlcdZtsb3M4mEsxXITCw2uhxqPpLDR6TCkju4t+pb3xLaN05Y
         NDjCMSng529FMobR4MawkBq+JnvqP4xFXys5m0Lgwd7cWdTYMApu3McFEkyjKntGxh1/
         zAyA==
X-Gm-Message-State: AOAM5307nc6NDlbaE3XDoyJ9RMNNCpNSXtLP6oKJ40nwVQseuJAZ0qMX
        ObukDpe9yD3B6Tr/MHxrWM0=
X-Google-Smtp-Source: ABdhPJxPflOHMFEWYMu3x9YA3dT0WxH1qUhkWOwMe2iBLDL4KppcPD+eMWmi9HFdGA9HjSMZAwg9Pw==
X-Received: by 2002:a05:651c:1141:: with SMTP id h1mr9553812ljo.224.1626546185688;
        Sat, 17 Jul 2021 11:23:05 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v5 05/12] usb: otg-fsm: Fix hrtimer list corruption
Date:   Sat, 17 Jul 2021 21:21:27 +0300
Message-Id: <20210717182134.30262-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
References: <20210717182134.30262-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The HNP work can be re-scheduled while it's still in-fly. This results in
re-initialization of the busy work, resetting the hrtimer's list node of
the work and crashing kernel with null dereference within kernel/timer
once work's timer is expired. It's very easy to trigger this problem by
re-plugging USB cable quickly. Initialize HNP work only once to fix this
trouble.

 Unable to handle kernel NULL pointer dereference at virtual address 00000126)
 ...
 PC is at __run_timers.part.0+0x150/0x228
 LR is at __next_timer_interrupt+0x51/0x9c
 ...
 (__run_timers.part.0) from [<c0187a2b>] (run_timer_softirq+0x2f/0x50)
 (run_timer_softirq) from [<c01013ad>] (__do_softirq+0xd5/0x2f0)
 (__do_softirq) from [<c012589b>] (irq_exit+0xab/0xb8)
 (irq_exit) from [<c0170341>] (handle_domain_irq+0x45/0x60)
 (handle_domain_irq) from [<c04c4a43>] (gic_handle_irq+0x6b/0x7c)
 (gic_handle_irq) from [<c0100b65>] (__irq_svc+0x65/0xac)

Cc: stable@vger.kernel.org
Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/common/usb-otg-fsm.c | 6 +++++-
 include/linux/usb/otg-fsm.h      | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
index 3740cf95560e..0697fde51d00 100644
--- a/drivers/usb/common/usb-otg-fsm.c
+++ b/drivers/usb/common/usb-otg-fsm.c
@@ -193,7 +193,11 @@ static void otg_start_hnp_polling(struct otg_fsm *fsm)
 	if (!fsm->host_req_flag)
 		return;
 
-	INIT_DELAYED_WORK(&fsm->hnp_polling_work, otg_hnp_polling_work);
+	if (!fsm->hnp_work_inited) {
+		INIT_DELAYED_WORK(&fsm->hnp_polling_work, otg_hnp_polling_work);
+		fsm->hnp_work_inited = true;
+	}
+
 	schedule_delayed_work(&fsm->hnp_polling_work,
 					msecs_to_jiffies(T_HOST_REQ_POLL));
 }
diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
index 3aee78dda16d..784659d4dc99 100644
--- a/include/linux/usb/otg-fsm.h
+++ b/include/linux/usb/otg-fsm.h
@@ -196,6 +196,7 @@ struct otg_fsm {
 	struct mutex lock;
 	u8 *host_req_flag;
 	struct delayed_work hnp_polling_work;
+	bool hnp_work_inited;
 	bool state_changed;
 };
 
-- 
2.32.0

