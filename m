Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5EAC864
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 19:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbfIGRrP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 13:47:15 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.101]:24848 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436544AbfIGRrP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Sep 2019 13:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567878431;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=dkjt0qMhGxLVTBpvMP6aAPlNlv/UnmzG7T8esfy3ij4=;
        b=E6kLNjw0XWaixjxK/AMZtsJ1QOVph9PUUTHm/tmknGAXdeM3m24vDAQwzRLpldcqt0
        tdvhg9R7n2yrOeOhB67oHou1xGqh+11vLwhd0xmu+Va05RfWrMNgbiMIjKHs2z22H1qa
        bQio10gp8gPMVLDlRMOVwLNrQ781lXuNghzM7uHoGcpUh8Mv7dacGXwpq/tAPFRUFpj7
        5MkPazj7cyitXW+hKRq0qm53/O0HTsl9wc9x+YSwpanbkEZKSKhl+PI2PuHmXoXzdy5W
        V1YV/VYr0cEPgTAUdlA/dXvtJKKW2eC0sKS+FF9mfBZ0nfieNIWWnqzVB8Wdb982NKQM
        yT7w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXL8GTntuxg="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v87Hkwrbm
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 7 Sep 2019 19:46:58 +0200 (CEST)
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
Subject: [PATCH 4/4] DTS: bindings: omap: update bindings documentation
Date:   Sat,  7 Sep 2019 19:46:53 +0200
Message-Id: <35e4f219af5f8bff48e89ece7541f4e4ae6f27a0.1567878413.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1567878413.git.hns@goldelico.com>
References: <cover.1567878413.git.hns@goldelico.com>
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

