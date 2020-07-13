Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765EF21D7DE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 16:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgGMOH2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 10:07:28 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10215 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgGMOH1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 10:07:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c6a930000>; Mon, 13 Jul 2020 07:07:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 07:07:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 07:07:27 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 14:07:24 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jul 2020 14:07:24 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0c6a980001>; Mon, 13 Jul 2020 07:07:24 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mirq-linux@rere.qmqm.pl>, <devicetree@vger.kernel.org>,
        <jonathanh@nvidia.com>, <talho@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ PATCH v5 4/4] soc/tegra: cpufreq: select cpufreq for Tegra194
Date:   Mon, 13 Jul 2020 19:36:49 +0530
Message-ID: <1594649209-29394-5-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
References: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594649235; bh=Z4LE+9mlEefkiZynxc+GIrsCq+qVS4APQRbGTaTqj3U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=AH6U/mbJ7J8lFPLWMVic8E/ux3ZD78PqUpCWc3JamkEYG57a9wFspQ9xoFdGKPVAQ
         oRmbjuc1mGh4x9PUb2TYI5K848wQ7iLTq1uHIer5svetZLFlArUay2NmLsqw/Vu1Ig
         BZmEqSAo3QMINERy2pIYiw4qf7FVwpDje+iF4vAQdQBNS0aq5XMQO8m155GvWXVYbU
         YygAxSyeVvkOZsvXevkPw49cFZlaqxZNEAkllEihqoEQXf7vOMomeHXClaeir3z6W+
         MzEn0s9llCyHgwEY8cxN77Dz5s5s+LDD6ZbJvfrd5x1oEtfrKp3lMTGshT9iEq/NID
         P8CSDBykB8ZLg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Select ARM_TEGRA194_CPUFREQ by default to enable CPU frequency
scaling support for Tegra194 SOC.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/soc/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 2e95809..6955cee 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -117,6 +117,7 @@ config ARCH_TEGRA_194_SOC
 	select TEGRA_HSP_MBOX
 	select TEGRA_IVC
 	select SOC_TEGRA_PMC
+	select ARM_TEGRA194_CPUFREQ
 	help
 	  Enable support for the NVIDIA Tegra194 SoC.
 
-- 
2.7.4

