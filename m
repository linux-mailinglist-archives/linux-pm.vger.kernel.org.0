Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0392441C9AD
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbhI2QJZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 12:09:25 -0400
Received: from ixit.cz ([94.230.151.217]:52012 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345662AbhI2QJJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Sep 2021 12:09:09 -0400
Received: from localhost.localdomain (78-80-97-115.customers.tmcz.cz [78.80.97.115])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 175B123B26;
        Wed, 29 Sep 2021 18:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1632931645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Py481dm6Mitgnggqp/GOXFcWMmJ8KLHphnXVkLLFkTg=;
        b=S8YfuQ2EQ1qjlh8YVe/bmj/7zpipp18L7E8kThkhIiwo5oqg+f/WbwgHzwjhCbSliRQKSZ
        Kj59odUwPhSQToxnRr9ZzK8M+R+ldifmksckLtf8WljpW6Oi9RXqpHa9o4SSDeXONcnGnd
        6f6QBBBYy0SzjwMoP5WXgGUdeKZOBMA=
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH] dt-bindings: power: supply: max17040: switch to unevaluatedProperties
Date:   Wed, 29 Sep 2021 18:06:05 +0200
Message-Id: <20210929160605.74831-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Required for validation of power-supplies from power-supply.yaml.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/power/supply/maxim,max17040.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
index f792d06db413..ffb344987a7b 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
@@ -62,7 +62,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.33.0

