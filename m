Return-Path: <linux-pm+bounces-11772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C19943702
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 22:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985C4B23AAD
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 20:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6829616CD09;
	Wed, 31 Jul 2024 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugq/t2kA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFB616C87B;
	Wed, 31 Jul 2024 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456979; cv=none; b=Lkgr2uqEzZbIhef5n4gcM4EiVADpqfffdgYcYAaYrHCtrLp3MfdsCS1iNgFLjPOxPWcVEwRrZLuwdCTQFkGI9iDkulRV6oB2JoUxr+mZTliK/o7t/G2vQYRDWOuO9oaAlEp/AJS8UXkDvQqRvyrvOBjMY81/YIPziAHhA0JkK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456979; c=relaxed/simple;
	bh=DiyhX8yumavlCwzOlf34nZDby+Y3G8PuxaAMdIsspjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFSgg41CmRroFFtSNbkpd60yyrBSpTZY5WW34Eqbp4Xny6M0liwQFCKeByXTT55q4zocr/ptqUX7OaGIoiu0WrrS85PSFRLokemT9aBUowCfwq/uq1xJh1wLzUbl4FeXC9KXNn4raLa63LiMNvEAP82gZQ5442medCBh8LBDOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugq/t2kA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011E9C116B1;
	Wed, 31 Jul 2024 20:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456979;
	bh=DiyhX8yumavlCwzOlf34nZDby+Y3G8PuxaAMdIsspjE=;
	h=From:To:Cc:Subject:Date:From;
	b=Ugq/t2kAWfxRBMZCvicvH2hfM+YVi5YqCm/G+wijpunQAXl0CTCR9yX+if28hSZlb
	 o6Fn+1Gnc1lokd1g+yOh4ksqUoUdwyt1y+/k771nT5BaOi091AyjBAX/mrVYo2EnOo
	 Tn5Ypsn+pLySrlzE2g4DsWZOR8BdO4n7A1Ci2HAgr0KwbK6zE1mkmlZVORvZIM+Ov1
	 AR/Ug24320NQSVAxLCBK+yjmhki4vCO9ZUBPxGH1TyWxqNnZ4AFRv3ZPSTf9fK4Kl7
	 Sbl5zUwEwhJTUdbgDPB2WlfaHgv1HFZwwxHylNpyK/voxFRaY3Fby0ViKfSqB8miVH
	 eOAqAJNxQsxZA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: spear: Use of_property_for_each_u32() instead of open coding
Date: Wed, 31 Jul 2024 14:16:15 -0600
Message-ID: <20240731201615.1841145-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_count_u32_elems() and of_property_for_each_u32() instead
of of_find_property() and open coding the property parsing.

This is part of a larger effort to remove callers of of_find_property()
and similar functions. of_find_property() leaks the DT struct property
and data pointers which is a problem for dynamically allocated nodes
which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/cpufreq/spear-cpufreq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 78b875db6b66..4d28147c23f1 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -171,9 +171,8 @@ static struct cpufreq_driver spear_cpufreq_driver = {
 static int spear_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
-	const struct property *prop;
 	struct cpufreq_frequency_table *freq_tbl;
-	const __be32 *val;
+	u32 val;
 	int cnt, i, ret;
 
 	np = of_cpu_device_node_get(0);
@@ -186,26 +185,23 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
 				&spear_cpufreq.transition_latency))
 		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
 
-	prop = of_find_property(np, "cpufreq_tbl", NULL);
-	if (!prop || !prop->value) {
+	cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
+	if (cnt <= 0) {
 		pr_err("Invalid cpufreq_tbl\n");
 		ret = -ENODEV;
 		goto out_put_node;
 	}
 
-	cnt = prop->length / sizeof(u32);
-	val = prop->value;
-
 	freq_tbl = kcalloc(cnt + 1, sizeof(*freq_tbl), GFP_KERNEL);
 	if (!freq_tbl) {
 		ret = -ENOMEM;
 		goto out_put_node;
 	}
 
-	for (i = 0; i < cnt; i++)
-		freq_tbl[i].frequency = be32_to_cpup(val++);
+	of_property_for_each_u32(np, "cpufreq_tbl", &val)
+		freq_tbl[i].frequency = val;
 
-	freq_tbl[i].frequency = CPUFREQ_TABLE_END;
+	freq_tbl[cnt].frequency = CPUFREQ_TABLE_END;
 
 	spear_cpufreq.freq_tbl = freq_tbl;
 
-- 
2.43.0


