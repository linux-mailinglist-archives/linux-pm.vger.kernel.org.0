Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5DB2DC097
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 13:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgLPM7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 07:59:05 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:30169 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgLPM7E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 07:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608123544; x=1639659544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=QX08wLzxTODbJ7tONbfhIPOAMrkosrjWU9SC8iacCdY=;
  b=R2lBYM3DElWiMAHScOlPsKw9rta22s6f97J/C5k0BWoaTV5zjKUcsRW/
   cUQ/RdhbgxEMpZu058g2JGOsyFiOHeSJ5qT/AUkUH/94bJl0enZGZRA+Q
   6qjJdCvB/jmcp9cv9f9KIB39lZcmDuZVMtEdXmL+n69iZSSqn1s4Tmd0X
   9jtF9pueTN+a2XShRRYHdML87Bl2mk+mC5vZ2q9d/j23NU2c4Aw3MvJlr
   QJZCPyUk0GffC982fqJYQBVJ38jHVhB75N5JeNWVjg5+nKzYzwlC1Q+Bp
   i5D0aYcLfG66DFKj/9jX7EoRoYy54h+hMDoEVY9Wn7SCJAamIpNP1AhAd
   A==;
IronPort-SDR: GqC/6eMxJrjMOjtMoi3L9i+WZ4cklLPfUQz5B+M2gKWjp3ffixcdLdxiXStk1oN8yoD0ycvm9Z
 F1o4xKdBxxE3R+KnhK4PRLg1yK9fUz5aS8S5UdWTSGT+XK4Hrt+aVPSjwSWwalW3oimHRTFQZc
 4aAeFSvMZhhe5IYjBFz8UQRzEKuRwJ9/47qOhUoaTlhnNyTTDPoRkKmO3+OcmasxqwEOyMmmWg
 bwFEiIqz5FCpHpoVwOOyhAzOkxtv8ZxU1q/8vp/NZaE+Bo/kpRP44g09iqBz/D2kQHqJOQziV3
 E7g=
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="100047312"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2020 05:57:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 05:57:48 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 16 Dec 2020 05:57:46 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] dt-bindings: atmel-sysreg: add microchip,sama7g5-shdwc
Date:   Wed, 16 Dec 2020 14:57:32 +0200
Message-ID: <1608123453-1423-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add compatible for Microchip SAMA7G5's shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 62cd4e89817c..7990358ac06e 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -91,7 +91,8 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
 1) shdwc node
 
 required properties:
-- compatible: should be "atmel,sama5d2-shdwc" or "microchip,sam9x60-shdwc".
+- compatible: should be "atmel,sama5d2-shdwc", "microchip,sam9x60-shdwc" or
+  "microchip,sama7g5-shdwc"
 - reg: should contain registers location and length
 - clocks: phandle to input clock.
 - #address-cells: should be one. The cell is the wake-up input index.
@@ -103,7 +104,7 @@ optional properties:
   microseconds. It's usually a board-related property.
 - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
 
-optional microchip,sam9x60-shdwc properties:
+optional microchip,sam9x60-shdwc or microchip,sama7g5-shdwc properties:
 - atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
 
 The node contains child nodes for each wake-up input that the platform uses.
-- 
2.7.4

