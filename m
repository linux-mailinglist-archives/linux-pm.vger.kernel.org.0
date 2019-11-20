Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B99103A74
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfKTM5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:57:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34730 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfKTM47 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:56:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id i17so28812014qtq.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cANs+XnpVTcynqaWpfsqlgLUi206zYOAK/dPpz604Tg=;
        b=MJg7O/TJk2K7ImDXGKhqrX6U/5p9NJhHcTR2lgYkod0HwVASuMcrBcy1ud268D1N0k
         b2DS/xpDFR5YAuK9gax0enejq1T5tamnZ8BlkYMGQiTKk1hoZ2cWWFGKLnyO7XRNqAk3
         X2eT+CKejP1VK0TLb9TgYC7hkvgabZXMkU58QZv2au1anvF4cKaueiWBiPbypQ1qPC9d
         n+5Dzl0MxwU4kNB+nZ7TBGH6r2EAin5d3mKUjddUcOYF/pi772AziGhySCkrF2rr36eF
         YVeJpqt5QSlqI87Ri1KT7vhgJURoS0RxUES9B8fQ4qdrvuJxqP8HZqWaJHhNOuUpMJUd
         pwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cANs+XnpVTcynqaWpfsqlgLUi206zYOAK/dPpz604Tg=;
        b=unjS9cgal+cnOTtePOxIPAkkEA3k/vhqhJxeQ+9gzYyrAuwhBKcYA99eJcI+8/S9yO
         ns3qmpGon6/5UXLDtL+sDmWQK2oN9kNb3SU8lSXgc55SRDI7EUzH6NzZCINRmOozVFAo
         lgMy66K0iledGKKjIXMaJ331Ui5EguGJiV+gtZWcMtTqgsqyHjGzc9p9XtsY/ydmDQsL
         ElUxwDGjpm85zELTTWEOBJ0TXMruEPNGxq13a2Ub3X50wzxIxptHm7CnUXdL/ZYGO4ds
         zsUCSHhWkgR+ocx1tzbYIVKyOkqfs4i0MjNZ7r/EibNBDwyGJj0BBJQexDBju++m/RWW
         Aj+Q==
X-Gm-Message-State: APjAAAUThKtA3ugR3Okwa/MUhzmhYyK9C3p2Kb4S2o4lXUW4Gny/uVSg
        oubiWtMe9YLpoLCXnvLcaqD22g==
X-Google-Smtp-Source: APXvYqySn/aIs6hMGIqMIcxxfm7tqJHVK7kXXyzjWECMU9RJJqSgIfBzONFBB7sckH/Ezcbxla3Keg==
X-Received: by 2002:ac8:542:: with SMTP id c2mr2363165qth.56.1574254617325;
        Wed, 20 Nov 2019 04:56:57 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:56:55 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 5/7] soc: qcom: Extend RPMh power controller driver to register warming devices.
Date:   Wed, 20 Nov 2019 07:56:31 -0500
Message-Id: <1574254593-16078-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
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
	  ensure that warming devices are registerd after thermal
	  framework is initialized.
 
 drivers/soc/qcom/rpmhpd.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 9d37534..5666d1f 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/pwr_domain_warming.h>
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
@@ -396,7 +401,14 @@ static int rpmhpd_probe(struct platform_device *pdev)
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
@@ -413,3 +425,27 @@ static int __init rpmhpd_init(void)
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
+			pwr_domain_warming_register(rpmhpds[i]->dev,
+						    rpmhpds[i]->res_name, i);
+
+	return 0;
+}
+late_initcall(rpmhpd_init_warming_device);
-- 
2.1.4

