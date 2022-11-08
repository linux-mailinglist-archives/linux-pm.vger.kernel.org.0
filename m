Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01AD620630
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 02:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiKHBf6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 20:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiKHBfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 20:35:48 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC41B1C9;
        Mon,  7 Nov 2022 17:35:39 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BB91D84DF9;
        Tue,  8 Nov 2022 02:35:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667871337;
        bh=mk53bEXFmT8Z8hA3JrwDO7z2xvGqQ7cSbF9bJCtkDg4=;
        h=From:To:Cc:Subject:Date:From;
        b=LX+LYXHuoNYsO7cLRtBleHOOS4+La3GywxY8oBrIb0y1EDeuQNylIigDc5s0q1Ob5
         kcI3V+Htu4HKGGl2W8OdNy5mMgX0P2Gmwv9V5eZCfwSey0BDnAkSUYfEyWmlb3pVha
         2iqH7I0K84OrguxR19LPFER5Iv4EeeKqHPbE3ECdhJ1/vQyWab0UOn3IrvpFP5jjNo
         vF3RoG3xqo97NDZdWI5zytHfG9dyCyE/GSo10gw7UrhBZDJxW6jmfS/8JPRHzVDNbr
         J7drfrsnDnwhqSPDHcMH5TbkhA+q1cQKGyvbyEIC33k02ORR9raVdr31Nf18tfiYX/
         5G5T7cU8PjRRQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 1/3] [RFC] PM: domains: Introduce .power_pre/post_on/off callbacks
Date:   Tue,  8 Nov 2022 02:35:15 +0100
Message-Id: <20221108013517.749665-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently it is possible that a power domain power on or off would claim
the genpd lock first and clock core prepare_lock second, while another
thread could do the reverse, and this would trigger lockdep warning.

Introduce new callbacks, .power_pre/post_on() and .power_off_pre/post(), which
are triggered before the genpd_lock() and after genpd_unlock() respectively in
case the domain is powered on and off. Those are meant to let drivers claim
clock core prepare_lock via clk_*prepare() call and release the lock via
clk_*unprepare() call to always assure that the clock and genpd lock ordering
is correct.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jacky Bai <ping.bai@nxp.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Martin Kepplinger <martink@posteo.de>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/base/power/domain.c | 103 ++++++++++++++++++++++++++++++++----
 include/linux/pm_domain.h   |   4 ++
 2 files changed, 97 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6471b559230e9..df2a93d0674e4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -494,6 +494,22 @@ void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
 
+static int genpd_power_pre_on(struct generic_pm_domain *genpd)
+{
+	if (!genpd->power_pre_on)
+		return 0;
+
+	return genpd->power_pre_on(genpd);
+}
+
+static int genpd_power_post_on(struct generic_pm_domain *genpd)
+{
+	if (!genpd->power_post_on)
+		return 0;
+
+	return genpd->power_post_on(genpd);
+}
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -544,6 +560,22 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	return ret;
 }
 
+static int genpd_power_off_pre(struct generic_pm_domain *genpd)
+{
+	if (!genpd->power_off_pre)
+		return 0;
+
+	return genpd->power_off_pre(genpd);
+}
+
+static int genpd_power_off_post(struct generic_pm_domain *genpd)
+{
+	if (!genpd->power_off_post)
+		return 0;
+
+	return genpd->power_off_post(genpd);
+}
+
 static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -816,12 +848,18 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 static void genpd_power_off_work_fn(struct work_struct *work)
 {
 	struct generic_pm_domain *genpd;
+	int ret;
 
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
+	ret = genpd_power_off_pre(genpd);
+	if (ret)
+		return;
 	genpd_lock(genpd);
 	genpd_power_off(genpd, false, 0);
 	genpd_unlock(genpd);
+	ret = genpd_power_off_post(genpd);
+	WARN_ON_ONCE(ret);
 }
 
 /**
@@ -938,12 +976,14 @@ static int genpd_runtime_suspend(struct device *dev)
 	if (irq_safe_dev_in_sleep_domain(dev, genpd))
 		return 0;
 
+	ret = genpd_power_off_pre(genpd);
+	if (ret)
+		return ret;
 	genpd_lock(genpd);
 	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 	genpd_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
-
-	return 0;
+	return genpd_power_off_post(genpd);
 }
 
 /**
@@ -977,12 +1017,21 @@ static int genpd_runtime_resume(struct device *dev)
 	if (irq_safe_dev_in_sleep_domain(dev, genpd))
 		goto out;
 
+	ret = genpd_power_pre_on(genpd);
+	if (ret)
+		return ret;
 	genpd_lock(genpd);
 	ret = genpd_power_on(genpd, 0);
 	if (!ret)
 		genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
 	genpd_unlock(genpd);
 
+	if (ret) {
+		genpd_power_post_on(genpd);
+		return ret;
+	}
+
+	ret = genpd_power_post_on(genpd);
 	if (ret)
 		return ret;
 
@@ -1017,10 +1066,13 @@ static int genpd_runtime_resume(struct device *dev)
 	genpd_stop_dev(genpd, dev);
 err_poweroff:
 	if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
-		genpd_lock(genpd);
-		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
-		genpd_power_off(genpd, true, 0);
-		genpd_unlock(genpd);
+		if (!genpd_power_off_pre(genpd)) {
+			genpd_lock(genpd);
+			gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
+			genpd_power_off(genpd, true, 0);
+			genpd_unlock(genpd);
+			genpd_power_off_post(genpd);
+		}
 	}
 
 	return ret;
@@ -1225,12 +1277,14 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 		}
 	}
 
+	ret = genpd_power_off_pre(genpd);
+	if (ret)
+		return ret;
 	genpd_lock(genpd);
 	genpd->suspended_count++;
 	genpd_sync_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
-
-	return 0;
+	return genpd_power_off_post(genpd);
 }
 
 /**
@@ -1267,10 +1321,16 @@ static int genpd_resume_noirq(struct device *dev)
 	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
 		return pm_generic_resume_noirq(dev);
 
+	ret = genpd_power_pre_on(genpd);
+	if (ret)
+		return ret;
 	genpd_lock(genpd);
 	genpd_sync_power_on(genpd, true, 0);
 	genpd->suspended_count--;
 	genpd_unlock(genpd);
+	ret = genpd_power_post_on(genpd);
+	if (ret)
+		return ret;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
 	    !pm_runtime_status_suspended(dev)) {
@@ -1378,6 +1438,9 @@ static int genpd_restore_noirq(struct device *dev)
 	 * At this point suspended_count == 0 means we are being run for the
 	 * first time for the given domain in the present cycle.
 	 */
+	ret = genpd_power_pre_on(genpd);
+	if (ret)
+		return ret;
 	genpd_lock(genpd);
 	if (genpd->suspended_count++ == 0) {
 		/*
@@ -1390,6 +1453,9 @@ static int genpd_restore_noirq(struct device *dev)
 
 	genpd_sync_power_on(genpd, true, 0);
 	genpd_unlock(genpd);
+	ret = genpd_power_post_on(genpd);
+	if (ret)
+		return ret;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
 	    !pm_runtime_status_suspended(dev)) {
@@ -1413,6 +1479,7 @@ static int genpd_restore_noirq(struct device *dev)
 static void genpd_complete(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1435,6 +1502,7 @@ static void genpd_switch_state(struct device *dev, bool suspend)
 {
 	struct generic_pm_domain *genpd;
 	bool use_lock;
+	int ret;
 
 	genpd = dev_to_genpd_safe(dev);
 	if (!genpd)
@@ -1442,8 +1510,13 @@ static void genpd_switch_state(struct device *dev, bool suspend)
 
 	use_lock = genpd_is_irq_safe(genpd);
 
-	if (use_lock)
+	if (use_lock) {
+		ret = suspend ? genpd_power_off_pre(genpd) :
+				genpd_power_pre_on(genpd);
+		if (ret)
+			return;
 		genpd_lock(genpd);
+	}
 
 	if (suspend) {
 		genpd->suspended_count++;
@@ -1453,8 +1526,12 @@ static void genpd_switch_state(struct device *dev, bool suspend)
 		genpd->suspended_count--;
 	}
 
-	if (use_lock)
+	if (use_lock) {
 		genpd_unlock(genpd);
+		ret = suspend ? genpd_power_off_post(genpd) :
+				genpd_power_post_on(genpd);
+		WARN_ON_ONCE(ret);
+	}
 }
 
 /**
@@ -2750,9 +2827,15 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
 	if (power_on) {
+		ret = genpd_power_pre_on(pd);
+		if (ret)
+			return ret;
 		genpd_lock(pd);
 		ret = genpd_power_on(pd, 0);
 		genpd_unlock(pd);
+		ret = genpd_power_post_on(pd);
+		if (ret)
+			return ret;
 	}
 
 	if (ret) {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ebc3516980907..3cf231a27cb1b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -134,8 +134,12 @@ struct generic_pm_domain {
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
+	int (*power_off_pre)(struct generic_pm_domain *domain);
 	int (*power_off)(struct generic_pm_domain *domain);
+	int (*power_off_post)(struct generic_pm_domain *domain);
+	int (*power_pre_on)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	int (*power_post_on)(struct generic_pm_domain *domain);
 	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
 	struct opp_table *opp_table;	/* OPP table of the genpd */
 	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
-- 
2.35.1

