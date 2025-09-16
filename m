Return-Path: <linux-pm+bounces-34762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63968B5A1A9
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 21:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BD9D4E2E51
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10D3304BCE;
	Tue, 16 Sep 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HRWZGMG4"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057A2E54BB;
	Tue, 16 Sep 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052253; cv=none; b=eFJBB/3T7GGD+7J6+ddXBCXmOXEKzWVC4jOYne39tRl6VMJt9WWK45a4gkRhlVKUlvlvGKxTn+dzUwf41Y11u/nNM5zq2KOLlmi81qahW9okJkOzZPh6sN20F0xo64xNZ0Pr6TH6vej2D/BfpKjeA8V6obrJDSXIgkNjzQdidr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052253; c=relaxed/simple;
	bh=rxU6PVmG83yicsKvP+6XTEJSdKPkh2zwzFo9IUSgHhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfhkXBzbDYPPdQqKHecRH/sB2GC7dNSK5GpdQcfHXnP+aaGjHrvODipbEiHsJ9iWqxYoYwyyPY29aBJ9LVZd8chZ/njOhjVkjm1lHAOTGQHsIiwr+C8rzIyrIZiasc7iaIBisoXPZJZAu/GgIEQKDmEn25kNWnarYGuDhgq+oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HRWZGMG4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758052252; x=1789588252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxU6PVmG83yicsKvP+6XTEJSdKPkh2zwzFo9IUSgHhg=;
  b=HRWZGMG4/IC5cDhjbXiVRIz3jU6i06cuyWFGO+PZSYKegVLAmIxj7+O/
   W0iosH1DZzmOL/QjxcfomItshIZRhOQdP6Khq7Ain5CrixTJlc5Fp87V/
   J+T61Xz8LOEEgXsbsO/7j4xyLTse0AKrp1JJ2l+lwhaJ6opYN1H1H/Y5f
   uIcu7D8pGLVb2ddmg9id1/AGkU8EER6GKd5nLW24Cr7Agrdx5bdcLt2N/
   37RiGjGqdf6RNQdqqSgN8j022d311cDJvnok6+9O47By/L9zItYhgwWAH
   a8RV7lB9IqlZ0czXDmrQhMrF/RNE8e8S7zEM/tmm/p7exHH0Dj/Dp+d5h
   Q==;
X-CSE-ConnectionGUID: OpVEzCAsSoaW6AVT1s3wKQ==
X-CSE-MsgGUID: iEhMxX1lQ0qgWColzJt/pQ==
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="47129849"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2025 12:50:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Sep 2025 12:50:17 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 16 Sep 2025 12:50:17 -0700
From: <Ryan.Wanner@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/3] ARM: dts: at91: sama7g5ek: add microchip,lpm-connection on shdwc node
Date: Tue, 16 Sep 2025 12:50:32 -0700
Message-ID: <e7b5108c07bd2b0b2bd83b22b373f0edeb6adc1a.1758051358.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758051358.git.Ryan.Wanner@microchip.com>
References: <cover.1758051358.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add microchip,lpm-connection binding to shdwc node. On SAMA7G5-EK REV4
LPM is connected to GMAC1's PHY, 24MHz oscillator and PMIC. On board
PMIC is not listed here as it is only treated on BSR mode
uncoditionally.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 3924f62ff0fb..50e9a5a5732a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -872,6 +872,7 @@ &sdmmc2 {
 
 &shdwc {
 	debounce-delay-us = <976>;
+	microchip,lpm-connection = <&gmac1 &main_xtal>;
 	status = "okay";
 
 	input@0 {
-- 
2.43.0


