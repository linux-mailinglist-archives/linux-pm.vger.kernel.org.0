Return-Path: <linux-pm+bounces-30214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42B9AFA565
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 15:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F630175D10
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606DC216E26;
	Sun,  6 Jul 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="bVWPImTa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AF22C339;
	Sun,  6 Jul 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808489; cv=none; b=bMsef0ITZHqxHW8pbvaTuB0R/J9QSt8nPNx8RSCzHjs0fPhcs8Ky/UZI8UiQDspmLLJs4DduuMRePckqgapG4qMBOIlWc/0vFSoZj80+EIfqfaNrLwh8qZghtD2zDOMeYQSz/lvzDElZ2KbDkz7hYKCV/KQDZA4jmswiRPHZOSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808489; c=relaxed/simple;
	bh=da0nGvF5a6zpWt5nlmeRCxWf/vRF9Co2BJ4qdir28RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWhAG5Az2szuhKGvr5eoECPVLZ9m5m7nuE2shnI7LWGa5lwUm7W66R7QJ0Y5tpnmCjwOGxBbkCZO19GZByZyghFaqsGPEzNzSEQBqv0QUekcHaX4fWB05p6zQDngwbR0BIQQLDgaDZf22EKEpKIsYOLvHv3louGFbSlAO887wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=bVWPImTa; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 13E341007A2;
	Sun,  6 Jul 2025 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751808147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gxsf7Rk0B55yNOTDa6h65e6zX4Hkue5rNrAIRz/iPnc=;
	b=bVWPImTatLUpkqzrGVcUoRuOZWjadNfEVDzV9/lxth3+czm8s0V36ZLfb4hIeCafjFzvSm
	6bQjO41J6ZE143Nsvn03mJ5ooLW11W2iZaQHdGPno42at8CQHNSfrtZyTNn17Es9mQClfN
	+hw48fUqSRLaIhwiTQRXxRmFWN8EynY=
Received: from frank-u24.. (fttx-pool-194.15.86.111.bambit.de [194.15.86.111])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id A4EF01226A5;
	Sun,  6 Jul 2025 13:22:26 +0000 (UTC)
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v8 00/16] further mt7988 devicetree work
Date: Sun,  6 Jul 2025 15:21:55 +0200
Message-ID: <20250706132213.20412-1-linux@fw-web.de>
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
- GPIO leds
- Basic network-support (ethernet controller + builtin switch + SFP Cages)

depencies (i hope this list is complete and latest patches/series linked):

support interrupt-names is optional again as i re-added the reserved IRQs
(they are not unusable as i thought and can allow features in future)
https://patchwork.kernel.org/project/netdevbpf/patch/20250619132125.78368-2-linux@fw-web.de/

needs change in mtk ethernet driver for the sram to be read from separate node:
https://patchwork.kernel.org/project/netdevbpf/patch/c2b9242229d06af4e468204bcf42daa1535c3a72.1751461762.git.daniel@makrotopia.org/

for SFP-Function (macs currently disabled):

PCS clearance which is a 1.5 year discussion currently ongoing

Daniel asked netdev for a way 2 go:
https://lore.kernel.org/netdev/aEwfME3dYisQtdCj@pidgin.makrotopia.org/

e.g. something like this (one of):
* https://patchwork.kernel.org/project/netdevbpf/patch/20250610233134.3588011-4-sean.anderson@linux.dev/ (v6)
* https://patchwork.kernel.org/project/netdevbpf/patch/20250511201250.3789083-4-ansuelsmth@gmail.com/ (v4)
* https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/

full usxgmii driver:
https://patchwork.kernel.org/project/netdevbpf/patch/07845ec900ba41ff992875dce12c622277592c32.1702352117.git.daniel@makrotopia.org/

first PCS-discussion is here:
https://patchwork.kernel.org/project/netdevbpf/patch/8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org/
some more here:
https://lore.kernel.org/netdev/20250511201250.3789083-4-ansuelsmth@gmail.com/

and then dts nodes for sgmiisys+usxgmii+2g5 firmware

when above depencies are solved the mac1/2 can be enabled and 2.5G phy/SFP slots will work.

changes:
v8:
- splitted binding into irq-count and irq-names and updated description
- fixed typo in mt7621 section "interrupt-namess"
- splitted binding changes into fixes (mac) and additions (sram)
- dropped change of reg (simple count to description)
- change ethernet register size to 0x40000

v7:
- fixed rebasing error while splitting dt-binding patch

v6:
binding:
- split out the interrupt-names into separate patch
- update irq(name) min count to 4
- move interrupt-names up
- add sram-property
- drop second reg entry and minitems as there is only 1 item left

dts:
- fix whitespace-errors for pdma irqs (spaces vs. tabs)
- move sram from eth reg to own sram node (needs CONFIG_SRAM)

v5:
- add reserved irqs and change names
- update binding for 8 irqs with different names (rx,tx => fe1+fe2, rx-ringX => pdmaX)
  (dropped Robs RB due to this change again, sorry)

v4:
  net-binding:
    - allow interrupt names and increase max interrupts to 6 because of RSS/LRO interrupts
      (dropped Robs RB due to this change)

  dts-patches:
  - add interrupts for RSS/LRO and interrupt-names for ethernet node
  - eth-reg and clock whitespace-fix
  - comment for fixed-link on gmac0
  - drop phy-mode properties as suggested by andrew
  - drop phy-connection-type on 2g5 board
  - reorder some properties
  - update 2g5 phy node
    - unit-name dec instead of hex to match reg property
    - move compatible before reg
    - drop phy-mode

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

Frank Wunderlich (16):
  dt-bindings: net: mediatek,net: update mac subnode pattern for mt7988
  dt-bindings: net: mediatek,net: allow up to 8 IRQs
  dt-bindings: net: mediatek,net: allow irq names
  dt-bindings: net: mediatek,net: add sram property
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
  arm64: dts: mediatek: mt7988a-bpi-r4: add aliases for ethernet
  arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
  arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds

 .../bindings/interconnect/mediatek,cci.yaml   |  11 +-
 .../bindings/net/dsa/mediatek,mt7530.yaml     |  24 +-
 .../devicetree/bindings/net/mediatek,net.yaml |  44 ++-
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts  |  11 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  19 ++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 198 ++++++-----
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 318 +++++++++++++++++-
 7 files changed, 527 insertions(+), 98 deletions(-)

-- 
2.43.0


