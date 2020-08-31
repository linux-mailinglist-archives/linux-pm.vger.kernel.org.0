Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB0257904
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHaMPC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 08:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgHaMPC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 08:15:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A98C061575
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 05:15:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so2862577pjd.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nIooSS36mtQC1Oee0ilIZhL51ovS8/MOftc7lgwrhZk=;
        b=j+O8vW6W1Gc50LTKk+bPWDl2aD/Y/8v0pN3M5ooAkHOOfnKXNv8lHpBa+hz5hQ9Qdm
         aQzNQDduTCwPIejvzPLN+j3zImKOghfg2di9S+GDHQQyV7t8crdnPp+kW+MXD4tMddBJ
         mBsLbCHxIRFFOHvyAbcro/zDqrQEDkrChrMU1bTr4c/QKBICKZvWlt621mhde4OTEQnF
         nPWfBjH11OUH07SsJ9O14NieyiySbMT0SYcFpxHwXwrAC3vmGtQGgfD6uSL0D+ObZ5TK
         UAtpVpS9uj7SipfCzgmclRHOHaN4jKHiihAIDptj/PeyC0LNgihCLtYkHyY04Hf9bIX3
         scfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nIooSS36mtQC1Oee0ilIZhL51ovS8/MOftc7lgwrhZk=;
        b=gIIgTh1k6MjaN430svmTNepbd5WWJxh8e6vXVrm13an5YaCf45RYWs0LujgOCPNyeh
         1DSx1vDzaPqeagZ96o93v0bjofFEvTbsw3rzSyvVdiFT0hm5K6VMKr023c+W1UxZuAyi
         HYJAy/OkpxNPo19JUt6Kh+71T2rXLoQKhAcTvwFJFZe7k+R5P8BVigQ5DSa/QpOSDb9F
         WvqAZxaqsbXZi17sLAE93E8qDAhpaeWDZ3LALqgnYKh6Pru3Jf1qlxMV5sibtqjnO2TI
         QacE9KjZ3A7wy3omtoY0+JHJRJfLiGXdvTDIFetWmiuVr0RBN7rfI9C/jcyWeR2QO8ul
         XAJA==
X-Gm-Message-State: AOAM530p2lKmtsx+WSMIb2Ql77ZjNPGBy1PjN3amXXRestGj/pfNWCmZ
        OfJWZfQEMJxqBTOYBoLBwOKTwg==
X-Google-Smtp-Source: ABdhPJxKWJ0rCeInmPfUSpGM2WCVJBJ1w1idLupTRD9Q7rQbKYLU49QfLGAqAh/76r6mL1e990sjGg==
X-Received: by 2002:a17:90b:a44:: with SMTP id gw4mr1105729pjb.26.1598876101178;
        Mon, 31 Aug 2020 05:15:01 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id t10sm7650745pfq.77.2020.08.31.05.14.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 05:14:59 -0700 (PDT)
Date:   Mon, 31 Aug 2020 17:44:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH v2] opp: Power on (virtual) power domains managed by the
 OPP core
Message-ID: <20200831121457.2v6avendroclvrn5@vireshk-i7>
References: <20200826093328.88268-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826093328.88268-1-stephan@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-20, 11:33, Stephan Gerhold wrote:
> dev_pm_opp_attach_genpd() allows attaching an arbitrary number of
> power domains to an OPP table. In that case, the genpd core will
> create a virtual device for each of the power domains.
> 
> At the moment, the OPP core only calls
> dev_pm_genpd_set_performance_state() on these virtual devices.
> It does not attempt to power on the power domains. Therefore
> the required power domain might never get turned on.
> 
> So far, dev_pm_opp_attach_genpd() is only used in qcom-cpufreq-nvmem.c
> to attach the CPR power domain to the CPU OPP table. The CPR driver
> does not check if it was actually powered on so this did not cause
> any problems. However, other drivers (e.g. rpmpd) might ignore the
> performance state until the power domain is actually powered on.
> 
> Since these virtual devices are managed exclusively by the OPP core,
> I would say that it should also be responsible to ensure they are
> enabled.
> 
> This commit implements this similar to the non-virtual power domains;
> we create device links for each of attached power domains so that they
> are turned on whenever the consumer device is active.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---

Applied with some changes, hope that is fine:

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[ Viresh: Rearranged the code to remove extra loop and minor cleanup ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/opp/opp.h  |  1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e65174725a4d..b608b0253079 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
 #include "opp.h"
@@ -1967,10 +1968,15 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 		if (!opp_table->genpd_virt_devs[index])
 			continue;
 
+		if (opp_table->genpd_virt_links[index])
+			device_link_del(opp_table->genpd_virt_links[index]);
+
 		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
 		opp_table->genpd_virt_devs[index] = NULL;
 	}
 
+	kfree(opp_table->genpd_virt_links);
+	opp_table->genpd_virt_links = NULL;
 	kfree(opp_table->genpd_virt_devs);
 	opp_table->genpd_virt_devs = NULL;
 }
@@ -2002,8 +2008,10 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
+	struct device_link *dev_link;
 	int index = 0, ret = -EINVAL;
 	const char **name = names;
+	u32 flags;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
 	if (IS_ERR(opp_table))
@@ -2030,6 +2038,21 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 	if (!opp_table->genpd_virt_devs)
 		goto unlock;
 
+	opp_table->genpd_virt_links = kcalloc(opp_table->required_opp_count,
+					      sizeof(*opp_table->genpd_virt_links),
+					      GFP_KERNEL);
+	if (!opp_table->genpd_virt_links) {
+		kfree(opp_table->genpd_virt_devs);
+		opp_table->genpd_virt_devs = NULL;
+		goto unlock;
+	}
+
+	/* Turn on power domain initially if consumer is active */
+	pm_runtime_get_noresume(dev);
+	flags = DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS;
+	if (pm_runtime_active(dev))
+		flags |= DL_FLAG_RPM_ACTIVE;
+
 	while (*name) {
 		if (index >= opp_table->required_opp_count) {
 			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
@@ -2043,12 +2066,23 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
 			goto err;
 		}
-
 		opp_table->genpd_virt_devs[index] = virt_dev;
+
+		/* Create device links to manage runtime PM */
+		dev_link = device_link_add(dev, opp_table->genpd_virt_devs[index],
+					   flags);
+		if (!dev_link) {
+			dev_err(dev, "Failed to create device link\n");
+			goto err;
+		}
+		opp_table->genpd_virt_links[index] = dev_link;
+
 		index++;
 		name++;
 	}
 
+	pm_runtime_put(dev);
+
 	if (virt_devs)
 		*virt_devs = opp_table->genpd_virt_devs;
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
@@ -2056,6 +2090,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 	return opp_table;
 
 err:
+	pm_runtime_put(dev);
 	_opp_detach_genpd(opp_table);
 unlock:
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 78e876ec803e..be5526cdbdba 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -186,6 +186,7 @@ struct opp_table {
 
 	struct mutex genpd_virt_dev_lock;
 	struct device **genpd_virt_devs;
+	struct device_link **genpd_virt_links;
 	struct opp_table **required_opp_tables;
 	unsigned int required_opp_count;
