Return-Path: <linux-pm+bounces-13959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0321E974198
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B3F1C2539B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0151A3BC3;
	Tue, 10 Sep 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V/aW2UEb"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A41A0732;
	Tue, 10 Sep 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991535; cv=none; b=ULS33555Oq6TWv1Un+cOczB0Oum2LE8IgU6KadQb+hWtYT7eFB4kfSRJRSs1nz92DnGj9yjIEkzBie54dxbWinZ58dF9zBDP0JXZH0DGXUiJwpikEsgo0oTZboFG8i6EcyoAosRY1LCWRbgJfnbC7tsY+6oyDvJx/AzLrG+/1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991535; c=relaxed/simple;
	bh=kEZ+U8Z66xptCiF1McdzJy5YJA7WQzf6RD2McVh/daI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dyj9nCfJ8VrYddyqfVE42WPU9ByZcD0/wr06k2fe4+HrELkcMh2mbb59bK0uHalmFqz2t3biT1UT5qJB/udtT2AmAIFWAMT5GXnORjuMhKXZ6k3FKDLwwYQftqqRqJcRQGMXm67U+0drJKL3rtnX+Ev9X2+lY0LJ44KX36CHFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V/aW2UEb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725991531;
	bh=kEZ+U8Z66xptCiF1McdzJy5YJA7WQzf6RD2McVh/daI=;
	h=From:To:Cc:Subject:Date:From;
	b=V/aW2UEbOfT4WTlIRZdoHx0XfdQEDeYDPfs0w+9lizFejRIZqyLfx6NXtB7AxtQjN
	 R1HNiEklDd5l5HQ8eD8m/KXyEmFnl2s+j1aRSZtkItVFx4awBuS6WQVnCw+6I50k2x
	 hQ28dchLe/7joasDbNXMgCxT4229ACEwrJNTC1z1MKbJ+42R860z+n3/EABOisHfJg
	 EIxlDDGB0kmaXFm9hRNF7RIvzbYR14h3wCGf112WwTsjm8KWuWWjrIzWzsZG1Gl+jo
	 p9pUXl4bK8Yu/pZuEYdiZSBlEt3ulmw8+DgkHsxq3Pd52A3DWbJsf6o31VnAL9Q2IO
	 07t53l8DYNDaQ==
Received: from jupiter.universe (dyndsl-091-248-215-127.ewe-ip-backbone.de [91.248.215.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D039D17E35F8;
	Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8B0324800EA; Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 0/6] Fix RK3588 GPU domain
Date: Tue, 10 Sep 2024 19:57:09 +0200
Message-ID: <20240910180530.47194-1-sebastian.reichel@collabora.com>
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

I'm not really happy about the hack to get a regulator for a sub-node
in the 5th patch, which I took over from the Mediatek driver. But to
get things going and open a discussion around it I thought it would be
best to send a first version as soon as possible.

Greetings,

-- Sebastian
Sebastian Reichel (6):
  pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain errors
  pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
  pmdomain: rockchip: reduce indention in rockchip_pd_power
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
 drivers/pmdomain/rockchip/pm-domains.c        | 130 +++++++++++++-----
 14 files changed, 144 insertions(+), 35 deletions(-)

-- 
2.45.2


