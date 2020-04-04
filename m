Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD7319E75B
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 21:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDDT3o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 15:29:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8291 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgDDT3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 15:29:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e88dfc30000>; Sat, 04 Apr 2020 12:28:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 04 Apr 2020 12:29:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 04 Apr 2020 12:29:43 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 4 Apr
 2020 19:29:43 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 4 Apr 2020 19:29:43 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e88e0240000>; Sat, 04 Apr 2020 12:29:43 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ Patch v2 3/3] arm64: defconfig: Enable CONFIG_ARM_TEGRA194_CPUFREQ
Date:   Sun, 5 Apr 2020 00:59:07 +0530
Message-ID: <1586028547-14993-4-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
References: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586028484; bh=b+iJd85eLTzjFvAEBon3IVxdm6w1fZJjJXVaVJhMvwU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=K+0GYzj1eqRD4IdgpCdKpPoo/6PkOv7eVH0ArflmEjfXF/ofbnyh56ARD5f3F9v4S
         iQlbzxFkOMIj1nDJOd0C0BtpgHYwh32EBKDKZG59Ee8t5AC/uqwsaeaigLondOLy88
         IVqfLZTwK+kOP6QPDMjxXG/gVo3pHc0wqzFzLQcFViXoS0pe7K6g3bPSKU262aCsEO
         iJUcPSx+3mP/NfyH3O3NNRFjfKfCjkcdpDtEudAsubgZyNPzX7V6/kgIzNZ7L1TwA3
         ZIKRtZhiVFAu5VCx0xI7eHbHiFcZykiPIMe/mz5lVCuDjbJ3jWGcktrfpUW52Cw5fG
         uN6LMhNyZfMqA==
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
index 8a5f8d6..7ae746e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -87,6 +87,7 @@ CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_IMX_CPUFREQ_DT=m
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
 CONFIG_ARM_TEGRA186_CPUFREQ=y
+CONFIG_ARM_TEGRA194_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
-- 
2.7.4

