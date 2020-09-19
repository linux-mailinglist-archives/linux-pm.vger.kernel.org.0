Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3468270E53
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 16:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgISOEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Sep 2020 10:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOEd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Sep 2020 10:04:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48BC21741;
        Sat, 19 Sep 2020 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524272;
        bh=ugAs2y4rZlA6vZBj2bhkYKT3elTk+a0JzAZleLgQ7w0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O7Xt1G1aXZoEJT23mm564dFtIebvpZ71szGK1T/F1LRl9PWZD2F3RTYT7uap/vdAf
         Lv7mm3niKqVeX4pSH8o1qUT6PoeiC39dA4g7fxeczrpGwCttWJWaNyBxnCObiiIOgK
         tV7ieoIqzJUySy4S7eLfwaGfnPWM+qCVNwZqPyBg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: power: bq27xxx: add bq34z100
Date:   Sat, 19 Sep 2020 16:04:13 +0200
Message-Id: <20200919140418.3705-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200919140418.3705-1-krzk@kernel.org>
References: <20200919140418.3705-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add compatible for bq34z100 charger.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 82f682705f44..45beefccf31a 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -51,6 +51,7 @@ properties:
       - ti,bq27621
       - ti,bq27z561
       - ti,bq28z610
+      - ti,bq34z100
 
   reg:
     maxItems: 1
-- 
2.17.1

