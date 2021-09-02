Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF6D3FEBF1
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbhIBKRm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 06:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbhIBKRm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 06:17:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5463C061575
        for <linux-pm@vger.kernel.org>; Thu,  2 Sep 2021 03:16:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m4so2544652ljq.8
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 03:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8gHKZlIfNMsE2pwpZyxC6yykTeyy3ncWsPcdI97ZBw=;
        b=Oz8M17UZ6Gx8M9KbOtjRmP3bgfiYuuxEHm6LOcO2pUnB9laFx5UVB5VKthK6ntGR0x
         cgOiXgmpxCBMTPt/U5URfmDm6XbHPMzJPBpI8F9nPcS+UPXKuUjf9oO6SsetA3IbfmGh
         zjk9F3KXuQ/XWjnP2i6TL9e7xb5KIWe2AoGuVI3F013ag+8+I8dOKA2qxSRwxORsd7WE
         pju3HKN/TnJi0qfjLLYp9ZNuqr0/mWb+6mbuC8HIyNI4UYHCT0kiYobL4YoyUXJpPTnW
         8nFlCLi9dH+VxjezfhukcYdstS5keqcN+GyypIPpk2DtDWWXlg9sYWKqg7huXgJyvhP7
         w0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8gHKZlIfNMsE2pwpZyxC6yykTeyy3ncWsPcdI97ZBw=;
        b=NYGVfi7ep+Q2j429ObuuRMBhFxkNN9hX2BPn37GqqSL5+zG+VF2deHIujjBrYiPBjM
         8iHTL8oegZCNe4mQAcERvGhlsypPsAYlqtZ4Lyzu7kObx7qIov19S2LnU/wKhGfQ/QJw
         6D+kUkm1QwBOGAyJ/2vXVeJOqEeuc5B9Xb1pbUwMcLPlBqf0mdGTcPJ1FuwT1Ya/iIuy
         Nojet9n7PBmb/KcaZJiUCj+UdRuzJyQz1ZlPXQqe3PXRl8jv5f1Wp9FtQCf3HnK71/Wr
         OvMVeY6NjYRn9LBxCC4l9ZNfZB0nwH9p3V5nHPn9qyBHXaw2582DiTGgp8BoajwWLe0k
         qTcg==
X-Gm-Message-State: AOAM5324so6KWyJXkub8crov3skYPN82eAexPqzztgXwylo88TpDxfby
        z5ger4WMgE+jE+0Ou6PC/zX9ZQ==
X-Google-Smtp-Source: ABdhPJzB9h6Twzy69IlKpaCmsSc174yIyH9MuvDLdUFpiBXC0tvx5XVeFz7kIcQaHw3PYf6tMNnYrA==
X-Received: by 2002:a2e:5758:: with SMTP id r24mr1849768ljd.432.1630577802207;
        Thu, 02 Sep 2021 03:16:42 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id s4sm155897lfd.53.2021.09.02.03.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 03:16:41 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state() callback to genpd
Date:   Thu,  2 Sep 2021 12:16:34 +0200
Message-Id: <20210902101634.827187-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902101634.827187-1-ulf.hansson@linaro.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hardware may be preprogrammed to a specific performance state, which may
not be zero initially during boot. This may lead to that genpd's current
performance state becomes inconsistent with the state of the hardware. To
deal with this, the driver for a device that is being attached to its
genpd, need to request an initial performance state vote, which is
typically done by calling some of the OPP APIs while probing.

In some cases this would lead to boilerplate code in the drivers. Let's
make it possible to avoid this, by adding a new optional callback to genpd
and invoke it per device during the attach process. In this way, the genpd
provider driver can inform genpd about the initial performance state that
is needed for the device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 8 +++++---
 include/linux/pm_domain.h   | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 800adf831cae..1a6f3538af8d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2640,13 +2640,15 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
-static int genpd_get_default_performance_state(struct device *dev,
+static int genpd_get_default_performance_state(struct generic_pm_domain *genpd,
+					       struct device *dev,
 					       unsigned int index)
 {
 	int pstate = of_get_required_opp_performance_state(dev->of_node, index);
 
 	if (pstate == -ENODEV || pstate == -EOPNOTSUPP)
-		return 0;
+		pstate = genpd->dev_get_performance_state ?
+			 genpd->dev_get_performance_state(genpd, dev) : 0;
 
 	return pstate;
 }
@@ -2701,7 +2703,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	}
 
 	/* Set the default performance state */
-	pstate = genpd_get_default_performance_state(dev, index);
+	pstate = genpd_get_default_performance_state(pd, dev, index);
 	if (pstate < 0) {
 		ret = pstate;
 		goto err;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 21a0577305ef..da694489a05a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -131,6 +131,8 @@ struct generic_pm_domain {
 	struct opp_table *opp_table;	/* OPP table of the genpd */
 	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
 						 struct dev_pm_opp *opp);
+	int (*dev_get_performance_state)(struct generic_pm_domain *genpd,
+					 struct device *dev);
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
-- 
2.25.1

