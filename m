Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D134B7ECF5
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbfHBGzw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 02:55:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36104 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389177AbfHBGzw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 02:55:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so35522842pfl.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 23:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2A7aCPKk6mS2mwCaQ9tN7cyd1W6l/kKs9HodzX2zX+c=;
        b=KPyoW8E45yaL4xs6t0Jkv+CW3x3yezufRzS6w6RVMneP/5f+L5GYnmh1ofbWNNlxhy
         SS92sNv9JR8GT0u7P2SOAZ2VXrUz40MclxXPs/v8Glp8HnJ+OC88rAT1fEVykrRmNpEZ
         LncucOIgitx/hgWyBRUQw/9H+vh93Ff2HYqVzBuPJPudEzDLTW3bntCQgFA5DtTv/PeF
         7KcV02kq+odvT3tNpIDiW+JCrehDPgrHZ+0yBf5J+3T3OGNa9XFNUSXPrLdufL6rpSha
         Ndp0JhSwOTwZb6iamWiYRCYFtFG69/4qkxmIq2MhgrE2dzzW4c0zkzeDLrbqwPGLJ6M2
         B1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2A7aCPKk6mS2mwCaQ9tN7cyd1W6l/kKs9HodzX2zX+c=;
        b=DMbSmxR2zIZZj801nTgT/65DGOlV4oc5M9mvwCxhX94/6WApGE4+aTObcJZX69dk2Q
         dfwnLEaqFL7oDRJOG7vr//dkmmidqexosLNU3ODpkJqznViCnlPu5WZqhkbeVZkqeaMc
         Ub4W2Q0diguUqJOR4XAjVZmEoSnW2Q27ZdI4SpILwghewJamFcZgsFoYJ5ul+uKRqYSg
         wp/7vu8J6C1EJJNzj6fdwSzk+bvt7NyChEeAHXL8fU5eYj/XvRtKQoNdvez6s50s7hf+
         W/dScN5EkG6ntLq/BjWdYL/E8R0wITg3t+hSQ0bCTS3Ju+AmKDTWJW+jYlPiDFw+nQtd
         6Aug==
X-Gm-Message-State: APjAAAUYKgwfVr1/k5lAwF9dzTpk05vxOfjgwTAMT3SAR5zlQcx1uo4q
        HNNnF2SSFF+6iY2cxdyvQNs=
X-Google-Smtp-Source: APXvYqyby+Zyx7I9niw03Jc1TLTHB6oqegWL++iNi2S3T/eqytVqAlfJxt2CNygYkqCn34yPjKWOXw==
X-Received: by 2002:aa7:93bb:: with SMTP id x27mr59775860pff.10.1564728951408;
        Thu, 01 Aug 2019 23:55:51 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id c70sm31820230pfb.36.2019.08.01.23.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 23:55:50 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com, zhangwen@yulong.com
Subject: [PATCH] thermal/drivers/core: Use put_device() if device_register() fails
Date:   Fri,  2 Aug 2019 14:55:20 +0800
Message-Id: <20190802065520.3744-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Never directly free @dev after calling device_register(), even if it
returned an error! Always use put_device() to give up the reference
initialized.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/thermal/thermal_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6bab66e..ffe5d8e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -985,7 +985,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 	result = device_register(&cdev->device);
 	if (result) {
 		ida_simple_remove(&thermal_cdev_ida, cdev->id);
-		kfree(cdev);
+		put_device(&cdev->device);
 		return ERR_PTR(result);
 	}
 
@@ -1292,7 +1292,7 @@ struct thermal_zone_device *
 	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
 	if (result)
-		goto remove_device_groups;
+		goto release_device;
 
 	for (count = 0; count < trips; count++) {
 		if (tz->ops->get_trip_type(tz, count, &trip_type))
@@ -1347,8 +1347,11 @@ struct thermal_zone_device *
 	device_unregister(&tz->device);
 	return ERR_PTR(result);
 
-remove_device_groups:
-	thermal_zone_destroy_device_groups(tz);
+release_device:
+	ida_simple_remove(&thermal_tz_ida, tz->id);
+	put_device(&tz->device);
+	return ERR_PTR(result);
+
 remove_id:
 	ida_simple_remove(&thermal_tz_ida, tz->id);
 free_tz:
-- 
1.9.1

