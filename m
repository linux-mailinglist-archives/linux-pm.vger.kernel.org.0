Return-Path: <linux-pm+bounces-28278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD8CAD14AD
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 23:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0070B163697
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416325CC6E;
	Sun,  8 Jun 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="bKdPZAD2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E625A337;
	Sun,  8 Jun 2025 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749417870; cv=none; b=osd3EQUQIusicVLJas/pJFNG92hbW9EIFByHF8VgKNz3kHBEl4uTPg19bbDGGFuWJ3MVCvXAlTl5TXS/b3diAHBMPb67GJ2Ex9Hft67yIT1Z66Ea3+YcqSgWAI/OXCDqLzYlMllyeAc62+j3fv5UKy+ctju8nFOojlChoKB0Phg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749417870; c=relaxed/simple;
	bh=i7LTF0PzYZ8rWmNIEhD5BzP+l+Leb46YWANh/GS73kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWZbI2IoAoCrUY4mxL7Xe1kZnye8XuCAIX4L9ikcgcsIztTlu5W3aKxYCBG8EucGwQlMcOZyzrSHiUA8nHjJKTynhafgIwQcm+ZE/n43kzrpZEceAQyc1HhYVT9U230QttUBfXFGnPio2X9D4FeJ4ammHqB/vNYC36mU8cgDGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=bKdPZAD2; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 1099860111;
	Sun,  8 Jun 2025 21:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749417299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/FDjKxyb0Ux2PaPWHkQ3W8xWMjny7KqjqFPL+z9eE5w=;
	b=bKdPZAD2AeuvbWPKvIdrWQHjSLAyltZ/Gdsyfyw1sfIPqlfC7xeleuWXWKOm9C9bOCsI8Q
	i1TwLPjb4xtAL5HdFSMz1T+5O26XelJ4RoT6kCfKDiCdjqmIewn0wLOf+L4KPJ4GmuNq+v
	1+4wMbAIvYiM1CBc2NhH4mIqlEq4K+c=
Received: from frank-u24.. (fttx-pool-80.245.77.166.bambit.de [80.245.77.166])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 9DBA91226D6;
	Sun,  8 Jun 2025 21:14:58 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 00/13] further mt7988 devicetree work
Date: Sun,  8 Jun 2025 23:14:33 +0200
Message-ID: <20250608211452.72920-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

    This series continues mt7988 devicetree work
    
    - Extend cpu frequency scaling with CCI
    - Basic network-support (ethernet controller + builtin switch + SFP Cages)
    
    depencies (i hope this list is complete and latest patches/series linked):
    
    for 2.5g phy function (currently disabled):
    - net: ethernet: mtk_eth_soc: add support for MT7988 internal 2.5G PHY (already merged to 6.15-net-next)
    - net: phy: mediatek: add driver for built-in 2.5G ethernet PHY on MT7988
      https://patchwork.kernel.org/project/netdevbpf/patch/20250516102327.2014531-3-SkyLake.Huang@mediatek.com/ (v4)
    
    for SFP-Function (macs currently disabled):
    
    PCS clearance which is a 1.5 year discussion currently ongoing
    
    e.g. something like this (one of):
    * https://patchwork.kernel.org/project/netdevbpf/patch/20250511201250.3789083-4-ansuelsmth@gmail.com/ (v4)
    * https://patchwork.kernel.org/project/netdevbpf/patch/20250523203339.1993685-4-sean.anderson@linux.dev/ (v5)
    * https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/
    
    full usxgmii driver:
    https://patchwork.kernel.org/project/netdevbpf/patch/07845ec900ba41ff992875dce12c622277592c32.1702352117.git.daniel@makrotopia.org/
    
    first PCS-discussion is here:
    https://patchwork.kernel.org/project/netdevbpf/patch/8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org/
    
    and then dts nodes for sgmiisys+usxgmii+2g5 firmware
    
    when above depencies are solved the mac1/2 can be enabled and 2.5G phy/SFP slots will work.
    
    changes:
    v3:
      - dropped patches already applied (SPI+thermal)
      - added soc specific cci compatible (new binding patch + changed dts)
      - enable 2g5 phy because driver is now merged
      - add patch for cleaning up unnecessary pins
      - add patch for gpio-leds
      - add patch for adding ethernet aliases
    
    v2:
      - change reg to list of items in eth binding
      - changed mt7530 binding:
        - unevaluatedProperties=false
        - mediatek,pio subproperty
        - from patternProperty to property
      - board specific properties like led function and labels moved to bpi-r4 dtsi

Frank Wunderlich (13):
  dt-bindings: net: mediatek,net: update for mt7988
  dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for
    mt7988
  dt-bindings: net: dsa: mediatek,mt7530: add internal mdio bus
  dt-bindings: interconnect: add mt7988-cci compatible
  arm64: dts: mediatek: mt7988: add cci node
  arm64: dts: mediatek: mt7988: add basic ethernet-nodes
  arm64: dts: mediatek: mt7988: add switch node
  arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
  arm64: dts: mediatek: mt7988a-bpi-r4: drop unused pins
  arm64: dts: mediatek: mt7988a-bpi-r4: add gpio leds
  arm64: dts: mediatek: mt7988a-bpi-r4: add aliase for ethernet
  arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
  arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds

 .../bindings/interconnect/mediatek,cci.yaml   |  11 +-
 .../bindings/net/dsa/mediatek,mt7530.yaml     |  24 +-
 .../devicetree/bindings/net/mediatek,net.yaml |  10 +-
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts  |  12 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  18 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 197 ++++++-----
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 310 +++++++++++++++++-
 7 files changed, 484 insertions(+), 98 deletions(-)

-- 
2.43.0


