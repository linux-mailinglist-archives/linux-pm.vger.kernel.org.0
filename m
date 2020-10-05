Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB5B283C87
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgJEQai (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 12:30:38 -0400
Received: from foss.arm.com ([217.140.110.172]:52554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgJEQai (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Oct 2020 12:30:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AE1711D4;
        Mon,  5 Oct 2020 09:30:37 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.49.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1FA5B3F66B;
        Mon,  5 Oct 2020 09:30:33 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Cc:     amitk@kernel.org, corbet@lwn.net, daniel.lezcano@linaro.org,
        lukasz.luba@arm.com, Dietmar.Eggemann@arm.com, qperret@google.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org,
        rjw@rjwysocki.net
Subject: [RESEND][PATCH v2 3/3] dt-bindings: thermal: update sustainable-power with abstract scale
Date:   Mon,  5 Oct 2020 17:30:16 +0100
Message-Id: <20201005163016.13650-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the documentation for the binding 'sustainable-power' and allow
to provide values in an abstract scale. It is required when the cooling
devices use an abstract scale for their power values.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---

Hi Rob,
 
This is a fixed patch for DT binding, which now passes the
make dt_binding_check (I have changed tabs into spaces).
The former patch error that I have received is here [1]. 

Regards,
Lukasz

[1] https://lore.kernel.org/linux-pm/20201002114426.31277-1-lukasz.luba@arm.com/T/#md4b02a3ada592df67446566180643ba56788c159

 .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 3ec9cc87ec50..c445927749c3 100644
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
+          that this thermal zone can dissipate at the desired control
+          temperature. For reference, the sustainable power of a 4-inch phone
+          is typically 2000mW, while on a 10-inch tablet is around 4500mW.
+
+          It is possible to express the sustainable power in an abstract
+          scale. This is the case when the related cooling devices use also
+          abstract scale to express their power usage. The scale must be
+          consistent.
 
       trips:
         type: object
-- 
2.17.1

