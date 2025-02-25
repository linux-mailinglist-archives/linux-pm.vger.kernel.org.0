Return-Path: <linux-pm+bounces-22886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5598EA43FD6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 13:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0673BBE72
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8572690EA;
	Tue, 25 Feb 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="W1PiSNut"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031BA268FC9;
	Tue, 25 Feb 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488281; cv=pass; b=uVX+ECJfiC1iPCxaW2vg1kx57IL11+vIeN9fx7UjnBiichX6Gaqo266e24XlgUGS8x8V07/6HQskwnOST5PSGB/T0bjHIeRnw9DM4TxrOJ5L/bJ5Sz7oe/V3PB2thJE2llk+sXlkJzPv/lqTxNnh3SN+Ea6MnWpFkTYNmlD8Wck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488281; c=relaxed/simple;
	bh=gmVRBp31ky8f3h0ObsfAUWA2PBlhlr8lpiwr6zAEC0s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ge4aug3iMDmc4uWZijPZkDqW9alErjlDjenkm8nRhqT7TF87huFyIPLimh/H2clmQpYyqkEecMdmzj6EFojysFgmji9xM+i1MK2X8dOP0wm5qBa5dvKzEKXIfo0gGd+1d2GUZbumRDg36VkNAINLoC3h258+U61ehdh3WkljwP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=W1PiSNut; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740488244; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ub9JGPo9D1ifA95PSsr4m+nbi/kTPs5vuK7r5cMtIi0SJwgLE7zIgCvT0bU7BPeeQBq4YjmKnWv2Jw07tHLKeh/NbaUczps7VRx4d9Kh4vhu6XEk7WMUbTs4OPSuRQummXVyXm5N4hhM0vDuTnShDcKlTlX9gPGLwflw6Yty9MI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740488244; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jJAK7+RdO6qxkZv/jve6HIDmzwFTZEZnuZrMgglgd14=; 
	b=IE4aNldVR/c28tAtpUCr+3VCnSE7PcAJ0CpVWx6Qi3Ak/lXNyO78IvuLzdAEjV4La106FEY3n5eLuqmSakAeU1efkQnhQNGKScsOUWnQ5jSEEE3oBFugaPw3jb2WHKF8Omf5QZJQFrwnAqakslUuZ5Yy/xXLWsFlc2ggVodoWLw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740488244;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=jJAK7+RdO6qxkZv/jve6HIDmzwFTZEZnuZrMgglgd14=;
	b=W1PiSNutconTu6O9hPtA+Vj3nN0CGYuIRbb9lz4JdbWozm3x2X60Cso80vaKzRro
	qBSUSD2aG+K+SqL0hn3AajUnimV7Qq9w87jN259nqhjRg2ksP9VBi4BW5+rrN/MK3Mq
	dY/yeBbu791mXgOuEgQPbu/5a7fg0P6K7gne/Yz0=
Received: by mx.zohomail.com with SMTPS id 1740488236610849.3832570884305;
	Tue, 25 Feb 2025 04:57:16 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/6] RK3576 thermal sensor support, including OTP trim
 adjustments
Date: Tue, 25 Feb 2025 13:56:43 +0100
Message-Id: <20250225-rk3576-tsadc-upstream-v2-0-6eb7b00de89c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAu+vWcC/3WOQQ6CMBREr0L+2m9okSKsvIdhUcpHGoFiWwiGc
 HcruHX5JpmZt4Ijq8lBEa1gadZOmyEAP0WgWjk8CHUdGHjM05izFO0zSTOB3sla4TQ6b0n2mFG
 sWJ40mbhKCN3RUqOXffdeHmzpNYV5f4RQSUeoTN9rX0QDLR6PC57Ct9Bq5419714z2xs/BfFHY
 WYYoyCVizzhXLLLTZmuk5Wx8hx+oNy27QO5nTMe7wAAAA==
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

You can grab yourself a spicy linux-next based tree from [1] with this
changeset if you just want to give it a spin on your own board.

For the record, here's a listing of SoCs that implement the OTP trim
functionality in some variation, with a legend that is as follows:
- A = chip-wide trim value
- B = trim_base value
- C = trim_base_frac value
- D = per-channel trim value
- E = compatible is either in mainline or in this series

The list is as follows:
- RK3502 (A____)
- RK3528 (A____)
- RK3562 (ABC__)
- RK3566 (_BCDE)
- RK3568 (_BCDE)
- RK3576 (___DE) <- the only one we're adding OTP trim for here atm
- RV1126 (AB___)

[1]: https://gitlab.collabora.com/fratti/linux/-/tree/rk3576-thermal-adc-5

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v2:
- As per Rob's request, the bindings now only feature the new properties
  depending on the compatible. Since the combination is slightly
  different for each SoC anyway, this makes future work easier too.
- The different channels are now explicitly named, instead of giving
  them patternProperties names. This is once again per-compatible.
- As per Sebastian's suggestion, unified trim_l and trim_h into just one
  nvmem cell in the bindings, device tree and driver. I did this after
  verifying that downstream has no SoC where trim_l and trim_h are ever
  non-contiguous, including for SoCs upstream does not (yet) support.
- Rebased on top of next-20250225 and dropped Heiko's OTP patchset as a
  dependency as it was merged.
- Added a handy overview of which SoCs use which part of the OTP trim
  functionality in the cover letter
- Reintroduced an accidentally removed dev_dbg in the function 
  rockchip_thermal_set_trips
- Link to v1: https://lore.kernel.org/r/20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com

---
Nicolas Frattaroli (5):
      dt-bindings: rockchip-thermal: Add RK3576 compatible
      arm64: dts: rockchip: Add thermal nodes to RK3576
      dt-bindings: thermal: rockchip: document otp thermal trim
      arm64: dts: rockchip: Add thermal trim OTP and tsadc nodes
      thermal: rockchip: support reading trim values from OTP

Ye Zhang (1):
      thermal: rockchip: Support RK3576 SoC in the thermal driver

 .../bindings/thermal/rockchip-thermal.yaml         |  65 +++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 221 ++++++++++++++++-
 drivers/thermal/rockchip_thermal.c                 | 263 +++++++++++++++++++--
 3 files changed, 528 insertions(+), 21 deletions(-)
---
base-commit: 8c1704d15a5e488ee273b953afbdf781fd1b939d
change-id: 20250215-rk3576-tsadc-upstream-7e0c193f768a

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


