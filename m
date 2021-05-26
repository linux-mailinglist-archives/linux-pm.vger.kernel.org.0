Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5451391CF7
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 18:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhEZQZE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 12:25:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35265 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbhEZQZD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 12:25:03 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llwJf-0008D6-Jz
        for linux-pm@vger.kernel.org; Wed, 26 May 2021 16:23:31 +0000
Received: by mail-vs1-f70.google.com with SMTP id z5-20020a67d2850000b029023673cc643bso468118vsi.7
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 09:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NwA8NmUwiZmbFBWUe/+uyLFAYgt93yKUAUW2ekHfg4=;
        b=gi/ToTx1KgbQU5wKO6yXrQ0o4tsCmKZUMN4+L5K08l+VJrx0pzp1NPdgJNVXPLi7yh
         K/Axv99Z6o2W9otZdu+RhgA8iVAL014LTY9iu//WibyvcR+SqVcpWTp8cOEWP0G4LH24
         a8fYAb6m4f9jeFUeycmttgExAcNOQMF0lNr1Qv326M52dPRT7aCnsJphl08Rpb00O9v2
         xuOnRGH5Ba1UHyt1MpUDmYZRmT9tvSkZ+OdpywGQlDFIKuxBZRlmvRYGA5fkz8NvB5XZ
         ppdAIkSQvpuOZqQn44MPV7qgYWYlNi5J2Zj983zrjtZ2TbQxs2CeRpKbO/VXZ1JQU0mf
         wrvg==
X-Gm-Message-State: AOAM530WcR0aqv71Tfzk9n3wn8UbG9UNmitdkV8VHDWY+zDb6rOCC2Ir
        SqvsPU0dnaKEcDAniu6UU87y0V4LtTYg5GpixdkoMSq+pwe05+xKSdG6I6VXP2RM3KN41ifJwf5
        JgQlYMTd6ae+LbaNwSs+iBphKN0pd/PYhqsjt
X-Received: by 2002:ab0:2b15:: with SMTP id e21mr34132869uar.102.1622046208937;
        Wed, 26 May 2021 09:23:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq+aNeLdtNs2xkhZJ1UzALGUp4kKfuJC0kkp93ok5ZySBg2n0E8vSWq5sGiiq8LBThjDFJMQ==
X-Received: by 2002:ab0:2b15:: with SMTP id e21mr34132748uar.102.1622046207995;
        Wed, 26 May 2021 09:23:27 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.4])
        by smtp.gmail.com with ESMTPSA id t16sm574459uao.0.2021.05.26.09.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:23:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] PM: runtime: document common mistake with pm_runtime_get_sync()
Date:   Wed, 26 May 2021 12:22:51 -0400
Message-Id: <20210526162251.125600-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm_runtime_get_sync(), contradictory to intuition, does not drop the
runtime PM usage counter on errors which lead to several wrong usages in
drivers (missing the put).  pm_runtime_resume_and_get() was added as a
better implementation so document the preference of using it, hoping it
will stop bad patterns.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Reword after comments from Rafael.
---
 Documentation/power/runtime_pm.rst | 6 +++++-
 include/linux/pm_runtime.h         | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 18ae21bf7f92..33619bf83f69 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -378,7 +378,11 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
 
   `int pm_runtime_get_sync(struct device *dev);`
     - increment the device's usage counter, run pm_runtime_resume(dev) and
-      return its result
+      return its result;
+      be aware that it does not drop the device's usage counter on errors so
+      so consider using pm_runtime_resume_and_get() instead of it, especially
+      if its return value is checked by the caller, as this is likely to result
+      in cleaner code.
 
   `int pm_runtime_get_if_in_use(struct device *dev);`
     - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 6c08a085367b..aab8b35e9f8a 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -380,6 +380,9 @@ static inline int pm_runtime_get(struct device *dev)
  * The possible return values of this function are the same as for
  * pm_runtime_resume() and the runtime PM usage counter of @dev remains
  * incremented in all cases, even if it returns an error code.
+ * Consider using pm_runtime_resume_and_get() instead of it, especially
+ * if its return value is checked by the caller, as this is likely to result
+ * in cleaner code.
  */
 static inline int pm_runtime_get_sync(struct device *dev)
 {
-- 
2.27.0

