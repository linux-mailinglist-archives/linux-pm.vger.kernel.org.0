Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1129740BDC0
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 04:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhIOCYv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 22:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhIOCYv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Sep 2021 22:24:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A98BC061574;
        Tue, 14 Sep 2021 19:23:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so1317554pff.3;
        Tue, 14 Sep 2021 19:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12wUXhhqWT6EypSPX1Qo4sn/OvorWOKkb7IuIsjoAFA=;
        b=iRmJEfdwx/SqzJ16EmbSxREzNUZAiVKN9w9t04DydMR/0SzLZRKWePycER9GLi2W85
         oSUxW4m0yL0wbT4uXTkPV9weGR3c53V8Q7+ch0VsRVXNY75pZfzun4/+H9Elu5agfWHK
         LljWsqzlQdpiawZPJmjiyH1bkwqOM0c45vXB9ZlUy7LTBp6IxcdjSx8zNXnzzkF1iJTj
         tKPZxhLW7U3bCEujcGygjAcrRQw3GoCQOArr2jdZb9fec0lu+2KAPoJy2L/PGXtgJywy
         jk+ULiRRyWRYavMYoi85gLHAbPjVLMOmFwwZZjAaQcWwNx0D/9dR6ogXYCba/KSeuT/j
         gzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12wUXhhqWT6EypSPX1Qo4sn/OvorWOKkb7IuIsjoAFA=;
        b=2rpaTlwbRsUFU5x5LyTLhpUjHAKWYQOUALR+AR8UxxKeCUn1+xMD6Hw2fpRyPvukSE
         kB/89w1Osfjfqd16YiwkEVBc2DAMo/m+GGn7e/jKMkNpGHnWePaA0Q7BB/qBKPhKtSlW
         vLxmuEmR5wFW8vHSZE4qAPitStF35CFgOZVBUgCwZ48mZGg4OeKLOv6XaLcmi1L1HQvr
         yxO96KNBnOKnjLtGq9+pvXn3yKlu2OX+UUXfLHEP9kkKRgdBZFK77w/wL1cwidRxOI6a
         9BLLPqXBRVoVRi3ZNu5ZS4XpGGyssuQ2sZAsqF7qrJ50QK0T3ZXXRXMXXHB707Dq2gEq
         sDPA==
X-Gm-Message-State: AOAM5309y+JfoG3dK7Y1PJh6cwgtJbbq9ld7PZKEhFa0dtGoO1HYT2AT
        U/L0jJmI2tzZ04AigrAGgzsUB1Qf8yw=
X-Google-Smtp-Source: ABdhPJzqsEjyP6eHKH6vzEQWKxxTcmXgMe4S536pLvzFe2LyK2rBdIMYnzYsUKEWii6FGXl2CXA2dQ==
X-Received: by 2002:a65:6251:: with SMTP id q17mr18297678pgv.416.1631672612415;
        Tue, 14 Sep 2021 19:23:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h16sm11686649pfn.215.2021.09.14.19.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 19:23:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     geert+renesas@glider.be, Florian Fainelli <f.fainelli@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM)
Subject: [PATCH] PM / sleep: Do not assume that "mem" is always present
Date:   Tue, 14 Sep 2021 19:23:28 -0700
Message-Id: <20210915022328.56702-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

An implementation of suspend_ops is allowed to reject the PM_SUSPEND_MEM
suspend type from its ->valid() callback, we should not assume that it
is always present as this is not a correct reflection of what a firmware
interface may support.

Fixes: 406e79385f32 ("PM / sleep: System sleep state selection interface rework")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 kernel/power/suspend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index eb75f394a059..02e306ad8db8 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -171,8 +171,7 @@ static bool valid_state(suspend_state_t state)
 
 void __init pm_states_init(void)
 {
-	/* "mem" and "freeze" are always present in /sys/power/state. */
-	pm_states[PM_SUSPEND_MEM] = pm_labels[PM_SUSPEND_MEM];
+	/* "freeze" is always present in /sys/power/state. */
 	pm_states[PM_SUSPEND_TO_IDLE] = pm_labels[PM_SUSPEND_TO_IDLE];
 	/*
 	 * Suspend-to-idle should be supported even without any suspend_ops,
@@ -214,6 +213,7 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
 	}
 	if (valid_state(PM_SUSPEND_MEM)) {
 		mem_sleep_states[PM_SUSPEND_MEM] = mem_sleep_labels[PM_SUSPEND_MEM];
+		pm_states[PM_SUSPEND_MEM] = pm_labels[PM_SUSPEND_MEM];
 		if (mem_sleep_default >= PM_SUSPEND_MEM)
 			mem_sleep_current = PM_SUSPEND_MEM;
 	}
-- 
2.25.1

