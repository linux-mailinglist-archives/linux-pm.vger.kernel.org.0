Return-Path: <linux-pm+bounces-22158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F22A3713F
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 00:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CDE16FA4F
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 23:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BA31FDE10;
	Sat, 15 Feb 2025 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="VdUaNEpT"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E151FDA8B;
	Sat, 15 Feb 2025 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662533; cv=pass; b=i9RwfPYpge2LKklywTQF5sCTcf8mRrpQ3tb1cbnZN4ufj5Go2hiMcS1l8S10u+dVVFTDp/ZLrNHDm0HCf/mzgmbnQ8ts+SoicCbWljVqvN3OuyzFrG/aXO+uqJCBTq632kWBxFyBIPrQWMJN6e+aqkFoSig0GNQpYMPJYQL/vOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662533; c=relaxed/simple;
	bh=3LfqDR2Pzs7OKRyDz5mrNdZnhWugx+GxSd2BzhP+4os=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YBEOfmU3VJYwo3BOeo6m59uNPMF9ABNdFVVOqIKhok/mF4ofMOBc9AzOEBu0ER8igdx1nAzR+KeU5+Ge3gN9BbsK9dHkEG5rkq760L+HkK3HUY6Z7qKdhh/fn/x6NmKRAPTbDMrHcXNJNlJLYalnp/qzPjZEZVyS1H5EmPka2aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=VdUaNEpT; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739662504; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H0f8h1UNsng7CEtVbo53pmVCmAmNgqG1K+hLVRKeEcomU5XTOAh18wBstErMKh6Hw2FK3gUAC1dbA8We+yVsz9aUijeqAekFF07kj/Xi5DFh8AtlELheUtk8lw+vf2Yau7ttmpEfNmx0rBsJeWUjEJvRsr3QkhgGBbnADZOOsvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739662504; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2IwalmKvII2wjdNIZlzpaAimkHRlXVRsnIocmdujjKQ=; 
	b=UBX/iciIGXZ8T1EY1+SI80SJ6mVfsxZ4ODXRYLkFLbFlueRf6lNVnppjAlrfzGr8tQ4JyXcmkyaERmQ+V3WpBq14f+2Qjv5aqfJGBIpBE9Yr7P0k1YcF+4capG9+r9UAppK4Cb4/+eTcZwxZD4hgH5n3D0cbbaAr5ZfW0/zzv+s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739662504;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=2IwalmKvII2wjdNIZlzpaAimkHRlXVRsnIocmdujjKQ=;
	b=VdUaNEpTfhrBgz3yCxJzRhkxyYY5GNurBCa8pmxnME/ZtDHwcQc0nlpt2+KurSty
	KzJw55z3DxnXck48z5u7/MsTpR6alWj2HV7YgfNcxHUASd0QuF90wFCR1dwkkPR2R51
	+nntNRTtBUYqfAr0cJBgs4jgRKl7i8/7SGxPtF3c=
Received: by mx.zohomail.com with SMTPS id 1739662502809296.039531409702;
	Sat, 15 Feb 2025 15:35:02 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/6] RK3576 thermal sensor support, including OTP trim
 adjustments
Date: Sun, 16 Feb 2025 00:34:49 +0100
Message-Id: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkksWcC/y3MQQqDMBCF4atI1h1JotEqpfQexUUaxxokajOxC
 OLda9Xl/+B9CyP0FomV0cI8fi3Zod9CXCJmWt2/EWy9NZNcKi6FAt8lKs8gkK4NTCMFj9pBjty
 IImny7KrZ9h09Nnbe3Wd1tMfPtPHhGJlDIr3zZXQ7dS5lqgSPhSjSIktAQIu2Gx7UBzRtXOP9b
 780IZjBORvKqMc5wHmXrFrXHwAAv+7SAAAA
X-Change-ID: 20250215-rk3576-tsadc-upstream-7e0c193f768a
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Ye Zhang <ye.zhang@rock-chips.com>
X-Mailer: b4 0.14.2

This series adds support for the RK3576's thermal sensor.

The sensor has six channels, providing measurements for the package
temperature, the temperature of the big cores, the temperature of the
little cores, and the GPU, NPU and DDR controller.

In addition to adding support for the sensor itself, the series also
adds support for reading thermal trim values out of the device tree.
Most of this functionality is not specific to this SoC, but needed to be
implemented to make the sensors a little more accurate in order to
investigate whether the TRM swapped GPU and DDR or downstream swapped
GPU and DDR in terms of channel IDs, as downstream disagrees with what's
in the TRM, and the difference is so small and hard to pin down with
testing that the constant offset between the two sensors was a little
annoying for me to deal with.

I ended up going with the channel assignment the TRM lists, as I see the
DDR sensor get a larger deviation from baseline temperatures during memory
stress tests (stress-ng --memrate 8 --memrate-flush) than what the TRM
claims is the GPU sensor but downstream claims is the DDR sensor. Input
from Rockchip engineers on whether the TRM is right or wrong welcome.

The trim functionality is only used by RK3576 at the moment. Code to
handle other SoCs can rely on the shared otp reading and perhaps even
the IP revision specific function, but may need its own IP revision
specific functions added as well. Absent trim functionality in other
SoCs should not interfere with the modified common code paths.

Patch 1 adds the RK3576 compatible to the bindings.

Patch 2 adds the basic thermal nodes required to get temperature
readings and device throttling to the rk3576.dtsi device tree.

Patch 3 adds support for this SoC's thermal chip to the driver. It is a
port of the downstream commit adding support for this.

Patch 4 adds some documentation for imminent additional functionality to
the binding, namely the trim value stuff.

Patch 5 adds the requisite OTP cells and tsadc nodes to the SoC's device
tree, conforming with the bindings modified in Patch 4.

Patch 6 adds support for reading these OTP values in the
rockchip_thermal driver, and makes use of them. The code is mostly new
upstream code written by me, using downstream code as reference.

This series depends on Heiko's OTP series[1]. You can grab yourself a
spicy linux-next based tree from [2] with both changesets if you just
want to give it a spin on your own board.

[1]: https://lore.kernel.org/linux-rockchip/20250210224510.1194963-1-heiko@sntech.de/
[2]: https://gitlab.collabora.com/fratti/linux/-/tree/rk3576-thermal-adc-4

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (5):
      dt-bindings: rockchip-thermal: Add RK3576 compatible
      arm64: dts: rockchip: Add thermal nodes to RK3576
      dt-bindings: thermal: rockchip: document otp thermal trim
      arm64: dts: rockchip: Add thermal trim OTP and tsadc nodes
      thermal: rockchip: support reading trim values from OTP

Ye Zhang (1):
      thermal: rockchip: Support RK3576 SoC in the thermal driver

 .../bindings/thermal/rockchip-thermal.yaml         |  45 ++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 239 +++++++++++++++++-
 drivers/thermal/rockchip_thermal.c                 | 280 +++++++++++++++++++--
 3 files changed, 540 insertions(+), 24 deletions(-)
---
base-commit: 6f5eb5a1b91efbc9317ac7a55c5c9e74be3e358d
change-id: 20250215-rk3576-tsadc-upstream-7e0c193f768a
prerequisite-message-id: <20250210224510.1194963-1-heiko@sntech.de>
prerequisite-patch-id: 8b8d7c74c83755b87a59b37dfa1c335a84f4fbda
prerequisite-patch-id: 39def5e1f0f4ae6f182cf50b42e1e43a90d0991d
prerequisite-patch-id: bf402264f426cb53f5a40b36dea74e0e2def5621
prerequisite-patch-id: fb7a67402ea0d8792cbcefed9239ad141689e33a
prerequisite-patch-id: ae942d1f9e0e9d8e0b0ca493b8ec0bd5994365ae
prerequisite-patch-id: 12e5d422403737e300ba9563f7d4338e356d0299

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


