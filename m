Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BEE281177
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 13:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgJBLpI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 07:45:08 -0400
Received: from foss.arm.com ([217.140.110.172]:33410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387817AbgJBLpF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Oct 2020 07:45:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 074961063;
        Fri,  2 Oct 2020 04:45:05 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.50.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EF9C3F73B;
        Fri,  2 Oct 2020 04:45:01 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, amitk@kernel.org, corbet@lwn.net,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, qperret@google.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org,
        rjw@rjwysocki.net
Subject: [PATCH v2 3/3] dt-bindings: thermal: update sustainable-power with abstract scale
Date:   Fri,  2 Oct 2020 12:44:26 +0100
Message-Id: <20201002114426.31277-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002114426.31277-1-lukasz.luba@arm.com>
References: <20201002114426.31277-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the documentation for the binding 'sustainable-power' and allow
to provide values in an abstract scale. It is required when the cooling
devices use an abstract scale for their power values.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 3ec9cc87ec50..4d8f2e37d1e6 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -99,10 +99,15 @@ patternProperties:
       sustainable-power:
         $ref: /schemas/types.yaml#/definitions/uint32
         description:
-          An estimate of the sustainable power (in mW) that this thermal zone
-          can dissipate at the desired control temperature. For reference, the
-          sustainable power of a 4-inch phone is typically 2000mW, while on a
-          10-inch tablet is around 4500mW.
+          An estimate of the sustainable power (in mW or in an abstract scale)
+	  that this thermal zone can dissipate at the desired control
+	  temperature. For reference, the sustainable power of a 4-inch phone
+	  is typically 2000mW, while on a 10-inch tablet is around 4500mW.
+
+	  It is possible to express the sustainable power in an abstract
+	  scale. This is the case when the related cooling devices use also
+	  abstract scale to express their power usage. The scale must be
+	  consistent.
 
       trips:
         type: object
-- 
2.17.1

