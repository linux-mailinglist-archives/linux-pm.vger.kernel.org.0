Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F494E8EF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfFUNXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 09:23:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40840 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfFUNXf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 09:23:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so6566493wre.7
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fq+Z50AlOAOovE68oIdAizLRw1Oe4GlAcSjc3Z5IAmg=;
        b=Cy8gsxAuPsWgA60+HCVbZ+nbzkJ6dlQSJjSVksW3OiAEHQUBROFi9UyiWxOUaGvUFx
         HuIGfoWy4Oqmng0EYzN9T0AaggH6lVP/7XJARkS/T9U9Klu6591jGN+U57ZTR1LiXr1c
         sOcYSMoUCEiMdHFihphRgKBFw9928QEYbt3CP05DCmdyHgqpRqZzMXfGgwZkrIKrfaJN
         o3ZpZVctPxxGqqonaD75qt4XOUxuMJSBAawKhGVPIgftzDjSusRc4HWL8Tz6yG2j9sXu
         l3c+2p/Bez1KE92iW8V/vPPJqZ4W0WE6Y84xI4VcQfvliIW0jMhlwaHNVfVGSY6eznZ4
         juuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fq+Z50AlOAOovE68oIdAizLRw1Oe4GlAcSjc3Z5IAmg=;
        b=jMjqd/h822calGpYRN+IpUyT48R2vrX2mZH/moi2hnsy03Bid/E07OPP2EwyhNjdde
         FhLAhsaSe0M6tzrk43EbPlPyxHmO782JAbgdXDUpApJ9zf1kvMa29HiLJUB9/z0119Gw
         jC4XdKLCA/Fp86uia7kqRhGrgcBDRp+T2ptISK9w2Wpu5I2lP0R1gvyGvfshWLfpZXqx
         Hh/K/SYV8PZaq2gPq/UtttwNAoZG53h/ECgl2VOjmwnmeCduj8015dB6PewJBcXARof0
         pazHLOGquFtUEe81BlxZbErO4RwvtKCUtQCfZDvpTi4Do5YRW1LNCcGD6ErOuSV4xiMc
         qShQ==
X-Gm-Message-State: APjAAAXoeeIMEEymYIBxFgKP++iRYW1kwTeIAtfR1rXq8SgHIUhtY2q1
        qLwwVNQvfCzJESvjIIr845QRrA==
X-Google-Smtp-Source: APXvYqyXQ/G4rNGx0EM/Bw+9JQKTF91f36TGVl8rfi0tSILHCQdL+onbnDx+h5JIzzjxLnDFJhNJ/w==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr73752462wrn.94.1561123412645;
        Fri, 21 Jun 2019 06:23:32 -0700 (PDT)
Received: from clegane.local (206.105.129.77.rev.sfr.net. [77.129.105.206])
        by smtp.gmail.com with ESMTPSA id s188sm1981234wmf.40.2019.06.21.06.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:23:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 5/6] thermal/drivers/imx: Remove cooling device usage
Date:   Fri, 21 Jun 2019 15:23:01 +0200
Message-Id: <20190621132302.30414-5-daniel.lezcano@linaro.org>
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
 drivers/thermal/imx_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 6746f1b73eb7..021c0948b740 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -203,7 +203,6 @@ static struct thermal_soc_data thermal_imx7d_data = {
 struct imx_thermal_data {
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *cdev;
 	enum thermal_device_mode mode;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_init_calib() */
@@ -656,6 +655,7 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
 static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 {
 	struct device_node *np;
+	struct thermal_cooling_device *cdev;
 	int ret;
 
 	data->policy = cpufreq_cpu_get(0);
@@ -667,9 +667,9 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 	np = of_get_cpu_node(data->policy->cpu, NULL);
 
 	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
-		data->cdev = cpufreq_cooling_register(data->policy);
-		if (IS_ERR(data->cdev)) {
-			ret = PTR_ERR(data->cdev);
+		cdev = cpufreq_cooling_register(data->policy);
+		if (IS_ERR(cdev)) {
+			ret = PTR_ERR(cdev);
 			cpufreq_cpu_put(data->policy);
 			return ret;
 		}
-- 
2.17.1

