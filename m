Return-Path: <linux-pm+bounces-33133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888DAB373B5
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 22:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA2A5E16BC
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706A1286D76;
	Tue, 26 Aug 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1GnltAn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21717B505;
	Tue, 26 Aug 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239383; cv=none; b=mqbFcXRY08h8032GBdGbAlLetdAQyzhk6g+dgREeryFthYBQk3kqKGjX57PndpPYa2BOTmljk+I+WPntNjWTFQJl+Yy/lXII+dQlV3K/YYXh5pRI/kEP8ylq92uI1W3f3SgyCNksoiQimu7Lgy75aDp5kJ9nYykXNQK9VshbMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239383; c=relaxed/simple;
	bh=F4eCXDpiPLysUuWKZGHe3bREw0x2ZaT5IN5Hy4x12FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3rJBTRLc8t5Wr3C/phBzWUOJSrDpXB2HxocrSNRVNKRNMf1MN7aeKz1NQxvdLT0rkQue+UOOduYWr0DVNcPoLH0+LUrvOebrvWsTzhcJDkvMFeYVQgrt+sKhSmgqCXSeDgs2ucKbb2pVsrTXY60iKxX0ZfRqNFiJfkFf3irTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1GnltAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFA68C4CEF4;
	Tue, 26 Aug 2025 20:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756239382;
	bh=F4eCXDpiPLysUuWKZGHe3bREw0x2ZaT5IN5Hy4x12FY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S1GnltAnW2Rmqpa1OBaayvFQV3qnq5hgI100N9vBuc/oa20zEur0ZlB0ZpZLa1Aa0
	 z84bZJqVqawIe2A4WSyeoiKsEAApoE1lOlWDHd3hbNGpF0kDuZB1BFgVJ+7NaZZ1xy
	 fGF09acCLKozOvxcHWrFBE1Z+Z5MKLvNlZlrx31yRJIfdkchiH5vs63FhbACP1/Z+Y
	 fPpVbadCmDZNhCtjJHXKs89MsEa+CUqWjnTjeFGAdZesIneR4HyRV5GXwClgTDNyEb
	 ZcOoNjFQvwdx5jps6Gdb7WgUWtbsblBc5f76gKOzqlsKhrECWoW0dNFRxGWfEtPhaY
	 5CeQ6+jZ37IlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF53CA0FF8;
	Tue, 26 Aug 2025 20:16:22 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 26 Aug 2025 15:16:00 -0500
Subject: [PATCH 2/2] cpufreq: tegra186: Initialize all cores to base
 frequencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-tegra186-cpufreq-fixes-v1-2-97f98d3e0adb@gmail.com>
References: <20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com>
In-Reply-To: <20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <luceoscutum@gmail.com>, 
 Sumit Gupta <sumitg@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756239382; l=1607;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=9bUHeyaYYD5fuQRhqyZoy/YoCxZst0rIRpuE3PyDvxs=;
 b=Zu2irhRctxFYy8ShV3iS/NGGP7/GCtf5cIRe2O/vva1S8TPz5Mtf7QMi+4k9PQMx4+NC44Htj
 iBUqMvyf3/KBGshN+/S06gfLre71hS+9D7kdJZnQidiJcID01Pj5nzs
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

During initialization, the EDVD_COREx_VOLT_FREQ registers for some cores
are still at reset values and not reflecting the actual frequency. This
causes get calls to fail. Set all cores to their respective base
frequency during probe to initialize the registers to working values.

Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 6c394b429b6182faffabf222e5af501393dbbba9..ef288705f00b0918d0f8963ef9cc9fc53be88091 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -229,7 +229,8 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 {
 	struct tegra186_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
-	unsigned int i = 0, err;
+	unsigned int i = 0, err, edvd_offset;
+	u32 edvd_val, cpu;
 
 	data = devm_kzalloc(&pdev->dev,
 			    struct_size(data, clusters, TEGRA186_NUM_CLUSTERS),
@@ -257,6 +258,14 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 			err = PTR_ERR(cluster->table);
 			goto put_bpmp;
 		}
+
+		for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
+			if (data->cpus[cpu].bpmp_cluster_id == i) {
+				edvd_val = cluster->table[0].driver_data;
+				edvd_offset = data->cpus[cpu].edvd_offset;
+				writel(edvd_val, data->regs + edvd_offset);
+			}
+		}
 	}
 
 	tegra186_cpufreq_driver.driver_data = data;

-- 
2.50.1



