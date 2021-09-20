Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B65412C60
	for <lists+linux-pm@lfdr.de>; Tue, 21 Sep 2021 04:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350476AbhIUCnt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 22:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhIUCCj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 22:02:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621EEC1400AB;
        Mon, 20 Sep 2021 11:12:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u8so19847062lff.9;
        Mon, 20 Sep 2021 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcjaPyxUOcH+Po9iWB7z9kNYrbD1HMHOoC8A400eowg=;
        b=UM/ko01aCuthp92r37GPlR03YsKDOEweZSdVVdKxuobOIpZ58cPAs/v4LzY4D1nuKk
         zIHPfFs5sgTh4AFcPN6WngXe1oJ3kBvKhUJxT3GHNS5AaFkNQ+Rfo/FBRY5HSaV+cWGz
         x/JYpB/w+M47ARc6jN9Y9xTvd3BK3xxWdqdHeKzdbbziMjvjQ7l4tqNumDY4IvmRIhqi
         1a2GKdGVzJYksI0vYbDVDljsaiFUCoVXobFMul9eNdtIW3ZwPIVaLkGAq5Rtg2jBQo/j
         j0nH8arimnmSoepWP3IlVYpM+Th6JWgcrta6MRhKr0zgi1pJzL+uy4yxkFhxCREL7kpV
         Rb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcjaPyxUOcH+Po9iWB7z9kNYrbD1HMHOoC8A400eowg=;
        b=zzpy7KrUnJkm1h4J5d2nhzQC0hF552gVbA5Qc7HHLGKM8LbXMkgK8nklC7ZYz44Jhx
         57ldHXVySd2g6QO2ADA8L0B8vQFczhR8ewqiRnFlH4V0UjY7hCrKmr984GfbjaFAvoDA
         eJZc+7IPT/k2ebcCspGx+Cw/1ua6WkI7H2bg4ckmottGKCPyf9iF5pyVtNT6ESt306ZR
         9Fqk16PB9ZndV1rJM+OecXB8pDzzR8ImAeKn3KTB1ngQs/0od9uxrKQZMgtE2m3tCD0Y
         89HOuTog0lPbVBB9FdDv/5WX6LH1G6WQUyMXEqlUsFSO9pTUwaU7UDY/O0pO5MDJ1xFp
         Ml6Q==
X-Gm-Message-State: AOAM531wUmNLkb/kBoMAVA3UQgmF6us3j3sam5L0sFs5jZExWmYR8zsk
        g5x76ZELVFznm2Bo1Nof7QQ=
X-Google-Smtp-Source: ABdhPJzoRsuYkly/8ewFVEICJsnb24cOJ02pKw4wVJLL5dpbwol6WZZHotCxulWs+DvWJLBZODOSUw==
X-Received: by 2002:a19:9142:: with SMTP id y2mr4270710lfj.168.1632161529743;
        Mon, 20 Sep 2021 11:12:09 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v12 09/35] gpu: host1x: Add runtime PM and OPP support
Date:   Mon, 20 Sep 2021 21:11:19 +0300
Message-Id: <20210920181145.19543-10-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add runtime PM and OPP support to the Host1x driver. For the starter we
will keep host1x always-on because dynamic power management require a major
refactoring of the driver code since lot's of code paths are missing the
RPM handling and we're going to remove some of these paths in the future.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/debug.c         |  15 +++
 drivers/gpu/host1x/dev.c           | 151 +++++++++++++++++++++++------
 drivers/gpu/host1x/dev.h           |   3 +-
 drivers/gpu/host1x/hw/channel_hw.c |  44 ++++-----
 drivers/gpu/host1x/intr.c          |   3 -
 drivers/gpu/host1x/syncpt.c        |   5 +-
 6 files changed, 165 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/host1x/debug.c b/drivers/gpu/host1x/debug.c
index 8a14880c61bb..18d9c8d206e3 100644
--- a/drivers/gpu/host1x/debug.c
+++ b/drivers/gpu/host1x/debug.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 
@@ -52,6 +53,11 @@ static int show_channel(struct host1x_channel *ch, void *data, bool show_fifo)
 {
 	struct host1x *m = dev_get_drvdata(ch->dev->parent);
 	struct output *o = data;
+	int err;
+
+	err = pm_runtime_resume_and_get(m->dev);
+	if (err < 0)
+		return err;
 
 	mutex_lock(&ch->cdma.lock);
 	mutex_lock(&debug_lock);
@@ -64,6 +70,8 @@ static int show_channel(struct host1x_channel *ch, void *data, bool show_fifo)
 	mutex_unlock(&debug_lock);
 	mutex_unlock(&ch->cdma.lock);
 
+	pm_runtime_put(m->dev);
+
 	return 0;
 }
 
@@ -71,9 +79,14 @@ static void show_syncpts(struct host1x *m, struct output *o)
 {
 	struct list_head *pos;
 	unsigned int i;
+	int err;
 
 	host1x_debug_output(o, "---- syncpts ----\n");
 
+	err = pm_runtime_resume_and_get(m->dev);
+	if (err < 0)
+		return;
+
 	for (i = 0; i < host1x_syncpt_nb_pts(m); i++) {
 		u32 max = host1x_syncpt_read_max(m->syncpt + i);
 		u32 min = host1x_syncpt_load(m->syncpt + i);
@@ -101,6 +114,8 @@ static void show_syncpts(struct host1x *m, struct output *o)
 					    base_val);
 	}
 
+	pm_runtime_put(m->dev);
+
 	host1x_debug_output(o, "\n");
 }
 
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index fbb6447b8659..595b91099e3e 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -6,14 +6,18 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
+#include <soc/tegra/common.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/host1x.h>
 #undef CREATE_TRACE_POINTS
@@ -190,6 +194,9 @@ static void host1x_setup_sid_table(struct host1x *host)
 	const struct host1x_info *info = host->info;
 	unsigned int i;
 
+	if (!info->has_hypervisor)
+		return;
+
 	for (i = 0; i < info->num_sid_entries; i++) {
 		const struct host1x_sid_entry *entry = &info->sid_table[i];
 
@@ -347,6 +354,27 @@ static void host1x_iommu_exit(struct host1x *host)
 	}
 }
 
+static int host1x_get_resets(struct host1x *host)
+{
+	int err;
+
+	host->resets[0].id = "mc";
+	host->resets[1].id = "host1x";
+	host->nresets = ARRAY_SIZE(host->resets);
+
+	err = devm_reset_control_bulk_get_optional_exclusive_released(
+				host->dev, host->nresets, host->resets);
+	if (err) {
+		dev_err(host->dev, "failed to get reset: %d\n", err);
+		return err;
+	}
+
+	if (WARN_ON(!host->resets[1].rstc))
+		return -ENOENT;
+
+	return 0;
+}
+
 static int host1x_probe(struct platform_device *pdev)
 {
 	struct host1x *host;
@@ -423,12 +451,9 @@ static int host1x_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	host->rst = devm_reset_control_get(&pdev->dev, "host1x");
-	if (IS_ERR(host->rst)) {
-		err = PTR_ERR(host->rst);
-		dev_err(&pdev->dev, "failed to get reset: %d\n", err);
+	err = host1x_get_resets(host);
+	if (err)
 		return err;
-	}
 
 	err = host1x_iommu_init(host);
 	if (err < 0) {
@@ -443,22 +468,10 @@ static int host1x_probe(struct platform_device *pdev)
 		goto iommu_exit;
 	}
 
-	err = clk_prepare_enable(host->clk);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto free_channels;
-	}
-
-	err = reset_control_deassert(host->rst);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to deassert reset: %d\n", err);
-		goto unprepare_disable;
-	}
-
 	err = host1x_syncpt_init(host);
 	if (err) {
 		dev_err(&pdev->dev, "failed to initialize syncpts\n");
-		goto reset_assert;
+		goto free_channels;
 	}
 
 	err = host1x_intr_init(host, syncpt_irq);
@@ -467,10 +480,18 @@ static int host1x_probe(struct platform_device *pdev)
 		goto deinit_syncpt;
 	}
 
-	host1x_debug_init(host);
+	pm_runtime_enable(&pdev->dev);
+
+	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (err)
+		goto pm_disable;
 
-	if (host->info->has_hypervisor)
-		host1x_setup_sid_table(host);
+	/* the driver's code isn't ready yet for the dynamic RPM */
+	err = pm_runtime_resume_and_get(&pdev->dev);
+	if (err)
+		goto pm_disable;
+
+	host1x_debug_init(host);
 
 	err = host1x_register(host);
 	if (err < 0)
@@ -486,13 +507,14 @@ static int host1x_probe(struct platform_device *pdev)
 	host1x_unregister(host);
 deinit_debugfs:
 	host1x_debug_deinit(host);
+
+	pm_runtime_put(&pdev->dev);
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
 	host1x_intr_deinit(host);
 deinit_syncpt:
 	host1x_syncpt_deinit(host);
-reset_assert:
-	reset_control_assert(host->rst);
-unprepare_disable:
-	clk_disable_unprepare(host->clk);
 free_channels:
 	host1x_channel_list_free(&host->channel_list);
 iommu_exit:
@@ -507,19 +529,94 @@ static int host1x_remove(struct platform_device *pdev)
 
 	host1x_unregister(host);
 	host1x_debug_deinit(host);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	host1x_intr_deinit(host);
 	host1x_syncpt_deinit(host);
-	reset_control_assert(host->rst);
-	clk_disable_unprepare(host->clk);
 	host1x_iommu_exit(host);
 
 	return 0;
 }
 
+static int __maybe_unused host1x_runtime_suspend(struct device *dev)
+{
+	struct host1x *host = dev_get_drvdata(dev);
+	int err;
+
+	host1x_intr_stop(host);
+	host1x_syncpt_save(host);
+
+	err = reset_control_bulk_assert(host->nresets, host->resets);
+	if (err) {
+		dev_err(dev, "failed to assert reset: %d\n", err);
+		goto resume_host1x;
+	}
+
+	usleep_range(1000, 2000);
+
+	clk_disable_unprepare(host->clk);
+	reset_control_bulk_release(host->nresets, host->resets);
+
+	return 0;
+
+resume_host1x:
+	host1x_setup_sid_table(host);
+	host1x_syncpt_restore(host);
+	host1x_intr_start(host);
+
+	return err;
+}
+
+static int __maybe_unused host1x_runtime_resume(struct device *dev)
+{
+	struct host1x *host = dev_get_drvdata(dev);
+	int err;
+
+	err = reset_control_bulk_acquire(host->nresets, host->resets);
+	if (err) {
+		dev_err(dev, "failed to acquire reset: %d\n", err);
+		return err;
+	}
+
+	err = clk_prepare_enable(host->clk);
+	if (err) {
+		dev_err(dev, "failed to enable clock: %d\n", err);
+		goto release_reset;
+	}
+
+	err = reset_control_bulk_deassert(host->nresets, host->resets);
+	if (err < 0) {
+		dev_err(dev, "failed to deassert reset: %d\n", err);
+		goto disable_clk;
+	}
+
+	host1x_setup_sid_table(host);
+	host1x_syncpt_restore(host);
+	host1x_intr_start(host);
+
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(host->clk);
+release_reset:
+	reset_control_bulk_release(host->nresets, host->resets);
+
+	return err;
+}
+
+static const struct dev_pm_ops host1x_pm = {
+	SET_RUNTIME_PM_OPS(host1x_runtime_suspend, host1x_runtime_resume,
+			   NULL)
+	/* TODO: add system suspend-resume once driver will be ready for that */
+};
+
 static struct platform_driver tegra_host1x_driver = {
 	.driver = {
 		.name = "tegra-host1x",
 		.of_match_table = host1x_of_match,
+		.pm = &host1x_pm,
 	},
 	.probe = host1x_probe,
 	.remove = host1x_remove,
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index fa6d4bc46e98..41a7a63514c4 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -118,7 +118,8 @@ struct host1x {
 	struct host1x_syncpt_base *bases;
 	struct device *dev;
 	struct clk *clk;
-	struct reset_control *rst;
+	struct reset_control_bulk_data resets[2];
+	unsigned int nresets;
 
 	struct iommu_group *group;
 	struct iommu_domain *domain;
diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
index 1999780a7203..6b40e9af1e88 100644
--- a/drivers/gpu/host1x/hw/channel_hw.c
+++ b/drivers/gpu/host1x/hw/channel_hw.c
@@ -159,6 +159,27 @@ static void host1x_channel_set_streamid(struct host1x_channel *channel)
 #endif
 }
 
+static void host1x_enable_gather_filter(struct host1x_channel *ch)
+{
+#if HOST1X_HW >= 6
+	struct host1x *host = dev_get_drvdata(ch->dev->parent);
+	u32 val;
+
+	if (!host->hv_regs)
+		return;
+
+	val = host1x_hypervisor_readl(
+		host, HOST1X_HV_CH_KERNEL_FILTER_GBUFFER(ch->id / 32));
+	val |= BIT(ch->id % 32);
+	host1x_hypervisor_writel(
+		host, val, HOST1X_HV_CH_KERNEL_FILTER_GBUFFER(ch->id / 32));
+#elif HOST1X_HW >= 4
+	host1x_ch_writel(ch,
+			 HOST1X_CHANNEL_CHANNELCTRL_KERNEL_FILTER_GBUFFER(1),
+			 HOST1X_CHANNEL_CHANNELCTRL);
+#endif
+}
+
 static int channel_submit(struct host1x_job *job)
 {
 	struct host1x_channel *ch = job->channel;
@@ -190,6 +211,7 @@ static int channel_submit(struct host1x_job *job)
 	}
 
 	host1x_channel_set_streamid(ch);
+	host1x_enable_gather_filter(ch);
 
 	/* begin a CDMA submit */
 	err = host1x_cdma_begin(&ch->cdma, job);
@@ -249,27 +271,6 @@ static int channel_submit(struct host1x_job *job)
 	return err;
 }
 
-static void enable_gather_filter(struct host1x *host,
-				 struct host1x_channel *ch)
-{
-#if HOST1X_HW >= 6
-	u32 val;
-
-	if (!host->hv_regs)
-		return;
-
-	val = host1x_hypervisor_readl(
-		host, HOST1X_HV_CH_KERNEL_FILTER_GBUFFER(ch->id / 32));
-	val |= BIT(ch->id % 32);
-	host1x_hypervisor_writel(
-		host, val, HOST1X_HV_CH_KERNEL_FILTER_GBUFFER(ch->id / 32));
-#elif HOST1X_HW >= 4
-	host1x_ch_writel(ch,
-			 HOST1X_CHANNEL_CHANNELCTRL_KERNEL_FILTER_GBUFFER(1),
-			 HOST1X_CHANNEL_CHANNELCTRL);
-#endif
-}
-
 static int host1x_channel_init(struct host1x_channel *ch, struct host1x *dev,
 			       unsigned int index)
 {
@@ -278,7 +279,6 @@ static int host1x_channel_init(struct host1x_channel *ch, struct host1x *dev,
 #else
 	ch->regs = dev->regs + index * 0x100;
 #endif
-	enable_gather_filter(dev, ch);
 	return 0;
 }
 
diff --git a/drivers/gpu/host1x/intr.c b/drivers/gpu/host1x/intr.c
index 45b6be927ec4..965ba21818b1 100644
--- a/drivers/gpu/host1x/intr.c
+++ b/drivers/gpu/host1x/intr.c
@@ -297,14 +297,11 @@ int host1x_intr_init(struct host1x *host, unsigned int irq_sync)
 			 "host1x_sp_%02u", id);
 	}
 
-	host1x_intr_start(host);
-
 	return 0;
 }
 
 void host1x_intr_deinit(struct host1x *host)
 {
-	host1x_intr_stop(host);
 }
 
 void host1x_intr_start(struct host1x *host)
diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index d198a10848c6..e08e331e46ae 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -143,6 +143,8 @@ void host1x_syncpt_restore(struct host1x *host)
 	for (i = 0; i < host1x_syncpt_nb_bases(host); i++)
 		host1x_hw_syncpt_restore_wait_base(host, sp_base + i);
 
+	host1x_hw_syncpt_enable_protection(host);
+
 	wmb();
 }
 
@@ -366,9 +368,6 @@ int host1x_syncpt_init(struct host1x *host)
 	host->syncpt = syncpt;
 	host->bases = bases;
 
-	host1x_syncpt_restore(host);
-	host1x_hw_syncpt_enable_protection(host);
-
 	/* Allocate sync point to use for clearing waits for expired fences */
 	host->nop_sp = host1x_syncpt_alloc(host, 0, "reserved-nop");
 	if (!host->nop_sp)
-- 
2.32.0

