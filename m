Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0270366E5A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhDUOhb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbhDUOha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 10:37:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3959BC06174A;
        Wed, 21 Apr 2021 07:36:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s22so8923949pgk.6;
        Wed, 21 Apr 2021 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EKAtUZl+TRDKugRT+eA6LqC2SBuBYVSKTMQWk3KBVs4=;
        b=Z4Y1u0jhO1lXAyubIB2I4kWETFgqF3fgDTnOvdpqWnDn6++0UCMA9C/4VhtQTj+G2Y
         WL/IHCrN5u2DQhMv1ne5JJ9Jiz33hweq2u6OByXiE4ZMQfqIzqTIu02Fj7+3HwuRAf0e
         B27/V8HH+DDqbf0SNhKk15GajiGHf6zfoXFNlcE3KIH8vNSSTpdWFVHO+fy2e/+2dWsf
         3aAYYjxQfVxBtKXgw6+hWCbQVk0dPzg0pXw5rn0RORx6aOhE7q+TPNPaYH0BnQoH2rsn
         9yNX/CBFgtJum6uzdDu7/6cPBnvGfOmGyj1IAlEXxVg6nr2paaj98CAhJY6EyAoSawSe
         Nelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EKAtUZl+TRDKugRT+eA6LqC2SBuBYVSKTMQWk3KBVs4=;
        b=UDumkzGLgdnA3G0wWPQIkV+qEw8A4EQ6gR5YEFmC81ciGWGvMmwOC4THC0x+1z+pt9
         drfa8Pyd2J12rVOhoT1ScAT/g/r4w0NzCqeu6BJ+1eRSQiiK8Vn9906eoi1CCzjpL+RW
         VXJgMGtF6UqErZo7gTrz6Ox2hRBYTXimSCyDeUFnkQEpe2vNS/OhMtIQnBWPSQl+rjV3
         rwDAO1eu4nNaG3/AD6qbX4rf2lvtOmap7ViqZgd3KLKhunbTJ0fQAKRbLwDQS6W9uSg1
         06OH64A8b7rKEs/QRRcMvOYKNusVK+54TawawaUNtUBmUQsC5bRIk8bgtW73ZeyeBJB+
         GptQ==
X-Gm-Message-State: AOAM532tmcrhwaVSUeo2r9rtPBYSnW4sE2XoQPzZF85AK63RsYJnwi9R
        lltJ67ucL+QUdmqDmxyc602haYwQQ6WS7zSN
X-Google-Smtp-Source: ABdhPJxKNrifmZEuw++9U8ppHmiCF3OoM9Yznds7wUI/lYOWG5SwGp66/Q5gKXfxsWV9r5u17lHaSg==
X-Received: by 2002:a17:90a:4811:: with SMTP id a17mr11276071pjh.74.1619015814894;
        Wed, 21 Apr 2021 07:36:54 -0700 (PDT)
Received: from localhost.localdomain ([96.44.140.50])
        by smtp.gmail.com with ESMTPSA id 123sm1977731pfx.180.2021.04.21.07.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:36:54 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH v2] power: supply: cpcap-battery: fix invalid usage of list cursor
Date:   Wed, 21 Apr 2021 22:36:50 +0800
Message-Id: <20210421143650.16045-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Fix invalid usage of a list_for_each_entry in cpcap_battery_irq_thread().
Empty list or fully traversed list points to list head, which is not
NULL (and before the first element containing real data).

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
v2:
  - Modify commit message and code as suggested by Sebastian.
---
 drivers/power/supply/cpcap-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 6d5bcdb9f45d..a3fc0084cda0 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -786,7 +786,7 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
 			break;
 	}
 
-	if (!d)
+	if (list_entry_is_head(d, &ddata->irq_list, node))
 		return IRQ_NONE;
 
 	latest = cpcap_battery_latest(ddata);
-- 
2.17.1

