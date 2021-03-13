Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC09339A56
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 01:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhCMALu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 19:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMALg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 19:11:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7EC061574
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 16:11:36 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so5304108wmq.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 16:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lmV+XFFuguRxzGXkG/gkv+9ezvwT+03zZXAFkwK/P+0=;
        b=yIIdhzKQMwauxAGbzV4U2FS+PGaufjocUfa4ZKQWdIAjKSJ2BCcOCbK7E87q9PkY9v
         fqQZ4vgLSiTh1pw6BerzSL1a6NG+KHd+KfsbhAn1xnCDBr+hN6tnQB2iYrX2fyLkagHa
         1uNLqiSYZYrSQY7arA7UcVls/Q95wPvq+FYRSV8RcCWG/t2R2M626Asea8wl6fdZG+9w
         uIiABh/0+c8kBvlhz/jA42OujMtJFJkeRttwNT3UwK5TrIpgIKYLVR+d9EppTGnW6DlC
         v7f71qNpJ0BA8ns27ZVw8tkvEXAbbxxx8il9adi8yT44b8oMHmCkjUJxlMQHK2n/XHrx
         laSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lmV+XFFuguRxzGXkG/gkv+9ezvwT+03zZXAFkwK/P+0=;
        b=Cvrx5KMBmD406IInLNGKA/4vjBssfoB/h/CxzJctJ1rk5wDVjK/RyTxDk/paMS/uqy
         kzEgfPyMiMlI4cBuBiWPFKA7S0ql+UlGtqwrM3LinlPTsowDSIuDzeK6S8gvnuACZqfu
         /c5ZYTJ+jP6Kf8s11vWWOj4HtHVP+a2I2WMmVM+eU5wVQBefXt0jnuIpA/F2YvBArKIU
         lJvihsl04MGJe+aMt07eLFH6aSKgk2JkEZjpHvLa9GJB/ioEbEJ4kvh9By5ESRk/laOA
         wjAeumF1xHdvBxhCVBcxNUlfkQTsQY6CMdMQiSO4BHxEWpHy0+HcM/P0V5jeGvuJ54Zx
         Rsdg==
X-Gm-Message-State: AOAM5329XgOzEJD4Aofvlb+VAdUB9oLE3wPFLtkxXKpSq6rY2G5A1B+r
        GAnmVVZQwtdGfft214b0ymHK1Q==
X-Google-Smtp-Source: ABdhPJykOSoBgpK1zijOXuzz3Lyb25Ak4j6bnaRNCxFGU28gD4XRH2ydrIPWat0QCGL6LgYr7dp0IA==
X-Received: by 2002:a1c:1b43:: with SMTP id b64mr15570568wmb.79.1615594295028;
        Fri, 12 Mar 2021 16:11:35 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id a6sm4613813wmm.0.2021.03.12.16.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 16:11:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH 1/2] powercap/drivers/dtpm: Export the symbols for the modules
Date:   Sat, 13 Mar 2021 01:11:04 +0100
Message-Id: <20210313001105.7568-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DTPM framework provides a generic API to register devices which
power capable. The devices may be compiled as modules while the
framework is not.

Export the necessary API to let the drivers register themselves.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index a4784ac2f79b..69fb5a8e9822 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -202,6 +202,7 @@ struct dtpm *dtpm_get(const char *name)
 
 	return dtpm;
 }
+EXPORT_SYMBOL_GPL(dtpm_get);
 
 static void dtpm_release(struct kref *kref)
 {
@@ -221,6 +222,7 @@ void dtpm_put(struct dtpm *dtpm)
 {
 	kref_put(&dtpm->kref, dtpm_release);
 }
+EXPORT_SYMBOL_GPL(dtpm_put);
 
 /**
  * dtpm_register - Register the dtpm in the dtpm list
@@ -266,6 +268,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dtpm_register);
 
 /**
  * dtpm_unregister - Remove the dtpm device from the list
@@ -295,6 +298,7 @@ void dtpm_unregister(const char *name)
 
 	mutex_unlock(&dtpm_lock);
 }
+EXPORT_SYMBOL_GPL(dtpm_unregister);
 
 /**
  * dtpm_update_power - Update the power on the dtpm
@@ -315,6 +319,7 @@ int dtpm_update_power(struct dtpm *dtpm)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dtpm_update_power);
 
 /**
  * dtpm_release_zone - Cleanup when the node is released
@@ -515,6 +520,7 @@ void dtpm_init(struct dtpm *dtpm, struct dtpm_ops *ops)
 		dtpm->ops = ops;
 	}
 }
+EXPORT_SYMBOL_GPL(dtpm_init);
 
 /**
  * dtpm_destroy - Destroy a dtpm node from the hierarchy tree
@@ -530,6 +536,7 @@ void dtpm_destroy(struct dtpm *dtpm)
 
 	pr_info("Destroyed dtpm node '%s'\n", dtpm->zone.name);
 }
+EXPORT_SYMBOL_GPL(dtpm_destroy);
 
 /**
  * dtpm_create - Create a dtpm node in the hierarchy tree
@@ -604,6 +611,7 @@ int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dtpm_create);
 
 static int __init init_dtpm(void)
 {
-- 
2.17.1

