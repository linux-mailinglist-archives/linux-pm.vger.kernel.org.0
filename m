Return-Path: <linux-pm+bounces-32249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10073B24429
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 10:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A521AA29CD
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899182DE1F0;
	Wed, 13 Aug 2025 08:20:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F11E0DE2;
	Wed, 13 Aug 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073230; cv=none; b=JFu8JJbueSBsQUxbHhFmPChwJvhNwK+O+KYl8CzGBJ6+Z057qDsJr1nMatPohhrcwRdTxESggYh5nruSK8977RDAOm2XE5EE5CIkFsBxZzgLaDg8toAL+fNgTuWOWgit+9w3lw3e+RDRFrl9Q67QeaLU1sBNRAb3EAY5jTWu5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073230; c=relaxed/simple;
	bh=6ayZlO2PSXhtLjxbAr30198jx2UL7fDJVteF34QqTfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyPJnxKp5JmkwPsCkhHHs1VZGHkv/a9MLg+eXbd89+oJqXf82EQvscXXuUo1DImQkHCdCPpEKd3udqudjAWzca9cRJ44bBDy7lo6o9JMBReHJ3PDUCEqsCRbKjtK2UhTbMK5JJ/lU0jOQfEcfUelLo8HaFUpT+2KZrXhrScGAeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2526C4CEEB;
	Wed, 13 Aug 2025 08:20:27 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: renesas: mstp: Add genpd OF provider at postcore_initcall()
Date: Wed, 13 Aug 2025 10:20:22 +0200
Message-ID: <81ef5f8d5d31374b7852b05453c52d2f735062a2.1755073087.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Genpd OF providers must now be registered after genpd bus registration.
However, cpg_mstp_add_clk_domain() is only called from CLK_OF_DECLARE(),
which is too early.  Hence on R-Car M1A, R-Car H1, and RZ/A1, the
CPG/MSTP Clock Domain fails to register, and any devices residing in
that clock domain fail to probe.

Fix this by splitting initialization into two steps:
  - The first part keeps on registering the PM domain with genpd at
    CLK_OF_DECLARE(),
  - The second and new part moves the registration of the genpd OF
    provider to a postcore_initcall().

See also commit c5ae5a0c61120d0c ("pmdomain: renesas: rcar-sysc: Add
genpd OF provider at postcore_initcall").

Fixes: 18a3a510ecfd0e50 ("pmdomain: core: Add the genpd->dev to the genpd provider bus")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued as a fix in renesas-clk-for-v6.17.

drivers/clk/mmp/clk-of-mmp2.c:mmp2_pm_domain_init() has the same issue.

Note that R-Car H1 still booted fine, as the CPG/MSTP Clock Domain is no
longer used directly on that SoC: all devices were moved to the R-Car
SYSC PM Domain in commits 751e29bbb64ad091 ("ARM: dts: r8a7779: Use SYSC
"always-on" PM Domain") and commit a03fa77d85a736d3 ("ARM: dts: r8a7779:
Use SYSC "always-on" PM Domain for HSCIF"), and use the clock domain
only indirectly from rcar-sysc through cpg_mstp_{at,de}tach_dev()).
---
 drivers/clk/renesas/clk-mstp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 6b47bb5eee45f75b..5fcc81b92a973771 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -305,6 +305,9 @@ void cpg_mstp_detach_dev(struct generic_pm_domain *unused, struct device *dev)
 		pm_clk_destroy(dev);
 }
 
+static struct device_node *cpg_mstp_pd_np __initdata = NULL;
+static struct generic_pm_domain *cpg_mstp_pd_genpd __initdata = NULL;
+
 void __init cpg_mstp_add_clk_domain(struct device_node *np)
 {
 	struct generic_pm_domain *pd;
@@ -326,5 +329,20 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
 	pd->detach_dev = cpg_mstp_detach_dev;
 	pm_genpd_init(pd, &pm_domain_always_on_gov, false);
 
-	of_genpd_add_provider_simple(np, pd);
+	cpg_mstp_pd_np = of_node_get(np);
+	cpg_mstp_pd_genpd = pd;
+}
+
+static int __init cpg_mstp_pd_init_provider(void)
+{
+	int error;
+
+	if (!cpg_mstp_pd_np)
+		return -ENODEV;
+
+	error = of_genpd_add_provider_simple(cpg_mstp_pd_np, cpg_mstp_pd_genpd);
+
+	of_node_put(cpg_mstp_pd_np);
+	return error;
 }
+postcore_initcall(cpg_mstp_pd_init_provider);
-- 
2.43.0


