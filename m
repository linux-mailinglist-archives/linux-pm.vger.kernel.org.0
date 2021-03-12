Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814B93391FE
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhCLPoy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55690 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhCLPoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B048C1F46E7C
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7A7B548011E; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 36/38] dt-bindings: power: supply: sbs-battery: Fix dtbs_check
Date:   Fri, 12 Mar 2021 16:43:55 +0100
Message-Id: <20210312154357.1561730-37-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Existing in-tree users make use of '"ti,bq20z45", "sbs,sbs-battery"', so
add it to the list of known compatible strings.

Also add missing support for the generic 'power-supplies' property by
importing power-supply.yaml and setting unevaluatedProperties instead
of additionalProperties.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/power/supply/sbs,sbs-battery.yaml  | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
index a90b3601e695..90b9d3d882a4 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
@@ -12,12 +12,15 @@ maintainers:
 description: |
   Battery compatible with the smart battery system specifications
 
-properties:
+allOf:
+  - $ref: power-supply.yaml#
 
+properties:
   compatible:
     oneOf:
       - items:
           - enum:
+              - ti,bq20z45
               - ti,bq20z65
               - ti,bq20z75
           - enum:
@@ -60,7 +63,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.30.1

