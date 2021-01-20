Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75B2FDBD5
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 22:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbhATVZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 16:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbhATVYv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 16:24:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC9C061757;
        Wed, 20 Jan 2021 13:13:52 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id q8so4482322lfm.10;
        Wed, 20 Jan 2021 13:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZyyjughXVQWOCamHA5hQecx4dkH4WA782c6u3ykaXc=;
        b=lNXdLU+DdJmsFQjB9xuWEX+44vbJRXDESQMP0PnyNXhcDw1LzXMoH9NgAD5Y2lLERK
         8NtGccxUAflMbyVJTda4y78/TK+fILB6BEWDbgaP0BUHxqEI718k8zgp3BivIOj1baoB
         VvsEMyh4hF7ouTF2nD/s3sni86dWT9I2qvPaXlHBzw+r1TJEutIKLxfj1QWTWCwQFauH
         /IK/7nEpxiChvfHROpN/yuWq25KmDGR/4SHjHVE1lVpUfu9LvBivFM/xlv5wspMJEzjI
         tOx3J9/715C63VncN4BP6m0BZYrtYlsI1w3EOLs62DoqeCUFYuxZvi2cgyYm5iQne2WT
         +M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZyyjughXVQWOCamHA5hQecx4dkH4WA782c6u3ykaXc=;
        b=khK1eJ06jRs9PJT1BtnMV67czSbsobmX2X7EUJt+0+9hn7wDtnbFdho2c4Ef9zG0hb
         JVyvMWNIkGFPteDzgSpEMg1wTUtCsjqjSNtSwljztIP7ZcgnV3D7XpTmEZfa+NvYe+T5
         t0zlxha8IrqQQ2xLKrqHQ3VeeqFdRWzloAgQVcLyt1tCPUccQYUOXDmYTiCzwrPBoprm
         4y8FCHJqQ9rUGY2Gz8xn7SNdxR+XiTyjDWguMm4PCiQnmcfOYc7MKzh7kQRDKiTqSOjG
         KWu+J7kBt85qmgNN1o3Iy2+w7QXWl0zXCGLdvfe9UrPfKsINdcIjhZ85oq+hN1z2P88G
         DNJQ==
X-Gm-Message-State: AOAM533+NWyhQ8KS7l/yyZ4E1AGIa1Pcl/xiqQ+u7sjcmxUllmY2Vu+Y
        hcTYkehyhSiB8NniDVNYxBQ=
X-Google-Smtp-Source: ABdhPJwkj0Lo/eNGpw4KKAwbidgNRUzYBBJG1SH49hWuruG5tXCvSHBQJ9EX265XlHQnFeGrtKVJ6Q==
X-Received: by 2002:a05:6512:3ea:: with SMTP id n10mr5034842lfq.535.1611177231423;
        Wed, 20 Jan 2021 13:13:51 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id 196sm298131lfj.219.2021.01.20.13.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:13:50 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 1/3] PM: domains: Make set_performance_state() callback optional
Date:   Thu, 21 Jan 2021 00:12:30 +0300
Message-Id: <20210120211232.17299-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120211232.17299-1-digetx@gmail.com>
References: <20210120211232.17299-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make set_performance_state() callback optional in order to remove the
need from power domain drivers to implement a dummy callback. If callback
isn't implemented by a GENPD driver, then the performance state is passed
to the parent domain.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
[tested on NVIDIA Tegra20/30/124 SoCs]
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9a14eedacb92..5c843772f7f4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -297,6 +297,18 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 	return state;
 }
 
+static int genpd_xlate_performance_state(struct generic_pm_domain *genpd,
+					 struct generic_pm_domain *parent,
+					 unsigned int pstate)
+{
+	if (!parent->set_performance_state)
+		return pstate;
+
+	return dev_pm_opp_xlate_performance_state(genpd->opp_table,
+						  parent->opp_table,
+						  pstate);
+}
+
 static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 					unsigned int state, int depth)
 {
@@ -311,13 +323,8 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 	list_for_each_entry(link, &genpd->child_links, child_node) {
 		parent = link->parent;
 
-		if (!parent->set_performance_state)
-			continue;
-
 		/* Find parent's performance state */
-		ret = dev_pm_opp_xlate_performance_state(genpd->opp_table,
-							 parent->opp_table,
-							 state);
+		ret = genpd_xlate_performance_state(genpd, parent, state);
 		if (unlikely(ret < 0))
 			goto err;
 
@@ -339,9 +346,11 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 			goto err;
 	}
 
-	ret = genpd->set_performance_state(genpd, state);
-	if (ret)
-		goto err;
+	if (genpd->set_performance_state) {
+		ret = genpd->set_performance_state(genpd, state);
+		if (ret)
+			goto err;
+	}
 
 	genpd->performance_state = state;
 	return 0;
@@ -352,9 +361,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 					     child_node) {
 		parent = link->parent;
 
-		if (!parent->set_performance_state)
-			continue;
-
 		genpd_lock_nested(parent, depth + 1);
 
 		parent_state = link->prev_performance_state;
@@ -399,9 +405,6 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	if (!genpd)
 		return -ENODEV;
 
-	if (unlikely(!genpd->set_performance_state))
-		return -EINVAL;
-
 	if (WARN_ON(!dev->power.subsys_data ||
 		     !dev->power.subsys_data->domain_data))
 		return -EINVAL;
-- 
2.29.2

