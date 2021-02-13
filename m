Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743E531AB28
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 13:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhBML7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 06:59:45 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:41921 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBML7g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2021 06:59:36 -0500
Received: by mail-lj1-f181.google.com with SMTP id e17so2145556ljl.8;
        Sat, 13 Feb 2021 03:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Og3EKyxPUKMGfzz8yqu0JBwP+v96RpWUBQsEZbrHD+8=;
        b=inRjugq8dZYlJ6CKvLuFRZuygDwWgg/eI1qK0UtvZC5aXeTHWXAZnh4CmXIvaUpdET
         RZbmyLvO2Jgjrc8l/m7pxQ6AQfapVpdoTDVR72Z3a3f2BFyr5+VCS57NzbTlVjVIKga6
         PWwfLi6Ytk0GX9K3QgfsxOUXNqecAQaYp8Ri+Z0dNzn9zCQd5KJ9+TTG7fZ973FNzx6k
         d/hPzIS96BCawHPV9lkFNxvvqKXl7tnRfA12eivyl0Zn56uwyCHdacF0JNqDawGw395+
         X3reRIZlP3l4ffScErusYdied3SeyAqU1qQEBxYPIsBUMPKUkViW4qjtO8v51+ZvPj2l
         vIHg==
X-Gm-Message-State: AOAM5311BlORlGJ4wtfdqkHqgDcrgZjlZFL437zEnwtxdQcCWfr5k3Je
        sarltkWfCO+KaWsm9Jx+z1g=
X-Google-Smtp-Source: ABdhPJxj3xe2a6po48BGrT8aKajunBGOzOMxU/3dhpzzTPYFHT/e8seZG86Yo2/QJ4xnTqfESId53w==
X-Received: by 2002:a2e:7a18:: with SMTP id v24mr4030132ljc.55.1613217533531;
        Sat, 13 Feb 2021 03:58:53 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id v72sm1838780lfa.77.2021.02.13.03.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 03:58:52 -0800 (PST)
Date:   Sat, 13 Feb 2021 13:58:44 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Message-ID: <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few drivers which need a delayed work-queue must cancel work at exit.
Some of those implement remove solely for this purpose. Help drivers
to avoid unnecessary remove and error-branch implementation by adding
managed verision of delayed work initialization

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/base/devres.c  | 33 +++++++++++++++++++++++++++++++++
 include/linux/device.h |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index fb9d5289a620..2879595bb5a4 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1231,3 +1231,36 @@ void devm_free_percpu(struct device *dev, void __percpu *pdata)
 			       (void *)pdata));
 }
 EXPORT_SYMBOL_GPL(devm_free_percpu);
+
+static void dev_delayed_work_drop(struct device *dev, void *res)
+{
+	cancel_delayed_work_sync(*(struct delayed_work **)res);
+}
+
+/**
+ * devm_delayed_work_autocancel - Resource-managed work allocation
+ * @dev: Device which lifetime work is bound to
+ * @pdata: work to be cancelled when device exits
+ *
+ * Initialize work which is automatically cancelled when device exits.
+ * A few drivers need delayed work which must be cancelled before driver
+ * is unload to avoid accessing removed resources.
+ * devm_delayed_work_autocancel() can be used to omit the explicit
+ * cancelleation when driver is unload.
+ */
+int devm_delayed_work_autocancel(struct device *dev, struct delayed_work *w,
+				 void (*worker)(struct work_struct *work))
+{
+	struct delayed_work **ptr;
+
+	ptr = devres_alloc(dev_delayed_work_drop, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(w, worker);
+	*ptr = w;
+	devres_add(dev, ptr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_delayed_work_autocancel);
diff --git a/include/linux/device.h b/include/linux/device.h
index 1779f90eeb4c..192456198de7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -27,6 +27,7 @@
 #include <linux/uidgid.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
+#include <linux/workqueue.h>
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
 #include <linux/device/driver.h>
@@ -249,6 +250,10 @@ void __iomem *devm_of_iomap(struct device *dev,
 			    struct device_node *node, int index,
 			    resource_size_t *size);
 
+/* delayed work which is cancelled when driver exits */
+int devm_delayed_work_autocancel(struct device *dev, struct delayed_work *w,
+				 void (*worker)(struct work_struct *work));
+
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
