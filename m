Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A903B9987
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhGAXqb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbhGAXq1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED33C0613DE;
        Thu,  1 Jul 2021 16:43:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u25so10799141ljj.11;
        Thu, 01 Jul 2021 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5wbH7/HMNjanvR8tAtZwAF7kIgDHX/YS9tb4UgAOWc=;
        b=h0vlT1OlSlEAUB13UOuY9xFCOZ5aFqW82re6QtgaLgVBidGuj7DW94ugdc4fOCjnXa
         mpKvGPEGWIJ8DVAKgARSG7aL5aBCNl+bxIugTxxSnWlGIbJ0ZRg7AlpK1vtBUM2LZ9Xp
         Ikr3dKe8y6r9xAudOSnbKmuBeSrpYAvV1V6IiPh2Ca+DxiyJTKaSA6AyPpXagbgvwy7+
         sYvBZAZQQ+1PEdQTW8bP1gZOdbAIjSiycJxAs6A6bBuQ1Yz/DgRKGoG1kguh+90Xfx8U
         ozJW4qIR8GzruYBKPSPW7gp6dCYuX03PfTGkoMDNXUwoR+ccfKm5Zzv/nCkXfWelbE/L
         SToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5wbH7/HMNjanvR8tAtZwAF7kIgDHX/YS9tb4UgAOWc=;
        b=Ogp0HltWfe4tSxTaMuLagS5L+sDlW3kKmxY/Y8ti73ZBTtmuOmW2pX/Qw/RduvS2Qi
         X5A4mvrHhUlEriQ7Je+e2eoufubfFTqgJ6xf6n6sbFqqgqg1gXjdJCK6bGUKfVk9Kp1T
         QiCuJv9+yKdvGROiM2rt1Ygrt5JVvFQD2jsO+g57j7YxmN/ApLY/+DqM/Zxo40GLGSDD
         Ikq/xufy7EwvaY7ko51PV4M2zArMi3upuqVsWvwGKpBfDU44G8k2GB5Izi7UX3+LgIh4
         O9Adq0orKl1K1zbULWI8umLravJatpaqbP6fXs9Ay7MY/KVZoLypjhNbQECFtu1gG0Zw
         zUXA==
X-Gm-Message-State: AOAM5323EIKR0E3Hx8JvTNp8JQOsrkWCv3CtboafI0czay/o2R1mVs+J
        X5zjLvsSJNdXVSYKkgjpvCw=
X-Google-Smtp-Source: ABdhPJxNWsrRwm0fpmFG46xxp21YRDZQYZzPoDl3+5LZQjGc5mtxccbk+69xZl0ONM5rPoD/L4dK3w==
X-Received: by 2002:a2e:9ace:: with SMTP id p14mr1571292ljj.188.1625183034051;
        Thu, 01 Jul 2021 16:43:54 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:53 -0700 (PDT)
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
Subject: [PATCH v2 05/12] usb: otg-fsm: Fix hrtimer list corruption
Date:   Fri,  2 Jul 2021 02:43:10 +0300
Message-Id: <20210701234317.26393-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701234317.26393-1-digetx@gmail.com>
References: <20210701234317.26393-1-digetx@gmail.com>
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

Cc: stable@vger.kernel.org
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
2.30.2

