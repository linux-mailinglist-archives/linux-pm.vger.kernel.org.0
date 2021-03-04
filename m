Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5452232CC5A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 07:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhCDGJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 01:09:29 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19314 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbhCDGI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 01:08:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604079510001>; Wed, 03 Mar 2021 22:08:17 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 06:08:17 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:16 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <daniel.lezcano@linaro.org>,
        <robh+dt@kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v1 1/5] MAINTAINERS: Add Tegra CPUIDLE driver section
Date:   Wed, 3 Mar 2021 22:08:08 -0800
Message-ID: <1614838092-30398-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614838097; bh=ooxAqdYwtjF3ejhyniZpEkKraYlFNnY4uuE7CwW4z9E=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=kX4mberFHmtOmOR+if52uacJHyc/kbrmOUuItKBOs5kJ90SPyybPDtX8bwJLJMnrB
         05eZqIh9U2vi7jB+SEmgrhiFKHCE/BL6Sxg8xx9whmjcrriWxeRCEhUf9WHvVcOJ7j
         BPnS2goJStdgN/U1JShKKiMROu8IZI4n22nFQuzVdnqsvkHNWj0nEp9XKH4a94NA5Q
         WOqkvKVQUaPoFGsliz/Vwt6nCP/hvA0P4yaNCwF1TFVppRgAUHKRbyqu0Cn+CgiQO0
         2wTQkMizLwsDMKc2XqV4jWufCPWABmRODmqBoEUrpV2/eKV38h5mYXBZzEhj2EMM3f
         36/16dj4fllMA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Tegra CPUIDLE driver section with maintainers and mailing list
entries.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cac8429..277fcfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4679,6 +4679,18 @@ S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.h
 F:	drivers/cpuidle/cpuidle-psci-domain.c
 
+CPUIDLE DRIVER - TEGRA194
+M:	Thierry Reding <thierry.reding@gmail.com>
+M:	Jonathan Hunter <jonathanh@nvidia.com>
+M:	Krishna Sitaraman <ksitaraman@nvidia.com>
+M:	Sanjay Chandrashekara <sanjayc@nvidia.com>
+M:	Sowjanya Komatineni <skomatineni@nvidia.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
+F:	drivers/cpuidle/cpuidle-tegra194.c
+
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
-- 
2.7.4

