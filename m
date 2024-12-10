Return-Path: <linux-pm+bounces-18930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF79EB795
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 18:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B371C1887EED
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A517B23D41E;
	Tue, 10 Dec 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="djH8PAyv"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8DE23A594;
	Tue, 10 Dec 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850629; cv=none; b=nVX5yQm54tOrRyYE6m+7VTDumcoQRHx3c0NRWWZLZJSZbp70ZIMWeojSKSQBGViMHhVamb5CTL1qPhCEPDinuC85Muj43i/nqdb6CrWweBx9Qxu07bjYz5iEeaR81eaYvvcTuP72RK8FUIhEa/jmCJmzsHK4AQp6woEBlS6JZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850629; c=relaxed/simple;
	bh=FEWnd3vRw56+0zU9iQm+h5IV4wTiZ4mx1GMYuoKmShg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BOP3SjGJi1EyI0N4wa+q1mHketCK6t1VPyGcGYtIQoKIc3stUA51ydDltvUMoHOZv9ZvywmEPyDSMEjDMtQ8mdzqxEKGtsdnPh/qilcy4FSdx/tEBmZKys0cX1q8if5R+hnwX/M1EJStQ+cNzZzPo86ABd/UINgmMssQ9PTPIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=djH8PAyv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733850625;
	bh=FEWnd3vRw56+0zU9iQm+h5IV4wTiZ4mx1GMYuoKmShg=;
	h=From:To:Cc:Subject:Date:From;
	b=djH8PAyv2m0Piy9QfdK2AsmiP3iTCg/H1JJv4rastS0dG3vSRKHmCB0X4ZKWA+nRn
	 Y1KgCMD/JXS1cnArN4PB59DPTBieyRAEoQlnHR41ekjbnJm+NaQMQbX2lYHY+dSzcY
	 8zVlRSfIaZKbeoKVktVBMiDaJM0rObgpFiYkFzQA12xMT9laTdOWQIjk6s9PAegBz4
	 aVRCpkXTKhZ5gPB1mO5cxl/ktAShsZPgy53sTUAE6Pu3iItYn9yf5x8rrZvbM5Vju0
	 RhNgue7UcvWezuVQHpLVb90Qe6FjBLwVgCE/hEO5626soFEf7yWB7yEWwCFFoZrOjF
	 pghi4SibnATlw==
Received: from jupiter.universe (dyndsl-091-248-190-127.ewe-ip-backbone.de [91.248.190.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 265A717E37C5;
	Tue, 10 Dec 2024 18:10:25 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A401648CC8A; Tue, 10 Dec 2024 18:10:24 +0100 (CET)
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
Subject: [PATCH v4 0/7] Fix RK3588 GPU power domain
Date: Tue, 10 Dec 2024 18:06:40 +0100
Message-ID: <20241210171023.141162-1-sebastian.reichel@collabora.com>
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

This introduces devm_of_regulator_get without the _optional suffix, since
that is more sensible for the Rockchip usecase. Longer explanation can be
seen in patch 6, which adds the handling to the Rockchip driver. My merge
suggestion would be that Mark provides an immutable branch.

The last patch, which updates the RK3588 board files should cover all RK3588
boards that are currently in Heiko's for-next branch. Any board missing the
update will behave as before, so it is perfectly fine not to update all DT
files at once (in case I missed any).

Changes since PATCHv3:
 * https://lore.kernel.org/linux-rockchip/20241022154508.63563-1-sebastian.reichel@collabora.com/
 * Rebase to Heiko's for-next branch
   - update DT patch to handle new RK3588(s) boards
   - make sure to use a clean topic branch without HDMI-RX code (Heiko Stübner)
 * Add Tested-by from Heiko Stübner

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


