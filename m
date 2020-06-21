Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC40202CFF
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jun 2020 23:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgFUVew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 17:34:52 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8729 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgFUVev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 17:34:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eefd26e0000>; Sun, 21 Jun 2020 14:34:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jun 2020 14:34:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jun 2020 14:34:51 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jun
 2020 21:34:47 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 21 Jun 2020 21:34:46 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eefd2720000>; Sun, 21 Jun 2020 14:34:46 -0700
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
Subject: [TEGRA194_CPUFREQ Patch v3 1/4] dt-bindings: arm: Add t194 ccplex compatible and bpmp property
Date:   Mon, 22 Jun 2020 03:04:31 +0530
Message-ID: <1592775274-27513-2-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
References: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592775278; bh=GFfWIGaXrMvp1DkevXPif529sLhgwm+yOrbKbLziXEQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=R83+V+nLFEij8+xT/ZWbBiEktc1LnX/dcasmxo8B0Ww8U9+z2nO3uWqLt/jgDvAU+
         B4ueYGfhZdmFqEJp1BTDg3aiAJz591M61cAcpuS+ye7OPfAyrWsUSy7c2newobZ3y1
         k5Wo1b8k6cG2ipQS+UXbNGDe5IFqK9c8U6xAkgvJhLJJ6eQvQoszhbfm+vo8a4G5Vd
         jABIG14QID9C4SfHn6wALN65gQjDkttIfQ8e3sQx8ZwvK+G12ZvqYYzz3Dsyt/EpAS
         vIYkXCgsgoKfe/Gr2V7wtS5By2cDg/L2CL+D1SZyFFI1+l8PhqCVyj7eIzu6rZuAfm
         EqAaAFuxi+AHw==
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

