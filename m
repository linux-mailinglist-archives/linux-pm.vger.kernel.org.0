Return-Path: <linux-pm+bounces-36221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E17BDBE1E71
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 09:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C01884EB91F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EA82F6188;
	Thu, 16 Oct 2025 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tbj63GWZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7C2E1F08
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599485; cv=none; b=uhtXTV5pvByJTINWET7RLPAoDWED3P0lDwrp/kgUqZ5JWC7jklevHq6bi2jLd4QKu8JPO9DZosz6Ogdc9GRzSAfehPy/1l5i4gz+uKNxm3Jr3YcfhgvXxMudyHWAMHK3bHLRJU7IGZzoi+EnNbKTWyhxm9ebCYdtdrJh4QjGL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599485; c=relaxed/simple;
	bh=5xo1wcMo2ObznNd0kT3fow7tyytTL4bVQLcZfQgpJNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=lk91/qPm2jpuj/lzhu+6X6TCiKxboJqVMahnU+kYqu1D9oPcIo8zFKDxorPBw0DJcpfmtnQKFWgavqLc3Wf2N7lvusAfJS8ujvmG5Ts/BVY6KjIOzW3VJbBQ5NWyWkynT6ZYAF7FbjRObtSMG1Aw39waVjcHTkuezHDvmDg6O6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tbj63GWZ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251016072440epoutp0398e6f74047fcf6c38dc7b04af8e1c48f~u5_ZEiDTa1905019050epoutp03z
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 07:24:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251016072440epoutp0398e6f74047fcf6c38dc7b04af8e1c48f~u5_ZEiDTa1905019050epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760599480;
	bh=uvPq6Yt+OkoQhl8rEe9LIjf6WFzUTfhhECRiJsOl0Bc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=tbj63GWZxqzCPC8PYsOY+XfeMnVB0vOuEdTaZJXyo2jCzNkQkO0XOQUVZP/3CSqH/
	 6dCoAN/I+/NyXLfeyzKebRV1eserjrrQcIxzPZiiC7OygmKrNZkpzypobelJF7jOsC
	 IlGr+9k9jqqzKLd0OH584kP7OPTfBFkg7ipGewlM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20251016072439epcas2p263c9131a1e33874315c5c755bc31cbac~u5_Yjl-863251532515epcas2p2I;
	Thu, 16 Oct 2025 07:24:39 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.202]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cnKGH4Tdzz2SSKk; Thu, 16 Oct
	2025 07:24:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20251016072438epcas2p4c090c6e0433452e0ee061b115398dddf~u5_XoFJ9x2416724167epcas2p45;
	Thu, 16 Oct 2025 07:24:38 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251016072438epsmtip14a5e9c18ff706ff09ae7d4bf88c40cf5~u5_XimSB72023420234epsmtip1c;
	Thu, 16 Oct 2025 07:24:38 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Henrik Grimler
	<henrik@grimler.se>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] Add exynosautov920 thermal support
Date: Thu, 16 Oct 2025 16:24:26 +0900
Message-ID: <20251016072429.1933024-1-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251016072438epcas2p4c090c6e0433452e0ee061b115398dddf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251016072438epcas2p4c090c6e0433452e0ee061b115398dddf
References: <CGME20251016072438epcas2p4c090c6e0433452e0ee061b115398dddf@epcas2p4.samsung.com>

This patch series adds support for exynosautov920, automotive-grade
processor. Although the exynosautov920's TMU hardware differs slightly
from exisiting platform, its read and calibration logic closely follow
our legacy TMU interface. To prevent runtime and build time errors,
it is kept as a single change rather than being split.

This change merges the new exynosautov920-specific register definitions and
timing parameters into the exynos-tmu driver, ensuring consistent behavior
across all Exynos series. All new code paths have been tested on a
exynosautov920 board and verified to correctly read temperatures and
emulate behavior.

Changes in v7:
- Use lowercase hex for register address
- Dropped unnecessary 'minItems' from properties.
- Added restriction for 'clock-names'

Changes in v6:
- Add a reviewer for the thermal driver patch.

Changes in v5:
- Changed the maximum number of thermal sensors to 15.

Changes in v4:
- Kept 'addtionalProperties: false'.
- Removed the 'samsung,hw-sensor-indices' property in the binding.
- Added the 'samsung,sensors' property in the binding.
- Dropped code-like formatting and rewrote the description in plain,
  hardware-focused language in the commit message.
- Removed the bitmap and replaced the tz_count to sensor_count.

Changes in v3:
- Removed redundant commit message.
- Rephrased the sentences to describe the hardware clearly.
- Restricted sensor indices to V920.
- Set #thermal-sensor-cells per variant.
- Replaced 'additionalProperties' with 'unevaluatedProperties'.
- Removed the duplicate #define and use the original.
- Used lowercase hex in #define.
- Simplified 'temp_to_code' and 'code_to_temp' to one computation
  path by normalizing calib_temp.

Changes in v2:
- Replace the generic property with a vendor-specific one.
- Added an indices property instead of ranges.
- Shortened thermal node name and made them more generic.
- Updated the indices logic accordingly after removing the ranges property.

Shin Son (3):
  dt-bindings: thermal: samsung: Adjust '#thermal-sensor-cells' to 1
  thermal: exynos_tmu: Support new hardware and update TMU interface
  arm64: dts: exynosautov920: Add multiple sensors

 .../thermal/samsung,exynos-thermal.yaml       |  33 +-
 .../boot/dts/exynos/exynosautov920-tmu.dtsi   | 377 ++++++++++++++++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  31 ++
 drivers/thermal/samsung/exynos_tmu.c          | 322 +++++++++++++--
 4 files changed, 725 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi

-- 
2.50.1


