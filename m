Return-Path: <linux-pm+bounces-13591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6986696C098
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 16:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B099B2863D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF721DC1B0;
	Wed,  4 Sep 2024 14:31:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6881DC1A2
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460262; cv=none; b=o131egTenRpoeI8yFnSqEougyLIOYZhrLj1b/lafI1aap6fO6XVfTvG5EkKDhjY4aqnN8b/s/g60c4tQ5l8cQ1hI0kduILjC0tZlZoiNFypmatHGnkeVa/B06sUpA16p8oJQIy0397u2h5OQ7Gop9aJwifQYA6H5uNuSuhDOUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460262; c=relaxed/simple;
	bh=IHJiZt3d3WP1/U0rfOhft2OuptnfKHxTsCu5JXAwzBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ba6OcobWIn5x04FVZtqB31bXTZmMhTGyCzZZRU6bXvEqFA/7gbmeDzuc6er3HQnHNrUmScEiG0Pj9wSgbIi/llMnE5MdE/SqRRCC6t3nNPxWTpcMcrgjZoGhhcW7o/JLk3ybXQZrn/Z2p7KfE8vl9fPj7L6FHjN2pB6EMDSOhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:ef52:68c5:eac1:f6b5])
	by albert.telenet-ops.be with cmsmtp
	id 8EWv2D00D3m5in106EWvSN; Wed, 04 Sep 2024 16:30:57 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr24-0028JW-Jx;
	Wed, 04 Sep 2024 16:30:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr27-004MyM-BS;
	Wed, 04 Sep 2024 16:30:55 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] pmdomain: core: Reduce debug summary table width
Date: Wed,  4 Sep 2024 16:30:48 +0200
Message-Id: <f8e1821364b6d5d11350447c128f6d2b470f33fe.1725459707.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725459707.git.geert+renesas@glider.be>
References: <cover.1725459707.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9094e53ff5c86ebe ("pmdomain: core: Use dev_name() instead of
kobject_get_path() in debugfs") severely shortened the names of devices
in a PM Domain.  Now the most common format[1] consists of a 32-bit
unit-address (8 characters), followed by a dot and a node name (20
characters for "air-pollution-sensor" and "interrupt-controller", which
are the longest generic node names documented in the Devicetree
Specification), for a typical maximum of 29 characters.

This offers a good opportunity to reduce the table width of the debug
summary:
  - Reduce the device name field width from 50 to 30 characters, which
    matches the PM Domain name width,
  - Reduce the large inter-column space between the "performance" and
    "managed by" columns.

Visual impact:
  - The "performance" column now starts at a position that is a
    multiple of 16, just like the "status" and "children" columns,
  - All of the "/device", "runtime status", and "managed by" columns are
    now indented 4 characters more than the columns right above them,
  - Everything fits in (one less than) 80 characters again ;-)

[1] Note that some device names (e.g. TI AM335x interconnect target
    modules) do not follow this convention, and may be much longer, but
    these didn't fit in the old 50-character column width either.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
On the Koelsch development board with an R-Car M2-W SoC, the contents of
/sys/kernel/debug/pm_genpd/pm_genpd_summary change from:

    domain                          status          children                           performance
        /device                                             runtime status                           managed by
    ------------------------------------------------------------------------------------------------------------
    clock-controller                on                                                 0
    sgx                             off-0                                              0
    sh-4a                           off-0                                              0
    ca15-cpu1                       on                                                 0
    ca15-cpu0                       on                                                 0
    ca15-scu                        on                                                 0
                                                    ca15-cpu0, ca15-cpu1
    always-on                       on                                                 0
                                                    ca15-scu, sh-4a, sgx
        e60b0000.i2c                                        suspended                  0                  SW
        ffca0000.timer                                      suspended                  0                  SW
        e6590100.usb-phy-controller                         unsupported                0                  SW
        e6050000.gpio                                       suspended                  0                  SW
        e6051000.gpio                                       suspended                  0                  SW
        e6052000.gpio                                       active                     0                  SW
        e6053000.gpio                                       active                     0                  SW
        e6054000.gpio                                       suspended                  0                  SW
        e6055000.gpio                                       active                     0                  SW
        e6055400.gpio                                       active                     0                  SW
        e6055800.gpio                                       active                     0                  SW
        ee090000.pci                                        active                     0                  SW
        ee0d0000.pci                                        active                     0                  SW
        e6700000.dma-controller                             active                     0                  SW
        e6720000.dma-controller                             active                     0                  SW
        ec700000.dma-controller                             suspended                  0                  SW
        ec720000.dma-controller                             suspended                  0                  SW
        e65a0000.dma-controller                             suspended                  0                  SW
        e65b0000.dma-controller                             suspended                  0                  SW
        e6e60000.serial                                     active                     0                  SW
        e6e68000.serial                                     active                     0                  SW
        ee300000.sata                                       active                     0                  SW
        e6b10000.spi                                        suspended                  0                  SW
        e6e20000.spi                                        suspended                  0                  SW
        e6518000.i2c                                        suspended                  0                  SW
        e6530000.i2c                                        suspended                  0                  SW
        e6520000.i2c                                        suspended                  0                  SW
        e61f0000.thermal                                    active                     0                  SW
        ec500000.sound                                      suspended                  0                  SW
        e61c0000.interrupt-controller                       active                     0                  SW
        ee700000.ethernet                                   active                     0                  SW
        ee100000.mmc                                        suspended                  0                  SW
        ee140000.mmc                                        suspended                  0                  SW
        ee160000.mmc                                        suspended                  0                  SW

to:

    domain                          status          children        performance
        /device                         runtime status                  managed by
    ------------------------------------------------------------------------------
    clock-controller                on                              0
    sgx                             off-0                           0
    sh-4a                           off-0                           0
    ca15-cpu1                       on                              0
    ca15-cpu0                       on                              0
    ca15-scu                        on                              0
                                                    ca15-cpu0, ca15-cpu1
    always-on                       on                              0
                                                    ca15-scu, sh-4a, sgx
        e60b0000.i2c                    suspended                   0           SW
        ffca0000.timer                  suspended                   0           SW
        e6590100.usb-phy-controller     unsupported                 0           SW
        e6050000.gpio                   suspended                   0           SW
        e6051000.gpio                   suspended                   0           SW
        e6052000.gpio                   active                      0           SW
        e6053000.gpio                   active                      0           SW
        e6054000.gpio                   suspended                   0           SW
        e6055000.gpio                   active                      0           SW
        e6055400.gpio                   active                      0           SW
        e6055800.gpio                   active                      0           SW
        ee090000.pci                    active                      0           SW
        ee0d0000.pci                    active                      0           SW
        e6700000.dma-controller         active                      0           SW
        e6720000.dma-controller         active                      0           SW
        ec700000.dma-controller         suspended                   0           SW
        ec720000.dma-controller         suspended                   0           SW
        e65a0000.dma-controller         suspended                   0           SW
        e65b0000.dma-controller         suspended                   0           SW
        e6e60000.serial                 active                      0           SW
        e6e68000.serial                 active                      0           SW
        ee300000.sata                   active                      0           SW
        e6b10000.spi                    suspended                   0           SW
        e6e20000.spi                    suspended                   0           SW
        e6518000.i2c                    suspended                   0           SW
        e6530000.i2c                    suspended                   0           SW
        e6520000.i2c                    suspended                   0           SW
        e61f0000.thermal                active                      0           SW
        ec500000.sound                  suspended                   0           SW
        e61c0000.interrupt-controller   active                      0           SW
        ee700000.ethernet               active                      0           SW
        ee100000.mmc                    suspended                   0           SW
        ee140000.mmc                    suspended                   0           SW
        ee160000.mmc                    suspended                   0           SW
---
 drivers/pmdomain/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 2233daaa4168be14..2c51de5d58372d3d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3308,7 +3308,7 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
 	else
 		WARN_ON(1);
 
-	seq_printf(s, "%-25s  ", p);
+	seq_printf(s, "%-26s  ", p);
 }
 
 static void perf_status_str(struct seq_file *s, struct device *dev)
@@ -3326,7 +3326,7 @@ static void mode_status_str(struct seq_file *s, struct device *dev)
 
 	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
 
-	seq_printf(s, "%9s", gpd_data->hw_mode ? "HW" : "SW");
+	seq_printf(s, "%2s", gpd_data->hw_mode ? "HW" : "SW");
 }
 
 static int genpd_summary_one(struct seq_file *s,
@@ -3353,7 +3353,7 @@ static int genpd_summary_one(struct seq_file *s,
 	else
 		snprintf(state, sizeof(state), "%s",
 			 status_lookup[genpd->status]);
-	seq_printf(s, "%-30s  %-49s  %u", genpd->name, state, genpd->performance_state);
+	seq_printf(s, "%-30s  %-30s  %u", genpd->name, state, genpd->performance_state);
 
 	/*
 	 * Modifications on the list require holding locks on both
@@ -3369,7 +3369,7 @@ static int genpd_summary_one(struct seq_file *s,
 	}
 
 	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		seq_printf(s, "\n    %-50s  ", dev_name(pm_data->dev));
+		seq_printf(s, "\n    %-30s  ", dev_name(pm_data->dev));
 		rtpm_status_str(s, pm_data->dev);
 		perf_status_str(s, pm_data->dev);
 		mode_status_str(s, pm_data->dev);
@@ -3387,9 +3387,9 @@ static int summary_show(struct seq_file *s, void *data)
 	struct generic_pm_domain *genpd;
 	int ret = 0;
 
-	seq_puts(s, "domain                          status          children                           performance\n");
-	seq_puts(s, "    /device                                             runtime status                           managed by\n");
-	seq_puts(s, "------------------------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "domain                          status          children        performance\n");
+	seq_puts(s, "    /device                         runtime status                  managed by\n");
+	seq_puts(s, "------------------------------------------------------------------------------\n");
 
 	ret = mutex_lock_interruptible(&gpd_list_lock);
 	if (ret)
-- 
2.34.1


