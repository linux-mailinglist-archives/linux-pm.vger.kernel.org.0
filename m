Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A71276B50
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 10:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIXIA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 04:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgIXIA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 04:00:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E7C0613CE;
        Thu, 24 Sep 2020 01:00:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z18so1426395pfg.0;
        Thu, 24 Sep 2020 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SGl+breC8K9DZrFahalhbnYwE9PtZ9W0GoZnYML7ng0=;
        b=fFCLD85CQF97stUOStSx7BIHQeboYjWxWZGzHZuSzf6h6MvR36Y0HL78awwIHOR7jM
         xVvqJio0wc9I8uMo2o+isDmQz2YCVixQN/uHCAM4HfrufyPwOtYvac+Mxp4kK65BM5bO
         ZhSf3Qx2w7ufHFs/Q2HNqMJLKWl0X6aKm/M7X12zAObT3HwXXIDm+Zii9uVybIFMdkL8
         vLc74QliQrivZkpxivgXedt/0s76KM+NjWr7qjLgREAeIygel3z4sFjRHfdRy5hTew4K
         m+yf/bNohEZWbo4CGYIjQ1jo8ttdpnLR50S2KFL4495ED84Qenpbhyb6k8QiDnjyW+JE
         Ax/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SGl+breC8K9DZrFahalhbnYwE9PtZ9W0GoZnYML7ng0=;
        b=kCYMSnc8fgUhHc0W9nlSZ23V3GtQUGSdSkY9lXisbgkbu/S8F2mTHIPpCrJAbmZES5
         XAUKZC+MCGLQRfodzCOG9ZkB2oK340UkwHjm3xLPqOiOONqZg/7vYTTFGUQl4PxJNP8g
         ns+zsLUM7hzTpjiQgjEBtM4prgwHbtlRyfmXA+sJdUIMYErmSaV8syY9jgkf8Rx9ZCi4
         qYOouoJBTZcT6v/n8WaMsMxvOaPjD/QEHwRUEjvSfEnruOJ/H6HAecAyJI8Luwj6OfnA
         2sH5jbwhHRqD8Ncv2e7hbR9ri1661/jEN1NoRlekHdO9nrD9QvReHXTtAkHSHOse1Fs4
         4/BA==
X-Gm-Message-State: AOAM531y5p4SJm0znvSo/KhVE0P2UCSCncmPamavmalISm3JVPLJtd5a
        5IMZJGGtRTLZjNyr+LmQLEk=
X-Google-Smtp-Source: ABdhPJwIceL2FFIaXp152oPqEv28Fsp9zTrULykK+7DU7WDJ7/UFb5srhrU+gvEVwruQGGkKb7lt4w==
X-Received: by 2002:a65:594b:: with SMTP id g11mr2985272pgu.382.1600934459326;
        Thu, 24 Sep 2020 01:00:59 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id 137sm1947359pfb.183.2020.09.24.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:00:58 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: [PATCH] cpuidle: change #ifdef for the declaration of cpuidle_enter_s2idle()
Date:   Thu, 24 Sep 2020 16:00:41 +0800
Message-Id: <20200924080041.2740-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

Currently, if CONFIG_SUSPEND=n and CONFIG_CPU_IDLE=y, the function
cpuidle_enter_s2idle() is declared but not defined, it may cause error
when cpuidle_enter_s2idle() is called.

If CONFIG_SUSPEND=y and CONFIG_CPU_IDLE=n, the function
cpuidle_enter_s2idle() is defined as "return -ENODEV;" which is not
supposed to be.

Change #ifdef CONFIG_CPU_IDLE to #ifdef CONFIG_SUSPEND for
cpuidle_enter_s2idle() in cpuidle.h, which is consistent with its
defination in cpuidle.c.

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 include/linux/cpuidle.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 6175c77bf25e..2aa8cead1727 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -216,22 +216,26 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
 extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev,
 				      u64 latency_limit_ns);
-extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev);
 extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     struct cpuidle_device *dev,
 					     u64 latency_limit_ns)
 {return -ENODEV; }
-static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
-				       struct cpuidle_device *dev)
-{return -ENODEV; }
 static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
 {
 }
 #endif
 
+#ifdef CONFIG_SUSPEND
+extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
+				struct cpuidle_device *dev);
+#else
+static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
+				       struct cpuidle_device *dev)
+{return -ENODEV; }
+#endif
+
 /* kernel/sched/idle.c */
 extern void sched_idle_set_state(struct cpuidle_state *idle_state);
 extern void default_idle_call(void);
-- 
2.17.1

