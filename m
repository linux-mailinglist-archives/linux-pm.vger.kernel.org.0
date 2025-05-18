Return-Path: <linux-pm+bounces-27286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A12ABB221
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 00:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715D0173F64
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 22:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025091FBEB9;
	Sun, 18 May 2025 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="fZ0CQ0K/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0638DE1
	for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606696; cv=none; b=OWEhFTjjqmF+ZChi375YvcdSxlo4Ga+E5riBtIFmA75GRLwU0ga6M4uYWvkiGfwNrpYGMx/H4166gD+IonWz9wD63KIfjZdzvX0STVsNJtK8H6jRVtEqwPkQNVAcmpx17us/Zw4nzuuUlqErtJAZfP5aJVMbXjrXchMWCG+Y3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606696; c=relaxed/simple;
	bh=4NsPffv0XXVJT+w1Hwa18uapraBH1MPE/1ptpvhkpaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BMU8NT+Zl6iYj/zx9bSawImbjOWtd730eNwkAYwaJdQML3gQDhiPROvSSMqY+yFvuOFx2KX67eyAbpr74MrUUykUIMxfbN0e+DRHWXAbp0C4fIYqaItVNM/nXRRbmU8RjPIBSlxLH3D33yI4R2vXBV/QxFk66R2uBvPQMNRn3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=fZ0CQ0K/; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1747606694;
 bh=bhPt7fBQetiRYT1MgQ8GKwCup58p63/+Za+k3J/ZaT4=;
 b=fZ0CQ0K/HKp7WatzdWpRCX5Vo5a+weaMqitENKvrkoMKZNizJKfWUOBBIZkjcHiiIOXsIMzQZ
 pKvdlWGm3A8uxsXzT50dVn+nuVqn2Llef/FDJxpke0djIxm7I0xcweAZ3PCO2N3/Z61yDSGXuKS
 kBy2mY4651YAx4BK2Ykiz4cZmOL/vxTBHaupYiacakoZL5DXrBSeOlAmQjto27Y+m1ojUyxL0RU
 LSR0CoLW7zkhwyRIn1oXq1trNRZxJHNvxjUVFN8iLWFiG7kHnQWbP6tazKApWxHpcVv13ndwjlt
 tdoW7WzBbzLKaFIsI4fbfT7FOgNChc69xPMRLHnc3+Iw==
X-Forward-Email-ID: 682a5a1178cae75fbd8d4660
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/9] rockchip: Add power controller support for RK3528
Date: Sun, 18 May 2025 22:06:47 +0000
Message-ID: <20250518220707.669515-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip RK3528 support multiple power domains, one PD_GPU that can
fully be powered down, and other that can be idle requested.

Vendor kernel flag all power domains on RK3528 as always-on, this takes
a different route and instead tries to describe all devices power-domain
in the device tree, even for controllers with unsupported runtime status.

The PD_RKVDEC is used by RKVDEC and DDRPHY CRU, and is kept disabled to
prevent a full system reset when trying to read current rate of the
SCMI_CLK_DDR clock.

Patch 1-4 prepares and makes it possible to use the PD_GPU power domain
for a separate "Add GPU support for RK3528" series.

Patch 7-9 updates dt-bindings for controllers not supporting use of the
power-domains prop and enables the PD_RKVENC, PD_VO and PD_VPU domains.

pm_genpd_summary on a Radxa E20C after this:

  domain                          status          children        performance
      /device                         runtime status                  managed by
  ------------------------------------------------------------------------------
  vpu                             on                              0
      ffaf0000.gpio                   unsupported                 0           SW
      ffb10000.gpio                   unsupported                 0           SW
      ffbe0000.ethernet               active                      0           SW
      ffae0000.adc                    unsupported                 0           SW
      ffbf0000.mmc                    suspended                   0           SW
  vo                              on                              0
      ffb00000.gpio                   unsupported                 0           SW
      ffc30000.mmc                    suspended                   0           SW
  venc                            on                              0
      ffb20000.gpio                   unsupported                 0           SW
      ffa58000.i2c                    unsupported                 0           SW
  gpu                             off-0                           0
      ff700000.gpu                    suspended                   0           SW

Jonas Karlman (9):
  dt-bindings: power: rockchip: Add support for RK3528
  pmdomain: rockchip: Add support for RK3528
  dt-bindings: rockchip: pmu: Add compatible for RK3528
  arm64: dts: rockchip: Add power controller for RK3528
  dt-bindings: mmc: sdhci-of-dwcmhsc: Allow use of a power-domain
  dt-bindings: gpio: rockchip: Allow use of a power-domain
  dt-bindings: i2c: i2c-rk3x: Allow use of a power-domain
  dt-bindings: iio: adc: rockchip-saradc: Allow use of a power-domain
  arm64: dts: rockchip: Enable more power domains for RK3528

 .../devicetree/bindings/arm/rockchip/pmu.yaml |  2 +
 .../bindings/gpio/rockchip,gpio-bank.yaml     |  3 +
 .../devicetree/bindings/i2c/i2c-rk3x.yaml     |  3 +
 .../bindings/iio/adc/rockchip-saradc.yaml     |  3 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  4 -
 .../power/rockchip,power-controller.yaml      |  1 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 87 +++++++++++++++++++
 drivers/pmdomain/rockchip/pm-domains.c        | 27 ++++++
 .../dt-bindings/power/rockchip,rk3528-power.h | 19 ++++
 9 files changed, 145 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/power/rockchip,rk3528-power.h

-- 
2.49.0


