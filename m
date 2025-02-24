Return-Path: <linux-pm+bounces-22814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CEEA42367
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 15:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F5E16F1FC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1901E254844;
	Mon, 24 Feb 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CLBQNIPk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XdPt6QjP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7F24BC14;
	Mon, 24 Feb 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407328; cv=none; b=ktL/I+9WdV7E4fSLn6bZFPbTZd+E1X9Me3giWiCN0CDbQh9HewdT7yUN02zec+Zo0LS4F2fyKSpYli3WaNLYNsTu2iL816VfNbSiufo8lje4IFSPXZSv8WbimUqgkUPTvFEoC8OH3xvbsz0W4xKDuguGGiJmga+Dg4E0fLV9ujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407328; c=relaxed/simple;
	bh=vjSkzZMm6hnVsnL4OBKLlEPTJr3DRcmbUtmaNmTWP28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfsdqOmxyt8U/A9OAM86sFVDN03XWpoQJXWWVz9VcG24K+KhGuGLWuFJahubZtwQr4dNWdNNbg/VPTif+PmWBAwNQpUPO10G7upbfGeJlW2VyOjQhzfJV1aLQXK68UTNS2UgO8DWKw6tJq3Odj/4dI70uDODpUYD8KwPsfoU7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CLBQNIPk; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XdPt6QjP reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740407325; x=1771943325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f163cXOml+YO0Ef+W322W1dfG/8cGPnD5lNX0O+cQgg=;
  b=CLBQNIPkl/ZtjimMm84W7z4eMQ1E1bn/YH76jTzUKcNvIIp1qLFQZmqZ
   BHlVMLNOXZeuB4y1TI2rR+r+7TJEv3LwX+3mgUh1dIRUh/m0zy0bLjV73
   VBsQ4ls3NeMMbpF4N6OPSq6nDNiklG9kp1sLqoDulsvBO23q54/J/jRBQ
   saG1Jcg2rHECY6pvGYXvSVJ3DqYaDaDwa0TiR2m3DMHaC/JLuIAHaB02S
   /mjh0Jy9IQzVzoNppV8EV4IoYG/sBEy34rz7uCSS2OCjik+kki1o+AxSi
   Wtm2JIr9iu2L9wa8WPMXWYYsqjcjfZPvq8/DyMY2O4idg/AV3Mp92Wdmi
   w==;
X-CSE-ConnectionGUID: Fl10DxnJTpqdmIPt8ZJkOw==
X-CSE-MsgGUID: FIP9+gYZSO6RU2rvvRug9g==
X-IronPort-AV: E=Sophos;i="6.13,309,1732575600"; 
   d="scan'208";a="42042100"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Feb 2025 15:28:41 +0100
X-CheckPoint: {67BC8219-2F-B8541F8F-E50F9B0E}
X-MAIL-CPID: D7FE984E3EAE872F6989C03514BDF7EE_2
X-Control-Analysis: str=0001.0A002105.67BC8218.003B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B250E163EB7;
	Mon, 24 Feb 2025 15:28:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740407316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f163cXOml+YO0Ef+W322W1dfG/8cGPnD5lNX0O+cQgg=;
	b=XdPt6QjPC5bfyE59bCT3j/2fQcyS7YcghvcH3qz46Y39oEwWIPfuPnAg0oUMFP07l0ZF73
	1etv9Ca05+DeOmYO/RLc86RCj+sfx1UaQEmDOSxmo8WojwfdHhLTWfy6Ar/yaXYfZBRyZ0
	eFblQEocm9yKIYZkwHDlXpANU05KnWRqDzI1K7q8Wzf1CEzy29Eh7dI6HcbcSdVJb/YtvK
	BShermGzljlCOIFRJ30Pvt6BeVls99HmGLh5klohZciR3mkzI+6q8MRBrIFkAd/PdQ/shn
	0Zp0GE78xGZ5MPH7QoyhwZuDzw0SESyNIjWeE2H/YnW9pC5yEik6HyaKjVaH+g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/6] TQMa93xx on MBa93xxLA/CA LVDS support
Date: Mon, 24 Feb 2025 15:28:21 +0100
Message-ID: <20250224142831.485159-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

after a long time (v1 at [1]) this is v2 for the LVDS support on TQMa93xx
module series.

It consists of three parts:
1. New PLL configuration for 477.4 MHz
2. LVDS support for imx93
3. LVDS platform support for tqma9352-mba93xxla & tqma9352-mba93xxca

Patch 1 adds a video PLL configuration for 477.4MHz
Patch 2 is the imx93 equivalent of commit 1cb0c87d27dc ("dt-bindings:
  soc: imx8mp-media-blk-ctrl: Add LDB subnode into schema and example")
Patch 3 is the imx93 equivalent of commit 9cb6d1b39a8f ("soc: imx:
  imx8m-blk-ctrl: Scan subnodes and bind drivers to them")
Patch 4 is the imx93 equivalent of commit 94e6197dadc9 ("arm64: dts:
  imx8mp: Add LCDIF2 & LDB nodes")
Patch 5 adds LVDS DT overlay for tqma9352-mba93xxla platform
Patch 6 adds LVDS DT overlay for tqma9352-mba93xxca platform

Changes in v2:
* Rebased to next-20250221
* Reordered patches
* Added 'ranges' to bindings
* Use subnode constraint styles as suggested by Rob Herring
* Use IMX93_CLK_SYS_PLL_PFD0 as parent for IMX93_CLK_MEDIA_AXI
* Use 333MHz for IMX93_CLK_MEDIA_AXI
* Do not set board compatible in orverlays
* Add MBa93xxCA platform as well

I skipped the support for dynamic PLL configuration for now. This is a
separate task, see [2].

Best regards,
Alexander
    
[1] https://lore.kernel.org/all/20231020130019.665853-1-alexander.stein@ew.tq-group.com/
[2] https://lore.kernel.org/all/20250210160012.783446-1-alexander.stein@ew.tq-group.com/

Alexander Stein (6):
  clk: imx: clk-fracn-gppll: Add 477.4MHz config for video pll
  dt-bindings: soc: imx93-media-blk-ctrl: Add LDB subnode into schema
    and example
  soc: imx: imx93-blk-ctrl: Scan subnodes and bind drivers to them
  arm64: dts: imx93: Add LCDIF & LDB nodes
  arm64: dts: tqma9352-mba93xxla: Add LVDS overlay
  arm64: dts: tqma9352-mba93xxca: Add LVDS overlay

 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 51 ++++++++++++
 arch/arm64/boot/dts/freescale/Makefile        |  5 ++
 ...3-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso | 40 ++++++++++
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 27 +++++++
 ...3-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso | 40 ++++++++++
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 27 +++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 77 +++++++++++++++++++
 drivers/clk/imx/clk-fracn-gppll.c             |  1 +
 drivers/pmdomain/imx/imx93-blk-ctrl.c         |  7 ++
 9 files changed, 275 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso

-- 
2.43.0


