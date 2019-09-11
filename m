Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC355B02F4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfIKRrg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 13:47:36 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.103]:18378 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbfIKRrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568224051;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=dkjt0qMhGxLVTBpvMP6aAPlNlv/UnmzG7T8esfy3ij4=;
        b=tCg85+ZHQcuEWedm5g4+uftTdIEv7RZShgTyZAIgXKJ+QVfyYk2iRVnzmPSAca2X1L
        mZCc/8sffGM76CPt9d+RpdmWlOnorn0qH9iztkSuR2Iax5G3ki1dyU1daG10XncRnyG8
        oQGftLQ/C0czW5sEBHFpqHMuw9d6Jnxjqn/aJbd6+3DeMuWmwM3jBi3hOd3tQpbMMyQ+
        DpGQ2O2OqgLT/0Hu5+ICGsL0S5KzjABX+mwY5Mndynk0mbS8zAG4QcAh+fpECgHVEPW3
        Fp/nDhRzMx4Xh5j3aLL7rim4txcafKCSi2rsP5s66K15oa23GrkNnUDeRHOePfqWOtUC
        o6Tg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7Nk1d2C6Y"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v8BHlG8nt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 11 Sep 2019 19:47:16 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/8] DTS: bindings: omap: update bindings documentation
Date:   Wed, 11 Sep 2019 19:47:09 +0200
Message-Id: <2316bdb65c4223d54aefa74043a02d588cdeb04a.1568224033.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1568224032.git.hns@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* clarify that we now need either "ti,omap3430" or "ti,omap3630" or "ti,am3517" for omap3 chips
* clarify that "ti,omap3" has no default
* clarify that AM33x is not an "ti,omap3"
* clarify that the list of boards is incomplete
* remove some "ti,am33xx", "ti,omap3"
* add some missing "ti,omap4"

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/arm/omap/omap.txt     | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index b301f753ed2c..e77635c5422c 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -43,7 +43,7 @@ SoC Families:
 
 - OMAP2 generic - defaults to OMAP2420
   compatible = "ti,omap2"
-- OMAP3 generic - defaults to OMAP3430
+- OMAP3 generic
   compatible = "ti,omap3"
 - OMAP4 generic - defaults to OMAP4430
   compatible = "ti,omap4"
@@ -51,6 +51,8 @@ SoC Families:
   compatible = "ti,omap5"
 - DRA7 generic - defaults to DRA742
   compatible = "ti,dra7"
+- AM33x generic
+  compatible = "ti,am33xx"
 - AM43x generic - defaults to AM4372
   compatible = "ti,am43"
 
@@ -63,12 +65,14 @@ SoCs:
 
 - OMAP3430
   compatible = "ti,omap3430", "ti,omap3"
+  legacy: "ti,omap34xx" - please do not use any more
 - AM3517
   compatible = "ti,am3517", "ti,omap3"
 - OMAP3630
-  compatible = "ti,omap36xx", "ti,omap3"
-- AM33xx
-  compatible = "ti,am33xx", "ti,omap3"
+  compatible = "ti,omap3630", "ti,omap3"
+  legacy: "ti,omap36xx" - please do not use any more
+- AM335x
+  compatible = "ti,am33xx"
 
 - OMAP4430
   compatible = "ti,omap4430", "ti,omap4"
@@ -110,19 +114,19 @@ SoCs:
 - AM4372
   compatible = "ti,am4372", "ti,am43"
 
-Boards:
+Boards (incomplete list of examples):
 
 - OMAP3 BeagleBoard : Low cost community board
-  compatible = "ti,omap3-beagle", "ti,omap3"
+  compatible = "ti,omap3-beagle", "ti,omap3430", "ti,omap3"
 
 - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
-  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3"
+  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3"
 
 - OMAP4 SDP : Software Development Board
-  compatible = "ti,omap4-sdp", "ti,omap4430"
+  compatible = "ti,omap4-sdp", "ti,omap4430", "ti,omap4"
 
 - OMAP4 PandaBoard : Low cost community board
-  compatible = "ti,omap4-panda", "ti,omap4430"
+  compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4"
 
 - OMAP4 DuoVero with Parlor : Commercial expansion board with daughter board
   compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
@@ -134,16 +138,16 @@ Boards:
   compatible = "variscite,var-dvk-om44", "variscite,var-som-om44", "ti,omap4460", "ti,omap4";
 
 - OMAP3 EVM : Software Development Board for OMAP35x, AM/DM37x
-  compatible = "ti,omap3-evm", "ti,omap3"
+  compatible = "ti,omap3-evm", "ti,omap3630", "ti,omap3"
 
 - AM335X EVM : Software Development Board for AM335x
-  compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
+  compatible = "ti,am335x-evm", "ti,am33xx"
 
 - AM335X Bone : Low cost community board
-  compatible = "ti,am335x-bone", "ti,am33xx", "ti,omap3"
+  compatible = "ti,am335x-bone", "ti,am33xx"
 
 - AM3359 ICEv2 : Low cost Industrial Communication Engine EVM.
-  compatible = "ti,am3359-icev2", "ti,am33xx", "ti,omap3"
+  compatible = "ti,am3359-icev2", "ti,am33xx"
 
 - AM335X OrionLXm : Substation Automation Platform
   compatible = "novatech,am335x-lxm", "ti,am33xx"
-- 
2.19.1

