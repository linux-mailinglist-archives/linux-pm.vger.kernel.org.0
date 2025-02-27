Return-Path: <linux-pm+bounces-23106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756ECA483E1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98F27A34BE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669026E978;
	Thu, 27 Feb 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xy+CQ7XV"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E226E164;
	Thu, 27 Feb 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671592; cv=none; b=lFtEm21zSqtH+M59ytHyECT+RvuFzGEYL7HFySBUHx2G6tXiDDmcjB8enH1rI1U5pVsFId/mAAcQyRWeuqMmlWzfSAptMqS4qN6WiCrmb0p6CH8zfk+4y/aihmgN30J2R1O+LrIjIqBYlVrZVxGmc3XpVGuFJvcYGTMlEDPsq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671592; c=relaxed/simple;
	bh=CSqowWllSWs/9jg8yYeeMjHbutTuRtta9NocLFIFSDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYOwmFxZ00YpjT3P/9+6jIuEpgpxitohwXU01jkdwFgIJDr6DYdfI/IZylpVzeJFjWKWF1gBmi3PgWGDWVAGHOD0LcKCoXuanEzK1f+aXTtKtW7lMGg016wW8VmHyYf4kwTu7DOX/PLItoQOsHCpQMFm6IoEYD3CzB+GZOiA+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xy+CQ7XV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671590; x=1772207590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CSqowWllSWs/9jg8yYeeMjHbutTuRtta9NocLFIFSDA=;
  b=xy+CQ7XVKtzghOmtk5LhR0AOrmaSivMGirG1RbKiC+qfvv+k93E6wPso
   6y+ScHxcRoUX/smxRY9bGQ+SAbufbyKO1lNSm8GjU7KtKqkowi6VBtk6L
   75+HuGoslvebbkmSIVK69bNecC3ZZTWY6Mt6LY6eV3eYU26TLq+yQ8T4n
   UyRMMnG0sa86Ov4OfbsA39R4BcazittWWoXqUyERL5k26c3KFywZQ/clP
   WXemaYFPD9qIC98pugxi8bmU02eGDxYaZJtM8mz4I1bYHK79z+4d9nfQl
   2YJNzZ4mvPMLzS5GLv4B6hxKmfhMloyPqKTHXV+LcVXo9mS42qDXyQO76
   A==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: GjahxtAfR1ecHef6+c7Dig==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638181"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:46 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:46 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 16/21] ARM: dts: microchip: sama7d65: Add Shutdown controller support
Date: Thu, 27 Feb 2025 08:52:03 -0700
Message-ID: <ffc76b757cd1ba4ca38947f8b30525b848aa8ad7.1740671156.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add shutdown controller support for SAMA7D65 SoC.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 5165259fb926..b0a676623100 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -109,6 +109,17 @@ reset_controller: reset-controller@e001d100 {
 			clocks = <&clk32k 0>;
 		};
 
+		shdwc: poweroff@e001d200 {
+			compatible = "microchip,sama7d65-shdwc", "microchip,sama7g5-shdwc", "syscon";
+			reg = <0xe001d200 0x20>;
+			clocks = <&clk32k 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			atmel,wakeup-rtc-timer;
+			atmel,wakeup-rtt-timer;
+			status = "disabled";
+		};
+
 		clk32k: clock-controller@e001d500 {
 			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
 			reg = <0xe001d500 0x4>;
-- 
2.43.0


