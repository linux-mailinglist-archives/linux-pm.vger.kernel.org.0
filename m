Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7BC271B05
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 08:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIUGoU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUGoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 02:44:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829E3C061755;
        Sun, 20 Sep 2020 23:44:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so8434012pfd.3;
        Sun, 20 Sep 2020 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TY6rTuH+hQ+q4EsNuPxFLoYH5/k041XwcpZaYAsbudM=;
        b=X4Na4JCDn50tVyv7IpaQpmWbJVu5ibSFdJi3zeC2/66qjRAyUBQbaTjRWuRCvV6IYZ
         M8ia5La846d7CuDz4LcmpNNpfEWnMC178n7lTFYB4VQ6FDRx4xyHlRLe/9oqZFw9ZMCS
         sZFNrtGwjJsml6LdkJVXn2/rxHpizTJbLop/fqqta37wq+k1fkZUwbNAvpyo0OOSg2qq
         d8sYCMMU4Z88YL32yzsb/ycMqTfMCEF1EJJU68ZVUKuyoHFEgcK/XjBAsz0uZI163A2a
         n3iA1srN2lEWpL8jl4BMls3wlIgdxWKnp7HspXGGG45xpsWmerhWz6lPHO6MCo+LOk/6
         ArWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TY6rTuH+hQ+q4EsNuPxFLoYH5/k041XwcpZaYAsbudM=;
        b=tlmeFKsuzXMw5hn419WzOKwfxLdYz5B6YMEv/3vskWfCzAzPOHZUdHAktq4JQmHzVu
         z4vZX2EaWK0XxIAW/a0hBnO2LdraUo93Y6ZTg5jbdc8fvDo5oqGZ+dbyuLOuv2xT2pFI
         4xi9MGu2zqHon0NTC9NvB+MY56+WCROcBaOqGC9QTtz8nVKmurx81BjYUXud0nEyY3MA
         stRhkN51hJUFQTtp/FvvJQluvBSKpFQrp3nFwJB6zPrxua31nDrA6ztmAdDo+JVPW1sw
         JTJ1wikAS6ggBZMFscO1k5lRYypNi8ba2x7xSSnox3XE6fAeODcSX5VsCPc89YyFxpuv
         sVjA==
X-Gm-Message-State: AOAM530NXpRdXkCBKlwij0xbvwWBmppMxJstPv2BbVmkSaI/tVTNnGOy
        7d4PQE8/lRisW/MKza65UsBEhUn9nyPTGwVu
X-Google-Smtp-Source: ABdhPJx0xGsITLrS+x2JafQi4Mc0gWy1XG/i6ut90fAd0FU/Dp/uJE3pCjZarsw9RH0TeYelBf/z4w==
X-Received: by 2002:a17:902:bc82:b029:d2:2988:43ef with SMTP id bb2-20020a170902bc82b02900d2298843efmr1934647plb.68.1600670659992;
        Sun, 20 Sep 2020 23:44:19 -0700 (PDT)
Received: from localhost.localdomain ([47.242.4.81])
        by smtp.gmail.com with ESMTPSA id 84sm11007069pfw.14.2020.09.20.23.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 23:44:19 -0700 (PDT)
From:   Herrington <hankinsea@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shipujin.t@gmail.com, hankinsea@gmail.com,
        Pujin Shi <shipj@lemote.com>
Subject: [PATCH] powercap: include header to fix -Wmissing-prototypes
Date:   Mon, 21 Sep 2020 14:44:04 +0800
Message-Id: <20200921064404.1316-1-hankinsea@gmail.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Include the linux/idle_inject.h header to fix W=1 build warning:

    vers/powercap/idle_inject.c:152:6: warning: no previous prototype for ‘idle_inject_set_duration’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:167:6: warning: no previous prototype for ‘idle_inject_get_duration’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:179:6: warning: no previous prototype for ‘idle_inject_set_latency’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:195:5: warning: no previous prototype for ‘idle_inject_start’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:227:6: warning: no previous prototype for ‘idle_inject_stop’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:299:28: warning: no previous prototype for ‘idle_inject_register’ [-Wmissing-prototypes]
    drivers/powercap/idle_inject.c:345:6: warning: no previous prototype for ‘idle_inject_unregister’ [-Wmissing-prototypes]

Signed-off-by: Herrington <hankinsea@gmail.com>
Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
Signed-off-by: Pujin Shi <shipj@lemote.com>
---
 drivers/powercap/idle_inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 4310901a074e..6e1a0043c411 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -43,6 +43,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/smpboot.h>
+#include <linux/idle_inject.h>
 
 #include <uapi/linux/sched/types.h>
 
-- 
2.25.4

