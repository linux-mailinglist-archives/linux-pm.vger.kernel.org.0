Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E471121D7D2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 16:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgGMOHE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 10:07:04 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10134 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMOHD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 10:07:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c6a7b0001>; Mon, 13 Jul 2020 07:06:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 07:07:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 07:07:03 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 14:07:02 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jul 2020 14:07:02 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0c6a820001>; Mon, 13 Jul 2020 07:07:02 -0700
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
Subject: [TEGRA194_CPUFREQ PATCH v5 1/4] dt-bindings: arm: Add t194 ccplex compatible and bpmp property
Date:   Mon, 13 Jul 2020 19:36:46 +0530
Message-ID: <1594649209-29394-2-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
References: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594649211; bh=4OTHJwUV+Bl9p50zsqtzV49JPGwrtnTk2fPNfo/7QAc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=aEqjLXBKq2oJcUprnXuxl/KBkP/nSm6Aezj1xmk+AUUF1MrWMPXHgbhOZp0GLwX0R
         HtCTrxuuagnLxS7Hm1Pa2dxujpnj74T4zwzDuz1T/S10pbST38mnlmm1ciOHNMYDEv
         r9eUS+Nn3qZeRaF+Oh88ExDdS5+5FEF/zbtsijLyNekaPDpn3jXhJ40UmyRLgRFH21
         7LzITs/Oc6P3V1TEmKuRJpmiTfcLUm32vBD0m4t3sBl89OuUp4YD+6LsZlolR6QLI9
         gvKLatp9JS42jqIw3T64Yr7aKCxH7s9R7Ii9q27wh7cS3F/tKVe1ybG4v7vXuXTxxx
         imrtknPX/8fjQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To do frequency scaling on all CPUs within T194 CPU Complex, we need
to query BPMP for data on valid operating points. Document a compatible
string under 'cpus' node to represent the CPU Complex for binding drivers
like cpufreq which don't have their node or CPU Complex node to bind to.
Also, document a property to point to the BPMP device that can be queried
for all CPUs.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index a018147..9b328e3 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -162,6 +162,7 @@ properties:
       - nvidia,tegra132-denver
       - nvidia,tegra186-denver
       - nvidia,tegra194-carmel
+      - nvidia,tegra194-ccplex
       - qcom,krait
       - qcom,kryo
       - qcom,kryo260
@@ -255,6 +256,15 @@ properties:
 
       where voltage is in V, frequency is in MHz.
 
+  nvidia,bpmp:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Specifies the bpmp node that needs to be queried to get
+      operating point data for all CPUs.
+
+      Optional for systems that have a "compatible"
+      property value of "nvidia,tegra194-ccplex".
+
   power-domains:
     $ref: '/schemas/types.yaml#/definitions/phandle-array'
     description:
@@ -340,6 +350,7 @@ required:
 
 dependencies:
   rockchip,pmu: [enable-method]
+  nvidia,bpmp: [compatible]
 
 examples:
   - |
-- 
2.7.4

