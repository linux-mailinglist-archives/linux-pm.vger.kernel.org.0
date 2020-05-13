Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA11D1419
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbgEMNJS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 09:09:18 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43049 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgEMNJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 09:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589375342; x=1620911342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Is4lRNYSiquyResjIg3T8wiw24hPoKYdLEtowPC0kg=;
  b=YBJs7QnHpD9oy5ZX40mRkbfuKEMUNPoXK0Ydmd41p5Y1WKTeQ9aFdBeK
   zV/1pHGD1zU83kKYD8qb88WsdAquu6U4XTp/gWZq23dSIjEOhTdvyf5vz
   utN+3n4B25E54Q4gMV3a5te5NROYLgGJTafLuU1QY43JCMboKWpl9Imtw
   AC89CrRU89DS0Y/AGILhig0HL7TibOoP41LekqyhiYLpM9L2fX0bU8IC0
   dORy7nHwd6HdUvmbjfCCZoskkVNEVPpO/UumvSYnUTl4R+6FD8KEO3n2F
   PrXBF91ZYopajKpeuA6Up80yxEcsSpaP08oe/R6rhhENJzgstHFsd8HL4
   Q==;
IronPort-SDR: 75D4jjDICZ0KPTl1UtCcW9v1pG/9kSDua3FNKu6/RyNLCaHt7q4MshxmBU5tJ7TqvPJ1on5PRh
 Sq0jw3yQGcIVxnBvJ8g2H+Rt/3uJS7mQoxzyyw7jhyp9P9NQlEJ61J7MIIWKp4L4HxCMGRu3Hf
 7KNqfsYMtx4r5zzmT5DOBOzdJBhVDd7YnDOjelBjnSDXn5wmHjrPb7lLBZHWvz28vfMpT+RQMu
 skQC4EGfKcsNwjcee9UmFkpeefAxCA3OsTm6OTEmmwrZueoTRbUzwqAmIbqSgJWytEaij8oTJt
 l28=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="79438679"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:09:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:09:01 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:08:59 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/5] dt-bindings: reset: ocelot: Add documentation for 'microchip,reset-switch-core' property
Date:   Wed, 13 May 2020 15:08:40 +0200
Message-ID: <20200513130842.24847-4-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513130842.24847-1-lars.povlsen@microchip.com>
References: <20200513130842.24847-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This documents the 'microchip,reset-switch-core' property in the
ocelot-reset driver.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../devicetree/bindings/power/reset/ocelot-reset.txt        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
index 4d530d8154848..20fff03753ad2 100644
--- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
+++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
@@ -9,9 +9,15 @@ microchip Sparx5 armv8 SoC's.
 Required Properties:
  - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chip-reset"

+Optional properties:
+- microchip,reset-switch-core : Perform a switch core reset at the
+  time of driver load. This is may be used to initialize the switch
+  core to a known state (before other drivers are loaded).
+
 Example:
 	reset@1070008 {
 		compatible = "mscc,ocelot-chip-reset";
 		reg = <0x1070008 0x4>;
+		microchip,reset-switch-core;
 	};

--
2.26.2
