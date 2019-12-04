Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD3511374C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 22:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfLDV43 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 16:56:29 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43007 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfLDV42 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 16:56:28 -0500
Received: by mail-pg1-f202.google.com with SMTP id x189so552693pgd.9
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 13:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=NAupc/vR8bVWuaMCvX72N/qStHFA90T0ir1IJdUyDdE=;
        b=sbU0t/KzGn2j9p0ayPj+KQNR/KUydw26BP24k17+yr+P4OCHLehU0UBTL/B2Abr+/2
         sQf5fD9mTwnZooHzWk0YZlJXAWEb6f/7Dl2oRN90wghJoWjU1+h309N4d0U4PBHtycjQ
         UXk+UrCUxUqY9RTQNkYfFeqxqIS46oUAo4BZbnFiVoP6yJjiTBK1PFEPvuICfFtbrpss
         mdU+l9/cNMdnFQ3do4so/sm9xyh7Z+MNh4eU0a+QhACZ9wCqQ4mjLA9ZOIS+Dgu3D23W
         rNyRmVb3lUx1so88I8VXF4i54g1OA8QcfKt3BkPTiikWozM40GsdcSzXZP5zA7q/4jTL
         XD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=NAupc/vR8bVWuaMCvX72N/qStHFA90T0ir1IJdUyDdE=;
        b=JFstfmyfNrBEQVsYo6AOg9071tPmVmKwtbUSJ7PWdbSSJ97liTyAEQrdcB15oswFSk
         qXpMpP5U3tNR140bXS3TOisr78L8i+qR6WHE/g1T1HqIw4q4sHPWnbem3Sd1dyj14Lvo
         1F2/nURwEyhYie4SToEhkc56mFEwdy1OJhiUNH9aqa7o9mbN58v2WgocvXxxn/K3xfn9
         CN/kufK9nKnJWVxrQ1AJUf7gTljF3/0E7v0NpUqp4Q9799SdHKaoVV3Hm6X0byEvont/
         /b6YR6QNYO2LX2tjC5Om9lugs/yO0954WXX9hGYAlbaCWr8yLIMD2W0mjcLmy2FO/AeZ
         +rNg==
X-Gm-Message-State: APjAAAVF2B+YO0JIe5astiBCXmZqBvE9dJ5wviegqG2bMWqQzIrl/Zn3
        8pVy3byXFEG5RyCW74Vt9yTDoGg=
X-Google-Smtp-Source: APXvYqxXKUmGZWwlHDbL9ugwrz5hieTgw+FpXeR0Lks6uU8kJqHa5r4R0hgTQHw9EpKYr33quBhpHh0=
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr5708130pgs.396.1575496587829;
 Wed, 04 Dec 2019 13:56:27 -0800 (PST)
Date:   Wed,  4 Dec 2019 13:56:17 -0800
In-Reply-To: <20191204215618.125826-1-wvw@google.com>
Message-Id: <20191204215618.125826-2-wvw@google.com>
Mime-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
 <20191204215618.125826-1-wvw@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2 1/2] thermal: fix and clean up tz and cdev registration
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make cooling device registration behavior consistent with
thermal zone. This patch also cleans up a unnecessary
nullptr check.

Signed-off-by: Wei Wang <wvw@google.com>
---
 drivers/thermal/thermal_core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4481cc8958f..64fbb59c2f44 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -954,8 +954,16 @@ __thermal_cooling_device_register(struct device_node *np,
 	struct thermal_zone_device *pos = NULL;
 	int result;
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
-		return ERR_PTR(-EINVAL);
+	if (!type || !type[0]) {
+	    pr_err("Error: No cooling device type defined\n");
+	    return ERR_PTR(-EINVAL);
+	}
+
+	if (strlen(type) >= THERMAL_NAME_LENGTH) {
+	    pr_err("Error: Cooling device name (%s) too long, "
+		   "should be under %d chars\n", type, THERMAL_NAME_LENGTH);
+	    return ERR_PTR(-EINVAL);
+	}
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
 	    !ops->set_cur_state)
@@ -972,7 +980,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	}
 
 	cdev->id = result;
-	strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
+	strlcpy(cdev->type, type, sizeof(cdev->type));
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
 	cdev->np = np;
@@ -1250,7 +1258,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
+	if (strlen(type) >= THERMAL_NAME_LENGTH) {
 		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
 		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
-- 
2.24.0.393.g34dc348eaf-goog

