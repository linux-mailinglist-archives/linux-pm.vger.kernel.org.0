Return-Path: <linux-pm+bounces-37908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A2C55F10
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 07:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 123734E2F34
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 06:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2EA320CC9;
	Thu, 13 Nov 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GcHUH12s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4673218BA
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016039; cv=none; b=bBHlHEF1t95sMJDvQsCKQcbIhAn7h9jDDCk9Vapbz+rAvuESFZUe1UAF7xdxnuI8xccvjTrsTFucRUFGFUryxt5SmbXqXveHn00WfcX+LU7BnwLzYBY8ai9qluZjf5feKZrgv1W4q2CINZpp+/1uERWhcJyxSv2tdGzM4EcfjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016039; c=relaxed/simple;
	bh=FaPSdt1BpUF0/rBEN7O+UBa34orAz/bvGk0wE7vUdCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=swTIM99adSvT3h7jyba7/bH5vunzDiahIfqBYag/cydaFfoQPAamiSZBe17lTDFvB1mGgsBDkJcmw1RtivDkRugC09Fpr4afr+O/TpaTKPhFa101m1Uwlt7LVDv/YnHO/V4RIqKnLBvuaNe5HQeE9Og8/4hoo8E1uLxplfJRtlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GcHUH12s; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251113064033epoutp02ec5a12dd599677566ae059b72bb6b8e0~3fb31AUXX1313913139epoutp02J
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:40:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251113064033epoutp02ec5a12dd599677566ae059b72bb6b8e0~3fb31AUXX1313913139epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763016033;
	bh=fhcEhnT4KvHOonmk1YCZsf0kTUFCWo0RLPs6umghfh0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GcHUH12sPOefPmyTGpLtpIjepR9DmMNf/aENZNhUvnjzdaqFux96JKxJrpsvBCDwX
	 wzQ4/5BGurqME6zVb6u/6zTbNP/fr4PKc6bjI33rHDmDnrRtC0nqpNoLYMK5g8pBxS
	 DEZdbeFA/eAwsAmdAKFqNTMVxInfCD+jRQ/r4WrQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20251113064033epcas2p3aed9145c058d905ac5833ff4bbc9d553~3fb3by6Hc0175501755epcas2p3L;
	Thu, 13 Nov 2025 06:40:33 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.208]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4d6VyT1P1Kz2SSKt; Thu, 13 Nov
	2025 06:40:33 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20251113064032epcas2p316f2b271e581d03b729a5944d9624d49~3fb2guVks0175501755epcas2p3C;
	Thu, 13 Nov 2025 06:40:32 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113064032epsmtip2ffd412734659ee2cb9579ed2896b637d~3fb2bcIEO0149501495epsmtip2v;
	Thu, 13 Nov 2025 06:40:32 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Henrik Grimler <henrik@grimler.se>, Shin Son <shin.son@samsung.com>,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 RESEND 0/3] Add exynosautov920 thermal support
Date: Thu, 13 Nov 2025 15:40:19 +0900
Message-ID: <20251113064022.2701578-1-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113064032epcas2p316f2b271e581d03b729a5944d9624d49
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113064032epcas2p316f2b271e581d03b729a5944d9624d49
References: <CGME20251113064032epcas2p316f2b271e581d03b729a5944d9624d49@epcas2p3.samsung.com>

This is a gentle reminder.
The v7 series was first sent on Oct 16 and resent on Oct 31.
Any review or feedback would be appreciated when you have time.

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


