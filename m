Return-Path: <linux-pm+bounces-24519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D2EA71AA1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBAD188C4C2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839091F583A;
	Wed, 26 Mar 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JsesEFF+"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D41F4736;
	Wed, 26 Mar 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003401; cv=none; b=q9AlToLa465arOwT4u6mrj7p2PqrdSsT3y0A/GcnhgtcWjDSvF4OCse1tunTanYPhPmGO2URZlt9sSjeXISXZ63NtGepwRl5IHvfnR5s1nAS1b7vW0ZRFB+cxzfawmdWv1IsjHi12K8wyD4+wV02/gkGPWqoJWxTTwWQTDcsy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003401; c=relaxed/simple;
	bh=P0+FQOoZAZDGBeJjjiJS1++QSiAMr7ZQoLAUMUlSI2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjCEqdicwSRjYwJWyEuj0VUK19HCMs17iPdJdZOnwEqRd07DUkdJMSmavvzre17/lBa/68FjqXbRVSKnbbkBQ7HImkFgRzW7StYwlxFTH6TlHY6PedZaCKBnpmZDroFLlMTSjVjkSmBQsV6qd3DwCRSrd7eAlspz1mceFN+lxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JsesEFF+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003399; x=1774539399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P0+FQOoZAZDGBeJjjiJS1++QSiAMr7ZQoLAUMUlSI2E=;
  b=JsesEFF+EfFz6TtugH95a4wnS+BB40ZNLmLRgb2HtmqW4w42KvgDDDHX
   wCA+mItlg5qleSRoBwYwC60R+wLi7acEG/uAB0+OHSxtVrxw9eSO7/hfc
   +vaY3LeRIXEw7+PDBXVxiioRC+g1g1FnKFL3EbqjWhopbyGJVrwNdNDXS
   Sd8tIzXp6u/TY08sw3PmJS/GvPaNcvdsxBG4R9y/Xv/mgfa+ZdKFl4JN/
   EGQTSN4ICMPCF6cX2W3AmQuuW8AznHoIvAuGvMJRnR4qcQlidfIJGNHWT
   mhmp4zIPkAx4G2I96+BkKV4+zck10QAELZBsdhbHQqYTU9iX4+afsRV9r
   A==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: 2WjqQwB5TPyGcK53n9hLgg==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096103"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 08:35:51 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 08:35:51 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v4 05/11] dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
Date: Wed, 26 Mar 2025 08:35:38 -0700
Message-ID: <183474a65377f4030360166a5f2659af7323e82b.1742936082.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742936082.git.Ryan.Wanner@microchip.com>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add SAMA7D65 RTT compatible to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
index a7f6c1d1a08a..9c9b981fe38b 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - microchip,sam9x60-rtt
               - microchip,sam9x7-rtt
+              - microchip,sama7d65-rtt
           - const: atmel,at91sam9260-rtt
       - items:
           - const: microchip,sama7g5-rtt
-- 
2.43.0


