Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A002E3018D3
	for <lists+linux-pm@lfdr.de>; Sun, 24 Jan 2021 00:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbhAWXIk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 18:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbhAWXIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 18:08:38 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BDDC061788
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 15:07:56 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id k193so9052639qke.6
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 15:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=LuyByMzP9XIpNvMO/h3xsc2K4a2B8bL6ZURB3yLgRxE=;
        b=Q3h/Z9uI2RLv4Ril8dEGFUjuP2AFTj/U9XAvaZChDZN8jESPPusl0HZuc4h6u9v94L
         qHX6RBz02oTujpM9GgOtT1/u6MnxkkiJsP84ufVQSoagJMPPXl7DAiIPNf0AvZ6mtb6Q
         JYAEZvmu/BAvm4jqPuS3eRdW7VH2wlTiTBEM9Lgu/Q123ehlM4GsAInBDOMcRx/YESFk
         jFnhiAGVeqlPfWvW0ywL/YOAg55zZHuL0prGWu8zLN6YCITBBWwCn+7ZgRkj9KBUT6RR
         x+yXQvYLd51d+cdhAZkhWoQcQuOdJNM1Hjs0Mg8NvT9kiheF31/+3xbWM8XiZLp7RF+W
         833Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=LuyByMzP9XIpNvMO/h3xsc2K4a2B8bL6ZURB3yLgRxE=;
        b=igtZJol2aERllBc6Yt0LImI5674qxEQrXDuE3zd4B2UgFZG3SN09zsfYRYWqs9XonL
         cGVhH0LaBLkoO3QVYRmWjh+b1QAow9MjciBEVSpe5CRt2/lfoAO2tv4r35EESkzwkWmx
         +Pz9cWmuz6FwCar0GpUrtQuDA0MU3ny961ZSZH7nn9KspPHoAK/rNjD3Pj9SH63NpQtV
         AevLkr8s/XtSbzRRUQJT4dnXwAxVim0SIZm4JJiIuVB4FzJvMR3TzF83Ys0/aOnoOhk7
         0bsKXBBOTOQvUJi5I72NEG/Y7zrgKBrPsdj7cqQrWMZfIKx8ZuxCsDuhogIwKu80LAZv
         YrJA==
X-Gm-Message-State: AOAM5320uHGWrOC2SKInfEkCBBrCC75yz8omaZMixfg8cQVW1eNK6/WE
        oVOKDjo8n0k1zKosreB5JMmnjA==
X-Google-Smtp-Source: ABdhPJw7uYCsv/u13AU2jg/GEcDyOn4wxBzXtjiapeGMkRFt8969GvTNWvSmN8bz6cfqx6Q2awhC6w==
X-Received: by 2002:a05:620a:2f7:: with SMTP id a23mr1380368qko.256.1611443274940;
        Sat, 23 Jan 2021 15:07:54 -0800 (PST)
Received: from xanadu.home (modemcable076.50-203-24.mc.videotron.ca. [24.203.50.76])
        by smtp.gmail.com with ESMTPSA id v67sm9581148qkd.94.2021.01.23.15.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 15:07:54 -0800 (PST)
Date:   Sat, 23 Jan 2021 18:07:53 -0500 (EST)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3] PM / clk: make PM clock layer compatible with clocks that
 must sleep
In-Reply-To: <CAJZ5v0iNtmXWr3uXzit5Er_j7G=LkGVyhdNAsjwpVWsDy8F7KQ@mail.gmail.com>
Message-ID: <61p41n8-r88q-9npq-879o-s4r5856os9s1@onlyvoer.pbz>
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz> <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com> <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com> <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
 <CAJZ5v0hFjpGp2GbV1Evi+BbUF7Am4ETY4Cm8VzTrvTJ=7=oyPQ@mail.gmail.com> <84r6s34s-opq7-9358-o45n-27s17084012@onlyvoer.pbz> <CAJZ5v0jUxonxp0q80Kdcbax+WMmh-NZ_h=KQG-HcfFdE1hr4VA@mail.gmail.com> <CAJZ5v0hj4VC_kjB5e_b_ho=ET_quG5zUh0Dbbdwofp-6azopsw@mail.gmail.com>
 <CA+G9fYsRVxWPW1nvSXMTLWfEadrdBDSH5hRPtoUYpfpqq8zRSw@mail.gmail.com> <CAJZ5v0gsYb1uxDUTHUe539w8uXhk=m337Xn6wtPhF1oPKzaYrQ@mail.gmail.com> <30np982n-r2q8-8532-q6os-9p9729ppos45@syhkavp.arg>
 <CAJZ5v0iNtmXWr3uXzit5Er_j7G=LkGVyhdNAsjwpVWsDy8F7KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clock API splits its interface into sleepable ant atomic contexts:

- clk_prepare/clk_unprepare for stuff that might sleep

- clk_enable_clk_disable for anything that may be done in atomic context

The code handling runtime PM for clocks only calls clk_disable() on
suspend requests, and clk_enable on resume requests. This means that
runtime PM with clock providers that only have the prepare/unprepare
methods implemented is basically useless.

Many clock implementations can't accommodate atomic contexts. This is
often the case when communication with the clock happens through another
subsystem like I2C or SCMI.

Let's make the clock PM code useful with such clocks by safely invoking
clk_prepare/clk_unprepare upon resume/suspend requests. Of course, when
such clocks are registered with the PM layer then pm_runtime_irq_safe()
can't be used, and neither pm_runtime_suspend() nor pm_runtime_resume()
may be invoked in atomic context.

For clocks that do implement the enable and disable methods then
everything just works as before.

A note on sparse:
According to https://lwn.net/Articles/109066/ there are things
that sparse can't cope with. In particular, pm_clk_op_lock() and
pm_clk_op_unlock() may or may not lock/unlock psd->lock depending on
some runtime condition. To work around that we tell sparse the lock
is always untaken for the purpose of static analisys.

Thanks to Naresh Kamboju for reporting issues with the initial patch.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

---

Changes from v2:

- added workarounds to cope with sparse limitations (see above).

Changes from v1:

- made dummy clk_is_enabled_when_prepared() dependent on 
  CONFIG_HAVE_CLK_PREPARE instead of CONFIG_HAVE_CLK.

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index ced6863a16..e6956ce301 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -23,6 +23,7 @@
 enum pce_status {
 	PCE_STATUS_NONE = 0,
 	PCE_STATUS_ACQUIRED,
+	PCE_STATUS_PREPARED,
 	PCE_STATUS_ENABLED,
 	PCE_STATUS_ERROR,
 };
@@ -32,8 +33,108 @@ struct pm_clock_entry {
 	char *con_id;
 	struct clk *clk;
 	enum pce_status status;
+	bool enabled_when_prepared;
 };
 
+/**
+ * pm_clk_list_lock - ensure exclusive access for modifying the PM clock
+ *		      entry list.
+ * @psd: pm_subsys_data instance corresponding to the PM clock entry list
+ *	 and clk_op_might_sleep count to be modified.
+ *
+ * Get exclusive access before modifying the PM clock entry list and the
+ * clock_op_might_sleep count to guard against concurrent modifications.
+ * This also protects against a concurrent clock_op_might_sleep and PM clock
+ * entry list usage in pm_clk_suspend()/pm_clk_resume() that may or may not
+ * happen in atomic context, hence both the mutex and the spinlock must be
+ * taken here.
+ */
+static inline void pm_clk_list_lock(struct pm_subsys_data *psd)
+{
+	mutex_lock(&psd->clock_mutex);
+	spin_lock_irq(&psd->lock);
+}
+
+/**
+ * pm_clk_list_unlock - counterpart to pm_clk_list_lock().
+ * @psd: the same pm_subsys_data instance previously passed to
+ *	 pm_clk_list_lock().
+ */
+static inline void pm_clk_list_unlock(struct pm_subsys_data *psd)
+{
+	spin_unlock_irq(&psd->lock);
+	mutex_unlock(&psd->clock_mutex);
+}
+
+/**
+ * pm_clk_op_lock - ensure exclusive access for performing clock operations.
+ * @psd: pm_subsys_data instance corresponding to the PM clock entry list
+ *	 and clk_op_might_sleep count being used.
+ * @flags: stored irq flags.
+ * @fn: string for the caller function's name.
+ *
+ * This is used by pm_clk_suspend() and pm_clk_resume() to guard
+ * against concurrent modifications to the clock entry list and the
+ * clock_op_might_sleep count. If clock_op_might_sleep is != 0 then
+ * only the mutex can be locked and those functions can only be used in
+ * non atomic context. If clock_op_might_sleep == 0 then these functions
+ * may be used in any context and only the spinlock can be locked.
+ * Returns -EINVAL if called in atomic context when clock ops might sleep.
+ */
+static int pm_clk_op_lock(struct pm_subsys_data *psd, unsigned long *flags,
+			  const char *fn)
+{
+	bool atomic_context = in_atomic() || irqs_disabled();
+
+try_again:
+	spin_lock_irqsave(&psd->lock, *flags);
+	if (!psd->clock_op_might_sleep) {
+		/* the __release is there to work around sparse limitations */
+		__release(&psd->lock);
+		return 0;
+	}
+
+	/* bail out if in atomic context */
+	if (atomic_context) {
+		pr_err("%s: atomic context with clock_ops_might_sleep = %d",
+		       fn, psd->clock_op_might_sleep);
+		spin_unlock_irqrestore(&psd->lock, *flags);
+		might_sleep();
+		return -EPERM;
+	}
+
+	/* we must switch to the mutex */
+	spin_unlock_irqrestore(&psd->lock, *flags);
+	mutex_lock(&psd->clock_mutex);
+
+	/*
+	 * There was a possibility for psd->clock_op_might_sleep
+	 * to become 0 above. Keep the mutex only if not the case.
+	 */
+	if (likely(psd->clock_op_might_sleep))
+		return 0;
+
+	mutex_unlock(&psd->clock_mutex);
+	goto try_again;
+}
+
+/**
+ * pm_clk_op_unlock - counterpart to pm_clk_op_lock().
+ * @psd: the same pm_subsys_data instance previously passed to
+ *	 pm_clk_op_lock().
+ * @flags: irq flags provided by pm_clk_op_lock().
+ */
+static void pm_clk_op_unlock(struct pm_subsys_data *psd, unsigned long *flags)
+{
+	if (psd->clock_op_might_sleep) {
+		mutex_unlock(&psd->clock_mutex);
+	} else {
+		/* the __acquire is there to work around sparse limitations */
+		__acquire(&psd->lock);
+		spin_unlock_irqrestore(&psd->lock, *flags);
+	}
+}
+
 /**
  * pm_clk_enable - Enable a clock, reporting any errors
  * @dev: The device for the given clock
@@ -43,14 +144,21 @@ static inline void __pm_clk_enable(struct device *dev, struct pm_clock_entry *ce
 {
 	int ret;
 
-	if (ce->status < PCE_STATUS_ERROR) {
+	switch (ce->status) {
+	case PCE_STATUS_ACQUIRED:
+		ret = clk_prepare_enable(ce->clk);
+		break;
+	case PCE_STATUS_PREPARED:
 		ret = clk_enable(ce->clk);
-		if (!ret)
-			ce->status = PCE_STATUS_ENABLED;
-		else
-			dev_err(dev, "%s: failed to enable clk %p, error %d\n",
-				__func__, ce->clk, ret);
+		break;
+	default:
+		return;
 	}
+	if (!ret)
+		ce->status = PCE_STATUS_ENABLED;
+	else
+		dev_err(dev, "%s: failed to enable clk %p, error %d\n",
+			__func__, ce->clk, ret);
 }
 
 /**
@@ -64,17 +172,20 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 		ce->clk = clk_get(dev, ce->con_id);
 	if (IS_ERR(ce->clk)) {
 		ce->status = PCE_STATUS_ERROR;
+		return;
+	} else if (clk_is_enabled_when_prepared(ce->clk)) {
+		/* we defer preparing the clock in that case */
+		ce->status = PCE_STATUS_ACQUIRED;
+		ce->enabled_when_prepared = true;
+	} else if (clk_prepare(ce->clk)) {
+		ce->status = PCE_STATUS_ERROR;
+		dev_err(dev, "clk_prepare() failed\n");
+		return;
 	} else {
-		if (clk_prepare(ce->clk)) {
-			ce->status = PCE_STATUS_ERROR;
-			dev_err(dev, "clk_prepare() failed\n");
-		} else {
-			ce->status = PCE_STATUS_ACQUIRED;
-			dev_dbg(dev,
-				"Clock %pC con_id %s managed by runtime PM.\n",
-				ce->clk, ce->con_id);
-		}
+		ce->status = PCE_STATUS_PREPARED;
 	}
+	dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",
+		ce->clk, ce->con_id);
 }
 
 static int __pm_clk_add(struct device *dev, const char *con_id,
@@ -106,9 +217,11 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
 
 	pm_clk_acquire(dev, ce);
 
-	spin_lock_irq(&psd->lock);
+	pm_clk_list_lock(psd);
 	list_add_tail(&ce->node, &psd->clock_list);
-	spin_unlock_irq(&psd->lock);
+	if (ce->enabled_when_prepared)
+		psd->clock_op_might_sleep++;
+	pm_clk_list_unlock(psd);
 	return 0;
 }
 
@@ -239,14 +352,20 @@ static void __pm_clk_remove(struct pm_clock_entry *ce)
 	if (!ce)
 		return;
 
-	if (ce->status < PCE_STATUS_ERROR) {
-		if (ce->status == PCE_STATUS_ENABLED)
-			clk_disable(ce->clk);
-
-		if (ce->status >= PCE_STATUS_ACQUIRED) {
-			clk_unprepare(ce->clk);
+	switch (ce->status) {
+	case PCE_STATUS_ENABLED:
+		clk_disable(ce->clk);
+		fallthrough;
+	case PCE_STATUS_PREPARED:
+		clk_unprepare(ce->clk);
+		fallthrough;
+	case PCE_STATUS_ACQUIRED:
+	case PCE_STATUS_ERROR:
+		if (!IS_ERR(ce->clk))
 			clk_put(ce->clk);
-		}
+		break;
+	default:
+		break;
 	}
 
 	kfree(ce->con_id);
@@ -269,7 +388,7 @@ void pm_clk_remove(struct device *dev, const char *con_id)
 	if (!psd)
 		return;
 
-	spin_lock_irq(&psd->lock);
+	pm_clk_list_lock(psd);
 
 	list_for_each_entry(ce, &psd->clock_list, node) {
 		if (!con_id && !ce->con_id)
@@ -280,12 +399,14 @@ void pm_clk_remove(struct device *dev, const char *con_id)
 			goto remove;
 	}
 
-	spin_unlock_irq(&psd->lock);
+	pm_clk_list_unlock(psd);
 	return;
 
  remove:
 	list_del(&ce->node);
-	spin_unlock_irq(&psd->lock);
+	if (ce->enabled_when_prepared)
+		psd->clock_op_might_sleep--;
+	pm_clk_list_unlock(psd);
 
 	__pm_clk_remove(ce);
 }
@@ -307,19 +428,21 @@ void pm_clk_remove_clk(struct device *dev, struct clk *clk)
 	if (!psd || !clk)
 		return;
 
-	spin_lock_irq(&psd->lock);
+	pm_clk_list_lock(psd);
 
 	list_for_each_entry(ce, &psd->clock_list, node) {
 		if (clk == ce->clk)
 			goto remove;
 	}
 
-	spin_unlock_irq(&psd->lock);
+	pm_clk_list_unlock(psd);
 	return;
 
  remove:
 	list_del(&ce->node);
-	spin_unlock_irq(&psd->lock);
+	if (ce->enabled_when_prepared)
+		psd->clock_op_might_sleep--;
+	pm_clk_list_unlock(psd);
 
 	__pm_clk_remove(ce);
 }
@@ -330,13 +453,16 @@ EXPORT_SYMBOL_GPL(pm_clk_remove_clk);
  * @dev: Device to initialize the list of PM clocks for.
  *
  * Initialize the lock and clock_list members of the device's pm_subsys_data
- * object.
+ * object, set the count of clocks that might sleep to 0.
  */
 void pm_clk_init(struct device *dev)
 {
 	struct pm_subsys_data *psd = dev_to_psd(dev);
-	if (psd)
+	if (psd) {
 		INIT_LIST_HEAD(&psd->clock_list);
+		mutex_init(&psd->clock_mutex);
+		psd->clock_op_might_sleep = 0;
+	}
 }
 EXPORT_SYMBOL_GPL(pm_clk_init);
 
@@ -372,12 +498,13 @@ void pm_clk_destroy(struct device *dev)
 
 	INIT_LIST_HEAD(&list);
 
-	spin_lock_irq(&psd->lock);
+	pm_clk_list_lock(psd);
 
 	list_for_each_entry_safe_reverse(ce, c, &psd->clock_list, node)
 		list_move(&ce->node, &list);
+	psd->clock_op_might_sleep = 0;
 
-	spin_unlock_irq(&psd->lock);
+	pm_clk_list_unlock(psd);
 
 	dev_pm_put_subsys_data(dev);
 
@@ -397,23 +524,30 @@ int pm_clk_suspend(struct device *dev)
 	struct pm_subsys_data *psd = dev_to_psd(dev);
 	struct pm_clock_entry *ce;
 	unsigned long flags;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
 	if (!psd)
 		return 0;
 
-	spin_lock_irqsave(&psd->lock, flags);
+	ret = pm_clk_op_lock(psd, &flags, __func__);
+	if (ret)
+		return ret;
 
 	list_for_each_entry_reverse(ce, &psd->clock_list, node) {
-		if (ce->status < PCE_STATUS_ERROR) {
-			if (ce->status == PCE_STATUS_ENABLED)
+		if (ce->status == PCE_STATUS_ENABLED) {
+			if (ce->enabled_when_prepared) {
+				clk_disable_unprepare(ce->clk);
+				ce->status = PCE_STATUS_ACQUIRED;
+			} else {
 				clk_disable(ce->clk);
-			ce->status = PCE_STATUS_ACQUIRED;
+				ce->status = PCE_STATUS_PREPARED;
+			}
 		}
 	}
 
-	spin_unlock_irqrestore(&psd->lock, flags);
+	pm_clk_op_unlock(psd, &flags);
 
 	return 0;
 }
@@ -428,18 +562,21 @@ int pm_clk_resume(struct device *dev)
 	struct pm_subsys_data *psd = dev_to_psd(dev);
 	struct pm_clock_entry *ce;
 	unsigned long flags;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
 	if (!psd)
 		return 0;
 
-	spin_lock_irqsave(&psd->lock, flags);
+	ret = pm_clk_op_lock(psd, &flags, __func__);
+	if (ret)
+		return ret;
 
 	list_for_each_entry(ce, &psd->clock_list, node)
 		__pm_clk_enable(dev, ce);
 
-	spin_unlock_irqrestore(&psd->lock, flags);
+	pm_clk_op_unlock(psd, &flags);
 
 	return 0;
 }
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8c1d04db99..3d751ae5bc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1164,6 +1164,27 @@ int clk_enable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_enable);
 
+/**
+ * clk_is_enabled_when_prepared - indicate if preparing a clock also enables it.
+ * @clk: clock source
+ *
+ * Returns true if clk_prepare() implicitly enables the clock, effectively
+ * making clk_enable()/clk_disable() no-ops, false otherwise.
+ *
+ * This is of interest mainly to power management code where actually
+ * disabling the clock also requires unpreparing it to have any material
+ * effect.
+ *
+ * Regardless of the value returned here, the caller must always invoke
+ * clk_enable() or clk_prepare_enable()  and counterparts for usage counts
+ * to be right.
+ */
+bool clk_is_enabled_when_prepared(struct clk *clk)
+{
+	return clk && !(clk->core->ops->enable && clk->core->ops->disable);
+}
+EXPORT_SYMBOL_GPL(clk_is_enabled_when_prepared);
+
 static int clk_core_prepare_enable(struct clk_core *core)
 {
 	int ret;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 31ff1bf1b7..a4a86aa8b1 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -238,6 +238,7 @@ static inline bool clk_is_match(const struct clk *p, const struct clk *q)
 
 #endif
 
+#ifdef CONFIG_HAVE_CLK_PREPARE
 /**
  * clk_prepare - prepare a clock source
  * @clk: clock source
@@ -246,10 +247,26 @@ static inline bool clk_is_match(const struct clk *p, const struct clk *q)
  *
  * Must not be called from within atomic context.
  */
-#ifdef CONFIG_HAVE_CLK_PREPARE
 int clk_prepare(struct clk *clk);
 int __must_check clk_bulk_prepare(int num_clks,
 				  const struct clk_bulk_data *clks);
+
+/**
+ * clk_is_enabled_when_prepared - indicate if preparing a clock also enables it.
+ * @clk: clock source
+ *
+ * Returns true if clk_prepare() implicitly enables the clock, effectively
+ * making clk_enable()/clk_disable() no-ops, false otherwise.
+ *
+ * This is of interest mainly to the power management code where actually
+ * disabling the clock also requires unpreparing it to have any material
+ * effect.
+ *
+ * Regardless of the value returned here, the caller must always invoke
+ * clk_enable() or clk_prepare_enable()  and counterparts for usage counts
+ * to be right.
+ */
+bool clk_is_enabled_when_prepared(struct clk *clk);
 #else
 static inline int clk_prepare(struct clk *clk)
 {
@@ -263,6 +280,11 @@ clk_bulk_prepare(int num_clks, const struct clk_bulk_data *clks)
 	might_sleep();
 	return 0;
 }
+
+static inline bool clk_is_enabled_when_prepared(struct clk *clk)
+{
+	return false;
+}
 #endif
 
 /**
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 47aca6bac1..482313a8cc 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -537,6 +537,8 @@ struct pm_subsys_data {
 	spinlock_t lock;
 	unsigned int refcount;
 #ifdef CONFIG_PM_CLK
+	unsigned int clock_op_might_sleep;
+	struct mutex clock_mutex;
 	struct list_head clock_list;
 #endif
 #ifdef CONFIG_PM_GENERIC_DOMAINS
