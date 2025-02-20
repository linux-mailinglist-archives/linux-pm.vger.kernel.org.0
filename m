Return-Path: <linux-pm+bounces-22565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4AFA3E46A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290FF3A35A0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87718266593;
	Thu, 20 Feb 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YIRSD4H5"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C1263F45;
	Thu, 20 Feb 2025 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077917; cv=none; b=oZweDgHDBAaQlKAsXde3kWphS8TTcKG9jtnsgk1lrmGuRtse6A+VyrEFufMoFZ0gA1EWA0qT3mKI5id9M5xFeaWOQ0ZvmNeCpzg414vyChLgZozTy2jRfCLN3Ts103izFRFcM1dxqBFdO4yyOr1eSQZQGEegp79dxUDCntJFu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077917; c=relaxed/simple;
	bh=5RUhj/XKWCMdIn7xMzd8UnOXh1gataI0Ma4K+le0c9M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bH0d2dWMSLisrDleHaOl3uAlCOny8elpvQ2ZJROuLoZOj+oOyvbG+fCWHFRh0nGpg+32iKC/piLbMyPPgLUgRMCZb21B2MzQiD5Rfov7B22yiAQ6IPcmC5iaXKqmja95DIm1MuhKNhLj4qCoY0YqoQjQEmdqCd5NOFHwNz3fIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YIRSD4H5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740077913;
	bh=5RUhj/XKWCMdIn7xMzd8UnOXh1gataI0Ma4K+le0c9M=;
	h=From:Subject:Date:To:Cc:From;
	b=YIRSD4H564Z+xv6LcMd/wlH1ofnllyyKsIILrj7QawBPJJ/KzOK0f2sFo+28w4QIE
	 aaS24nef2XZet1ekuymv+ioZXecBQodaQpEcK90BVXg5/+nSION7bJUYmQ2gkJ1YGI
	 Llzoz02kudNQAJNsNQxo0gWqjVTOxy0gplY28/P5DEj2b0d/ig2TDYl0pH7KJ5yLby
	 r8nnIY/IONiT22EZLyuJufmaHRebs78fv9N2GpnuD9NqWqU9m96il9CWNUXMd6/oNr
	 pdnUqKy3A+Z2rGN6e4E5kHo26t/OUCC8CwZMOlPNQRuQy+qTkHJnpUiGzUUIuwFCnS
	 c9M5Gy1fMiYNA==
Received: from jupiter.universe (dyndsl-091-248-085-196.ewe-ip-backbone.de [91.248.85.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D56F17E0DFB;
	Thu, 20 Feb 2025 19:58:33 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0A660480035; Thu, 20 Feb 2025 19:58:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 0/8] Fix RK3588 power domain problems
Date: Thu, 20 Feb 2025 19:58:03 +0100
Message-Id: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADt7t2cC/x3NwQqDMAyA4VeRnBfIIorsVcYOdY1d2NaWVJ0gv
 rtlx+/y/zsUMZUCt2YHk1WLpljRXxp4vlwMguqrgYk7Yia0d9sNA4a8YP4Z+vR1GtEkLB83J8N
 JiPuWvYx0hVrJJpNu/8P9cRwn4WR//3EAAAA=
X-Change-ID: 20250220-rk3588-gpu-pwr-domain-regulator-fe02632deb01
To: Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 =?utf-8?q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Peter Geis <pgwipeout@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Vignesh Raman <vignesh.raman@collabora.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6190; i=sre@kernel.org;
 h=from:subject:message-id; bh=5RUhj/XKWCMdIn7xMzd8UnOXh1gataI0Ma4K+le0c9M=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe3e1ityO3P0bORtrcKSLYu9l17LIhaxvF9D
 8zc5rqvbDflCokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnt3tYAAoJENju1/PI
 O/qauuQP/RBkuybibunrRYK7X+ucv83h3euEn2v5sSdmE3hBVjYXe+rcoVs4G/TZRuYxhoFB4Er
 7uDVRsTZDKSNM3orkv4TsmfnjJhZfcKiuPoi7rav5OEGap9ZTHiuphH4XcUCjLTVCvEFc30ZZZQ
 1Y5KxXt5znGZorUPMTdgBJyDH+T80lH63J86COHMjiLVDchoyLjIywpqMF7d3y0+b7U9NvL7Sob
 bNpWJdbPSImyImN/nxKEKGj5+IJwMX3oPmShV7P0YZ2SMg3nZGMfWVP5FxUmF5OegQ1OeVNRI4x
 YN04UhejVwg1V9So5K1k/8jjPnyblCsGVqP/OyEHyHtjLVzYLxS0VdIJ1GCb4PXfjzKFXXpZQYD
 XN8jMEMjkYrTX7Vea/sMy4Trxo4YcQJWwJPEZiknCrXRGyHVXpMJDGocgNU/KDph6xsWBbC2k8V
 xTWuIenD8X6YAiGTPRpeS0JFa4GLb7fwMOM/YCocOqRJCVeRXUVoShzuhkusAlr9UI+2QMEYw8c
 yGfNm/yP4HAROZeXiRTlgwJTqbv+//53kaVVGTaF5WHoCLKxd8XGmMVYFwMsjIk4UmZyS+MMDnV
 5qip5feuQYz4iLhsnsPeWAJJcJukXZ3HvmAGO+OyXW4ktZmXlAOBrqSMDxMgo62ch3Th4h2+ufg
 NeI2Fv0ZhfvSB0b8tvYE3aQ==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Hi,

I got a report, that the Linux kernel crashes on Rock 5B when the panthor
driver is loaded late after booting. The crash starts with the following
shortened error print:

rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'gpu', val=0
rockchip-pm-domain fd8d8000.power-management:power-controller: failed to get ack on domain 'gpu', val=0xa9fff
SError Interrupt on CPU4, code 0x00000000be000411 -- SError

This series first does some cleanups in the Rockchip power domain
driver and changes the driver, so that it no longer tries to continue
when it fails to enable a domain. This gets rid of the SError interrupt
and long backtraces. But the kernel still hangs when it fails to enable
a power domain. I have not done further analysis to check if that can
be avoided.

Last but not least this provides a fix for the GPU power domain failing
to get enabled - after some testing from my side it seems to require the
GPU voltage supply to be enabled.

This introduces devm_of_regulator_get without the _optional suffix, since
that is more sensible for the Rockchip usecase. Longer explanation can be
seen in patch 6, which adds the handling to the Rockchip driver. My merge
suggestion would be that Mark provides an immutable branch to Ulf.

The last patch, which updates the RK3588 board files should cover all RK3588
boards that are currently in Heiko's for-next branch. Any board missing the
update will behave as before, so it is perfectly fine not to update all DT
files at once (in case I missed any).

This is based on Heiko's for-next branch. Also it's probably worth mentioning,
that mesa CI is carrying this patchset for quite some time now.

Changes since PATCHv5:
 * https://lore.kernel.org/linux-rockchip/20241211143044.9550-1-sebastian.reichel@collabora.com/
 * Rebase to Heiko's for-next branch
 * Integrate the patch from Peter Geis into this series
   - https://lore.kernel.org/linux-rockchip/20241214215802.23989-1-pgwipeout@gmail.com/

Changes since PATCHv4:
 * https://lore.kernel.org/linux-rockchip/20241022154508.63563-1-sebastian.reichel@collabora.com/
 * Rebase to Heiko's for-next branch
   - update DT patch to handle new RK3588(s) boards
   - make sure to use a clean topic branch without HDMI-RX code (Heiko Stübner)
 * Add Tested-by from Heiko Stübner

Changes since PATCHv3:
 * accidently none, sorry!

Changes since PATCHv2:
 * https://lore.kernel.org/linux-rockchip/20240919091834.83572-1-sebastian.reichel@collabora.com/
 * Rebase to 6.12-rc1 + devm_of_regulator_get_optional branch (Ulf Hansson, Chen-Yu Tsai)
  - Introduce devm_of_regulator_get()
  - Add code to only request regulators for domains needing them
 * Mention other platforms in the DT binding patch (Rob Murphy)
 * Update more RK3588 DT files (Jonas Karlman)

Changes since PATCHv1:
 * https://lore.kernel.org/all/20240910180530.47194-1-sebastian.reichel@collabora.com/
 * Collect Reviewed-by/Acked-by/Tested-by
 * swap first and second patch to avoid introducing and directly removing a mutex_unlock
 * fix spelling of indentation
 * fix double empty line after rockchip_pd_regulator_disable()

Greetings,

-- Sebastian

---
Peter Geis (1):
      pmdomain: rockchip: fix rockchip_pd_power error handling

Sebastian Reichel (7):
      regulator: Add (devm_)of_regulator_get()
      pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
      pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain errors
      pmdomain: rockchip: reduce indentation in rockchip_pd_power
      dt-bindings: power: rockchip: add regulator support
      pmdomain: rockchip: add regulator support
      arm64: dts: rockchip: Add GPU power domain regulator dependency for RK3588

 .../bindings/power/rockchip,power-controller.yaml  |   3 +
 .../arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi |   4 +
 .../boot/dts/rockchip/rk3588-armsom-sige7.dts      |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |   2 +-
 .../arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi |   4 +
 .../dts/rockchip/rk3588-edgeble-neu6a-common.dtsi  |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi |   4 +
 .../dts/rockchip/rk3588-firefly-core-3588j.dtsi    |   4 +
 .../dts/rockchip/rk3588-friendlyelec-cm3588.dtsi   |   4 +
 .../arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts     |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts   |   4 +
 .../arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi |   4 +
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi     |   4 +
 .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |   4 +
 .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts  |   4 +
 .../boot/dts/rockchip/rk3588s-gameforce-ace.dts    |   4 +
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts  |   4 +
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts     |   4 +
 .../arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts |   4 +
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi      |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts   |   4 +
 drivers/pmdomain/rockchip/pm-domains.c             | 195 +++++++++++++--------
 drivers/regulator/devres.c                         |  17 ++
 drivers/regulator/of_regulator.c                   |  21 +++
 include/linux/regulator/consumer.h                 |   6 +
 35 files changed, 290 insertions(+), 70 deletions(-)
---
base-commit: 03fa1896664722f35cdfc41a37b3ab17d60bd66e
change-id: 20250220-rk3588-gpu-pwr-domain-regulator-fe02632deb01

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


