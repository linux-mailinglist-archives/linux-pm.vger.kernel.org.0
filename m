Return-Path: <linux-pm+bounces-23730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FBEA58BAE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 06:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615D7188C368
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 05:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96AC1C5D53;
	Mon, 10 Mar 2025 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIDX2/E4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9CD2F28;
	Mon, 10 Mar 2025 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741584530; cv=none; b=tq0AocbHdfc0WPqXytpLpfP4PZZLzfGffSuHRluJcCmSKuBfrJ91H/KXW3wVhn8a/WCqiseW1VRBMfgw2NdcjioitV0SaIUDaIPP51yBD1sJDkxiDqlBMc/fADygsQdp+caFpAakcHDPczQ0cEKU+T5UE3FAxA+21bTGITD6//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741584530; c=relaxed/simple;
	bh=xZ+9XNOyt3FXchZM+SS0uxDvW1K/kZComkL9YrJmHt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Maj5UlnxzaWj4stapCroCeuNZbil8fJOXGqT3jxCqF3zNEkMWomlNY1e7Xqzt8yXk6Bu4H+6BvdaW23TgN/PhM6vxchL8rpjFiRwjViOfdRzx9Z2Ofs+a1RklWsryWTvMl8Mwuigk8QWGV7zQUZ8RTe154lcLSYkZ5bSNB99YoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIDX2/E4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5884C4CEE5;
	Mon, 10 Mar 2025 05:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741584529;
	bh=xZ+9XNOyt3FXchZM+SS0uxDvW1K/kZComkL9YrJmHt0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=rIDX2/E4lBsqXjsNuAig5eNGi7BrcvYB10j9RmMexEjuoC36aFp4MPj7rJv9/5/QL
	 v6xYqDwvhlyE4OMaZWi7Nt+4iqMGLIiOdF5FzoVCVYk8BhYQbUeNsEBjv4o40dHNRf
	 QWMVf4F2U08l/OwZ/SNwW3ZgqMoajp0T4AnghkWkaS9HDdGXtZ8gtjV5LTnXnZQaNS
	 kh/GdSoLnbvXgm85wOcEjzqAf/DwgQTIaz03otY+4Vw840fSRvd8g2ejqWsyPJowM+
	 PwRQEvKYgxL02xQ/rSbRKTdg2+mWXUZv1LcqV3/vmlQS1q2kwQee5oQhY5VahbPmnk
	 gQbsbIWXJ4vGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A0C282DE;
	Mon, 10 Mar 2025 05:28:49 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 10 Mar 2025 00:28:48 -0500
Subject: [PATCH v2] cpufreq: tegra186: Share policy per cluster
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-cpufreq-t186-share-policy-v2-1-d0b743cd051f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI94zmcC/0XMTQ7CIBBA4as0rJ2GGQTRlfcwLhCnLbEtFepfm
 t5d4sblt3hvEZlT4CwO1SISP0MOcSygTSV858aWIVyLBUnSUqEEPz2axHeY0RrInUsMU+yD/4C
 jndFkldWKROmnxE14/96nc3GT4gBzl9j9j4QGjbTS1GqP2hhAePGlZb4hqe2xHVzoax8Hsa5fr
 JkUUqsAAAA=
X-Change-ID: 20250310-cpufreq-t186-share-policy-a27652838532
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <luceoscutum@gmail.com>, 
 Sumit Gupta <sumitg@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741584529; l=1424;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=/U0Kh7Cb90mT2b4NourHWsyj9SF5IW5h30D3gxH4nRw=;
 b=PCFAeC5Bm9uq1dNxo+stUss63q42Esm2EXmtWsfRFbcc7mCaEnG69ijd77iec6/SSgX0SLsY2
 7c7GqheMqsXCAi4IEEqCtMGlQOdU0Y8jYktpuRf1ba8fqUhWhflzU0x
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <luceoscutum@gmail.com>

This functionally brings tegra186 in line with tegra210 and tegra194,
sharing a cpufreq policy between all cores in a cluster.

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index c7761eb99f3ccc3e85389cb1e79d338c47584ae3..92aa50f0166601e7b077a4127eba0cb60181dee3 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
+	u32 cpu;
 
 	policy->freq_table = data->clusters[cluster].table;
 	policy->cpuinfo.transition_latency = 300 * 1000;
 	policy->driver_data = NULL;
 
+	/* set same policy for all cpus in a cluster */
+	for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
+		if (data->cpus[cpu].bpmp_cluster_id == cluster)
+			cpumask_set_cpu(cpu, policy->cpus);
+	}
+
 	return 0;
 }
 

---
base-commit: 1110ce6a1e34fe1fdc1bfe4ad52405f327d5083b
change-id: 20250310-cpufreq-t186-share-policy-a27652838532

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



