Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0482202D0C
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jun 2020 23:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgFUVfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 17:35:07 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13112 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgFUVfG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 17:35:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eefd2300000>; Sun, 21 Jun 2020 14:33:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jun 2020 14:35:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jun 2020 14:35:06 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jun
 2020 21:35:04 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 21 Jun 2020 21:35:04 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eefd2840001>; Sun, 21 Jun 2020 14:35:03 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ Patch v3 4/4] arm64: defconfig: Enable CONFIG_ARM_TEGRA194_CPUFREQ
Date:   Mon, 22 Jun 2020 03:04:34 +0530
Message-ID: <1592775274-27513-5-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
References: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592775216; bh=lHNVU7VOn42qEJNEwY78N3Q41Uu/bIGWrHx8p5IG6bc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ROO+TbXj5NyrxbBYBz04uSud2CCbMrxOFnH+ff6/UnV0wds2XWnFVC/z88XHZwPGx
         fwjdTMTLcoFwB8WaxjjRhMLGaa9IDw0TibMP68QzqjZ0CP+l2o5Z+4BLbqHgvxsWce
         fIZJnq2sRLK1GBudQ+LkZUtXJCvnft2nSBN3FKCrSQF+tyUrVgRHrnycKnzue6kJVd
         mJ+R9VUIzF45LKhBTA4XFqLD9r/pKpUZ2ORwfwm/+rhyvac4reLxRpmNc4t+7h1pY4
         6ZvY+zAomPky48squ+UINIV+GMCXsN6NAUosHN3Rd2OzDsIFW5k+D517KXRipHtJYR
         vDZaeklKc7eug==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable Tegra194 CPU frequency scaling support by default.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9d378d..385bd35 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -91,6 +91,7 @@ CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
 CONFIG_ARM_QCOM_CPUFREQ_HW=y
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
 CONFIG_ARM_TEGRA186_CPUFREQ=y
+CONFIG_ARM_TEGRA194_CPUFREQ=y
 CONFIG_QORIQ_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
-- 
2.7.4

