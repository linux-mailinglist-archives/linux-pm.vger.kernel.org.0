Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE618C4DF
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 02:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCTBmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 21:42:16 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46388 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCTBlR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 21:41:17 -0400
Received: by mail-qv1-f68.google.com with SMTP id m2so2166632qvu.13
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lr1Y7KtiXEwRNt5oEJbHw3xmtSZcUrY6dlEwgFNuRHA=;
        b=JoZrZzq9MtCdZRY8h1hIczI93UjeYWLiyWcjBPqgqslk4B+dNR7hCtZIo7jyN6xzmt
         PhtpHWIrRArylYLj/pati/6Okn2ECsDFjNcuTjl/1u2m3eZZvbEsj0JyhcW+Nkf1rQm7
         7vkn6PlDFIgd/DPxZnqmxR9bm0UaGI9/Y/zVDLEmBBjWQaEm0UPOBRyLUpRpyat/lwQ2
         tIKTvYGmmrm/4MH5dCshcNMg2rWoiOfaFroCJC9mULyzd/myHd5i8mf8ZWoFDKvWy3R+
         JmxiYw5Up0VLEHVizPB0QOaKD3/xpnZLsGnlp0Z+8ZFsCkuwJrsbuGlF8/YewmN39dBz
         pLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lr1Y7KtiXEwRNt5oEJbHw3xmtSZcUrY6dlEwgFNuRHA=;
        b=DW5PKz08fZOBMj55iM53DKNDFMGYaOdqvAsdCIzoOjxX9JlSUzpFEOikd9gyX7lwlI
         A8hbesmf7FPmIXCOlTdBQbRUvxDQUOM5bUqVAF2K8sMjI53rOtPVDTkEy4MiNq6VeUGv
         JaSxCdb7f3xTNO4HpTvGq3JfKnEtBYS8s6YzjncqB8nnRglZAV/n08NJCgzklggf6Kuf
         YgTQFALt/tkclAQ2Hsg1cxk/ztsVwHkufBttz5PTGP9b0esvHAohfJcmGgZUSDWb4xv7
         IUYWhJRcO89o00YkJ6sahOHxV7yvG/yj5DNjzvHIQ8s0Qj90G4P7UGKVCmLraR+9tDwg
         e2/w==
X-Gm-Message-State: ANhLgQ0VAl+z5ux30L5WqPQGBYwz/f6HmRA861uh4xVmhDeNda8tmVI8
        ai3frtCagTtBRldtBrsR4cCzhQ==
X-Google-Smtp-Source: ADFU+vvtDmCrjDHyAveZQW2W4i/gOJjiWwSRbwpOR4ID352DOyHj0eK14rldf7txaLpbXuc8IAZf1Q==
X-Received: by 2002:a05:6214:12c1:: with SMTP id s1mr5757053qvv.150.1584668475089;
        Thu, 19 Mar 2020 18:41:15 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 2sm2706287qtp.33.2020.03.19.18.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:41:14 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v5 4/6] soc: qcom: Extend RPMh power controller driver to register warming devices.
Date:   Thu, 19 Mar 2020 21:41:05 -0400
Message-Id: <20200320014107.26087-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320014107.26087-1-thara.gopinath@linaro.org>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RPMh power control hosts power domains that can be used as
thermal warming devices. Register these power domains
with the generic power domain warming device thermal framework.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v3->v4:
	- Introduce a boolean value is_warming_dev in rpmhpd structure to
	  indicate if a generic power domain can be used as a warming
	  device or not.With this change, device tree no longer has to
	  specify which power domain inside the rpmh power domain provider
	  is a warming device.
	- Move registering of warming devices into a late initcall to
	  ensure that warming devices are registered after thermal
	  framework is initialized.

 drivers/soc/qcom/rpmhpd.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 7142409a3b77..4e9c0bbb8826 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/pd_warming.h>
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -48,6 +49,7 @@ struct rpmhpd {
 	bool		enabled;
 	const char	*res_name;
 	u32		addr;
+	bool		is_warming_dev;
 };
 
 struct rpmhpd_desc {
@@ -55,6 +57,8 @@ struct rpmhpd_desc {
 	size_t num_pds;
 };
 
+const struct rpmhpd_desc *global_desc;
+
 static DEFINE_MUTEX(rpmhpd_lock);
 
 /* SDM845 RPMH powerdomains */
@@ -89,6 +93,7 @@ static struct rpmhpd sdm845_mx = {
 	.pd = { .name = "mx", },
 	.peer = &sdm845_mx_ao,
 	.res_name = "mx.lvl",
+	.is_warming_dev = true,
 };
 
 static struct rpmhpd sdm845_mx_ao = {
@@ -452,7 +457,14 @@ static int rpmhpd_probe(struct platform_device *pdev)
 					       &rpmhpds[i]->pd);
 	}
 
-	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+	ret = of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+
+	if (ret)
+		return ret;
+
+	global_desc = desc;
+
+	return 0;
 }
 
 static struct platform_driver rpmhpd_driver = {
@@ -469,3 +481,26 @@ static int __init rpmhpd_init(void)
 	return platform_driver_register(&rpmhpd_driver);
 }
 core_initcall(rpmhpd_init);
+
+static int __init rpmhpd_init_warming_device(void)
+{
+	size_t num_pds;
+	struct rpmhpd **rpmhpds;
+	int i;
+
+	if (!global_desc)
+		return -EINVAL;
+
+	rpmhpds = global_desc->rpmhpds;
+	num_pds = global_desc->num_pds;
+
+	if (!of_find_property(rpmhpds[0]->dev->of_node, "#cooling-cells", NULL))
+		return 0;
+
+	for (i = 0; i < num_pds; i++)
+		if (rpmhpds[i]->is_warming_dev)
+			of_pd_warming_register(rpmhpds[i]->dev, i);
+
+	return 0;
+}
+late_initcall(rpmhpd_init_warming_device);
-- 
2.20.1

