Return-Path: <linux-pm+bounces-19895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724459FF88C
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 12:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1323A2D51
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D651AF0C7;
	Thu,  2 Jan 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddPNGJMb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D31ADFE0;
	Thu,  2 Jan 2025 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735816564; cv=none; b=ZV+Bq3aR21W/nHatfjtyG/UGTW86avrEywKGF1Vd+7ne9XnKJWq/OtCyHPvWTHt733JUXj9ZMNYlqu8gy8EOA87el9MGbP0e7NmHIC25aPOLB3/QgiC2B4z9ErE2LGbeQKFZIhbbi7nxiXIPsSw9eTDVeO7hXy48LuZm9NwHHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735816564; c=relaxed/simple;
	bh=BCKCRIacyWKgqo6gAegHeTB5UJABaGjYit2k0RzaGXo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sFafalgP9mQ0mh6ve3PfPnDWN7nuYMXuU6aCegSeQwL40sWhzspmJa96J5TvaI7vazxfmI5x0R37WxRRKovYjQr0XBfkNXiAZkpmZ3X/JTQeMmP5oaLYl5DT2/zfjxaghHok4tsnIgGtef8c0p/zc5Npgn+vs4fBC6sDlRLKres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddPNGJMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0C60C4CED0;
	Thu,  2 Jan 2025 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735816563;
	bh=BCKCRIacyWKgqo6gAegHeTB5UJABaGjYit2k0RzaGXo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ddPNGJMbDtFFvIaY6NZJ3R0J/5lMcrqSA61LFimqiZoeZvHLjEuNRz+b3xYIEcsn0
	 vagd3nvdPwSfrrtS3C7O9a9CDsISXUZrmF7Ntc2BtCCP7zPHIe9NXwCiLJRztYCqZi
	 9X5DyTLuvq/1M2uxn+mmY5kixeKu5SF6NRs5Q3YSIol4MtAPRwNAwsuN4QVhfEm9QX
	 GnZ3AOeJPsZK/qULq5M0knOIkcLZ5Qftg6dm35I3wLV/28lByXodTLl7NPc7R7M0JP
	 qN+r9B+Jh6rYQDwvGSmHzWhK61IUvlHTblHO5XF4oFPoCRmJuzqa/8VTecMYTtjl1o
	 /A/K3eeDjQrEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965F5E77188;
	Thu,  2 Jan 2025 11:16:03 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Subject: [PATCH v2 0/4] Google Pixel 6 (oriole): max77759 fuel gauge
 enablement and driver support
Date: Thu, 02 Jan 2025 12:15:02 +0100
Message-Id: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADZ1dmcC/4WNWwqDMBREtyL3uyl5ldR+dR9FJNEbvdAaSWqwi
 Htv6gb6M3AG5swGCSNhglu1QcRMicJUQJ4q6EY7DcioLwySSy1KMKfZkAQX7cuuxphL3fqBaS5
 RKmG1UwrKdI7oaT20j6bwSOkd4ud4yeLX/hFmwTirr7301jiPit+X7hmWbGk6O4Rm3/cvUWaGq
 bsAAAA=
X-Change-ID: 20241202-b4-gs101_max77759_fg-402e231a4b33
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735816515; l=1708;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=BCKCRIacyWKgqo6gAegHeTB5UJABaGjYit2k0RzaGXo=;
 b=nNwiaZEpXaE/xmq13KUaZhCVGXxQKaEr/PxDVQPiVg9kT2kvTD0OYSbdMx2Gh/O1M5enu4LZj
 vL6grHmE2QpAp6Z94gjM2/KM23we6cqO7iHL2goR6lHLpCb0jy0IE1L
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

The Google Pixel 6 has a Maxim max77759 which provides a fuel gauge with
an interface with a lot in common with the Maxim max1720x.

Modify the Maxim max1720x driver to be compatible with the Maxim max77759 and
enable it for the gs101-oriole board.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
Changes in v2:
- Add fallback for voltage measurement (André Draszik)
- Add regmap for the max77759 (André Draszik)
- Add chip identification for the max77759 (André Draszik, Peter Griffin)
- Move RSense value to a devicetree property shunt-resistor-micro-ohms
  (Dimitri Fedrau, André Draszik)
- Use allOf:if to narrow binding per variant (Krzysztof Kozlowski)
- Remove binding example (Krzysztof Kozlowski)
- Change defconfig order to follow savedefconfig (Krzysztof Kozlowski)
- Fix style errors
- Link to v1: https://lore.kernel.org/r/20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be

---
Thomas Antoine (4):
      power: supply: add support for max77759 fuel gauge
      dt-bindings: power: supply: add max77759-fg flavor
      arm64: defconfig: enable Maxim max1720x driver
      arm64: dts: exynos: gs101-oriole: enable Maxim max77759 fuel gauge

 .../bindings/power/supply/maxim,max17201.yaml      |  56 ++++--
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts |  10 ++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/power/supply/max1720x_battery.c            | 189 ++++++++++++++++++---
 4 files changed, 218 insertions(+), 38 deletions(-)
---
base-commit: 12e0a4072e8edc49c99418a4303bd7b96916de95
change-id: 20241202-b4-gs101_max77759_fg-402e231a4b33

Best regards,
-- 
Thomas Antoine <t.antoine@uclouvain.be>



