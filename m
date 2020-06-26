Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FAF20B514
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgFZPoK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 11:44:10 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12452 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgFZPoK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 11:44:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef6179b0001>; Fri, 26 Jun 2020 08:43:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 08:44:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 08:44:10 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 15:44:08 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 15:44:08 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef617c40003>; Fri, 26 Jun 2020 08:44:08 -0700
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
Subject: [TEGRA194_CPUFREQ PATCH v4 1/4] dt-bindings: arm: Add t194 ccplex compatible and bpmp property
Date:   Fri, 26 Jun 2020 21:13:53 +0530
Message-ID: <1593186236-12760-2-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
References: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593186203; bh=GFfWIGaXrMvp1DkevXPif529sLhgwm+yOrbKbLziXEQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DkiSSCBN1HJmIHbPKiReEqhMDzMgejZAZdBmnGHSIkWa3G0Xsn+dinn2CB8jXQOaQ
         PCxOj4QfgWYT+rF4tBgQtzM0hCWN0vef8Moqlbl+vKvAfKttoeNAq9PttoHoPi5rDk
         JmTmnaNPeBT3M+ZldNJcEXyk3nCAX5mzfZ2tUIcZD1yevzUeowJ9aEoIhXWox+MMX7
         DLjjUNN9j6tIHP3iWMaV98DWqXgCjsfdTWQ3fWI7dcCEMnCwvBfizKiehJFfoqjkgV
         6QnZqfbiC945ubVsXIVGLC/M4DkAm3SCobBuE9tFGC2oFTgVmUE6b+Z97J3WOwGcBw
         6iXeja4KoRuxw==
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
 Documentation/devicetree/bindings/arm/cpus.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index a018147..737b55e 100644
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
@@ -255,6 +256,14 @@ properties:
 
       where voltage is in V, frequency is in MHz.
 
+  nvidia,bpmp:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    descrption: |
+      Specifies the bpmp node that needs to be queried to get
+      operating point data for all CPUs.
+
+      Optional for NVIDIA Tegra194 Carmel CPUs
+
   power-domains:
     $ref: '/schemas/types.yaml#/definitions/phandle-array'
     description:
-- 
2.7.4

