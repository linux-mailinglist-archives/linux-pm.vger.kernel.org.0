Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D731CD9B7
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgEKM0P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 08:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729994AbgEKM0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 08:26:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0CCC05BD0B
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:26:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so3868361plo.7
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UPeYtFxFAx9gPdqtUllM7hIOHzpNJ87ucNQvEyM/W4=;
        b=dpuCWriuMUzF0JT7TfJy/jv3b0jgrrU72bBaJjT1jCmEuJjRUN4ZM+j5GKrrwQI7lp
         v96w4P9TimNRooGph5RFZKg7a8I5I/N4UQ/m35tfgeg556gISKAS7c9X+PcJgNw0lLdX
         ajUDubLvh0FClNcx7j0a1eNK2exQGmMNJ9RLkCBC53NpFUfLrNEJaf/ZnMohP2rHwEwa
         9sGm3MWCrw34sI5hDr1j6uPN4qJ/lWPeXJ14MPUXmU/qZwqKXn5i5NNhrqBEOVOUGDce
         183BM1xLwzgw5o48z1bAJ8+DIie4elOnqPYb0+YcAx602GqqiA6P1g0RB3nNU+jPFV6L
         o2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UPeYtFxFAx9gPdqtUllM7hIOHzpNJ87ucNQvEyM/W4=;
        b=KxDtcJaVMUGBBL49KQdENjG6hPwQ8fRcLT9z5HTlMUZYVvpXfVfxAx2u33p3fMVKcf
         Twplq5+BrW1BT5SNuH0FtQ+vA5pzjrzliwP7S+xtrqWgAfCJzTqbItoCbsH2iONZeajz
         7XzvmN8nCJEM9sJ9d9CqO+uVKnjEQgxLGyFs+XaAz+1kEx4Alr6lS8z/fHX2TLtWxYS8
         c3k9VznUiftOay0u014vE412/LuHnYSqOcGUFPOkMgXdwU5dwGFkPQ3pKyrENU6U7M7N
         tEZ+cRC44g2idh1QIQSU5viIyl3PxNE09OV6v+LW/rGKfcKZ3L+h0Jyhd3sAMgnQP+P3
         GIIg==
X-Gm-Message-State: AGi0Pub+/k0li1V36vnDNCeKCDxqCE7I/n2SaAcQ43izS2xedSa3JADd
        +j3A2e9Tl9r5C0dnBKSS/mh1aw==
X-Google-Smtp-Source: APiQypKRc5pNcAFtU8nJC4T0/Mj8a73yMDHrfKjYPg2Qve+SWffvBDZg6bGiuSNMLM2cmdKvT+yoTw==
X-Received: by 2002:a17:902:9b8e:: with SMTP id y14mr15048603plp.109.1589199973056;
        Mon, 11 May 2020 05:26:13 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id f6sm9198173pfn.189.2020.05.11.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:26:12 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 10/14] thermal/drivers/cpufreq_cooling: Replace module.h with export.h
Date:   Mon, 11 May 2020 17:54:58 +0530
Message-Id: <7a439e41e91d8bc5ff99207f99723fcf04ca36eb.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpufreq_cooling cannot be modular, remove the unnecessary module.h
include and replace with export.h to handle EXPORT_SYMBOL family of
macros.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 1b5a63b4763d..9e124020519f 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -10,12 +10,12 @@
  *		Viresh Kumar <viresh.kumar@linaro.org>
  *
  */
-#include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu_cooling.h>
 #include <linux/energy_model.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
-- 
2.20.1

