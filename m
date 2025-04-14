Return-Path: <linux-pm+bounces-25405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA07A88DF0
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 23:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A9B3A7A5B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE31F3FC0;
	Mon, 14 Apr 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SS1KNV+l"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A71F37C3;
	Mon, 14 Apr 2025 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666925; cv=none; b=r2QUQEYenxBdLBirP608LskyprGYJtl//05+y3vMtqZt6CYEHH2dSHRyuquT0S3Cssio6k9rCHzQdkhMYC9VxwgjtjV713w7yApX5mhS076eYsNWPQv1K+1rQqc59I7M0hQqp4fNUq37+iIq/A1Wgyg+uUGeFHAXHf2UOTxxFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666925; c=relaxed/simple;
	bh=y6zBcUQgWavANG8NsuRsZDucUUdJh5SHXwtzFjn3t3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkZrCq1Q0nKMy7aHNPhfP6l3SQhtUaFngDQnGZaBmXIElc1FHNnSVSNl2+FKIUIoJRWfgeyWjSt+9eDwpFLSH/BZuq1oKHukKrNb6tcn+CcWo9kjHj26dWaO+W5qVPcvCxg9V5oYElvhx9po7GFSxka6aw1aNxpZw1oCYBnRNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SS1KNV+l; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744666923; x=1776202923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y6zBcUQgWavANG8NsuRsZDucUUdJh5SHXwtzFjn3t3c=;
  b=SS1KNV+lSIUgzW8prAD46q4jQrewiDHSoJZzrhcbF6QA5pDdyKXZJv3D
   gGDk5qhnef/DoAUAQDNA0wUXG0VIC1eMYrWftJbzcx5emcm2exleMprVk
   nyBEaVEd15QstkVCsidiyt+ws1DcfoydVbnTjrffzyv+tjxUqJLhDKZFz
   Qt2LRFFDdpX0yzi79K6YcdiSQaI9jPGplqtRCur5H1UgiTD0XEsszURz3
   zEe+RQ+CajVvJOgCcsC1cCiPviWC1NsbCusFNQHZPXmZdF1JPzU/HuzqE
   1dCKEXWV5xZ97jj2INq1OPF9TjlBUow/K04424eR5+Q2xxqn/V/VEvGug
   w==;
X-CSE-ConnectionGUID: jf75aQsXSneWELgtntpGWQ==
X-CSE-MsgGUID: oWsgq+VNSYGlvgdS9mCSUQ==
X-IronPort-AV: E=Sophos;i="6.15,212,1739862000"; 
   d="scan'208";a="40006667"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2025 14:41:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Apr 2025 14:41:04 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Apr 2025 14:41:04 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v5 01/11] dt-bindings: sram: Add microchip,sama7d65-sram
Date: Mon, 14 Apr 2025 14:41:18 -0700
Message-ID: <35015e91dfd7d2240d05160a75cdd6dc4f4e6e79.1744666011.git.Ryan.Wanner@microchip.com>
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

Add microchip,sama7d65-sram compatibility to DT binding documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/sram/sram.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 7c1337e159f2..3071c5075ee4 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -31,6 +31,7 @@ properties:
         - amlogic,meson-gxbb-sram
         - arm,juno-sram-ns
         - atmel,sama5d2-securam
+        - microchip,sama7d65-securam
         - nvidia,tegra186-sysram
         - nvidia,tegra194-sysram
         - nvidia,tegra234-sysram
-- 
2.43.0


