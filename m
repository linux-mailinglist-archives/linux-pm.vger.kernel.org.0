Return-Path: <linux-pm+bounces-13592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9696C090
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 16:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED01289E38
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F691DC72A;
	Wed,  4 Sep 2024 14:31:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DC1DC07F
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460263; cv=none; b=CxHyepFS2+wvDhiy6wL4uuRNC9aZZhdaOFfOVGptGog+4uJSbACDf/finVcBSoDnUCkWpfnyTkoy7TMx3QtqDEBJxjy3yCiBNG5HTeJlf3Gc/mbxOrv+g0iQkIuZeK0IX5Kg/6k43OCxY7UJV0YkKESW/IIMBRZKKjyLot6LIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460263; c=relaxed/simple;
	bh=ck5HEjZevSTu8uCue2LCvHvhdo2sBkHkQBl5O3C9hmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjT2jDsnI//2Y2Lx2TrDxMHVgXD57SzelijHrkrfwbZCpMJGveFlTDs7EvwKBvkkOZOsMGTHS925Fp7FPraoczgmHbuhsY9aXoapPsie9FGTf2/ppaXxEOyUcu0zNzOe2koUxqFvmedpsbYSs20OKJF/bouNdo+gq8zs17JCyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:ef52:68c5:eac1:f6b5])
	by albert.telenet-ops.be with cmsmtp
	id 8EWv2D00C3m5in106EWvSM; Wed, 04 Sep 2024 16:30:57 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr24-0028JP-Hu;
	Wed, 04 Sep 2024 16:30:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr27-004MyD-8m;
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
Subject: [PATCH 2/4] pmdomain: core: Fix "managed by" alignment in debug summary
Date: Wed,  4 Sep 2024 16:30:46 +0200
Message-Id: <e004f9d2a75e9a49c269507bb8a4514001751e85.1725459707.git.geert+renesas@glider.be>
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

The "performance" column contains variable-width values.  Hence when
their printed values contain more than one digit, all values in
successive columns become misaligned.

Fix this by formatting it as a fixed-width field.  Adjust successive
spaces and field widths to retain the exiting layout.

Fixes: 0155aaf95a2a09ba ("PM: domains: Add the domain HW-managed mode to the summary")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested by printing pseudo-random numbers instead of the actual
performance_state, as the latter is always zero for me.
---
 drivers/pmdomain/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index afa4e75863a40b49..912bdc131fc0e2b1 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3317,7 +3317,7 @@ static void mode_status_str(struct seq_file *s, struct device *dev)
 
 	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
 
-	seq_printf(s, "%20s", gpd_data->hw_mode ? "HW" : "SW");
+	seq_printf(s, "%9s", gpd_data->hw_mode ? "HW" : "SW");
 }
 
 static void perf_status_str(struct seq_file *s, struct device *dev)
@@ -3325,7 +3325,7 @@ static void perf_status_str(struct seq_file *s, struct device *dev)
 	struct generic_pm_domain_data *gpd_data;
 
 	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	seq_put_decimal_ull(s, "", gpd_data->performance_state);
+	seq_printf(s, "%-10u  ", gpd_data->performance_state);
 }
 
 static int genpd_summary_one(struct seq_file *s,
-- 
2.34.1


