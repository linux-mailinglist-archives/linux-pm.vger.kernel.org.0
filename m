Return-Path: <linux-pm+bounces-28367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00B9AD3650
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ECE3AB499
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46982294A16;
	Tue, 10 Jun 2025 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="cU2pBJai"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7372949F2;
	Tue, 10 Jun 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558803; cv=pass; b=Zkw4BCO8Yo68pEx6E++oGerwdgfxsHK91zk7BZhEnlPlgle/pQiLwxwsxq6iPo2t1F+amouyvgWQ0YF75G6IwxzRFUe2yq3LdfSSsz2BR9ZMuVRQolFic8JdDDGpPzeF3XdZwQEVVMMcX6RsUGUr4EYcHnlvvKE5s/Fsi2ytkVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558803; c=relaxed/simple;
	bh=0LE/nuFr365cpn+KpHP6SdB5DWCWk3qGi7NX55HwNbE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uefHCFMoPvRvcyiTPfCeLfxrvsBt3yHWcDOjR4bl4Dtqjpy2eq/gaVYk3IAueTXfhkrUHcJeWPjO8OgeM9HQfEIyn0M3kqHpH5Z1JpSf2o5QWoIVWfUhORNOi9zWzfhO9AFwjYFGW6JiX+plaThQgcZQpmZMyb54rr1KIOJESK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=cU2pBJai; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749558767; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kImA814gjUbrxDwdmyR7nTUvysVbaR13KqrXXPCKUjpQBi366peYhyF/JcFZQnfhICH2y+KM3kW0f3YEmCUm3VIyhQrPo+sEyV63ETjqVYlNDUry3VbKvWGj6e8vJTbjxCpxEiD3XY2JmX3DMyDLekQJzaKbIZULsyReni3NRm8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749558767; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QIi9g6Ji8aGG9JtEtRjtoD3nFJK1xgryL1YyafjBz2o=; 
	b=SUBVtOqAFH1nwOunCKP/DmnRbS84jCFlTrYIrv3Sb4WsIQCkoZfn/Gt/Cyqufs1KSBd1rtP+2V5XWsprx547DmF3vWYkelrmbDTjCz2b7UO4e6I/Olc9EDYcFlmkn2xOQ+nI2x6jikhpZLm2qkaFPndOHI9DA0aHKgcY3b1lqUs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749558767;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=QIi9g6Ji8aGG9JtEtRjtoD3nFJK1xgryL1YyafjBz2o=;
	b=cU2pBJaif8HfHknFgO50Q1cinA5znJraTGktR9P4TVdDfMv/UFPVNqf8NdpPwVtA
	VN3TcyJZBZSFAbisnMEtax8I3lZWS6k6uEwOxHUWYToZ8mzJrw5hUV30Zp7ZgfoFU8v
	WEnItqvyPXtHoOY9c1BiNOcXheCFFETPPm3QdTxY=
Received: by mx.zohomail.com with SMTPS id 1749558765275911.517312346525;
	Tue, 10 Jun 2025 05:32:45 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v6 0/7] RK3576 thermal sensor support, including OTP trim
 adjustments
Date: Tue, 10 Jun 2025 14:32:36 +0200
Message-Id: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQlSGgC/3XPTW7DIBAF4KtYrEvEPyar3qPqAsbjBjWOE3BQq
 8h3L3UqJars5aCZ7/FuJGOKmMm+uZGEJeY4nupgXhoCB3/6QBq7OhPBhGaCa5o+pbaGTtl3QK/
 nPCX0A7XIgDvZW9N6Um/PCfv4tbhv7/c54eVa+en+SILPSGEchjjtm2J23NAEnPwuH2KexvS9/
 KnwZfsv3mzEF04ZNQjOOCmE5+oVxuPRhzH5Xc1Y1CKeJLFVpIhFCjYw1mHrYE2Sz1K7JckqqdC
 HIINxLrg1ST0kye2WpKoENcsBat3Z1Xb6IantdrpKDFrFgnMgGf6X5nn+AajjtkITAgAA
X-Change-ID: 20250215-rk3576-tsadc-upstream-7e0c193f768a
To: Alexey Charkov <alchark@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Jonas Karlman <jonas@kwiboo.se>
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

Patch 1 is a cleanup patch for the rockchip thermal driver, where a
function was confusingly named.

Patch 2 adds the RK3576 compatible to the bindings.

Patch 3 adds support for this SoC's thermal chip to the driver. It is a
port of the downstream commit adding support for this.

Patch 4 adds some documentation for imminent additional functionality to
the binding, namely the trim value stuff.

Patch 5 adds support for reading these OTP values in the
rockchip_thermal driver, and makes use of them. The code is mostly new
upstream code written by me, using downstream code as reference.

Patch 6 adds the basic thermal nodes required to get temperature
readings and device throttling to the rk3576.dtsi device tree.

Patch 7 adds the requisite OTP cells and tsadc nodes to the SoC's device
tree, conforming with the bindings modified in Patch 4.

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

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v6:
- dts: change polling-delay-passive to 100 for thermal zones with a
  passive cooling device, to fix the behaviour Alexey Charkov noticed,
  wherein the device would never get unthrottled otherwise
- Link to v5: https://lore.kernel.org/r/20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com

Changes in v5:
- Reorder dts patches to both be at the end of the series, as per
  Heiko's wishes
- Link to v4: https://lore.kernel.org/r/20250317-rk3576-tsadc-upstream-v4-0-c5029ce55d74@collabora.com

Changes in v4:
- driver: added a patch to rename tsadcv3_tshut_mode to
  tsadcv4_tshut_mode, as per Jonas' suggestion, and drop the duplicated
  function from the RK3576 support patch.
- Link to v3: https://lore.kernel.org/r/20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com

Changes in v3:
- Changed bindings back to using patternProperties, as per Rob's
  suggestions
- Adjusted dts changes to comply with the new schema
- Link to v2: https://lore.kernel.org/r/20250225-rk3576-tsadc-upstream-v2-0-6eb7b00de89c@collabora.com

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
Nicolas Frattaroli (6):
      thermal: rockchip: rename rk_tsadcv3_tshut_mode
      dt-bindings: rockchip-thermal: Add RK3576 compatible
      dt-bindings: thermal: rockchip: document otp thermal trim
      thermal: rockchip: support reading trim values from OTP
      arm64: dts: rockchip: Add thermal nodes to RK3576
      arm64: dts: rockchip: Add thermal trim OTP and tsadc nodes

Ye Zhang (1):
      thermal: rockchip: Support RK3576 SoC in the thermal driver

 .../bindings/thermal/rockchip-thermal.yaml         |  62 +++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 221 +++++++++++++++++-
 drivers/thermal/rockchip_thermal.c                 | 251 +++++++++++++++++++--
 3 files changed, 511 insertions(+), 23 deletions(-)
---
base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
change-id: 20250215-rk3576-tsadc-upstream-7e0c193f768a

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


