Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940A23BAF9D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGDW6r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhGDW6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F780C061765;
        Sun,  4 Jul 2021 15:56:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n14so29054816lfu.8;
        Sun, 04 Jul 2021 15:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Q+PKRJOc2730Ah0GRBri/k7y1AxQSUchChpfwd+0wc=;
        b=jRFuZkFe2ezJHVxFc7EUe0gyLGYwPNhNLGRI483JolnlLZlpn+Ta89nQtXJAsbkkOq
         cYSog+7ca6m4cI+cPC7L8/qB+WIDW2g8c+uH+K6dL3ZfC9X/82ox0beiKr5MsGVCn/cP
         jXL5sKcSLfgso1VvndBf9caFwUWXhyHr+9dR8UNG4qX/67Wd5FfpBPGr0p+eHZ2yb+TD
         nVhpFsvG51ias4+mB7Y1811C1U+JsN23pUxBCVnNv74NfeXPIj/VygWcUIW6ztxdN2MA
         93RQW8jr7HKYPYlstV3TxDrufNe6drqzIN/Vvv5eooS7SLMPKsoYs1MgB6tcvyEQuupZ
         Is0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Q+PKRJOc2730Ah0GRBri/k7y1AxQSUchChpfwd+0wc=;
        b=uTgn4EiRQdNh8selqMY1/kRTn+3gFg8lSyHmSAue19zhuqpzwVUkrTMkjGOdqaFDL7
         bcdnoMtiSrRfta8h7bN8Us3mSxKs8O2GYqp271vqboVH2tjLeOjyxAEyyWaMSXJlOm/R
         5f3u5C4r7wi9brcmaQdRA6CF3vmjoHqwntriDr9e9bEdu95C1E4fDh4qDRl8iEED3v4N
         wyXiP4cCJl7WG/XAT7VZ7ExZ6Oh/9UxYGHH3lktW50e31Rrnq1x94aAcjq1Z79ImgxFA
         QdjRG9acwehk0lSJAxS+Bgm4b5BZTg9iyXimzVNp2CuhbIHW6Ty3DYRdkPvZS89GX7vJ
         5Ycg==
X-Gm-Message-State: AOAM532XDWlFuza7oIkvhmGwiV8tRTlQOcX03U/H6gR9WhAcw1/9JCwQ
        eCMQo4bMwoV5AaSpGuW7bdg=
X-Google-Smtp-Source: ABdhPJy5cm4wAqhgL6IqjrrewpNZLpnknNjaSQ4lDTt9257wWY5AG3aI5taO1ZSYgcWQvDOEHR7vFg==
X-Received: by 2002:ac2:4f8a:: with SMTP id z10mr8391402lfs.30.1625439363596;
        Sun, 04 Jul 2021 15:56:03 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:03 -0700 (PDT)
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
Subject: [PATCH v3 05/12] usb: otg-fsm: Fix hrtimer list corruption
Date:   Mon,  5 Jul 2021 01:54:26 +0300
Message-Id: <20210704225433.32029-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
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
2.32.0

