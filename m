Return-Path: <linux-pm+bounces-25408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75262A88DFE
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 23:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A7F17B9E7
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7E11F5428;
	Mon, 14 Apr 2025 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mZBhuchO"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E64C1F4607;
	Mon, 14 Apr 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666928; cv=none; b=HZyDkIyWPnnnJpW7osSL9LXtjPhLsDmuO7aHCo7PIGDksZY1MiojJGG/uQeKAlYloVKHtfhgJVdc4EKahFG4YIXOvIotE4C5sfzcfh+pqoGM3utUPj7cfVPC769QvH791qEpZHAGgspPBTvoJKbh9tJqzIND7+1VkQ7fYQ0erEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666928; c=relaxed/simple;
	bh=P0+FQOoZAZDGBeJjjiJS1++QSiAMr7ZQoLAUMUlSI2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSiqSz83YYx/ex77rRe2uk1RtU9QdLhQ9FuJd3cBMOWaH/765gasZFvVYdE4oA/Sl4gd9CFp7lhrAQbERQwVzyphAQh7aETVShblU6f5kbCUjQwzm3QTVygU59AsM860b6JOrPMLC6dtLH6HkxMyq6Y2vPgAID+KHQpm1nCedJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mZBhuchO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744666926; x=1776202926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P0+FQOoZAZDGBeJjjiJS1++QSiAMr7ZQoLAUMUlSI2E=;
  b=mZBhuchOxlJxh6hGluBiGo7yzecPdjN5NOGW7OITn3aUIJbKTOSKfblq
   VlbE9wS5CYbd8NqnZdw8ZO/vKr/Eq8Fj+MITRDN+cqn5ae3iwlfTTFBi0
   GRnTQe3/LzO8lizj47T9HisuNFUeZU7DotIWaRMfVpAUemX0sy281bzfn
   PQbxxKBOjNfzfC3TZC/I7KCLlmu0Fc9j1AuaDG/T11p71Phx7W+9aFEAn
   kpN8jOWFlbUEOEhAYxJqj6II3Hh2jOvWZN3Ye3oNjnN9aDkY5ac5+S/S4
   yqK54sKWPC9sq1k5eSqevh7nbGIHOieiwU47dkWDa6gSXZXV33t2Z+KQs
   w==;
X-CSE-ConnectionGUID: jf75aQsXSneWELgtntpGWQ==
X-CSE-MsgGUID: oiXX/nZaR0SBoW4EIzQuEg==
X-IronPort-AV: E=Sophos;i="6.15,212,1739862000"; 
   d="scan'208";a="40006673"
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
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v5 05/11] dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
Date: Mon, 14 Apr 2025 14:41:22 -0700
Message-ID: <183474a65377f4030360166a5f2659af7323e82b.1744666011.git.Ryan.Wanner@microchip.com>
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


