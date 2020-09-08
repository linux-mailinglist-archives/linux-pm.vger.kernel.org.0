Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB22614A8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbgIHQay (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 12:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731436AbgIHQa1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 12:30:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9DF22B4E;
        Tue,  8 Sep 2020 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577169;
        bh=jo8XYvozevoqwLnr8Q8ChiN/Mq4AJaD2/hqaujjU+jw=;
        h=From:To:Cc:Subject:Date:From;
        b=JPbf4sMP6KmcVCTAryLd32cvDGv2RaJpdhFq6aE4BYR2ha21kqZ/1SaAxL9ZPf8Mt
         4G+jN5cNbtfuleQ/g0rZxuMgJCxoev6ierAyzkVjN+wSoN3KRcqonaa6ssaEyOYFSj
         zexwbpNsyG8uRkJReKcoe/L7fIF6gPIwtkW99EB4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: power: Correct interrupt flags in examples
Date:   Tue,  8 Sep 2020 16:59:22 +0200
Message-Id: <20200908145922.4502-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted some
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/power/supply/act8945a-charger.txt       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
index c7dfb7cecf40..cb737a9e1f16 100644
--- a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
@@ -33,7 +33,7 @@ Example:
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 			interrupt-parent = <&pioA>;
-			interrupts = <45 GPIO_ACTIVE_LOW>;
+			interrupts = <45 IRQ_TYPE_LEVEL_LOW>;
 
 			active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
 			active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
-- 
2.17.1

