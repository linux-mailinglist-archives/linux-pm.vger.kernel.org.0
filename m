Return-Path: <linux-pm+bounces-25410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB7FA88E06
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 23:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1983D17BADF
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 21:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431091F8720;
	Mon, 14 Apr 2025 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WWZou3jl"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F61F4C9C;
	Mon, 14 Apr 2025 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666929; cv=none; b=QwevXJf/rHMjGC5V8TwZR6zP9l7a7wncGi8RsQVaet79Iryp+tRtuqQdxZdob/RalmUF+NXqRZPOG9SnahGDVYXiuA00SAhW/uzYFYaPVVIo2cYWTS5NDyeHTC10uaPQCFt322ZYdv7W/XfR1qhupPnhWR9A/9TwviX8g8PEcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666929; c=relaxed/simple;
	bh=OM1d3llXIfkK0/Fd/B3sNNDqgNroniFjy4Xdxaa5Z5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ft/hLuxbJ2UD2zVzdSGX6U04VazCTHS5k4kam5KDvlcwInktXFk5U+J6ZGBT3suNBgNdQs/z0aWAjXB+SpqwCiHt4yq/7/IRaj8AscuNFTrTueJse13+p5ajsENFSSYgDUNcb6e0HPfXKBv8dU8z0epGGj47D856UPHe1EY4Yqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WWZou3jl; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744666927; x=1776202927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OM1d3llXIfkK0/Fd/B3sNNDqgNroniFjy4Xdxaa5Z5c=;
  b=WWZou3jlLFWxDX4AfxtxYB8SF50orUqVKwVWU4BsX4bc0VRxucD8RQFP
   7+itvTepUHO/1FKskOkgpQgEI3V8lkHU6J3ZO+3blPmZ4Z09/k79J7HzW
   G6O8JxraEpyn7NKYw1k5i/5elcau35w1TvZ1lOzuZrcH+/fNFK+uDyjaR
   ZGY8+/BsxPT7XAvnmaJClJSmEfjRPt1vlLY349c/rOzfGc+TXLT6bmM0S
   tuVCMXv60I3LoJOBLYaf3YVb/Eb/kZjU/2f9GT1qYlhZXYlFOxCEmBbkI
   eFb0gYdQW40CZ7byGYXYu3MRLSH2hCyZ4YwI0Fpv6jzL91jCWLPIITURz
   g==;
X-CSE-ConnectionGUID: jf75aQsXSneWELgtntpGWQ==
X-CSE-MsgGUID: fu3b2IBCT8mVUyCt3fIHXQ==
X-IronPort-AV: E=Sophos;i="6.15,212,1739862000"; 
   d="scan'208";a="40006674"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2025 14:41:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Apr 2025 14:41:05 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Apr 2025 14:41:05 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 06/11] dt-bindings: mfd: atmel: Add microchip,sama7d65-gpbr
Date: Mon, 14 Apr 2025 14:41:23 -0700
Message-ID: <ddbcb306699b8c09f3210d714c0701afa1a7cb96.1744666011.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744666011.git.Ryan.Wanner@microchip.com>
References: <cover.1744666011.git.Ryan.Wanner@microchip.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


