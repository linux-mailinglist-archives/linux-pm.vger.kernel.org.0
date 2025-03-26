Return-Path: <linux-pm+bounces-24522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50205A71AAD
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D416D165166
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357C71F873F;
	Wed, 26 Mar 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1CNWLpmQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2F1F5845;
	Wed, 26 Mar 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003403; cv=none; b=C0mGL4gDu4QZOQqIARdIn29r10NIMyKZnsVtdSATRngPqBGeoUhg+8H8zU9JJxWxb2XqzgVQGYUJv4begozSimp5Q48PWqJ2ZY1DaadXSi6AgzWqOv4ohh0FI/+Ku2itpBYtH6JGVjQVjqX4add+o/HtD3LnK2qky2E5hzOFdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003403; c=relaxed/simple;
	bh=toMNQd4avKTFMnab9oaQtpEAy0iSa3Y/1sjDr01cM84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkEnPXMw7CkoaM7X/uJLeqoY7rF6HZD/4+5sKKRPfd4SaLnTJUN35gAPPSFsEOMsd0DlnU1zxeYEWZPBL0qKkAzhHKDTzoJ93oPPtACu8kmBVDs9TkLKOmuN1rtg2zA7TjPVYQ0e7boGN5l1QwYlLo+X+fyl6CabpsdSYfjiweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1CNWLpmQ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003401; x=1774539401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=toMNQd4avKTFMnab9oaQtpEAy0iSa3Y/1sjDr01cM84=;
  b=1CNWLpmQIyQVLEdCymY4eTU1HXfihFaalyoqquGK7fxe6w9b3E8lBXse
   H8MGZ8PO0ThSokO+LHy5btgLPVuCAuyC7BOuMHovOXqDBZqbscuxeu//c
   YyR0G/W46047GrSguP7LZBE4rQYp/YyFrvDQPbB9HqyyVTN1KL2iWQwpQ
   yLeXhN6UOicfYLTUW96Nv2rolJDMq1j0+PreMcyAkDY079QSsexRLTVth
   SA21blDV5zDICPTsFtsnCMXqzopgQIZiPM037RyQGPQCVmdlvJSw++inO
   0mAlOEmLJkfHbw1mXYmtzZUYEXiFl+8eG9ayeUWeqbxw1bUiuv2srepF5
   g==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: C3tCCdPASgia4Ox6w0hD5w==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096108"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:32 -0700
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
Subject: [PATCH v4 08/11] dt-bindings: mfd: syscon: add microchip,sama7d65-secumod
Date: Wed, 26 Mar 2025 08:35:41 -0700
Message-ID: <7248bb9d4ed491b178072b09830d6d68fde7b872.1742936082.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 SECUMOD compatible string to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml b/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
index 6edeb320220f..2f3e8722443b 100644
--- a/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
@@ -21,6 +21,7 @@ properties:
           - const: syscon
       - items:
           - enum:
+              - microchip,sama7d65-secumod
               - microchip,sama7g5-secumod
           - const: atmel,sama5d2-secumod
           - const: syscon
-- 
2.43.0


