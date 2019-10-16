Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BD1D922D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 15:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfJPNQT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 09:16:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35024 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfJPNQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 09:16:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so23987147lji.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t/IdaCvXraOwlJZTUOq6plCE0lZnjdA61GIv6muLp1Q=;
        b=VLCC0f2jo6csOzQNOAyaHJmjTKt6NC1Cuj782X7mRCJ5HwMnGpia1SOy5aQFzRAmbX
         6VF45SZ1bMcN702DI3Pl3OZGkvnTejl52/kfLwkqYZC3OG9JsKUZLKNVUNBW6ocQPW/f
         uOIefwzS9K9mHHbOaTeh2nJpSV5ubaXqVR2k6PAj62Z0LvMFfgY/qIbn/wkGCONUaaIN
         VF5dAZhTaJrtlI5xS4Q72xykG393Yf0Eij/3qaNS7Tx7T7VrY29b1eBlsjrTG/W84tYK
         KA33BxztW85EgaQXb/1lp41lV2jhE/4Ma0aLpYjinRvS1hassm/TlYLqCX7hjxF0J564
         Wc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t/IdaCvXraOwlJZTUOq6plCE0lZnjdA61GIv6muLp1Q=;
        b=V9lwLo9aVcbmBLO0MsC5gHDG1s5WsLvpUHDIfORpSOhnQDwliIQIOW5gj0lZXlIzcb
         dNRs+L/FQFk2Aa457rYZoQJRoVhltTxOZ7wgmydOtpNrw6O7DfrB2narr59Km04Q66OC
         ldokq9jrUubt8Q24YpMSOGwM1OWG+ee3sA0OkWZfDI4HwCB53kJww1fn8d/xi3ozX1Cg
         IYHOjsz6U++fT6+wCWBnog0y+k3qkBXJOsLqDExxhD+3zgL2eRipYk2TZcP9x+r8jvea
         PEVSDj2tz2rf151O/dVrLScORhu7MO9ic5jeOtUiuqV0H7gWMvzfvl+nLDPnAeVbkYvy
         DDog==
X-Gm-Message-State: APjAAAXS1dXr4GudEJdMJdAc2cx9oIrljqTgMsCHb05/IaHT1itKAd+/
        ybMkISrRkA2OkpE/flWFE34mnQ==
X-Google-Smtp-Source: APXvYqxHpO8/K1SzA/rbXfA8GoR1yQqr6YxgbM2Sg4Pj74RmTLT7iIM9oDjo8SJ4Tqufb8+dDZ73ng==
X-Received: by 2002:a2e:a211:: with SMTP id h17mr25768660ljm.251.1571231775888;
        Wed, 16 Oct 2019 06:16:15 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c26sm7022530ljj.45.2019.10.16.06.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:16:15 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 1/3] PM / Domains: Introduce dev_pm_domain_start()
Date:   Wed, 16 Oct 2019 15:16:03 +0200
Message-Id: <20191016131603.15784-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <../../misc/pm_patches/submitted_patches/pm_domain_start/0002-PM-Domains-Implement-the-start-callback-for-genpd.patch>
References: <../../misc/pm_patches/submitted_patches/pm_domain_start/0002-PM-Domains-Implement-the-start-callback-for-genpd.patch>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For a subsystem/driver that either doesn't support runtime PM or makes use
of pm_runtime_set_active() during ->probe(), may try to access its device
when probing, even if it may not be fully powered on from the PM domain's
point of view. This may be the case when the used PM domain is a genpd
provider, that implements genpd's ->start|stop() device callbacks.

There are cases where the subsystem/driver managed to avoid the above
problem, simply by calling pm_runtime_enable() and pm_runtime_get_sync()
during ->probe(). However, this approach comes with a drawback, especially
if the subsystem/driver implements a ->runtime_resume() callback.

More precisely, the subsystem/driver then needs to use a device flag, which
is checked in its ->runtime_resume() callback, as to avoid powering on its
resources the first time the callback is invoked. This is needed because
the subsystem/driver has already powered on the resources for the device,
during ->probe() and before it called pm_runtime_get_sync().

In a way to avoid this boilerplate code and the inefficient check for "if
(first_time_suspend)" in the ->runtime_resume() callback for these
subsystems/drivers, let's introduce and export a dev_pm_domain_start()
function, that may be called during ->probe() instead.

Moreover, let the dev_pm_domain_start() invoke an optional ->start()
callback, added to the struct dev_pm_domain, as to allow a PM domain
specific implementation.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/common.c | 20 ++++++++++++++++++++
 include/linux/pm.h          |  2 ++
 include/linux/pm_domain.h   |  5 +++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 8db98a1f83dc..bbddb267c2e6 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -187,6 +187,26 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
 
+/**
+ * dev_pm_domain_start - Start the device through its PM domain.
+ * @dev: Device to start.
+ *
+ * This function should typically be called during probe by a subsystem/driver,
+ * when it needs to start its device from the PM domain's perspective. Note
+ * that, it's assumed that the PM domain is already powered on when this
+ * function is called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_domain_start(struct device *dev)
+{
+	if (dev->pm_domain && dev->pm_domain->start)
+		return dev->pm_domain->start(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_start);
+
 /**
  * dev_pm_domain_set - Set PM domain of a device.
  * @dev: Device whose PM domain is to be set.
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 4c441be03079..e057d1fa2469 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -637,6 +637,7 @@ extern void dev_pm_put_subsys_data(struct device *dev);
  * struct dev_pm_domain - power management domain representation.
  *
  * @ops: Power management operations associated with this domain.
+ * @start: Called when a user needs to start the device via the domain.
  * @detach: Called when removing a device from the domain.
  * @activate: Called before executing probe routines for bus types and drivers.
  * @sync: Called after successful driver probe.
@@ -648,6 +649,7 @@ extern void dev_pm_put_subsys_data(struct device *dev);
  */
 struct dev_pm_domain {
 	struct dev_pm_ops	ops;
+	int (*start)(struct device *dev);
 	void (*detach)(struct device *dev, bool power_off);
 	int (*activate)(struct device *dev);
 	void (*sync)(struct device *dev);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index baf02ff91a31..5a31c711b896 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -366,6 +366,7 @@ struct device *dev_pm_domain_attach_by_id(struct device *dev,
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
 					    const char *name);
 void dev_pm_domain_detach(struct device *dev, bool power_off);
+int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
@@ -383,6 +384,10 @@ static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
 	return NULL;
 }
 static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
+static inline int dev_pm_domain_start(struct device *dev)
+{
+	return 0;
+}
 static inline void dev_pm_domain_set(struct device *dev,
 				     struct dev_pm_domain *pd) {}
 #endif
-- 
2.17.1

