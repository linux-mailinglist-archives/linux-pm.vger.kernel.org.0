Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD61D5017
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEOOLL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbgEOOLK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 10:11:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F9C061A0C
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 07:11:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k12so2473850wmj.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PKPieQCHF+nm/iYn6FAQVcl/MzY/rRP6qinUb5RW81I=;
        b=Das9pl01gBCsp1gGCbQcY1KZ1UFy97GIBpNJBqvH/Awn51perczGgth8S4CeOAhzAP
         wGe0X1exwRTLH60MlculCA+31NYczsae4pTkldI+iugU0PKRFlmC7+WYDolDVZWOw2lD
         QYh1w4oZrMCCfO+9vGwKudbEGpf3q7AZ1TbsCoSPBUghb1iiSLa7UGX/VWJgPzW6XNQp
         QzNpzf743a5dS89YPm9dMHWJ9DxQ0TOtsgTo+gkJtyzdOPGyjOXBtMCIT2OkEGvmuCWp
         w/C1gOomtr4YvD7lpKGrrfIulHzxFNWC9UdIX3eknuqsLgiO8k4PDD9SZSSYxTQzKoc/
         e+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PKPieQCHF+nm/iYn6FAQVcl/MzY/rRP6qinUb5RW81I=;
        b=IRWhDyf7/ZXX3TGdpZv+79rpLXzqlVHgRwna2vl0jV4dXoWVJxYVrDI0Dh3pwoAcdV
         Eb5Wdic8LA8Oa000WVE+4HECVnFTm2zkWEnSp0bBoWty4b37oyd1oB9IjnK4gQ9I8OLz
         Cob949ksdVSw5lEw7DoGpbmCp11NH/6odRg3KzpgRKSHpsd2nTrFl8PQDxYlPHgtz6vm
         Ref3VifQC30az+6L57OTpggvxM1X7OIVgDKylIQThm58T7+ePsupgRmKxInmwQRQur8G
         Tqa2/ERIUFea9em7VPqKCh9EXV3sY8S7uYvLQRxJjZxpeP5KddAKVGgyVpLheY2HWdxk
         gwzg==
X-Gm-Message-State: AOAM530RHefFt45l1RDqSw/Fo5L/Hx6SwH+4jbvn9JByv1dHRHOfYn2Q
        r1gYEbonOa2qlm5jPCaacDPnWw==
X-Google-Smtp-Source: ABdhPJy9Gia2ZS1ien6LmcmxFdsWEHYPQ+Zkigj3OCeK7I0PgfUjljQPj9SPuCt6ryozsZsXKTdapw==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr4504714wma.159.1589551868914;
        Fri, 15 May 2020 07:11:08 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id d6sm4432438wra.63.2020.05.15.07.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:11:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, srinivas.pandruvada@linux.intel.com,
        arnd@arndb.de, rkumbako@codeaurora.org, ilina@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] thermal: core: Remove old uapi generic netlink
Date:   Fri, 15 May 2020 16:10:32 +0200
Message-Id: <20200515141034.19154-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515141034.19154-1-daniel.lezcano@linaro.org>
References: <20200515141034.19154-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to set the scene for the new generic netlink thermal
management and notifications, let remove the old dead code remaining
in the uapi headers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h      |  5 -----
 include/uapi/linux/thermal.h | 12 +-----------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index faf7ad031e42..fc93a6348082 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -302,11 +302,6 @@ struct thermal_zone_params {
 	int offset;
 };
 
-struct thermal_genl_event {
-	u32 orig;
-	enum events event;
-};
-
 /**
  * struct thermal_zone_of_device_ops - scallbacks for handling DT based zones
  *
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index 96218378dda8..22df67ed9e9c 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -6,21 +6,12 @@
 
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
-#define THERMAL_GENL_VERSION                    0x01
+#define THERMAL_GENL_VERSION                    0x02
 #define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_grp"
 
-/* Events supported by Thermal Netlink */
-enum events {
-	THERMAL_AUX0,
-	THERMAL_AUX1,
-	THERMAL_CRITICAL,
-	THERMAL_DEV_FAULT,
-};
-
 /* attributes of thermal_genl_family */
 enum {
 	THERMAL_GENL_ATTR_UNSPEC,
-	THERMAL_GENL_ATTR_EVENT,
 	__THERMAL_GENL_ATTR_MAX,
 };
 #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
@@ -28,7 +19,6 @@ enum {
 /* commands supported by the thermal_genl_family */
 enum {
 	THERMAL_GENL_CMD_UNSPEC,
-	THERMAL_GENL_CMD_EVENT,
 	__THERMAL_GENL_CMD_MAX,
 };
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
-- 
2.17.1

