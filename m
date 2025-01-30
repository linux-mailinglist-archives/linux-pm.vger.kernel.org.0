Return-Path: <linux-pm+bounces-21144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 430DFA23322
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19371886A95
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75E71F238A;
	Thu, 30 Jan 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MqUKuyI0"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87F1F1535;
	Thu, 30 Jan 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258586; cv=none; b=U3RSW0u0HBwMq3uEa8lbY+Sa3MMw8hAKRT5g7DxnLemVp376eHbVE/aa7t1pzDOZFho5tWt8kfa5cBiFVez0Q+0xdviESe794jF2O4dbx0ZWhZ+6GelgZCao2t6EzhIomEW7PMR1vFsAyZsbxiWy9GzZVuMYviG+zjuu/Sgj+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258586; c=relaxed/simple;
	bh=zrbbMTlcUWrm93EkCQYP4a8+4Ji/9a+FhVO9sECvsBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj3IN7vlu5uHzk7Hr+vhtWgZc5sgjcy7D9X7L8a9EeTEoWMKZwzWUNY4p5g/Z3YrflZ2A4iOS+VsFk0Kvx58UBVk/2evH7XF2CtUAwxwWOH1UTbJaKKSc7bE0pZIJVj0ZLDeu8G+wAbEFH5mpF0kZBjAOzl7GZsw0ORJSJlNQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MqUKuyI0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258584; x=1769794584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zrbbMTlcUWrm93EkCQYP4a8+4Ji/9a+FhVO9sECvsBQ=;
  b=MqUKuyI0JSiifVcQEsRBkYRJ98fAgaKSIRwXkmKs4l4AS1/kQjFVJzpu
   eQZPgdfG0ZZNufE2bcizlKMx9bTk0uTX92ljj/XKxGGFhN1j+0dEl0hKz
   Uh/18M67/FqCPbPgxdoSnJDSdB4ZD0RGHwgSh7pR9bJYq0O7HtKNAuVGT
   qmGdevmULCE7wVjNYYZSPnVQg7nNt83FZ0m9jcCpggM01uf+Mmepb2fJ1
   6jIRhZe+XDkW/8T9GYvBA+cJ6HuE/NWOuI13g0aWLCGA9KCPM8l67qGv5
   tIH27No/B3L8URb/ZVfxRtAoxZlZbh9fa0sk3+x25JDYPKyxPHhKyDceC
   A==;
X-CSE-ConnectionGUID: Qux6TnwtQkq+U6Cg6JCAlA==
X-CSE-MsgGUID: 8djFspQTSKygg97mneOtTg==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204623013"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:36:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Jan 2025 10:35:40 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 Jan 2025 10:35:40 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>, <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 06/16] dt-bindings: rtc: at91rm9200: Reorganize compatible items
Date: Thu, 30 Jan 2025 10:33:46 -0700
Message-ID: <2846391c5ffab332ad7a4b65aa60aac9c49a3496.1738257860.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738257860.git.Ryan.Wanner@microchip.com>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Reorganize compatible to allow more devices to be added to this enum.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml        | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
index c8bb2eef442dd..30d87b74c51dc 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
@@ -21,9 +21,10 @@ properties:
           - atmel,sama5d4-rtc
           - atmel,sama5d2-rtc
           - microchip,sam9x60-rtc
-          - microchip,sama7g5-rtc
       - items:
-          - const: microchip,sam9x7-rtc
+          - enum:
+              - microchip,sama7g5-rtc
+              - microchip,sam9x7-rtc
           - const: microchip,sam9x60-rtc
 
   reg:
-- 
2.43.0


