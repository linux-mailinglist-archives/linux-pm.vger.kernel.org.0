Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30E2C3A30
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 08:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgKYHeS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 02:34:18 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:48066 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgKYHeS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 02:34:18 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 0BA2A3BAD00
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2020 07:19:59 +0000 (UTC)
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4A7C8FF803;
        Wed, 25 Nov 2020 07:19:36 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 1/3] dt-bindings: reset: ocelot: Add Luton and Jaguar2 support
Date:   Wed, 25 Nov 2020 08:19:18 +0100
Message-Id: <20201125071920.126978-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125071920.126978-1-gregory.clement@bootlin.com>
References: <20201125071920.126978-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the support for 2 others MIPS based VCore III SoCs: Luton
and Jaguar2.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../devicetree/bindings/power/reset/ocelot-reset.txt          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
index 4d530d815484..c5de7b555feb 100644
--- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
+++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
@@ -7,7 +7,9 @@ The reset registers are both present in the MSCC vcoreiii MIPS and
 microchip Sparx5 armv8 SoC's.
 
 Required Properties:
- - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chip-reset"
+
+ - compatible: "mscc,ocelot-chip-reset", "mscc,luton-chip-reset",
+   "mscc,jaguar2-chip-reset" or "microchip,sparx5-chip-reset"
 
 Example:
 	reset@1070008 {
-- 
2.29.2

