Return-Path: <linux-pm+bounces-23094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD10A483AF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BFF1894A48
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1481B982C;
	Thu, 27 Feb 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="notNt6X4"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE81B0F34;
	Thu, 27 Feb 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671584; cv=none; b=cY3xPIeaJ1HHlb36amFsAE9O4p5UuQRgJg2do8ppFW/tYEnNJD04qBEYbgaLq9JxL5l/722HI+TzdFbpLQvLIPjQyjFA0ZfEU2fqVWcqIt4SIV1TFllPWzM12vNk/15M732Z3sRU3uNhGJ5yLe2oWApYh2Vp2j75X2ovS0YQkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671584; c=relaxed/simple;
	bh=jOJz2FR/B0tRpFsFUS+2kPu1QtdKBp50iFZ5wBb9Z9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rjm3raxD4b1KozClnuNkdXasGyFwB0tA/e1+DzN8Wgp3RSGPfiMYGlJPL8WzTpgOrcInbH0AlF667H8B3AMZMJ0gtoo3bHKH/5UtR80KbdaFqUnBOW0LRpHyfbiTN151u4Dahm59EOmI9NnFZEHebDnTqHkttrENb+Bz8r760Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=notNt6X4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671583; x=1772207583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jOJz2FR/B0tRpFsFUS+2kPu1QtdKBp50iFZ5wBb9Z9c=;
  b=notNt6X4vyKfbartKlNEgN3ef/m8aFJwaO5BcoZfgTenmS/tXgybwGw0
   SbYO0Cf6TzuMzI8tC94RYOFhpaK708JSfHcrt6CWy89O93j1nnz1QMFJa
   eOG8FYI91tB/7nrEkBjEqHwSHU1fQAqxqEBTcSP/ZKjrx9w+VaLQv7JNp
   A4Yb0mvHf0BzFZjsKcSMJN82ti/4HRt2HgnoE36gPVBCukI9vppLOy566
   L/ruTll1HZwHQ3qyqyX2a2gzPlbIrSUk1/OjqvDiY/f3+eVnx2Qn5RMSc
   T4RCTUU++vc8y/jy2vuqnWCnYIDJON0New19DHhJoZGsQA9sY4o0R9UB7
   A==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: XnE71ClNQWuRt2rlGzoFAA==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638164"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:44 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:44 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 04/21] dt-bindings: power: reset: atmel,sama5d2-shdwc: Add microchip,sama7d65-shdwc
Date: Thu, 27 Feb 2025 08:51:51 -0700
Message-ID: <688a94d7aed24d3b7253af43bff3804dd8ac711d.1740671156.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add SAMA7D65 SHDWC compatible to DT bindings documentation

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
index 0735ceb7c103..9c34249b2d6d 100644
--- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -16,6 +16,11 @@ description: |
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - microchip,sama7d65-shdwc
+          - const: microchip,sama7g5-shdwc
+          - const: syscon
       - items:
           - const: microchip,sama7g5-shdwc
           - const: syscon
-- 
2.43.0


