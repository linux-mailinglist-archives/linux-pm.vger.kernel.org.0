Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1A1EDAE1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jun 2020 03:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFDBxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 21:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgFDBx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 21:53:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10455C08C5C8
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 18:53:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j32so3932612qte.10
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 18:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tud9p3zmcof67j7J04w2IZJcscMQG/mxzuG6n3catS0=;
        b=gvkwNtLeDcKfmolxt47SKJqNLrx96FuiXBbqhr6yL6pkbk+6eAfUdi7Ls635NAFRis
         1ZRTZoZVrji9WfctgIUCfoTMINNQPtGir1JDuraItDR4TWZbcbMtU2S0+2fwUELd77Wy
         bXiEYvBqgPMT4Dc1VEEruvyYf+4RPQtWGwAmPQfnJJOWKuWyT2CpsESBkiwsT0Xj/q5h
         8+de2RsSZmYinEoYcQcEs9UVRYEozaOh+kuah0oajP4qQlqj8s5sh57asM+LRqT4MmOM
         G6DkmlqR928RXVNYALs88O1fJBmUerCcuQM7UsK1zK4qxp8y+hMBAYlEPNTA6+pafGZd
         o6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tud9p3zmcof67j7J04w2IZJcscMQG/mxzuG6n3catS0=;
        b=skfhyWne2hVc16+tQxRxQBEFv7JO3ZqLDkYNl5UXu28UepNJns2fFHy8+zY99zrtQy
         ZRQqiadk8V0c0BTfLTBFchxhaHgSght1BrLLD6KxCK7tqyAGRECgda2oTF7pXuExTgRr
         VU/zYOHitYIm+o9R5JNoIoJEVA3zYS2zj7cT2VW+nwRhpaPwKkuL+1Ugs7pyIxla2WGo
         J3FABBYY3MTSfMlJNTZKE96clJI3UcAm2urCP4UiyF8k/V6NblL7G2Cf1buO6OL/U4IZ
         Uj9GerbwXAVLc3xCT1SnXh20r3nosX3dWL+m1I1OTMrXlW7nnm44WFzO1KHFZD4uv7JZ
         MYTg==
X-Gm-Message-State: AOAM531x+DuSyWESNAgrh/6yg8LBzO8vC0z4cpokRNAPtkQbUtGFOO5w
        Ge8ovkyNyQA7I8dmOM8Yxwq8Dw==
X-Google-Smtp-Source: ABdhPJwZSZlwdqbh/tvDoU4z1M6L05Pn97ctupdyClOzsDYxbB7M2fC/4WCBKJ4VDhth6SO/kz7aGA==
X-Received: by 2002:aed:2237:: with SMTP id n52mr2160281qtc.83.1591235606250;
        Wed, 03 Jun 2020 18:53:26 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id t74sm2986439qka.21.2020.06.03.18.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 18:53:24 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/6] soc: qcom: Extend RPMh power controller driver to register warming devices.
Date:   Wed,  3 Jun 2020 21:53:15 -0400
Message-Id: <20200604015317.31389-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604015317.31389-1-thara.gopinath@linaro.org>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RPMh power control hosts power domains that can be used as
thermal warming devices. Register these power domains
with the generic power domain warming device thermal framework.

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

v5->v6:
	- Moved back registering of warming devices into probe since
	  Bjorn pointed out that now the driver can be initialized as
	  as a module, late_initcall will not work. Thermal framework
	  takes care of binding a cooling device to a thermal zone even
	  if the cooling device is registered before the thermal framework
	  is initialized.

 drivers/soc/qcom/rpmhpd.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index a9c597143525..29e1eb4d11af 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/pd_warming.h>
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -49,6 +50,7 @@ struct rpmhpd {
 	bool		enabled;
 	const char	*res_name;
 	u32		addr;
+	bool		is_warming_dev;
 };
 
 struct rpmhpd_desc {
@@ -90,6 +92,7 @@ static struct rpmhpd sdm845_mx = {
 	.pd = { .name = "mx", },
 	.peer = &sdm845_mx_ao,
 	.res_name = "mx.lvl",
+	.is_warming_dev = true,
 };
 
 static struct rpmhpd sdm845_mx_ao = {
@@ -472,7 +475,19 @@ static int rpmhpd_probe(struct platform_device *pdev)
 					       &rpmhpds[i]->pd);
 	}
 
-	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+	ret = of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+
+	if (ret)
+		return ret;
+
+	if (!of_find_property(dev->of_node, "#cooling-cells", NULL))
+		return 0;
+
+	for (i = 0; i < num_pds; i++)
+		if (rpmhpds[i]->is_warming_dev)
+			of_pd_warming_register(rpmhpds[i]->dev, i);
+
+	return 0;
 }
 
 static struct platform_driver rpmhpd_driver = {
-- 
2.20.1

