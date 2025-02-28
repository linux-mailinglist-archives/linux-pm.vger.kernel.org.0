Return-Path: <linux-pm+bounces-23195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13930A4A3A7
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F082388239B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44571279343;
	Fri, 28 Feb 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WN9eZH2c"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46490279328;
	Fri, 28 Feb 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773260; cv=pass; b=d+mhLuXZ94QabI91MWB9IJWaGzBDfDsF6oA+ztTsK8v6gwfHOw5YAynjc+ecHIip+rEuZ0cMaYnxyHJvBG8vTD+85uoUp0RMA2TvLwkW6sEnqlxalb5Nimr5tfhBHB0lYkkQR9m+2NfST8UphkVoqHmV5ko20Ark2Kgj/2JPQWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773260; c=relaxed/simple;
	bh=OFCDGk68qcTDG5XS23iG3QfommOKANCBxjRQIng3Gmk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LMAYSLjL5lQLBTt6FEfOnhsT3oaqzkxGEVuK+hV70t3Fz8Q/fL0H0TFNMGROZV6rglaNhet4hE6+zPbokeKlxbaEd5wB6lj07qceRzSE9nDlEnZNRIGn6BiCXpc3NgJsiQhBXN8JQYi4W7GMhuWrku50ROPNdG6T62tt+WiAoug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=WN9eZH2c; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740773232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aDQ9XSFhTFSuSfJtilNc9D8UJ3U58nCRae8SXzRblM1oHHABehg2W3X86qjADDj1aW9/lKL5C0h3BvnLtY5V91D6NezbsyS2HfCzGT6QCBh8+Prv+Csu581wgGYcPOTWszvUD/i3/y1TcY5Q/VYOgN0sJHIN0QZfJ1R1yJ4XEyw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740773232; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NZEe0vmA/5VGyYiLh1+RkOnh9kBCTEZSOkm94y03iiA=; 
	b=klyduJ8+IWp8EAKX5Er02+jH4+k44wjE0Sl3RLy8GNFtd6baFZG+l+e+br6yNFy0Tom4eBXgfyw4ATx5+CeXE+bToQ7daHG1+mJayw+u85tZsRY4QiLGEpSQt8WffXPmFcu1LLw9k/5c4BigF3J5pwaTgsC5anHNq4v6673cA/0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740773232;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=NZEe0vmA/5VGyYiLh1+RkOnh9kBCTEZSOkm94y03iiA=;
	b=WN9eZH2cTFkXs7E0wRuLCofXKJrVxzfhlwXc7uMwn+1vE9gJt1+maLfWjB32D2FH
	iTU98EDI6iBFkS6pNFF6G8TnMhoAbExuLYqFtT9e91gLsim7vu/uNW/ArI0lV6Xt3M6
	OcHotsS4luJyNJzKwl+663UAmtsV47ykTcWjIVT4=
Received: by mx.zohomail.com with SMTPS id 174077323124077.63838150592198;
	Fri, 28 Feb 2025 12:07:11 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 0/6] RK3576 thermal sensor support, including OTP trim
 adjustments
Date: Fri, 28 Feb 2025 21:06:50 +0100
Message-Id: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFoXwmcC/3WPQQ7CIBBFr9KwdgxMLW1deQ/jgtJRibYoINGY3
 l2kLoyJyz/Jf//Nk3lyhjxbF0/mKBpv7JhCuSiYPqrxQGD6lBlyrDiKCtyprGoJwatew+3igyM
 1QE1ci7bc17JRLHUvjvbmnrnb3ZwdXW8JH+Yj65Qn0HYYTFgXI90DzBPYsHfhaHyw7pG9osiNj
 4L8oxAFcJCkW9mWiEqsNtqez6qzTi3TTqZG/CLhv2ciZlJXd5z31LT6lzRN0wtjRJNfOQEAAA=
 =
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

[1]: https://gitlab.collabora.com/fratti/linux/-/tree/rk3576-thermal-adc-6

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
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
Nicolas Frattaroli (5):
      dt-bindings: rockchip-thermal: Add RK3576 compatible
      arm64: dts: rockchip: Add thermal nodes to RK3576
      dt-bindings: thermal: rockchip: document otp thermal trim
      arm64: dts: rockchip: Add thermal trim OTP and tsadc nodes
      thermal: rockchip: support reading trim values from OTP

Ye Zhang (1):
      thermal: rockchip: Support RK3576 SoC in the thermal driver

 .../bindings/thermal/rockchip-thermal.yaml         |  62 +++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 221 ++++++++++++++++-
 drivers/thermal/rockchip_thermal.c                 | 263 +++++++++++++++++++--
 3 files changed, 525 insertions(+), 21 deletions(-)
---
base-commit: 15c3f6fa407bf6913c282b22ef2bcfa40cb53927
change-id: 20250215-rk3576-tsadc-upstream-7e0c193f768a

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


