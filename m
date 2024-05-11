Return-Path: <linux-pm+bounces-7736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E08C2F48
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 05:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3822832C7
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 03:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975EF335D3;
	Sat, 11 May 2024 03:15:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4132421A04;
	Sat, 11 May 2024 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397314; cv=none; b=VZIgq5K8EUe00GcumMtTgm6CZQoIxhsNaWWiTH3MRiuTGYctKjk6mtJyPbFmzFYbf2aft7CEgXXh40QhTEDVBHfvGNZbiuwWv/v0wy88fiH2pJe/O0K4O0cbVmiUbTBOmgYPmpycMH0zqHejoXj3ZdQm6HCV11rlCiLRNHTwnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397314; c=relaxed/simple;
	bh=7hKBsyDeJ3WJA3XhH1oHn62d0U8OLqzso5Esv3yvRT8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XyWz0qYKhCV2uAHhT7ZvAzYKFADoCDjWJc5NLx01MUj5VslGEg8Y5EaVzRYC5e02tkYKMmVh4Fu7YL35Y70C07vO2al+WHF3xDViaBF6OL1U+xwhj9BO0b6JApJrjBOpBXznVMRDesHYf5hqtG4y9+cF8feXYkJporTfI7IFfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C2EC1A02A7;
	Sat, 11 May 2024 05:15:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8116F1A07A8;
	Sat, 11 May 2024 05:15:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BB0BA181D0FC;
	Sat, 11 May 2024 11:15:00 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: ulf.hansson@linaro.org,
	heiko@sntech.de,
	u.kleine-koenig@pengutronix.de,
	geert+renesas@glider.be,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com,
	frank.li@nxp.com,
	mkl@pengutronix.de,
	linus.walleij@linaro.org
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] pmdomain: imx: gpcv2: Add delay after power up handshake
Date: Sat, 11 May 2024 10:55:25 +0800
Message-Id: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

AudioMix BLK-CTRL on i.MX8MP encountered an accessing register issue
after power up.

[    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
[    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
[    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
[    2.181050] Workqueue: events_unbound deferred_probe_work_func
[    2.181064] Call trace:
[...]
[    2.181142]  arm64_serror_panic+0x6c/0x78
[    2.181149]  do_serror+0x3c/0x70
[    2.181157]  el1h_64_error_handler+0x30/0x48
[    2.181164]  el1h_64_error+0x64/0x68
[    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
[    2.181183]  __genpd_runtime_resume+0x30/0x80
[    2.181195]  genpd_runtime_resume+0x110/0x244
[    2.181205]  __rpm_callback+0x48/0x1d8
[    2.181213]  rpm_callback+0x68/0x74
[    2.181224]  rpm_resume+0x468/0x6c0
[    2.181234]  __pm_runtime_resume+0x50/0x94
[    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
[    2.181258]  __driver_probe_device+0x48/0x12c
[    2.181268]  driver_probe_device+0xd8/0x15c
[    2.181278]  __device_attach_driver+0xb8/0x134
[    2.181290]  bus_for_each_drv+0x84/0xe0
[    2.181302]  __device_attach+0x9c/0x188
[    2.181312]  device_initial_probe+0x14/0x20
[    2.181323]  bus_probe_device+0xac/0xb0
[    2.181334]  deferred_probe_work_func+0x88/0xc0
[    2.181344]  process_one_work+0x150/0x290
[    2.181357]  worker_thread+0x2f8/0x408
[    2.181370]  kthread+0x110/0x114
[    2.181381]  ret_from_fork+0x10/0x20
[    2.181391] SMP: stopping secondary CPUs

According to comments in power up handshake:

	/* request the ADB400 to power up */
	if (domain->bits.hskreq) {
		regmap_update_bits(domain->regmap, domain->regs->hsk,
				   domain->bits.hskreq, domain->bits.hskreq);

		/*
		 * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
		 *				  (reg_val & domain->bits.hskack), 0,
		 *				  USEC_PER_MSEC);
		 * Technically we need the commented code to wait handshake. But that needs
		 * the BLK-CTL module BUS clk-en bit being set.
		 *
		 * There is a separate BLK-CTL module and we will have such a driver for it,
		 * that driver will set the BUS clk-en bit and handshake will be triggered
		 * automatically there. Just add a delay and suppose the handshake finish
		 * after that.
		 */
	}

The BLK-CTL module needs to add delay to wait for a handshake request finished.
For some BLK-CTL module (eg. AudioMix on i.MX8MP) doesn't have BUS clk-en
bit, it is better to add delay in this driver, as the BLK-CTL module doesn't
need to care about how it is powered up.

regmap_read_bypassed() is to make sure the above write IO transaction already
reaches target before udelay().

Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Closes: https://lore.kernel.org/all/66293535.170a0220.21fe.a2e7@mx.google.com/
Suggested-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v3:
- move change to gpcv2.c, as it is more reasonable to let power driver
  to handle such power issue, suggested by Frank Li

changes in v2:
- reduce size of panic log in commit message

 drivers/pmdomain/imx/gpcv2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 4b828d74a606..856eaac0ec14 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -393,6 +393,17 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		 * automatically there. Just add a delay and suppose the handshake finish
 		 * after that.
 		 */
+
+		/*
+		 * For some BLK-CTL module (eg. AudioMix on i.MX8MP) doesn't have BUS
+		 * clk-en bit, it is better to add delay here, as the BLK-CTL module
+		 * doesn't need to care about how it is powered up.
+		 *
+		 * regmap_read_bypassed() is to make sure the above write IO transaction
+		 * already reaches target before udelay()
+		 */
+		regmap_read_bypassed(domain->regmap, domain->regs->hsk, &reg_val);
+		udelay(5);
 	}
 
 	/* Disable reset clocks for all devices in the domain */
-- 
2.34.1


