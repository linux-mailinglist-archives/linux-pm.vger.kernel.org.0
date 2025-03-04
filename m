Return-Path: <linux-pm+bounces-23415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E5A4E650
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E88C8C3FF0
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC825FA0D;
	Tue,  4 Mar 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZAJmH9ma";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PJ+RHd0k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D825F789;
	Tue,  4 Mar 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103386; cv=none; b=WmgiRd1gGdR8l0/9Xg6lS8DL/RcYEaSZv1eknxIJRShG87f2Lxa+q2G35XbZrvWYlQ/a1vZpYxRZWiEirC/EhTqwETwnGU3Om6A7NSCxoxZhkM5ZS26mKNfx75d5ewfdZMsIyyx6qOE0qj0c8VhcQ5UYr9ZRVcokb+E0SRwXFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103386; c=relaxed/simple;
	bh=IZVtyHAG93XJVToieMuxGIEaIhkUm3s79JumsH2atio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvt34SeYeEPW5z3lKcrSNBIHfsAvdM+qQnNkQyYx+dDkgTrN++r5+BcVbTd+6eeq/cvpiOXGLWFybBL1XhzMag3HNkxpUy6fV1Pd14i++9j47oW44d+uGx3ki5e7wMQPlFCwJVAAb5jKivHgoK5f7mx1+rKsLNkTcmhqVX/61W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZAJmH9ma; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=PJ+RHd0k reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741103382; x=1772639382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V/cWI6jCuZn3fcy5zPp0Q323xNqJa1S74loek1ZBh4w=;
  b=ZAJmH9mar+mV2VqPDLb8zSS5DXU0LfY0oUxjSg3EhVIjKtQhNdKv1VX8
   F2J82wkTZRukDdbZnqvYb1637rrMYa+vwlLkomBNrkAsvjOt5bgBYNewX
   PGbD6Lv62aHEuTg0cN9tGywBgUz8fNTxDB8daHnL7gnxtGjj/Q9zS5Oxc
   zr94REA82Z937NNfkTPjAu+ehWDqEUguy9EhSF//Y6v6q2rrNFt02o2el
   aLAsa1ES80vk3hrVCfVo3ZJD8V+6BapfO7X2F3k3164YU5RoxnmFUTFCv
   BRMwExgYdEJhDdITZXorYfK/ca/bvLAY3usfT33RZQvwYWvxLuj0zFTVD
   Q==;
X-CSE-ConnectionGUID: 5RRrExnVSsyHBiZxymnz2g==
X-CSE-MsgGUID: W9sN2wF4TCe9QgLpWzcDKQ==
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="42272726"
X-URL-LookUp-ScanningError: 1
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Mar 2025 16:49:39 +0100
X-CheckPoint: {67C72113-5-2417938-F0170C2B}
X-MAIL-CPID: 1B5DD4582515C3582BD7AD615B33C118_2
X-Control-Analysis: str=0001.0A006369.67C72116.0066,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3DFC16156A;
	Tue,  4 Mar 2025 16:49:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741103374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V/cWI6jCuZn3fcy5zPp0Q323xNqJa1S74loek1ZBh4w=;
	b=PJ+RHd0k47M0p3Gvk5Gol0p05nmuw6+Wfy0Nb1JicPvJJ/gO0toelssg9xise111CADyl7
	k9XiBKVmJUl8TFfjhQS90zCTMEdVC43H++eqnMUJEnca8KIzLieiJzO2rqdWaTnWM0gZhn
	kIgCkD+cTdqOV5VUqNELxJd7KpUBhbIRymV2BaR1mwwBQFOjP06NQAtuYUFoomLYTYw9f2
	gPkwMdefX3QnbzpT7hTcQgVa5AvH4DsRkW3nzpFF3bR9UMaxrUl5GZpRfF+CKDSGYfk4XK
	qx2B3/aCSatZ0vafCGj8FNiGbpf14hMuks/v5cnwwooOrtYAMoJu1UDbXkvhyw==
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
Subject: [PATCH v3 0/6] TQMa93xx on MBa93xxLA/CA LVDS support
Date: Tue,  4 Mar 2025 16:49:19 +0100
Message-ID: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
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

this is v3 for the LVDS support on TQMa93xx module series.

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

Changes in v3:
* Collected Peng's R-b
* Fixed subject prefix in patch 3/6
* Fix 'ranges' property both in bindings example and .dtsi

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

v2:
* https://lore.kernel.org/all/20250224142831.485159-1-alexander.stein@ew.tq-group.com/
v1:
* https://lore.kernel.org/all/20231020130019.665853-1-alexander.stein@ew.tq-group.com/

Alexander Stein (6):
  clk: imx: clk-fracn-gppll: Add 477.4MHz config for video pll
  dt-bindings: soc: imx93-media-blk-ctrl: Add LDB subnode into schema
    and example
  pmdomain: imx93-blk-ctrl: Scan subnodes and bind drivers to them
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


