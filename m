Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F53B90CB
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 12:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhGALAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 07:00:12 -0400
Received: from relay05.th.seeweb.it ([5.144.164.166]:59043 "EHLO
        relay05.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbhGALAJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 07:00:09 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2EE513F645;
        Thu,  1 Jul 2021 12:57:37 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 3/9] dt-bindings: arm: cpus: Document 'qcom,freq-domain' property
Date:   Thu,  1 Jul 2021 12:57:24 +0200
Message-Id: <20210701105730.322718-4-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add devicetree documentation for 'qcom,freq-domain' property specific
to Qualcomm CPUs. This property is used to reference the CPUFREQ node
along with Domain ID (0/1).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index f3c7249c73d6..8512fa0147fa 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -290,6 +290,12 @@ properties:
 
       * arm/msm/qcom,kpss-acc.txt
 
+  qcom,freq-domain:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description: |
+      CPUs supporting freq-domain must set their "qcom,freq-domain" property
+      with phandle to a cpufreq_hw node followed by the Domain ID(0/1).
+
   rockchip,pmu:
     $ref: '/schemas/types.yaml#/definitions/phandle'
     description: |
-- 
2.32.0

