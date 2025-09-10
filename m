Return-Path: <linux-pm+bounces-34387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81010B51D77
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 18:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AED9A02B36
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB723375B4;
	Wed, 10 Sep 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nth409R/"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287833471D;
	Wed, 10 Sep 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521358; cv=none; b=to1vzLoV1DAdLYw74DJf2ysH2pIy3Iejb3ElX2Jx0/hdKuZK9Nv7pKnfYHnrfLnk4PBaRESZ/NYwDPxJdSeMN6tAqmNGswerkMdLLZH2KlAfzUH66s++EKcbEyMij65V4NUyE2Dxe8Lve/UF4x9v8bTWbIG4jSh0ApynwbfLmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521358; c=relaxed/simple;
	bh=xu3xFpP6OXvzUwoD4NKkxmtoukGTQw+z9PKBijHr5YA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MnmNK7thyulsHv1KOO8PLXhLv2BD0n/hNOsAkiT750nmg0iAcMGKfeRG9tFObZOYJFBTKZ0d2q38UABABhigDrlOpI52UV+NacLgPTQtLD05yOFRUljz/T0+Ro3fNI7ytU1zmywF2D2Kd85noATw5PL2AUOwYwM1cfeZJwLQF+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nth409R/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757521356; x=1789057356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xu3xFpP6OXvzUwoD4NKkxmtoukGTQw+z9PKBijHr5YA=;
  b=nth409R/GpnW6Y0nRsBKm2/LQ9/gb391ByERLRV9sW9AxMrFq1WoXX2f
   4h8ZwZSUxHW/XiB/IhYwKzDmVOiRQ0eRff3BHHqK+Yi6bhQhzkBhg2Git
   566ptAWtb5MwmWpi0j3gqhJkYOZ0F/7ZLQ7IwNKGus3tXqBvukv5yb5TI
   ewMvJ7MDgypx/dzaZeQlz2bwxW1wxpkqMqvg3ivT3N1/fIgiEZ4vAXGJP
   HD+Vrs1MAlao86HI6vgsgg2/z6LOs8dhROfZonhC08Uk6fIcgCWDhre7w
   HX4Q4LAF4NUTSeEB3E2Q5T35GJ3gsgqLw6eKGd/T1hEgqHMDdvNk+EtzQ
   w==;
X-CSE-ConnectionGUID: yOp9HMF6QSeW0ZytE26RNg==
X-CSE-MsgGUID: 4CDB0pBtTlCSlNsC6aYZhQ==
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="46875547"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2025 09:22:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 10 Sep 2025 09:22:10 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 10 Sep 2025 09:22:10 -0700
From: <Ryan.Wanner@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH 0/4] AT91 Low Power Mode adjustments
Date: Wed, 10 Sep 2025 09:20:35 -0700
Message-ID: <cover.1757519351.git.Ryan.Wanner@microchip.com>
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

This patch set adds the LPM pin feature to the SAMA7 SoCs.

This set also removes the 2.5V regulator since this is no longer
supported.

Claudiu Beznea (2):
  ARM: at91: PM: implement selection of LPM
  ARM: dts: at91: sama7g5ek: add microchip,lpm-connection on shdwc node

Ryan Wanner (1):
  ARM: at91: pm: Remove 2.5V regulator

Varshini Rajendran (1):
  dt-bindings: power: reset: atmel,sama5d2-shdwc: add lpm binding

 .../power/reset/atmel,sama5d2-shdwc.yaml      | 16 +++
 .../arm/boot/dts/microchip/at91-sama7g5ek.dts |  1 +
 arch/arm/mach-at91/pm.c                       | 98 ++++++++++++++++++-
 arch/arm/mach-at91/pm.h                       |  1 +
 arch/arm/mach-at91/pm_data-offsets.c          |  1 +
 arch/arm/mach-at91/pm_suspend.S               | 75 +++++++-------
 include/soc/at91/sama7-sfrbu.h                |  7 --
 7 files changed, 156 insertions(+), 43 deletions(-)

-- 
2.43.0


