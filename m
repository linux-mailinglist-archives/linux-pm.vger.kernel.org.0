Return-Path: <linux-pm+bounces-21736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59304A2FB91
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DC33A5196
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820424CED5;
	Mon, 10 Feb 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kHgTR4sL"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B9F24C671;
	Mon, 10 Feb 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222053; cv=none; b=OVowcYGJNSqL+a/zQtF2naKFzxL4H7nSaJjbgRYJcYEMeUoWVIl0USNXsHvkj5E0oPeswmSStjZe986LFHn1bbq4jf4niPWzrUHoJx6Ry5Iubilo2hoWAHVxA5HbHl0toTpGfSfmzkKdjaQPwscaAz/xapL7Z4Lljw4zmr7kros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222053; c=relaxed/simple;
	bh=Y2Ap/n3XU+GkX5uq/OLf/ypRq9fkD40RJF/s9rFn5tY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nolfgdFLsXH3oJObSTvlfuPezZUnMn9BIj3B/y+bL/7ghGzfr4JG1hwxOZWh6fYqpPlsPzNz0IGrRCgtGkT+uKlmTpSIyWE04+P+0dKF5aJzMufEXPEDS0BwBSk+NsTameKDW35Ds3AyQ/2ugaBVqG+uNF2BjHEoFQkBx6VGOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kHgTR4sL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739222052; x=1770758052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y2Ap/n3XU+GkX5uq/OLf/ypRq9fkD40RJF/s9rFn5tY=;
  b=kHgTR4sLtkMsiFQn8Dg0s16bsZnbzb8alc8Q7WLNJ6JSM/z9yZjFARFH
   wavlG7/u649OPRUhpJ71cDmDJpGx4Rri9jzaW2H9uuWkj4OyQ5DtFKuPT
   HBTL36FQuC0DFEjeMEqilxpbXOTv/QZ0UXDxxq76/+EBpbDqHXOE27tni
   ab91I9irFCU612oQ7utYBzB5e3E47rTM5sfUjRXNshvYRbHcglMt5fIv3
   3sLFJ2M6wxmSWSgHnMuzZa1yc/0YQ8f1djQOAgU/bGUvSknatXO3iV28M
   N7a3zG5iZqsHNHp0KHWWvy+52xwkqYYyZ/nkVbZedxs4wu/ltLSIqceXA
   A==;
X-CSE-ConnectionGUID: AYqW9AG9RbOJ2Xf8Pt97Yw==
X-CSE-MsgGUID: Xu/owgQoQyGvay+u6W+CDQ==
X-IronPort-AV: E=Sophos;i="6.13,275,1732604400"; 
   d="scan'208";a="205027964"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2025 14:14:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Feb 2025 14:13:45 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Feb 2025 14:13:45 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 01/15] dt-bindings: mfd: syscon: add microchip,sama7d65-ddr3phy
Date: Mon, 10 Feb 2025 14:13:01 -0700
Message-ID: <7e2c590467171cb3a942692aef5a679f127e567e.1739221064.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739221064.git.Ryan.Wanner@microchip.com>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add SAMA7D65 DDR3phy compatible to DT bindings documentation

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index b414de4fa779b..51d896c88dafa 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -90,6 +90,7 @@ select:
           - microchip,lan966x-cpu-syscon
           - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
+          - microchip,sama7d65-ddr3phy
           - microchip,sama7g5-ddr3phy
           - mscc,ocelot-cpu-syscon
           - mstar,msc313-pmsleep
@@ -188,6 +189,7 @@ properties:
           - microchip,lan966x-cpu-syscon
           - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
+          - microchip,sama7d65-ddr3phy
           - microchip,sama7g5-ddr3phy
           - mscc,ocelot-cpu-syscon
           - mstar,msc313-pmsleep
-- 
2.43.0


