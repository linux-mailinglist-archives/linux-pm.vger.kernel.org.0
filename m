Return-Path: <linux-pm+bounces-21146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6555BA23329
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1889D1612C1
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E2A1F2C3B;
	Thu, 30 Jan 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LoGV0VyJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06E1F1929;
	Thu, 30 Jan 2025 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258587; cv=none; b=RnZD3zeiJTGp0jTBSPR0AaC8pZjwpZe5dKKuKwJx8wBXby+moE8DtcO1RISFUzejx6rYvrs0XQpbwl4jGT9CFXol2iLywkn/Cg0YsTux6NvlxQwnARhphHnBqethMQHXKHVKsC7lGj3n73+QogwK6ur7cJHUv1KbI342pbzSm54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258587; c=relaxed/simple;
	bh=3DIUaseaLPdLuHuizOpT4HlTIidRdrZDDni3saHEVio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4Zu8ESCzLUOMI455JxcilW8cQMbh7jvb/hcROKjq6y542zkan/DNZY5vPITLR6RKo1A2ChUc/6VP8hiR+9Nlw6D7ImXLYdNjF7o3WOQpNsEwqlmB//92umpPF30SNTr2t+Lpwof4wHhj2qJhn215HtdV5PWWymEuZCqA0OmnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LoGV0VyJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258585; x=1769794585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3DIUaseaLPdLuHuizOpT4HlTIidRdrZDDni3saHEVio=;
  b=LoGV0VyJ7dnf3RIqo0l64qZjDJqo+OETHNZgl5IDq0RLXN4/bstRB06g
   VmoiVbU1JFARdzi8uX9L2rsOhM4DciSjo3DU8pXyNun+kOGXTYGIR3XiR
   nh8H2JOplhyxzfzv1Gm0PQHZ9ilwyF1RwRZ4coCHGCl9F3DIw/KZMCCli
   BlP+psxJEPQN40WN5u/5Jj9J/y1CJ5zd8AemSFmr+PyoMnYFVXK+KYSrE
   iANpCWqwAz7g4re55BQqUDytf15kpEA1OXCWBcY5yjzVTkHqI/F9vnxZx
   i3n+xi6lQHh47kF9bh3r29PL4XqUUzfIAl3opNI8DzhEFY6Ef/R2K4iZ9
   w==;
X-CSE-ConnectionGUID: Qux6TnwtQkq+U6Cg6JCAlA==
X-CSE-MsgGUID: EcLVourmTqyK7csd0aL7tA==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204623014"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:36:22 -0700
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
Subject: [PATCH 07/16] dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
Date: Thu, 30 Jan 2025 10:33:47 -0700
Message-ID: <18618f9afd74be84d446608257c37d7bc8271ff8.1738257860.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 RTC compatible to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
index 30d87b74c51dc..d248cd49dbe23 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
@@ -23,6 +23,7 @@ properties:
           - microchip,sam9x60-rtc
       - items:
           - enum:
+              - microchip,sama7d65-rtc
               - microchip,sama7g5-rtc
               - microchip,sam9x7-rtc
           - const: microchip,sam9x60-rtc
-- 
2.43.0


