Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB238D7BD
	for <lists+linux-pm@lfdr.de>; Sun, 23 May 2021 00:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhEVWzB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 May 2021 18:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhEVWzB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 May 2021 18:55:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A5C061574
        for <linux-pm@vger.kernel.org>; Sat, 22 May 2021 15:53:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c10so14075822lfm.0
        for <linux-pm@vger.kernel.org>; Sat, 22 May 2021 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cgxtdq7WfwcFi6Tw45dZZGm31pKf8GVZiN31I4P02hg=;
        b=eGg1KRCHwA5DKZio9LEU/CUsEVGgE78Hx8jGt6qQBnm8uxku/CkI9Dlgu1pkufw69+
         gc4j7QXZWIS9vvEcq067PIxSqD3VJbalC667MTX233RI4Wn8+lxGF5MkVwFvMmJNUlBd
         b/frYy99xd1GgO2WoN42tqUC5M6Gl9bmmNLl7TSHqfu+5+XJ5Tw5crdYZhqRFMrqOzI3
         bB5kiTuWEI/01/bFIjsOt6xKXCZZgmoRN+HQQa0SFl4cI+QskAOZM/LINylUZCpr4mo1
         IeNPRJv0IV8r8FvJxW7mCDdO9UDfZf+JUfYK4pq3SSLSxsDBEaShqIZOSMCtlJFcAukw
         cuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cgxtdq7WfwcFi6Tw45dZZGm31pKf8GVZiN31I4P02hg=;
        b=iuiDS5AOi0ZjdXhacxoBdpfehzl7lSujgni6k7bGQSmUb7nQFOaKdClIiy5jBwKbk1
         uMMWpXYQIELOi9Qx2J1nfV4JUTWg8/0mwTkWbgnLzCU3NvDPKv5Nroxg/yKOmNtBA8BA
         mg+hUG67nQ9hH4D/Frwsb+asjyTXJg3a1Zm22JzklldEF3VE0CHDYkUHAfevwyZQ1V4f
         iJTMEbaEQ0Sz9DvxmhSGKMDG7JzRcUs+ZM2Y9FRIqeQLt2NmYyBJMHjnLWbhffJ44R7P
         MsMahRQMvVtWDhFRse2nLTsO9HQVNz8B0O6VQJgufve8WOeOw9iPvOpA0UsLQAeR4J3D
         O9xQ==
X-Gm-Message-State: AOAM531KwTyvN9+rH42LbBLxVliGSYzeXvOhinmrcmyuUaEHvs0HIUhn
        +MtZAFoyyw9qXWHacCoc6jHl8A==
X-Google-Smtp-Source: ABdhPJxbKnIwx6KR1j4lq2TDkXfXuMo0jeNFysQIcuRdnYGPz0vLlkciy7kcN1KnfkhmojX3e+9lFA==
X-Received: by 2002:ac2:44cb:: with SMTP id d11mr6264941lfm.239.1621724014033;
        Sat, 22 May 2021 15:53:34 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id p14sm1136883ljc.58.2021.05.22.15.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 15:53:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5 v2] power: supply: ab8500: Drop unused member
Date:   Sun, 23 May 2021 00:50:43 +0200
Message-Id: <20210522225043.1004103-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522225043.1004103-1-linus.walleij@linaro.org>
References: <20210522225043.1004103-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This setting is read directly from the device tree in
the ab8500_charger.c code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on v5.13-rc1
---
 drivers/power/supply/ab8500-bm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 871bdc1f5cbd..0c940571e5b0 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -506,7 +506,6 @@ struct abx500_bm_data {
 	int usb_safety_tmr_h;
 	int bkup_bat_v;
 	int bkup_bat_i;
-	bool autopower_cfg;
 	bool no_maintenance;
 	bool capacity_scaling;
 	bool chg_unknown_bat;
-- 
2.31.1

