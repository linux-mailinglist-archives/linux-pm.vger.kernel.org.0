Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1772B3D10A8
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhGUNYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 09:24:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46809 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239103AbhGUNYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 09:24:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F0D05C0218;
        Wed, 21 Jul 2021 10:05:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 21 Jul 2021 10:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=s/UJMsLstRQEa
        tmqEBAhanNjKIYqM1TuZI100FllJ7E=; b=JppD9OxR+Huy8ISMMv9z+p6RWep2g
        FmAwQFLIl1zMm9A39SetUMgbCX1p50gpjaoX5NB7gdlGSCXFRaYZLEhjqy4afFJn
        F3fDbB+28qsBKqSUiy3/OmOYpgZRI9H+hK5KoD0NjkTKnYuQF7VPeGXi+gIG8faV
        aO+Sua/G2/QP1frCN5KCp0jjcjJi07H8sPH9DvOeMe82yCmnx/dKKqSjth9Jl1zO
        ABfHvzPF4XD8Q3wMSogzboMuJP+/JM9tJfnfPzIzbzJb3btCPsSUECpNC1xvzJXz
        ysylwPWtROsz34olnUNFMixHAc68yCXxj0w8txypjUuUt1wlMi+UNFwWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=s/UJMsLstRQEatmqEBAhanNjKIYqM1TuZI100FllJ7E=; b=bIBxKes8
        raEN+E2cstJnervPGBY5/ccSOPRJNfEt3rI0GPCEZor7zS6UHtJgFDPY4txzLNnH
        40o6MhyhLEUb6JDlO8MBQV+6J5k0uDy4k/CxDecZpEZqrEKzTQw9Rv7kMiLmV+l4
        gKcH9bB6J6mIS/PX95uFyMGfGYkxL8LNhclt55JbpOlFH6Mp9d+ze+ubdT1IGvtv
        mOWYqGfNk9VeBbXUzrVmovDAFQei8df476xpgiI5jZac3qzkzEN+9y5XGpWP0y0o
        g9G2NCnVRG+npA9Hb8tlBW51gPp36JY4T7ngfvkZtWjvB/vMMRUVa2CtT6e59MD1
        y10pRtezykUxMQ==
X-ME-Sender: <xms:pSn4YE5QSpcU8yd2ccOYepqTapOyhU2wyRyHdGN2Sz0vOQSUt5xQ9A>
    <xme:pSn4YF5hqCJJCuK8NUpQyj5bkWsygz4Wnut1vKGtqdSTrmoGv0cdLFcRyU2obQuKR
    nwDVqNmOQu9uj0Aoec>
X-ME-Received: <xmr:pSn4YDdBNEcxynyVdDZaWWKUQyA3TxQ5ySxeElIHDSTwBaOaK2ZIONCjBT3RWnPYlZP5liwkCCEgP00KG7I34xuGde4FwLd-UICZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeggdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pSn4YJKablmG1wWf-W0EBEtWntX8p7pVmuuf-wlUQvdYPV6lcR8P1w>
    <xmx:pSn4YILA0sldm0dgTkrnl6UXHkCDPbwf4ilPY6h-4fCEtz3kx1-sfw>
    <xmx:pSn4YKxfb_xhX_jxponaBNpUKRcHSo7UMFj9maBbl9k-7UoQ3Q53lA>
    <xmx:pin4YH_lYeG_3SJaWoY4v6JUQKjOvME7nPDAeslFUd9FtB-F2SFOBA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 10:05:25 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 28/54] dt-bindings: power: supply: axp20x: Add AXP803 compatible
Date:   Wed, 21 Jul 2021 16:03:58 +0200
Message-Id: <20210721140424.725744-29-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721140424.725744-1-maxime@cerno.tech>
References: <20210721140424.725744-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AXP803 compatible was introduced recently with a fallback to the
AXP813, but it was never documented.

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../supply/x-powers,axp20x-ac-power-supply.yaml    | 11 +++++++----
 .../x-powers,axp20x-battery-power-supply.yaml      | 11 +++++++----
 .../supply/x-powers,axp20x-usb-power-supply.yaml   | 14 +++++++++-----
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
index dcda6660b8ed..de6a23aee977 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
@@ -21,10 +21,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - x-powers,axp202-ac-power-supply
-      - x-powers,axp221-ac-power-supply
-      - x-powers,axp813-ac-power-supply
+    oneOf:
+      - const: x-powers,axp202-ac-power-supply
+      - const: x-powers,axp221-ac-power-supply
+      - items:
+          - const: x-powers,axp803-ac-power-supply
+          - const: x-powers,axp813-ac-power-supply
+      - const: x-powers,axp813-ac-power-supply
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index 86e8a713d4e2..d1f0df123a5a 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -19,10 +19,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - x-powers,axp209-battery-power-supply
-      - x-powers,axp221-battery-power-supply
-      - x-powers,axp813-battery-power-supply
+    oneOf:
+      - const: x-powers,axp202-battery-power-supply
+      - const: x-powers,axp221-battery-power-supply
+      - items:
+          - const: x-powers,axp803-battery-power-supply
+          - const: x-powers,axp813-battery-power-supply
+      - const: x-powers,axp813-battery-power-supply
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 61f1b320c157..0c371b55c9e1 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -20,11 +20,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - x-powers,axp202-usb-power-supply
-      - x-powers,axp221-usb-power-supply
-      - x-powers,axp223-usb-power-supply
-      - x-powers,axp813-usb-power-supply
+    oneOf:
+      - enum:
+          - x-powers,axp202-usb-power-supply
+          - x-powers,axp221-usb-power-supply
+          - x-powers,axp223-usb-power-supply
+          - x-powers,axp813-usb-power-supply
+      - items:
+          - const: x-powers,axp803-usb-power-supply
+          - const: x-powers,axp813-usb-power-supply
 
 
 required:
-- 
2.31.1

