Return-Path: <linux-pm+bounces-24515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89719A71ABA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301A57A3FE1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF97E1F4275;
	Wed, 26 Mar 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s7lLJnGl"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C81F3BB6;
	Wed, 26 Mar 2025 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003398; cv=none; b=DUR9Ex6FvyZXyZiBGlADRvmQYkHc68KNA4uPL1KiwNcMd2fzpotz9/CsBfmN6w67qhLZ7puNzIWHDW8j1POTofp6MiwjXclXWGz8YlMkbMTfcTSURKk51hVE8nyn8t+cqK7FAH2KTTams1WHp1q+DA0dn5WPJNr9NSLm2/Xppfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003398; c=relaxed/simple;
	bh=y6zBcUQgWavANG8NsuRsZDucUUdJh5SHXwtzFjn3t3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbSO0b737ftAR+dBJLDedsUY4yzPrBoAjXfd845XDeBI5kksTDVLAG9dSV6cWL5fxxneWyk8pzAIwNDc6b3qmTQ65JmHK1T85BeznMdWervbRA3tBTXrIIhL1cZCa9mFDBx0pkg2uHBRN7Z2KA9TZIX7APyyYlZ+tOVAXISvbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s7lLJnGl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003397; x=1774539397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y6zBcUQgWavANG8NsuRsZDucUUdJh5SHXwtzFjn3t3c=;
  b=s7lLJnGlFQAUWQuKogbfkKdEXNC/FuQIZK7WFEPQSHFZPKxrthktx7p/
   YVvTS6ZpNfkVD5SpybSOu+NKM7HEvztfA+3CLq7IfCeKvGeuMDhD+dOVh
   HXun0mCIRmfJKjmQA6sM7CAwpvl/17cf7JMSWjs1p8WjFlc0NURHlMCCv
   wRPq5mpgRQKsxe6oClue/1Glh36vxz3ltkz8PkXH6pP4gRYM2+X6qOs6V
   CUZUVR/JV+ypFEd3OjO9M4fR2JNiW9dX/HXb0JJhQMMGy5uEaK6Y4MPST
   JUR7698aHaWJ3aYNmu5sigP8PTcyVsIwnwka/I8fh08mhXer2NUiOC5m+
   g==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: nwryJGrFR6W9xwUv1FaEAg==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096097"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 08:35:50 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 08:35:50 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v4 01/11] dt-bindings: sram: Add microchip,sama7d65-sram
Date: Wed, 26 Mar 2025 08:35:34 -0700
Message-ID: <35015e91dfd7d2240d05160a75cdd6dc4f4e6e79.1742936082.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742936082.git.Ryan.Wanner@microchip.com>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
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


