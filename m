Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2045B584
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 08:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbhKXHiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 02:38:08 -0500
Received: from marcansoft.com ([212.63.210.85]:52696 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241199AbhKXHiH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Nov 2021 02:38:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 05BCC426A2;
        Wed, 24 Nov 2021 07:34:51 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 04/11] dt-bindings: pinctrl: apple,pinctrl: Add power-domains property
Date:   Wed, 24 Nov 2021 16:34:14 +0900
Message-Id: <20211124073419.181799-5-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124073419.181799-1-marcan@marcan.st>
References: <20211124073419.181799-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This will bind to the PMGR pwrstate nodes that control power/clock
gating to SoC blocks. The pinctrl driver doesn't do runtime-pm yet, so
initially this will just keep the domain on permanently.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 07b00de79755..200d411621e7 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -50,6 +50,9 @@ properties:
   '#interrupt-cells':
     const: 2
 
+  power-domains:
+    maxItems: 1
+
 patternProperties:
   '-pins$':
     type: object
-- 
2.33.0

