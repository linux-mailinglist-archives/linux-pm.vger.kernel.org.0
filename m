Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF33CC2FC
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhGQMOg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhGQMOa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:30 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F5C061766;
        Sat, 17 Jul 2021 05:11:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q4so17857989ljp.13;
        Sat, 17 Jul 2021 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tx+FBtsIpk7hvxer7pRAYtZGSgLlz0FVqFktBev8H5o=;
        b=HKs37eJ6E8wMQFBgL0U3kTEZfOud/q6TFjaA7R6MRIp9pKOXI3C/E0hzz0vYU1Y5/L
         uxeXpfVy9zwJdNNFZYNeFeqVR7oGs+cdQYyXIFulXVZjUXi9eCgF/p/kxqMA/u55VRh9
         xckgcTOamcdlfDaWTd1uTgAENUGQvvMdcRY1BWpCV/6dX4Fg1wrYl6wwh8/aVXc3J8pH
         A348By9zvzSWsbKRBtTWVYFRbiqO359H2zbuU+5sLvHWCHkVqDCyCoDiNBbLjnByv2hC
         eUm/dZrMdcCLtlF1u41ReZsTpn7Z5vM/An5aD2/yQAT78V+bJNmqHLW7SDaXma4TzZfL
         mykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tx+FBtsIpk7hvxer7pRAYtZGSgLlz0FVqFktBev8H5o=;
        b=Xl9VnoYym+v/uOJLx4D2a9mgLDwuozSGDKH0ZIrwNg7YQHP0qq+HQHLj42DrsW7o/g
         ibo6MSWrxsbrZEInwAczAVjDq0CCbWuxovGFpm9wc/kJ0MOLBDJUmE91jjp0N/9tXkLs
         ZsoVC5wsyBBp4XhFRGgKVzq+2BDPxOtUYIWOVUOZ3yhETt+N/sqCQ8tpK3ZgWFWiuGpE
         rHt38AwBAvhQhOmVE+V8rvkpVmyJtkwN6D/cyTG+cCF3jtrJjezusElcz/aqaBFWrgpr
         lAgDvJm9HL9AQpmnJuzU+h+wombdyNJRrUXNMJAfRiCuYYcAKRdKQoeSPORyh3uC1/Pm
         6l5Q==
X-Gm-Message-State: AOAM532LZIbLN0m1To5vTnYeYAErU5STjvpzdWMKVK+MgYvvdhWYNS8f
        PJqwDcUAlcxZsvhFavmxtH8=
X-Google-Smtp-Source: ABdhPJwea8wsk8Wzm6a+CwqHoTwX3mMu6RJGkSvwEOFYKVBLdzw2NlIbI3pxgfQ3WuSVnKpeT2kaHQ==
X-Received: by 2002:a05:651c:889:: with SMTP id d9mr6874144ljq.412.1626523890025;
        Sat, 17 Jul 2021 05:11:30 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:29 -0700 (PDT)
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
Subject: [PATCH v4 05/12] usb: otg-fsm: Fix hrtimer list corruption
Date:   Sat, 17 Jul 2021 15:11:05 +0300
Message-Id: <20210717121112.3248-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717121112.3248-1-digetx@gmail.com>
References: <20210717121112.3248-1-digetx@gmail.com>
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

