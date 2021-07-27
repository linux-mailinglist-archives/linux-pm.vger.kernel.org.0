Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512263D7BFB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 19:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhG0RQW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 13:16:22 -0400
Received: from box.trvn.ru ([194.87.146.52]:52621 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhG0RQV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Jul 2021 13:16:21 -0400
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 79A33413D3;
        Tue, 27 Jul 2021 22:06:28 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1627405589; bh=1+ecd5RxP5Uu5mrSwspRP0Hg++hsqVRh3UdQruBewQo=;
        h=From:To:Cc:Subject:Date:From;
        b=gu6DPLyLOcrzln61ZvTvlqDHox5pqN7yr0b7Wz65ba1Le9Fq3jPs3gJtr30ROjZLF
         aR4KggTq53VE8WIHvBF+Hk0VZP8XmrsR2USdbaE+kFBQQhhcq6z2Gu3yZPCFM+D4iS
         Em8AR5wXT6n+2o+azb3FCwWjIeP4EOXhHent128qCuVqJM9VEI0aldLA1kFN5yxeaA
         LnmzI0QTcKwbyWnEONd4ENCYMBpnDIXT9fC5obiBzdR21+SX3JtPfT2L861H4J8p2C
         tmWtbagczx4e1tzscB93zQ1mmD2K0yDylxL0QNN8EA6S3gPWsyGIehwQorpOFxcXXo
         Tudgseh3lFYdQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     sre@kernel.org
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 1/2] dt-bindings: power: supply: max17042: Document max77849-battery
Date:   Tue, 27 Jul 2021 22:03:44 +0500
Message-Id: <20210727170345.115004-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

max77849 is a combined fuel-gauge, charger and MUIC device. Add it to
the bindings documentation.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../devicetree/bindings/power/supply/maxim,max17042.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index c70f05ea6d27..42ebf87d300b 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -19,6 +19,7 @@ properties:
       - maxim,max17047
       - maxim,max17050
       - maxim,max17055
+      - maxim,max77849-battery
 
   reg:
     maxItems: 1
-- 
2.30.2

