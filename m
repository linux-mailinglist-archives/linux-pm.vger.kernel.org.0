Return-Path: <linux-pm+bounces-25406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4313A88DF5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 23:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58893A7FC2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAC11F4297;
	Mon, 14 Apr 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nIZ+GCVZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB71F3BAB;
	Mon, 14 Apr 2025 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666926; cv=none; b=jPm6xl63lGyP3K8wvP1w3r/S+NJ78kv958+gSFT9COhC0TIYCVNmLSHPYhQNjJQ1O3cgIB9WQSzSO2DoLPgZ6p9uRWA4pihMfOl39VQoFKtUzFCYy8c2+834lNWoP6g0Z5rq8LXG6Q/PCUzMT7tCUO0d24u4mfrrUhxY190Gk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666926; c=relaxed/simple;
	bh=jOJz2FR/B0tRpFsFUS+2kPu1QtdKBp50iFZ5wBb9Z9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/cY/L4/2U6fKW9xvXI+RAbsIEJVLJ8flxn2bUW4CKgNgdu3tKEgqFyUy2kkfHGdzx+KlO3T+FI3/3p+7SEwNvT6CG4jgpfvMAVZ3hsCwuNHX/hiCXicpFGbBy9WAf5b//gtHcH6bFi0ye5ZgNsodJBmbEN4dxin8qcaE341lrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nIZ+GCVZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744666924; x=1776202924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jOJz2FR/B0tRpFsFUS+2kPu1QtdKBp50iFZ5wBb9Z9c=;
  b=nIZ+GCVZa2NjjH5PikWXF3DtjDJuiwy36UykC0CmWnxcrlEPip2ztiNP
   ZvWxXPAIyAHiXGqhio5fCebafNoSykD/zy4d+HRclz+qG3rU7BIyoIncG
   SGTNhPtiC/pV0FV0OWBRVSxQTL1B79T3zcxeUSy0ptvlht+8QWWZJAv7+
   P5hyVk3OVErtekyA6qV9cRCB7Vlu+oSqbTWX1/kRrh9AlTPB4PJzmtk+Y
   z8IRMrKlZ6Yfe42+5fTx/2iCiisD7/uP9dvzDs86Y82QrS7perX4UHWiO
   zh/YvXRABCstQUSA6bjuoLdvxpnyFVZY3UHjsKsFu4fXEBvxIwJ9hOA/b
   A==;
X-CSE-ConnectionGUID: jf75aQsXSneWELgtntpGWQ==
X-CSE-MsgGUID: kear+yGWQxarTgaYcOwEtg==
X-IronPort-AV: E=Sophos;i="6.15,212,1739862000"; 
   d="scan'208";a="40006669"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2025 14:41:55 -0700
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
Subject: [PATCH v5 02/11] dt-bindings: power: reset: atmel,sama5d2-shdwc: Add microchip,sama7d65-shdwc
Date: Mon, 14 Apr 2025 14:41:19 -0700
Message-ID: <24666308604d3eb9f2b8c64d4a466c6fd77120e9.1744666011.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 SHDWC compatible to DT bindings documentation

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
index 0735ceb7c103..9c34249b2d6d 100644
--- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -16,6 +16,11 @@ description: |
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - microchip,sama7d65-shdwc
+          - const: microchip,sama7g5-shdwc
+          - const: syscon
       - items:
           - const: microchip,sama7g5-shdwc
           - const: syscon
-- 
2.43.0


