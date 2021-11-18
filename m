Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE00B4564A7
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 22:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhKRVFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 16:05:53 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:36926 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230422AbhKRVFx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Nov 2021 16:05:53 -0500
Received: from localhost.localdomain (ip-213-127-109-54.ip.prioritytelecom.net [213.127.109.54])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E68AECAD7C;
        Thu, 18 Nov 2021 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1637269371; bh=8tlSrro64Z/lABOoSyH9T70DBxFcqqceD5mOCWLL68M=;
        h=From:To:Cc:Subject:Date;
        b=o5tjir4D7XXdxYNTREpyc/K2jbBGwHuKmtlPDSNdqDTEFDplpeYsdiFrb97nT1RdK
         X93Rva4ViI6MxqKg0ELys2ZYydXLOdnfAjtmIEmr2OWA0cJvCGu+73XfFuir7mrv3a
         vwQdmV8B1GnGHC0zWVBI+uDcV8jy4zao23nC6CV4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: power: supply: pm8941-charger: add pm8226
Date:   Thu, 18 Nov 2021 22:02:04 +0100
Message-Id: <20211118210210.160895-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The charger in PM8226 (used in MSM8226) is similar to the charger in
PM8941.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/power/supply/qcom,pm8941-charger.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
index bc8904872d1b..caeff68c66d5 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,pm8941-charger
+    enum:
+      - qcom,pm8226-charger
+      - qcom,pm8941-charger
 
   reg:
     maxItems: 1
-- 
2.34.0

