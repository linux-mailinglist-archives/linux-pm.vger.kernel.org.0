Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 739F210CC6A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 17:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfK1QDW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 11:03:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45321 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfK1QDW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 11:03:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so5914971wrj.12;
        Thu, 28 Nov 2019 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOL2WwXKMkqlZX6wUQQ6MwqMeR5NI46AhAiQFt0R8fk=;
        b=c+nu4vtO+mJqL0W7fDFWd80nKNeQXZLNC4avT3H6DFtFBCKsCNI+/Xcx5u4Moz0mef
         tJX7I0vKqGfiiOwHmcsLPZiq+Bp+miZivn9I373iV+5nYjNdXGBooV5dAgZA42sDhBwp
         RAa9lySbVenpLPBcb+PDI02gGZ8/5AXVgh4FOusBKTYSCpujI4W41Bvs9lx/xnxui1cL
         p9VF9R1U4n64Q8PpMdtKtB1hlxB7KJ2lO3ognuM2fPLDFePLcSNYbsYl+lvmlh1Mnwak
         Fuj8IkSGxCWqrWo/PSCUqxm49SSEoja5dmdGHp8oWKmzKkDyy4u/5Pfirmocc+uPzN0V
         o9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOL2WwXKMkqlZX6wUQQ6MwqMeR5NI46AhAiQFt0R8fk=;
        b=IB5JmSAARXTR8k9UkImweYjsI3JJ7D9MCxXkz3DBS33TM2KVexKgmW8H0LTFQM/Fep
         vQNlsrwAw3pfw52a17g9SKaF1gFY+NfBCL2leceIiM4rm9IgCQCQpsK8wWQvmosodKYJ
         dzrLJ6k0G6tgAjauNox/htaKtAN15px40ZpbNBYWECYdfzN0N/q6/hRx/aCIJvGREupU
         KQ4AS8jU1adzDCvlDXgJlvTUGrVERNS0faWDpP5VT3Hz385BT2RBVI6L4Z0yazJiasZi
         lsVWFjIi8RM0q4Yn62ow95jbp2gCTCzwv1BQfZRp91pJvOrpTlssNzw9wGv0lv7JRlIP
         EQCQ==
X-Gm-Message-State: APjAAAVavqDQGq95vYTzigk8iOsEz3FLCsPFA5jits5OmLUQK+9w0/cB
        RCgEXFmWwrej1c5gITLVNWY=
X-Google-Smtp-Source: APXvYqwURFbvadsjM8yhtZLmDVxnsZK14DaAfPq8tFyanA5Uc6CobSzma1LQagRMoEn6yPCP6+rw1g==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr3193411wrq.37.1574956999474;
        Thu, 28 Nov 2019 08:03:19 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id g21sm25945451wrb.48.2019.11.28.08.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:03:18 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM behaviour on sleep
Date:   Thu, 28 Nov 2019 17:03:13 +0100
Message-Id: <20191128160314.2381249-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128160314.2381249-1-thierry.reding@gmail.com>
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Currently the driver PM core will automatically acquire a runtime PM
reference for devices before system sleep is entered. This is needed
to avoid potential issues related to devices' parents getting put to
runtime suspend at the wrong time and causing problems with their
children.

In some cases drivers are carefully written to avoid such issues and
the default behaviour can be changed to allow runtime PM to operate
regularly during system sleep.

Add helpers to flag devices as being safe to be runtime suspended at
system sleep time.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/base/power/main.c    |  6 ++++--
 drivers/base/power/runtime.c | 16 ++++++++++++++++
 include/linux/pm.h           |  1 +
 include/linux/pm_runtime.h   |  2 ++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 134a8af51511..f8dbf00c703b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1113,7 +1113,8 @@ static void device_complete(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
-	pm_runtime_put(dev);
+	if (!dev->power.always_runtime)
+		pm_runtime_put(dev);
 }
 
 /**
@@ -1896,7 +1897,8 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	 * block runtime suspend here, during the prepare phase, and allow
 	 * it again during the complete phase.
 	 */
-	pm_runtime_get_noresume(dev);
+	if (!dev->power.always_runtime)
+		pm_runtime_get_noresume(dev);
 
 	device_lock(dev);
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 48616f358854..699803984426 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1440,6 +1440,22 @@ void pm_runtime_allow(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_allow);
 
+void pm_runtime_always_allow(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	dev->power.always_runtime = 1;
+	spin_unlock_irq(&dev->power.lock);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_always_allow);
+
+void pm_runtime_always_forbid(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	dev->power.always_runtime = 0;
+	spin_unlock_irq(&dev->power.lock);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_always_forbid);
+
 /**
  * pm_runtime_no_callbacks - Ignore runtime PM callbacks for a device.
  * @dev: Device to handle.
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e057d1fa2469..6133cf496878 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -615,6 +615,7 @@ struct dev_pm_info {
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	unsigned int		memalloc_noio:1;
+	unsigned int		always_runtime:1;
 	unsigned int		links_count;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 22af69d237a6..28204baf01cb 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -46,6 +46,8 @@ extern void pm_runtime_enable(struct device *dev);
 extern void __pm_runtime_disable(struct device *dev, bool check_resume);
 extern void pm_runtime_allow(struct device *dev);
 extern void pm_runtime_forbid(struct device *dev);
+extern void pm_runtime_always_allow(struct device *dev);
+extern void pm_runtime_always_forbid(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
 extern void pm_runtime_irq_safe(struct device *dev);
 extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
-- 
2.23.0

