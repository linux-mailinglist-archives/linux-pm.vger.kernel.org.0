Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC565232CD1
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 10:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgG3ICH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 04:02:07 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:27376 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgG3ICG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 04:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596096121;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+WtiI0ygGdiZUF68UUWGgtshE7pdk3Dx6AuxN7BGWgU=;
        b=U7m9vs2ExhWUf5A617LAEWY9hr4EN4A25dYKIxRFAAbkVxGBCGTPRvCxIcVjZA4fD9
        +Ay4+bVLVNqGoJoVg33GpXoVcHFzcTy399+Lwb/NT1/rwaxnvWjljXI8O/XJcedswHxM
        xMIGFdB0T4macqh+Bh9lwVn6nubqytU3vJ5fJYyP+ZuKpVsgjx4klRiRa5YhnWPSfTUJ
        yPshvxB1A2Cf+KyJ1mC0wp2hwUFA1yU2tPv748OHn7xq2uRgZ1twWPRbrdunv9aKeZ6e
        30OG3BVO1HWLkhVxu5QUlC6PV6W6gaPBzO36uSoxAaXe56u5FyzKdKjT0ikYDguBj7pR
        IH9Q==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6NeHYC"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew6U820guw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 30 Jul 2020 10:02:00 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [RFC PATCH 3/3] opp: Power on (virtual) power domains managed by the OPP core
Date:   Thu, 30 Jul 2020 10:01:46 +0200
Message-Id: <20200730080146.25185-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730080146.25185-1-stephan@gerhold.net>
References: <20200730080146.25185-1-stephan@gerhold.net>
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
enabled. A similar approach is already used for regulators, see
commit 8d45719caaf5 ("opp: core: add regulators enable and disable").

This commit implements similar functionality for the virtual genpd
devices managed by the OPP core. The power domains are turned on
the first time dev_pm_opp_set_rate() is called. They are turned off
again when dev_pm_opp_set_rate(dev, 0) is called.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Related discussion: https://lore.kernel.org/linux-arm-msm/20200426123140.GA190483@gerhold.net/

There would be also other ways to implement this, e.g. device links,
assuming that the device using the OPP table also makes use of runtime PM.
My first thought was that it would be most consistent to handle this like
regulators, bandwidth votes etc. RFC :)
---
 drivers/opp/core.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h  |  1 +
 2 files changed, 56 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f93f551c911e..66ecffe12f01 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
 #include "opp.h"
@@ -796,6 +797,26 @@ static int _set_required_opp(struct device *dev, struct device *pd_dev,
 	return ret;
 }
 
+static int _enable_required_opp(struct device *dev, struct device *pd_dev,
+				bool on)
+{
+	int ret;
+
+	if (on) {
+		ret = pm_runtime_get_sync(pd_dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(pd_dev);
+			dev_err(dev, "Failed to enable %s: %d\n",
+				dev_name(pd_dev), ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_put(pd_dev);
+	}
+
+	return 0;
+}
+
 /* This is only called for PM domain for now */
 static int _set_required_opps(struct device *dev,
 			      struct opp_table *opp_table,
@@ -803,6 +824,8 @@ static int _set_required_opps(struct device *dev,
 {
 	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
 	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
+	bool power_on = opp != NULL;
+	bool already_enabled = power_on == opp_table->genpd_virt_enabled;
 	struct device *pd_dev;
 	int i, ret = 0;
 
@@ -829,6 +852,20 @@ static int _set_required_opps(struct device *dev,
 			ret = _set_required_opp(dev, pd_dev, opp, i);
 			if (ret)
 				break;
+
+			if (likely(already_enabled))
+				continue;
+
+			ret = _enable_required_opp(dev, pd_dev, power_on);
+			if (ret)
+				break;
+		}
+
+		if (ret && !already_enabled) {
+			/* Rollback (skip current since it failed) */
+			for (i--; i >= 0; i--)
+				_enable_required_opp(dev, genpd_virt_devs[i],
+						     !power_on);
 		}
 	} else {
 		/* Scaling down? Set required OPPs in reverse order */
@@ -838,8 +875,26 @@ static int _set_required_opps(struct device *dev,
 			ret = _set_required_opp(dev, pd_dev, opp, i);
 			if (ret)
 				break;
+
+			if (likely(already_enabled))
+				continue;
+
+			ret = _enable_required_opp(dev, pd_dev, power_on);
+			if (ret)
+				break;
+		}
+
+		if (ret && !already_enabled) {
+			/* Rollback (skip current since it failed) */
+			for (i++; i < opp_table->required_opp_count; i++)
+				_enable_required_opp(dev, genpd_virt_devs[i],
+						     !power_on);
 		}
 	}
+
+	if (ret == 0 && !already_enabled)
+		opp_table->genpd_virt_enabled = power_on;
+
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
 	return ret;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e51646ff279e..01ad9e136cc8 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -188,6 +188,7 @@ struct opp_table {
 	struct device **genpd_virt_devs;
 	struct opp_table **required_opp_tables;
 	unsigned int required_opp_count;
+	bool genpd_virt_enabled;
 
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
-- 
2.27.0

