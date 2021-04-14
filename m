Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5935EDAB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Apr 2021 08:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349321AbhDNGsJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348295AbhDNGsJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Apr 2021 02:48:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE195C061574;
        Tue, 13 Apr 2021 23:47:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p12so13713400pgj.10;
        Tue, 13 Apr 2021 23:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gwv5x6G6JJ9YN0KJM8SBzss+XRBm/4eYU9zWQJ9tAVw=;
        b=rz2u7gNrybHVnGHQWsSuv+iamFtXnVQPtIoieaY6PdCj42qg9cdLtQUVUgAlIjzkCq
         jMWhHFqQZq2S5JHPwArn6bIdqp6Wbcx0g5FjmjFPkW9+LCWB14luo0dTzP7DxIsTcXz9
         Q0P9RI6x3OzQPkO5yIctFNDvDHjHpcBq52GVpgl+oFF54H+bjc8EfFPUVWcHXHqdUgqg
         tyQeiGAK+PAswX5c/rYCJnGaeV2suDvLxYHiOfxU9Myq5D40XkBVjmLKYOeGIk+nWb0r
         CvRTA7uAzxGddl0v1K5PpTqBneFhjsTty0a4KAsae8oGXaUU/fsYllwXCUgQDOk1jP34
         OzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gwv5x6G6JJ9YN0KJM8SBzss+XRBm/4eYU9zWQJ9tAVw=;
        b=ObRSw4rbhz51Qh6BwYaILZgi8XRuQeB1dlgFPWzQBQa4mlGLon44QzeJKRG89LHCqp
         N3LkrrdR8T3YV8HLDEntj+Nlb4Vykk64HFkVZC/g97z/WRGgxbkx0V/+Je1mcu1YcMw7
         bb11E2zspfGLdU7LlHBwd3BdwzeuQV8In/OU2xqPq7o08oHPcL00gJEVck1jXVWxapls
         ajOhC+/Jd1a/+gbsEMnDEIa43TpXHdIM30oObhzS0A3kLoVZXNxisGbsD43MO3rjjKLr
         unYwEXRjGSYQCkVMuNmRKFNnng2HUKWBE94DKcryDDaBGx3XHOE85up8iHDDIzNB94SN
         VBFw==
X-Gm-Message-State: AOAM533/XsYx2QFhxLORT0uMZ0OFcN+yiMJShY+vEBFYg+PxCgRg4HBb
        TRP4FwjCrpaW3DJM81jFbNyLmdltg7BEJWSE
X-Google-Smtp-Source: ABdhPJxxih+hUbVYY+DjX6fDZ+p5zvJI2xBrensWhcBJKA6pNE86088BqCCj5AEt5pStuR6cICEMjg==
X-Received: by 2002:a63:d556:: with SMTP id v22mr3639061pgi.310.1618382868560;
        Tue, 13 Apr 2021 23:47:48 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c15sm14084913pfi.207.2021.04.13.23.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:47:48 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH] power: supply: cpcap-battery: fix invalid usage of list cursor
Date:   Wed, 14 Apr 2021 14:47:24 +0800
Message-Id: <20210414064724.27068-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Fix invalid usage of a list_for_each_entry in cpcap_battery_irq_thread().
When list is empty or if the list is completely traversed (without breaking
from the loop on one of the entries) then the list cursor does not point
to a valid entry and therefore should not be used. "if (!d)" will never
happen, maybe we should use "if (&d->node == &ddata->irq_list)".

Fixes: 874b2adbed125 ("power: supply: cpcap-battery: Add a battery driver")
Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 6d5bcdb9f45d..8169dc71a786 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -786,7 +786,7 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
 			break;
 	}
 
-	if (!d)
+	if (&d->node == &ddata->irq_list)
 		return IRQ_NONE;
 
 	latest = cpcap_battery_latest(ddata);
-- 
2.17.1

