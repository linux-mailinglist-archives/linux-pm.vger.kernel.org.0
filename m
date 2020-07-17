Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20882240B8
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGQQm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgGQQm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 12:42:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D3C0619D2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 09:42:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so7545635wmc.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+3rxnetOPA9YeqWq4tADlvynk7eUReArYRmyXTONGkI=;
        b=VV3akQYOc7tirLe5YfeKr+2LvlfDrzSZOXmAQ6ZPLWiskx350quVklFgQg0yJQkTYa
         eS6EeYav3uMhjFijSpqhTEPwEuX0ujOTKH6b8/dMoxs0MnRXqtq9aCb8Jpu5DQzHRspq
         OGOGm2ggyX0OpAm71tGlpf+ZJpzM5Rqk68pv9hB8KFxXXXW1mrUVJyb8CwfEEsvOY0NR
         rOpFbW8mxW1B3EzOxyUXGWKqUGw7iLtFBtTDsykH8CJ56lkvXhGIXZM+E7/KUsRww/Pr
         k9TOAU8+1ydhyIl8VlQIEBcRFyOT9LC5ToM626vYpnDUE5fRw5IwLhNpcUyfkU7jPNJV
         FFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+3rxnetOPA9YeqWq4tADlvynk7eUReArYRmyXTONGkI=;
        b=pG0HDA2Wb+nG8XH6Yrw0AxFYAfIuPhlUTDoaLTl89cQDmjov4usmo+DEFkJ3vuwLVs
         PBbk7a06g48aqlHJv3XrfYXgridBwO30RQydDpkw9FavasoczQQP0ZG51av7pgIes+Qo
         vgOb2BNjhTpZ5wheCAhUgC9Uwfi1OkhRlz5v2nnnvLVbsAc6g/+NdKmlsoe98upANKmv
         U2ZlDOLTwUWf7A7GnIZLWi2DXtjUz0gbQZhbDYmm69hUXD5vaFBWc85LHm8EYc56Bw0l
         N5AxU1RIaWFrFZmnGh138LOQAJcJ+ys5kIMyb4IwGdYz9WogepCcT7LCin4fc8SJlskD
         g6eA==
X-Gm-Message-State: AOAM533b8M1XxHe7OCUTktWcJ7OikWAcpv/jfhmUTObRqGFPryRFEjff
        ocjPXZXVvstLE+AajSjqUjRwj2FC/m8=
X-Google-Smtp-Source: ABdhPJz6ibl3EXJPZE9ZoeRR4tBj19Pijs9Q+8UEKUdJsN/HGgnGq9Ng0zgSSx9CCXPYISOa2oVzBA==
X-Received: by 2002:a1c:4183:: with SMTP id o125mr10113012wma.101.1595004145968;
        Fri, 17 Jul 2020 09:42:25 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id q5sm15312610wrp.60.2020.07.17.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:42:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        m.szyprowski@samsung.com, amit.kucheria@linaro.org
Subject: [PATCH 1/2] thermal: netlink: Improve the initcall ordering
Date:   Fri, 17 Jul 2020 18:42:16 +0200
Message-Id: <20200717164217.18819-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The initcalls like to play joke. In our case, the thermal-netlink
initcall is called after the thermal-core initcall but this one sends
a notification before the former is initialzed. No issue was spotted,
but it could lead to a memory corruption, so instead of relying on the
core_initcall for the thermal-netlink, let's initialize directly from
the thermal-core init routine, so we have full control of the init
ordering.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c    | 4 ++++
 drivers/thermal/thermal_netlink.c | 3 +--
 drivers/thermal/thermal_netlink.h | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 25ef29123f72..c2e7d7aaa354 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1581,6 +1581,10 @@ static int __init thermal_init(void)
 {
 	int result;
 
+	result = thermal_netlink_init();
+	if (result)
+		goto error;
+
 	mutex_init(&poweroff_lock);
 	result = thermal_register_governors();
 	if (result)
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index dd0a3b889674..42eace7401da 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -641,8 +641,7 @@ static struct genl_family thermal_gnl_family __ro_after_init = {
 	.n_mcgrps	= ARRAY_SIZE(thermal_genl_mcgrps),
 };
 
-static int __init thermal_netlink_init(void)
+int __init thermal_netlink_init(void)
 {
 	return genl_register_family(&thermal_gnl_family);
 }
-core_initcall(thermal_netlink_init);
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index 0ec28d105da5..828d1dddfa98 100644
--- a/drivers/thermal/thermal_netlink.h
+++ b/drivers/thermal/thermal_netlink.h
@@ -6,6 +6,7 @@
 
 /* Netlink notification function */
 #ifdef CONFIG_THERMAL_NETLINK
+int __init thermal_netlink_init(void);
 int thermal_notify_tz_create(int tz_id, const char *name);
 int thermal_notify_tz_delete(int tz_id);
 int thermal_notify_tz_enable(int tz_id);
@@ -23,6 +24,11 @@ int thermal_notify_cdev_delete(int cdev_id);
 int thermal_notify_tz_gov_change(int tz_id, const char *name);
 int thermal_genl_sampling_temp(int id, int temp);
 #else
+static inline int thermal_netlink_init(void)
+{
+	return 0;
+}
+
 static inline int thermal_notify_tz_create(int tz_id, const char *name)
 {
 	return 0;
-- 
2.17.1

