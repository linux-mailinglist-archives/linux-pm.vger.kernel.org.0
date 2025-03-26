Return-Path: <linux-pm+bounces-24520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039F5A71AB6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F99B188C549
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8E1F78E0;
	Wed, 26 Mar 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="moeGxVw8"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004AB1F540F;
	Wed, 26 Mar 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003402; cv=none; b=ZVMUguWz/NvHw/tqr1eInr4cofAOnf+oXoLsQ1TFNAeJfp5aC2Q8BtqoqfRGuj/TVIsU6qYFmC+vnWLjruaWuGsbFOTAdRYUUBmAa2kFhNKT0qeXkdW/BZC3wiCq8ga9Ra6stnMrAbixEpuVfdXlSilnoR+xiOCCcoPsWgTTbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003402; c=relaxed/simple;
	bh=xkIKAcxmvRMr0isI4ttyqqzXZUNUbkxbL/xiHHpkAg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHHAu/FzZSG8imDDUnGxcxlKK1Td8MZ40Zw8TVa6TiJR8Loo9IKtBhWtxFoOKiyXMBdUXq+FD/AkKDCa5Mt4hn5tNKf+DOR5MFng3uJbKe336WTSSxlZKbk6ugjQ6c7YJS90teGzjrHuldSU5Aq2cdXJEGUAPC5ueIW79U43ZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=moeGxVw8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003400; x=1774539400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xkIKAcxmvRMr0isI4ttyqqzXZUNUbkxbL/xiHHpkAg8=;
  b=moeGxVw86o3cv3CQ8w8nv6zcOxlwMLiGa7lbWAYQtc7lMJFz8ueF1Y0/
   3cFFRhOkr95CHh8mmzCQQ7ZJYZeseF9N3mhkBzDwhxpQtxfvKdQ+VpuVQ
   SaEi63AJuS7mjyOb2d3LhO55xcSyVOwt8wiczHY4uTII/uy1oTx2jZWio
   HEKRtqbbnqUOPi+Z0AxrEf5TjE3BtKwvmznTcciAdjjSjjoQZKogffA+s
   2DJSAnOLVkXUVPmCmyGF/GudHwjshS8SDr0biR3Ktz23weh1c3DSLdzUz
   TRblArpRfCB23MVLwfwaPOYsyTKQc/s9x9LdjVB70ZlqX6U1uKmGBx0ev
   g==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: hBcQ+YvkQV+0ElpMLixFdQ==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096105"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:31 -0700
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
Subject: [PATCH v4 06/11] dt-bindings: mfd: atmel: Add microchip,sama7d65-gpbr
Date: Wed, 26 Mar 2025 08:35:39 -0700
Message-ID: <57a9f2ef94005bc7bb450fe073fb594fe7d5c2e1.1742936082.git.Ryan.Wanner@microchip.com>
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

 Add SAMA7D65 GPBR compatible to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/mfd/atmel,at91sam9260-gpbr.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-gpbr.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-gpbr.yaml
index f805545aa62a..f6f47999c6c1 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-gpbr.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-gpbr.yaml
@@ -19,6 +19,7 @@ properties:
       - items:
           - enum:
               - atmel,at91sam9260-gpbr
+              - microchip,sama7d65-gpbr
           - const: syscon
       - items:
           - enum:
-- 
2.43.0


