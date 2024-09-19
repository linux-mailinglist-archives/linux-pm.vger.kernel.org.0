Return-Path: <linux-pm+bounces-14451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1297C6CA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087DF285AB4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA10199EBB;
	Thu, 19 Sep 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uj+yZL48"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A2FC0C;
	Thu, 19 Sep 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737521; cv=none; b=AS4wuY5VI1Z4Uj2ziXEbFa9GY0g8urrET7880xwLqEQl8mpXO25ztbUbuyxNmIYIaQpgJ2tGZpT+aMhRBkpi0tOeeRC+dGepj33bpclliOiKn4l3yMbL1H4hSTBRLmKBIgGE7zWxRDevLkFC1OWk+hAvK/O4Qhh0cbJ+/SzJnw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737521; c=relaxed/simple;
	bh=AskcAs/7IGdGwwichZGEUf19/IkDbJsPg1sXinT/vnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L5F+per3eDBD2DPOIFAAV/qxa0l4XM2jPEysRKkMuD2KVHgtRKbp887dFXCndRq1sF2xTVBkhwYn4N5e5U/x3Z+JNmJXjpnE7pEA2m/sGSpMOi7eQOKqZvOCHtv1DTwYXvA0GzJAXXeKIq7FpCa7XETwDzOz41jsX3FKfIna3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uj+yZL48; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726737516;
	bh=AskcAs/7IGdGwwichZGEUf19/IkDbJsPg1sXinT/vnQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Uj+yZL48c+2/7dlNfodatrWifsQHci+kVXeEswOFafkbW1gaiSB3vmQRydJ4ky8UV
	 SufYL/CT+xxHuwgiUygHAW12uyeAcMnmEQEJaaeWdht12cJ0YVV3TaLeUUkinG2M82
	 wNiJxjxhZEJ0QOGzA+xv24t/A0dcrKxkzAs5cbGO10JiQph3alHjrXVz33qcxt8M+/
	 UD8JeWsH1pGJWTGzobirC0ZDYGEk/5/hO1Pmm2cgnHXfSxaQslv5nSE9xGg/lxS7j8
	 ayrMKfnwXupOupdeCz7EJ6Gvgw0NRLFS+uZEr1drc07kKDQzYzUAt8ZOjVrZ3NXcP1
	 rVLbl/YwrMAUw==
Received: from jupiter.universe (dyndsl-091-248-208-160.ewe-ip-backbone.de [91.248.208.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B50117E107A;
	Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 57159480076; Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 0/6] Fix RK3588 GPU domain
Date: Thu, 19 Sep 2024 11:12:41 +0200
Message-ID: <20240919091834.83572-1-sebastian.reichel@collabora.com>
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

I'm not really happy about the hack to get a regulator for a sub-node,
which I took over from the Mediatek driver. I discussed this with
Chen-Yu Tsai and Heiko Stübner at OSS EU and the plan is:

1. Merge Rockchip PM domain driver with this hack for now, since DRM CI
   people need it
2. Chen-Yu will work on a series, which fixes the hack in Mediatek by
   introducing a new devm_regulator_get function taking an DT node as
   additional argument
3. Rockchip PM domain later will switch to that once it has landed

Changes since PATCHv1:
 * https://lore.kernel.org/all/20240910180530.47194-1-sebastian.reichel@collabora.com/
 * Collect Reviewed-by/Acked-by/Tested-by
 * swap first and second patch to avoid introducing and directly removing a mutex_unlock
 * fix spelling of indentation
 * fix double empty line after rockchip_pd_regulator_disable()

Greetings,

-- Sebastian

Sebastian Reichel (6):
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
 .../rockchip/rk3588-friendlyelec-cm3588.dtsi  |   4 +
 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |   4 +
 .../boot/dts/rockchip/rk3588-ok3588-c.dts     |   4 +
 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   |   4 +
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi |   4 +
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   4 +
 .../dts/rockchip/rk3588s-khadas-edge2.dts     |   4 +
 .../boot/dts/rockchip/rk3588s-orangepi-5.dts  |   4 +
 drivers/pmdomain/rockchip/pm-domains.c        | 129 +++++++++++++-----
 14 files changed, 143 insertions(+), 35 deletions(-)

-- 
2.45.2


