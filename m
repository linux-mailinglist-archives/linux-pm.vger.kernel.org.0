Return-Path: <linux-pm+bounces-34759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DB6B5A1A0
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C970A163DA7
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785BE29D27D;
	Tue, 16 Sep 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZgG9cg+P"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0622238178;
	Tue, 16 Sep 2025 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052250; cv=none; b=rzCvSxaP6ogVvF0qWyPf0XCAX/okW4cwaXWCIRUQJOz7wzEQGrbajsQaixQEbs1MC3p/tn/7fmCZc+r0JDy6viWxeh03y+PSH74n87bJ4ejwbbM4q3r/2U3lsVAEOat/ANzTwszIOlNcCXKuejol1tXMWowwlkTgASr/nA48rF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052250; c=relaxed/simple;
	bh=Hseq//EDsBEnv5NDrY+cP9+6SHkGyS860cCT1WxT8j4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lJ6+K4ovLS3u3WlYLzd4WPwr9MbrpXFTzklaFm0jzR+LDv0wYEX8E87m4fyA0Xhn+7aKqIsZNwh3umyxQTra+5YgeawEu3nahdd4YPOZRtdxKqzKxhbI4l6/U38FiJ1UNySKht9Zg4DKHVG6cArxTFFZ+ywi0Nd+729IXPmPXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZgG9cg+P; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758052248; x=1789588248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hseq//EDsBEnv5NDrY+cP9+6SHkGyS860cCT1WxT8j4=;
  b=ZgG9cg+P6zBAo7hLAmZzwwv+zQF5xKdNFhZzdeM7GxHsw9WBpybeJFZx
   /0JkT7GONSGem435xqgL/Jq+ImJ4jEiKyud6wGXVR9KLqcCXxbrgtJQbE
   90SdSHtudkfyAnLzjIAmeN6FEfzfL6KhQLXN1BU2NZztcVK6tg/aV6ztM
   wvjbopR8E3B9MqKYXzlxriZXAYoXwOFMJx/+HFeSLvUava1CM0n1dLiGX
   74h16huwk0j2bH5KieNDari7b78nK3D0K/lULDQagiWWpI2KyghQtRyV8
   MYK4B0YhLKhQNhU5LgcBC9ZCnEYB+uJ23QQ+UvG4Ww0YltmYoIA3oJlw8
   Q==;
X-CSE-ConnectionGUID: OpVEzCAsSoaW6AVT1s3wKQ==
X-CSE-MsgGUID: 8eDFBDG6T+uCphA8wzxghA==
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="47129844"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2025 12:50:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Sep 2025 12:50:16 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 16 Sep 2025 12:50:16 -0700
From: <Ryan.Wanner@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 0/3] AT91 Low Power Mode adjustments
Date: Tue, 16 Sep 2025 12:50:29 -0700
Message-ID: <cover.1758051358.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This patch set adds the Low Power Mode pin feature to the SAMA7 SoCs.

Changes v1 -> v2:
- The 2.5v regulator has been removed as it has been applied.
- Adjust the dt-binding to allow more than 1 phandle.
- Adjust the commit message to explain better what the Low power mode
  pin does.
- Simplify the how the lpm pin property is parsed from the DT.

Claudiu Beznea (2):
  ARM: at91: PM: implement selection of LPM
  ARM: dts: at91: sama7g5ek: add microchip,lpm-connection on shdwc node

Varshini Rajendran (1):
  dt-bindings: power: reset: atmel,sama5d2-shdwc: add lpm binding

 .../power/reset/atmel,sama5d2-shdwc.yaml      | 19 ++++
 .../arm/boot/dts/microchip/at91-sama7g5ek.dts |  1 +
 arch/arm/mach-at91/pm.c                       | 96 ++++++++++++++++++-
 arch/arm/mach-at91/pm.h                       |  1 +
 arch/arm/mach-at91/pm_data-offsets.c          |  1 +
 arch/arm/mach-at91/pm_suspend.S               | 48 +++++++++-
 6 files changed, 158 insertions(+), 8 deletions(-)

-- 
2.43.0


