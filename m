Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E838252A5D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 11:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgHZJiN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 05:38:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:20125 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgHZJer (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 05:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598434472;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=yBt+2etaBY9zgYdXE/iL82GyuWazNPY8Ty2z45dc9Fs=;
        b=deJ2I6kgPVKJpRe618C4ByI1ZN6r0M+aHEnB1/bL421s84REdHHGWXgNlujL0Qf/7Y
        yf9uv1c0/ncrqoEBzvPfau6FPsN5IkiVkYkcDXnOfDZy4lm3Hkisxtp4A/zVilJ61ojU
        WWaaydq7SHCKmmpOHiLHIQPZ7HwmidWvTpKETwWzlfyx4KhQifd+m9YNykJW89x66IOH
        ZEHCHvWLf3W0P8aF6etjAQEPdSjILgm5zy9PDh/4PtIhvCbSnzkBLQRlUfaQ+qDUbHpO
        UenfjMmqXj/FInx+8jp1vJZZiuh5FV7BcsJO9yB5qmvrR/lh+yrQ309lco6OP+r1RJFE
        mZww==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6NYn8D"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7Q9YUkzf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 26 Aug 2020 11:34:30 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2] opp: Power on (virtual) power domains managed by the OPP core
Date:   Wed, 26 Aug 2020 11:33:28 +0200
Message-Id: <20200826093328.88268-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_attach_genpd() allows attaching an arbitrary number of
power domains to an OPP table. In that case, the genpd core will
create a virtual device for each of the power domains.

At the moment, the OPP core only calls
dev_pm_genpd_set_performance_state() on these virtual devices.
It does not attempt to power on the power domains. Therefore
the required power domain might never get turned on.

So far, dev_pm_opp_attach_genpd() is only used in qcom-cpufreq-nvmem.c
to attach the CPR power domain to the CPU OPP table. The CPR driver
does not check if it was actually powered on so this did not cause
any problems. However, other drivers (e.g. rpmpd) might ignore the
performance state until the power domain is actually powered on.

Since these virtual devices are managed exclusively by the OPP core,
I would say that it should also be responsible to ensure they are
enabled.

This commit implements this similar to the non-virtual power domains;
we create device links for each of attached power domains so that they
are turned on whenever the consumer device is active.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Related discussion: https://lore.kernel.org/linux-arm-msm/20200426123140.GA190483@gerhold.net/

v1: https://lore.kernel.org/linux-pm/20200730080146.25185-4-stephan@gerhold.net/
Changes in v2:
  - Use device links instead of enabling the power domains in
    dev_pm_opp_set_rate()
---
 drivers/opp/core.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/opp/opp.h  |  1 +
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 8b3c3986f589..7e53a7b94c59 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
 #include "opp.h"
@@ -1964,10 +1965,13 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 		if (!opp_table->genpd_virt_devs[index])
 			continue;
 
+		if (opp_table->genpd_virt_links && opp_table->genpd_virt_links[index])
+			device_link_del(opp_table->genpd_virt_links[index]);
 		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
 		opp_table->genpd_virt_devs[index] = NULL;
 	}
 
+	kfree(opp_table->genpd_virt_links);
 	kfree(opp_table->genpd_virt_devs);
 	opp_table->genpd_virt_devs = NULL;
 }
@@ -1999,8 +2003,10 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
-	int index = 0, ret = -EINVAL;
+	struct device_link *dev_link;
+	int index = 0, ret = -EINVAL, num_devs;
 	const char **name = names;
+	u32 flags;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
 	if (IS_ERR(opp_table))
@@ -2049,6 +2055,32 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 		name++;
 	}
 
+	/* Create device links to enable the power domains when necessary */
+	opp_table->genpd_virt_links = kcalloc(opp_table->required_opp_count,
+					      sizeof(*opp_table->genpd_virt_links),
+					      GFP_KERNEL);
+	if (!opp_table->genpd_virt_links)
+		goto err;
+
+	/* Turn on power domain initially if consumer is active */
+	pm_runtime_get_noresume(dev);
+	flags = DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS;
+	if (pm_runtime_active(dev))
+		flags |= DL_FLAG_RPM_ACTIVE;
+
+	num_devs = index;
+	for (index = 0; index < num_devs; index++) {
+		dev_link = device_link_add(dev, opp_table->genpd_virt_devs[index],
+					   flags);
+		if (!dev_link) {
+			dev_err(dev, "Failed to create device link\n");
+			pm_runtime_put(dev);
+			goto err;
+		}
+		opp_table->genpd_virt_links[index] = dev_link;
+	}
+	pm_runtime_put(dev);
+
 	if (virt_devs)
 		*virt_devs = opp_table->genpd_virt_devs;
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
 
-- 
2.28.0

