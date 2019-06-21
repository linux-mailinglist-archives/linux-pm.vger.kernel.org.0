Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587324E8F1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFUNXh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 09:23:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39049 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFUNXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 09:23:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so6606360wma.4
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hWOyvG8gK3Yd2gZuZPX+zS+OzCMre8gWSxnhV9rJDR4=;
        b=c36ZpSewLyxdsNlrsvfl54dP1d3jg1M3kR6dJKnAlk5Kh6PlPsU1RM1YhgbelAsiB8
         KpDVG6V6mFy2Emmx9iXwPq8EIC6KiyewIFRtn7C86MwlueFkplHP1GF74Vi4K12kxjIB
         x2I3j7ScntkAxx19yk6Z339XPBZ1fQkRdWTGiUJ3xsUlU79u9TGcvn2+CrijnwNf2JiF
         u9o421T2miZQiLckihrPw66oLEHr1elWqUNNCGt020T49WC32Jsb5xkOQTHBdFQpYeTU
         G3D+d7LeI1PWxZ2zpYpm8PnS4+UsS0KRK3B6tZGx66Xw5HHqzyGTQbJbQjUz6uvy0yvh
         rIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hWOyvG8gK3Yd2gZuZPX+zS+OzCMre8gWSxnhV9rJDR4=;
        b=AarZOqBh4q70jjJtLLXUaOy332NIMbOZwqzdhYqeT+QAkCJopXcarj9Ay7/31bEDuo
         A74NLNtiVAunQTfjyOxAdYf4PTdAXplws36Qsrpm9wu2qAaqc5RZsDPMw6vFxLmkiVbk
         gmBKIj1pQ7YMEgvz7eWGuLiVKmjO6dlDXxqO2FE1nrme+26SlSxPNbDXdldOHoihrFwE
         TMNfabo9mJvynHjB4u+g0dYxW0RmciO3sVS2yfWelqNu6yvV0qaqc3xo1DnjtdYPy05T
         Lt28tdbAXFuGK97uT3QqWwZAhu0WbYr7yQO9+yHEQ+05gFwxpa0G55Ur3awebQvxH0dg
         TXRQ==
X-Gm-Message-State: APjAAAU5ZWJDvPe04WFB9oY7iXb1PZ1YLZr9g3Ph3hL35kPYHNB62SrF
        pRyihVlAbHywDVp08Kd9eha0Pg==
X-Google-Smtp-Source: APXvYqy3Q4/KfwLZiWac+IHlKAnk7Sl69mV+esSGzR2nnxIARsD/wBgEhPqG7TrBrUdnQkcJUBT6jw==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr4066497wmb.88.1561123414277;
        Fri, 21 Jun 2019 06:23:34 -0700 (PDT)
Received: from clegane.local (206.105.129.77.rev.sfr.net. [77.129.105.206])
        by smtp.gmail.com with ESMTPSA id s188sm1981234wmf.40.2019.06.21.06.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:23:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH 6/6] thermal/drivers/ti: Remove cooling device usage
Date:   Fri, 21 Jun 2019 15:23:02 +0200
Message-Id: <20190621132302.30414-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621132302.30414-1-daniel.lezcano@linaro.org>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq_cooling_unregister() function uses now the policy to
unregister itself. The only purpose of the cooling device pointer is
to unregister the cpu cooling device.

As there is no more need of this pointer, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 217b1aae8b4f..170b70b6ec61 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -41,7 +41,6 @@ struct ti_thermal_data {
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *ti_thermal;
 	struct thermal_zone_device *pcb_tz;
-	struct thermal_cooling_device *cool_dev;
 	struct ti_bandgap *bgp;
 	enum thermal_device_mode mode;
 	struct work_struct thermal_wq;
@@ -233,6 +232,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 {
 	struct ti_thermal_data *data;
 	struct device_node *np = bgp->dev->of_node;
+	struct thermal_cooling_device *cdev;
 
 	/*
 	 * We are assuming here that if one deploys the zone
@@ -256,9 +256,9 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 	}
 
 	/* Register cooling device */
-	data->cool_dev = cpufreq_cooling_register(data->policy);
-	if (IS_ERR(data->cool_dev)) {
-		int ret = PTR_ERR(data->cool_dev);
+	cdev = cpufreq_cooling_register(data->policy);
+	if (IS_ERR(cdev)) {
+		int ret = PTR_ERR(cdev);
 		dev_err(bgp->dev, "Failed to register cpu cooling device %d\n",
 			ret);
 		cpufreq_cpu_put(data->policy);
-- 
2.17.1

