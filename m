Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3AC2173DB
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGGQYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 12:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgGGQY3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 12:24:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA363C061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 09:24:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m9so8382925pfh.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5qLlzv2IdrRVupqKqhulZt6939J+XBU60CiFxmM7cU=;
        b=VQXfal6SP48mb+vig4iHdom3I2bB3mnJ44t9z32OcHIh1Nr57lzNzH42xrgkRUiF/w
         GnrEUHLPWufx2Smn911xp8Ln7oxiyrNsVjYM6SKl3dAaOKQIW1UZR7Ay2+MA3gkD8xUq
         kTfdRupNbe3AbhnA8wa+W1HyqMOsP99kfS9yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5qLlzv2IdrRVupqKqhulZt6939J+XBU60CiFxmM7cU=;
        b=PRwUBkaBlq5pU7G04kUkzBQbYG0MPZ9D9y3/dIK2TEdMWTd7ERDhhJOlKM0ixBLMeQ
         f0RiQOX2q0m8No14OfdxiRp9Y791bHJ0tvyBf1mK5bEJ9oHSMOF3SNPyOBNVQ7NLE4lj
         Wkvd6wEa14UJncRFnhFcIcNifmZpqhXG0xETT6dJcIGXV+/Z3nsYWwsor+MnCiuIY2fa
         cBUVJMZko5VPT2R+jugHxlrlGY7cNKIzmCGAI8Z1Sn/A7EkBGbMBbp0DUV4AgZo7Sxsy
         jwNAFRi6WtJt2y21u2feeRKElXp/DaY/vF5SwpbN8/LKIBvRavGaQaD0je6q6Z7JI2tv
         ZssA==
X-Gm-Message-State: AOAM533Q1oT+sNseIlEVOyE2kPqAQ6RCwydxxWJB+l0Yaq+udWHsKlrN
        TAUuBjWXJdIK3j0MFrwHMqPqMQ==
X-Google-Smtp-Source: ABdhPJwPoRk7OUCfAEPQBUn0rnvuerUwTtUvOtQLNJJOujLrkHwMcXQ6UE6f2EqOSWu4FnD7yqLVeg==
X-Received: by 2002:a63:3508:: with SMTP id c8mr46959312pga.9.1594139069345;
        Tue, 07 Jul 2020 09:24:29 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id s10sm3758196pjf.3.2020.07.07.09.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:24:28 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v4 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
Date:   Tue,  7 Jul 2020 09:24:17 -0700
Message-Id: <20200707092406.v4.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200707162417.3514284-1-abhishekpandit@chromium.org>
References: <20200707162417.3514284-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Udev rules that depend on the power/wakeup attribute don't get triggered
correctly if device_set_wakeup_capable is called after the device is
created. This can happen for several reasons (driver sets wakeup after
device is created, wakeup is changed on parent device, etc) and it seems
reasonable to emit a changed event when adding or removing attributes on
the device.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4:
- Fix warning where returning from void and tested on device

Changes in v3:
- Simplified error handling

Changes in v2:
- Add newline at end of bt_dev_err

 drivers/base/power/sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 24d25cf8ab1487..aeb58d40aac8de 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* sysfs entries for device PM */
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/export.h>
 #include <linux/pm_qos.h>
@@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 
 int wakeup_sysfs_add(struct device *dev)
 {
-	return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
+	int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
+
+	if (ret)
+		return ret;
+
+	return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 }
 
 void wakeup_sysfs_remove(struct device *dev)
 {
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
+	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 }
 
 int pm_qos_sysfs_add_resume_latency(struct device *dev)
-- 
2.27.0.212.ge8ba1cc988-goog

