Return-Path: <linux-pm+bounces-16236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331B9AB263
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A321C2249F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CD21A4F0C;
	Tue, 22 Oct 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JlK9/aXU"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966FB19ABAC;
	Tue, 22 Oct 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611913; cv=none; b=Tiw5JIEIGZjSSvL4xRuzkNh+Slu+Arpz7PX1BZj37zPjD10y6ZaXwrhGbuuo9zcSVSBBLJyAIt9PmYCaxdjW5qplotSNX6b8saKfHBJqFJB9o/US7T53TC1OKo2YaQBlZ0/tOBw2D+0DseWB/qyr1R3Y2ar8FKlhZvsKSijbBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611913; c=relaxed/simple;
	bh=M0bq/DvLeH0XIHZLMAHQAQJxIOvTez7VZya3lPCe2Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jflCms45nDFOv2mtyKhIWHF1BBQBh3dugteTHBg1Bi1E3X061RFimE93xMoqsbq5LSxvEzLjZovVo+vjHRIjb7ZRbgwKzZInJPSUw25IbR3351/sj519eqnvYWFxrUzRYAWlzKfX7DczN2paOsw03hbBrG10mwXU9aEsugo9Tic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JlK9/aXU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729611909;
	bh=M0bq/DvLeH0XIHZLMAHQAQJxIOvTez7VZya3lPCe2Gk=;
	h=From:To:Cc:Subject:Date:From;
	b=JlK9/aXU3yotrT+ZdDKCuV0cxRiZAgoqrk+oWTa10rSqk651kI+0/UlP9dJr+gVz3
	 EHM+U+XtUi9b0BXPOV+JF87ZK5Z+kSZ+RIWDf+mbEGVKUAKSWkbk7sjBEqUQMkFeC4
	 lt58tCANmk5oEH+MrjIE2KLjLWSTcPfAVahoJA+zwjEtV6/zQLs6De5Gu714bEDI0U
	 dqQyo82aRTFb3P503fe0ybFU3owHI2b02eCM1XUq/8KsVZnAjNoKajRXpDRJ5k/2Nw
	 AEOuk3DuzjvppyDNHe12y92jbKZaxPg54/mJ+HvUk4oEjR3uTuND7eHl7/VxfWN8Z8
	 /s4jIIt2A4hgA==
Received: from jupiter.universe (dyndsl-091-248-085-026.ewe-ip-backbone.de [91.248.85.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B27DA17E3662;
	Tue, 22 Oct 2024 17:45:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 6467C4800EA; Tue, 22 Oct 2024 17:45:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v3 0/7] Fix RK3588 GPU domain
Date: Tue, 22 Oct 2024 17:41:45 +0200
Message-ID: <20241022154508.63563-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

This series is now based on the pull request from Mark Brown:
https://lore.kernel.org/linux-pm/ZvsVfQ1fuSVZpF6A@finisterre.sirena.org.uk/

I added one more patch, which adds devm_of_regulator_get without the
_optional suffix, since that is more sensible for the Rockchip usecase.
Longer explanation can be seen in patch 6, which adds the handling to
the Rockchip driver. My merge suggestion would be that Mark adds the
regulator patch on top of the immutable branch and creates a new pull
request.

The last patch, which updates the RK3588 board files only covers the
boards from 6.12-rc1. Any board missing the update will behave as before,
so it is perfectly fine not to update all DT files at once.

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

Sebastian Reichel (7):
  regulator: Add (devm_)of_regulator_get()
  pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
  pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain errors
  pmdomain: rockchip: reduce indentation in rockchip_pd_power
  dt-bindings: power: rockchip: add regulator support
  pmdomain: rockchip: add regulator support
  arm64: dts: rockchip: Add GPU power domain regulator dependency for
    RK3588

 .../power/rockchip,power-controller.yaml      |   3 +
 .../boot/dts/rockchip/rk3588-armsom-sige7.dts |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |   2 +-
 .../boot/dts/rockchip/rk3588-coolpi-cm5.dtsi  |   4 +
 .../rockchip/rk3588-edgeble-neu6a-common.dtsi |   4 +
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |   4 +
 .../boot/dts/rockchip/rk3588-fet3588-c.dtsi   |   4 +
 .../rockchip/rk3588-friendlyelec-cm3588.dtsi  |   4 +
 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |   4 +
 .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi   |   4 +
 .../boot/dts/rockchip/rk3588-ok3588-c.dts     |   4 +
 .../dts/rockchip/rk3588-orangepi-5-plus.dts   |   4 +
 .../boot/dts/rockchip/rk3588-quartzpro64.dts  |   4 +
 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   |   4 +
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi |   4 +
 .../boot/dts/rockchip/rk3588-toybrick-x0.dts  |   4 +
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi  |   4 +
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   4 +
 .../dts/rockchip/rk3588s-gameforce-ace.dts    |   4 +
 .../dts/rockchip/rk3588s-indiedroid-nova.dts  |   4 +
 .../dts/rockchip/rk3588s-khadas-edge2.dts     |   4 +
 .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  |   4 +
 .../boot/dts/rockchip/rk3588s-odroid-m2.dts   |   4 +
 .../boot/dts/rockchip/rk3588s-orangepi-5.dts  |   4 +
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   4 +
 drivers/pmdomain/rockchip/pm-domains.c        | 190 +++++++++++-------
 drivers/regulator/devres.c                    |  17 ++
 drivers/regulator/of_regulator.c              |  21 ++
 include/linux/regulator/consumer.h            |   6 +
 30 files changed, 266 insertions(+), 69 deletions(-)

-- 
2.45.2


