Return-Path: <linux-pm+bounces-29751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB5AEC63E
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 11:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDEC188AA9C
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BFB2441AF;
	Sat, 28 Jun 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="sEbnFNOz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380D221571;
	Sat, 28 Jun 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751102240; cv=none; b=tipVvMM7emrkaDRzeS7O0A1jFimG398XaDTjhbWUnt0Vaqht6CZ08rMxb8QdpSze5tpAbsnvkn9XE4ymAYdfy8FKyG44kWnuolNi5eKSqcKvzEFhf2sUj+aqDd83LKuN8EatGyCIgmg5zwz3NqpmP/j1o4+dq54tApb/TfIjTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751102240; c=relaxed/simple;
	bh=Cxmn5Pg3asAxCndjpH6SKGoZeSv83bYbPY9lt3FfYYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CG7MJUdb8Vzan9Auz+5rOf0OQtSJDo94C29fEfiQLYWLMj81V+pEooVcxMZzFFgaN3yK0EKyYrjcMaB1bqmQq04339nTFKG2y+qBlvOYrbyJoM2LWTu3dV4uJTwY+BWpaFSRAzb7ucV66uNSC2z68y/86rJ14AvhG8QkBfwZKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=sEbnFNOz; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 6ABEF41B97;
	Sat, 28 Jun 2025 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751101850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=navsmZTqmQHpjVJuIxDMB45VsnQulvdzgcB2jVDeqVY=;
	b=sEbnFNOz1ZreOjmMVS9CiVEKm6w1qbTJmPscHn211kLPCU6LjTDkcUMlcB1T9bjO9toRfT
	fZS+H/rfFRY7A4Ckhc1961jAMPNWcOtQ8FSgCWDPtg0pLJeHDkSpn93KrtDL00VsBbzSYM
	3sjsG1cMtJKgn5g092CG+aHZ0vlMXVg=
Received: from frank-u24.. (fttx-pool-217.61.150.139.bambit.de [217.61.150.139])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 044051226F5;
	Sat, 28 Jun 2025 09:10:49 +0000 (UTC)
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
Subject: [PATCH v6 00/15] further mt7988 devicetree work
Date: Sat, 28 Jun 2025 11:10:24 +0200
Message-ID: <20250628091043.57645-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Resend due my linux.dev mailbox stopped sending due to many recipients.

This series continues mt7988 devicetree work

- Extend cpu frequency scaling with CCI
- GPIO leds
- Basic network-support (ethernet controller + builtin switch + SFP Cages)

depencies (i hope this list is complete and latest patches/series linked):

support interrupt-names is optional again as i re-added the reserved IRQs
(they are not unusable as i thought and can allow features in future)
https://patchwork.kernel.org/project/netdevbpf/patch/20250619132125.78368-2-linux@fw-web.de/

needs change in mtk ethernet driver for the sram to be read from separate node:
https://patchwork.kernel.org/project/netdevbpf/patch/566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel@makrotopia.org/

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


Frank Wunderlich (15):
  dt-bindings: net: mediatek,net: update for mt7988
  dt-bindings: net: mediatek,net: allow irq names
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
  arm64: dts: mediatek: mt7988a-bpi-r4: add aliases for ethernet
  arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
  arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds

 .../bindings/interconnect/mediatek,cci.yaml   |  11 +-
 .../bindings/net/dsa/mediatek,mt7530.yaml     |  24 +-
 .../devicetree/bindings/net/mediatek,net.yaml |  47 ++-
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts  |  11 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  19 ++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 198 ++++++-----
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 318 +++++++++++++++++-
 7 files changed, 529 insertions(+), 99 deletions(-)

-- 
2.43.0


