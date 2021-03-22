Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E969343AA9
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 08:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCVHhE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 03:37:04 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:41730 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhCVHgf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 03:36:35 -0400
Received: by mail-lj1-f175.google.com with SMTP id f26so19797761ljp.8;
        Mon, 22 Mar 2021 00:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BsY7YkuLSTkyifbDrF2JneCtTyzv1UBxYFrackx4xR8=;
        b=IhOnuVsAx+u19l0irWWmAI242FipU3nv1FIXSMOypMKnliHLr8Zj4smAy901S4u0D8
         ULPP3KiHLL8oeCX2Jlwb9ztpO6ECPHMFqCZfkntMD+/+fadd/ogdWh64SiJWnX0Mc7KF
         6ZAo0Fc3RsE9xzvsr9fwX6NlkyP6KV72Fj87KzPj0E+E7jWOt5hOkqbcLNgoOgV6JvYq
         d/eOtZpOCsXqq3R7hVSNOtgXnPj1rGdCRxUjBQUPhM42gcbBC47BiDGqNjnD0BldMWAQ
         uXLeHJlwdvB5+ho8isWuiy+Nc1yO/cQOBTCeGN5kouXGs911nip+yeCsgVSimqoZd1nf
         C1kQ==
X-Gm-Message-State: AOAM532Es5MBKEOGXv6d7Xw7mjqCypvjDeueFT1TDPgxiuvpRMRaxef9
        jEgUlJ0er5Se21qVQkW51vk=
X-Google-Smtp-Source: ABdhPJxZxKHSrUcrA+MxAaS9GKwnd6qja3nJ+fWL6807Hq21OSBs4TyQ9jeAqiqK9DZHnbgngykUjw==
X-Received: by 2002:a2e:3015:: with SMTP id w21mr8897322ljw.120.1616398593654;
        Mon, 22 Mar 2021 00:36:33 -0700 (PDT)
Received: from localhost.localdomain (mobile-access-5673b7-246.dhcp.inet.fi. [86.115.183.246])
        by smtp.gmail.com with ESMTPSA id d27sm394446lfv.226.2021.03.22.00.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:36:33 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:36:27 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
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
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [RFC RESEND PATCH v2 1/8] workqueue: Add resource managed version of
 delayed work init
Message-ID: <51769ea4668198deb798fe47fcfb5f5288d61586.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few drivers which need a delayed work-queue must cancel work at driver
detach. Some of those implement remove() solely for this purpose. Help
drivers to avoid unnecessary remove and error-branch implementation by
adding managed verision of delayed work initialization. This will also
help drivers to avoid mixing manual and devm based unwinding when other
resources are handled by devm.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 include/linux/devm-helpers.h | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 include/linux/devm-helpers.h

diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
new file mode 100644
index 000000000000..f64e0c9f3763
--- /dev/null
+++ b/include/linux/devm-helpers.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_DEVM_HELPERS_H
+#define __LINUX_DEVM_HELPERS_H
+
+/*
+ * Functions which do automatically cancel operations or release resources upon
+ * driver detach.
+ *
+ * These should be helpful to avoid mixing the manual and devm-based resource
+ * management which can be source of annoying, rarely occurring,
+ * hard-to-reproduce bugs.
+ *
+ * Please take into account that devm based cancellation may be performed some
+ * time after the remove() is ran.
+ *
+ * Thus mixing devm and manual resource management can easily cause problems
+ * when unwinding operations with dependencies. IRQ scheduling a work in a queue
+ * is typical example where IRQs are often devm-managed and WQs are manually
+ * cleaned at remove(). If IRQs are not manually freed at remove() (and this is
+ * often the case when we use devm for IRQs) we have a period of time after
+ * remove() - and before devm managed IRQs are freed - where new IRQ may fire
+ * and schedule a work item which won't be cancelled because remove() was
+ * already ran.
+ */
+
+#include <linux/device.h>
+#include <linux/workqueue.h>
+
+static inline void devm_delayed_work_drop(void *res)
+{
+	cancel_delayed_work_sync(res);
+}
+
+/**
+ * devm_delayed_work_autocancel - Resource-managed work allocation
+ * @dev: Device which lifetime work is bound to
+ * @pdata: work to be cancelled when driver is detached
+ *
+ * Initialize work which is automatically cancelled when driver is detached.
+ * A few drivers need delayed work which must be cancelled before driver
+ * is detached to avoid accessing removed resources.
+ * devm_delayed_work_autocancel() can be used to omit the explicit
+ * cancelleation when driver is detached.
+ */
+static inline int devm_delayed_work_autocancel(struct device *dev,
+					       struct delayed_work *w,
+					       work_func_t worker)
+{
+	INIT_DELAYED_WORK(w, worker);
+	return devm_add_action(dev, devm_delayed_work_drop, w);
+}
+
+#endif
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
