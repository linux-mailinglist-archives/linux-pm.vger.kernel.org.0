Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C422E3B8C29
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhGAC1X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbhGAC1U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5069C061756;
        Wed, 30 Jun 2021 19:24:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u13so8943620lfk.2;
        Wed, 30 Jun 2021 19:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5wbH7/HMNjanvR8tAtZwAF7kIgDHX/YS9tb4UgAOWc=;
        b=k2Ku7iWgKzBOaLNhEth63GngO1oW9CLqgD/ZtVyTnRfRRWpTo8NWSgX53DKcAJfTtO
         KR4GOgmBTALpWYFzuLwRgAbRQUiB0Ufq5yuVQYSmvIu9IFopMiW6Pbo3ceePxZcKm4Wg
         4eAhacInR0dP74IWrDn9nQVXCtgbqYximc8+3aOcppDMZnuAlF3hLtIl5boI4kri+HO6
         fqDZySV3aXCdCOTm6mDg/P6pbpX7aQNZVrQIGjvW5XfaBAt5vZVWJw/n7fX9jPYJ3Wgs
         A/Yj/7jmtzDmzllHM493wv/ia2VwC5KNi7Q8M30sXjz4FiaItTMR4d1t0eyPMvfNjLFJ
         tjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5wbH7/HMNjanvR8tAtZwAF7kIgDHX/YS9tb4UgAOWc=;
        b=UK5JtVLKJ2epFQFOuHYJbeRL9pvOh7an+Uol1fdTPlG9ZKsHsG5DrZJ3doNOwXoY3U
         oH3FzTRAk7cCjBG4j2Qa/i3IAhs4WyEH7i1ynw1e+GUbR2iCeghKHPbOd2hltO5WyT44
         GcVF5LPyg/tnZQePt5EXLykWCUwl6554EC4HykMEljM8JoMHgYf7rLjbpsTOcSt0o2If
         xCcKLKP7/Y7yz8IdJm/zLMmUhzkdu7YRj+FpOtjNNTBR/+i6vIa7ej/RnOPS6MpHUz2k
         m3nFxWUsleH6WY5PyM53ZRZu7lhjV3Gq+dFLQquW/B7JIbKyGvMn1d7wm28KOLn/siDu
         D6Ww==
X-Gm-Message-State: AOAM530/JD7idILYUBeEZR64ZRRwO4ii1l6v5MK1Tt3dEh6/B6NJ/p+I
        P087DQS5Q0EJtieR45qbWfE=
X-Google-Smtp-Source: ABdhPJwwldN7h/dhXXftRXHU5vIrMHcmozYmklSe1EVB8Zp7JVC65y5k0cf8x/g1NoEH+72G6tv3Cw==
X-Received: by 2002:a05:6512:20c9:: with SMTP id u9mr2667114lfr.264.1625106288212;
        Wed, 30 Jun 2021 19:24:48 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:47 -0700 (PDT)
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
Subject: [PATCH v1 05/12] usb: otg-fsm: Fix hrtimer list corruption
Date:   Thu,  1 Jul 2021 05:23:58 +0300
Message-Id: <20210701022405.10817-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701022405.10817-1-digetx@gmail.com>
References: <20210701022405.10817-1-digetx@gmail.com>
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

