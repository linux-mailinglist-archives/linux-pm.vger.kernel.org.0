Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A252D9A49
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 21:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394472AbfJPThg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 15:37:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46734 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394451AbfJPThf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 15:37:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id e66so3349920qkf.13
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SEzzpxn6TNoCaJjNnbG2b9pO7Zr0jWolxxLkxLULV5c=;
        b=jtg46D18bjGRyC40A5rJir1izsa/p65sPjSA6mfWjUIbPAwgAbDKZuoyK3S88fFVaw
         kuXOvBRiVr3prI14Wzpr879D32cekWxy2DfL9VOQ2S1SIbB3nvPiazNqIlkKepocZ5DZ
         laBNkiMBhlGk+kgT37dsdeInOu+lArHA3YkDS712pXc2v6jeK71o8l1wuztqj+wqCoPV
         sZ8vQS0SqkAK3789qvJtMJMZOLtTFDvdKIED6p38HeakzS1elUEavpdgF1ZXo8k0oXoa
         afIKOcKef7hh8Skn3Qb5TDFs2mP8t+6bBhJf0iEclk9Rstsq7HuNJh9zdbn/QS/T/ieW
         VIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SEzzpxn6TNoCaJjNnbG2b9pO7Zr0jWolxxLkxLULV5c=;
        b=mqkRmMbJYrq+9jDn0TNMBTPhnFvsRtIougDQAeJgODSQT6QBAy6u/Y1sAsIAz6kvwp
         Vy2SbIfMavf84b3izUuY/r90x3eshN/R7MHykXVO4pZH7V/oPOVrWmF81yy9XXN9o16K
         tQuKFTA7z+pi198LgTP4xPnd3yN4RnfBpHkycTp1SvhXLA7gefFsw4a2p9NJTujt5end
         9CEA8n/Xxhkehi+78rKcSLw+S4LFaTaUdEFPksJPeUidlRu1M5j+t6dKUFytXd0UMU+q
         zfe3UXcRgwLTSNVWRfKa/2yfuhTKJUfKKhiUW49znt7SdQGzZsC0JGzM5J8RJH4dmMj/
         mSuQ==
X-Gm-Message-State: APjAAAWM8A7dgiqI+2vDNh1wEwWX92awwRXnn3jmpFVu7Ith0QUYEtVz
        9ygKx8KlCVKjiZqx74tj/HFJOA==
X-Google-Smtp-Source: APXvYqx6RScGxFupPIKtDHHoMIuDZWH3t814tbZCS+r0zxMef5n03LF0cipYleH/qNbjnBURIvcaoA==
X-Received: by 2002:a37:f70f:: with SMTP id q15mr39409920qkj.428.1571254652961;
        Wed, 16 Oct 2019 12:37:32 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:32 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] thermal: core: Add late init hook to cooling device ops
Date:   Wed, 16 Oct 2019 15:37:17 -0400
Message-Id: <1571254641-13626-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a hook in thermal_cooling_device_ops to be called after
the cooling device has been initialized and registered
but before binding it to a thermal zone.

In this patch series it is used to hook up a power domain
to the device pointer of cooling device.

It can be used for any other relevant late initializations
of a cooling device as well.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_core.c | 13 +++++++++++++
 include/linux/thermal.h        |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 886e8fa..c2ecb73 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -994,6 +994,19 @@ __thermal_cooling_device_register(struct device_node *np,
 	list_add(&cdev->node, &thermal_cdev_list);
 	mutex_unlock(&thermal_list_lock);
 
+	/* Call into cdev late initialization if defined */
+	if (cdev->ops->late_init) {
+		result = cdev->ops->late_init(cdev);
+		if (result) {
+			ida_simple_remove(&thermal_cdev_ida, cdev->id);
+			put_device(&cdev->device);
+			mutex_lock(&thermal_list_lock);
+			list_del(&cdev->node);
+			mutex_unlock(&thermal_list_lock);
+			return ERR_PTR(result);
+		}
+	}
+
 	/* Update binding information for 'this' new cdev */
 	bind_cdev(cdev);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45659c..e94b3de 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -125,6 +125,7 @@ struct thermal_cooling_device_ops {
 			   struct thermal_zone_device *, unsigned long, u32 *);
 	int (*power2state)(struct thermal_cooling_device *,
 			   struct thermal_zone_device *, u32, unsigned long *);
+	int (*late_init)(struct thermal_cooling_device *);
 };
 
 struct thermal_cooling_device {
-- 
2.1.4

