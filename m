Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED5332FB18
	for <lists+linux-pm@lfdr.de>; Sat,  6 Mar 2021 15:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhCFOLp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Mar 2021 09:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhCFOLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Mar 2021 09:11:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCC6C06174A;
        Sat,  6 Mar 2021 06:11:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z5so2832694plg.3;
        Sat, 06 Mar 2021 06:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LgM7YFWhlt5znBD2/JLvW1bjNTi6OGhQjmnGFZap7Hs=;
        b=ckNoAB+ODBWa3INVgftQWQRWPnnDR4uxPs2MSO1/0eBbzbgDjEB5MKmQwCBfbiNb9Z
         JnLvIHZg0k9YxRwiUO6b/M9wyu7lNZYlM2KAsNtrQe1kRr1YH4iJOTwk27AQ/HRDYFdv
         1U8BA1QGM+4bHvofgz0XRVqq3x9bB35QCl1WwBvrxtyd+Y8aW+yiEa1hM3H4Szyi1SDv
         QC6o7NcyNZzJadL0cZ1VzgYE3+0gZvSExobJdZ8Y0LiTz1rnlXaH27rzZamtjC72DH5v
         sA/8GMSC8WIwHsUJIjF5293I+Aq2z1C8loYeTUkjUcTgshQ61RUqDHksCVOiEsfZh8WK
         Qr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LgM7YFWhlt5znBD2/JLvW1bjNTi6OGhQjmnGFZap7Hs=;
        b=ZvfJThNW5gHgDHHxK+2IT+fhs+vr3VE2DDoP0BiIlkATiGfJI3+Vo/JIF7nzOzkWmD
         os1E5nRlyhLpqu9+p07u3DkP9Yf2pRtU+cUgQDk8x9FaRM6yuKaSaaGte5CTEVTGCDHY
         +eAySn3cyBmxeYN+F90DWff9aua0LHQTGw8gchlZR52mqbL8gD0nKKlab5xH+MH0ifFQ
         73VlWKWMt78UM06ApnFgTQO1lDcc2ZwHGkB2SDgov+xMywKnK4/nGo31OVs2bvlDMjCG
         +RercBPJATb8VO98HCgsF1JYFGJjMJJg9gbwD+WOUHs7JBnAxc8sjI6vARjb4n/tw5Uh
         4vFQ==
X-Gm-Message-State: AOAM532GKLtTVavo2AWGXSmf9XEE0FoIBIky9BOIhr37kWsVQAZpPlZi
        Wu/QUpjLNMIQVB/7wBAO/22gKAOt6LbH6w==
X-Google-Smtp-Source: ABdhPJx0HUd2uHXnnm00G2u5dzEtzPO7Dne+6GxhtL76qKb/VcoV+Na1KZuJBVIKvaSY7hjCik7XYA==
X-Received: by 2002:a17:90a:a10a:: with SMTP id s10mr15827869pjp.36.1615039881660;
        Sat, 06 Mar 2021 06:11:21 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.79])
        by smtp.gmail.com with ESMTPSA id d2sm5521364pjx.42.2021.03.06.06.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 06:11:21 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] thermal: thermal_of: fix error return code of thermal_of_populate_bind_params()
Date:   Sat,  6 Mar 2021 06:11:06 -0800
Message-Id: <20210306141106.18695-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When kcalloc() fails and __tcbp is NULL, no error return code of
thermal_of_populate_bind_params() is assigned.
To fix this bug, ret is assigned with -ENOMEM in this case.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/thermal/thermal_of.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 69ef12f852b7..e8c9041482e9 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -710,8 +710,10 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 	}
 
 	__tcbp = kcalloc(count, sizeof(*__tcbp), GFP_KERNEL);
-	if (!__tcbp)
+	if (!__tcbp) {
+		ret = -ENOMEM;
 		goto end;
+	}
 
 	for (i = 0; i < count; i++) {
 		ret = of_parse_phandle_with_args(np, "cooling-device",
-- 
2.17.1

