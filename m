Return-Path: <linux-pm+bounces-30493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C26FAFEE24
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED63F4A17FC
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BC2E9742;
	Wed,  9 Jul 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV/UEic+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72028FA87;
	Wed,  9 Jul 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076427; cv=none; b=KKOrgrUtJ4TRvIJ5E7Edy9Qyd5DyKyv1aLPBMU4J58D27cPh5oClZB/8EttN3jgkrAglBbx7R3OM6rf7IWJFhOG8KjfoKvoQWF7vActUlc8T5E4MNEny7vdipJev+y6jNwDfru0QJpir7XUbm5eCdT0idtvT/dt9r9qWW6NmZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076427; c=relaxed/simple;
	bh=RY67xBd5sUO3XFR2TQQgs/qjtaenGN5JeNcwWjGIERE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IyZuIg3JRfEHcg3kOYulx3R9U2W3Nqyp/LumkTY8fiTPDOkB4gWPzFudwajHOLWXxZMqRYYCGDII+k83WvO9T7R7P1zAautC8C954ZZ2nXSzb1YkNmwETZ8gfSiGuLyvR9XB/zJX9yXDBoyRiu2q7fKP/DwBtDVWeYzgdsD/nXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV/UEic+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D22C4CEF6;
	Wed,  9 Jul 2025 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076426;
	bh=RY67xBd5sUO3XFR2TQQgs/qjtaenGN5JeNcwWjGIERE=;
	h=From:To:Cc:Subject:Date:From;
	b=qV/UEic+NBgClUfBz1cfNkW0Vs8dXgLz1LNkXdAdMku5pyLmZGxLWDxrPuEWj9qQ5
	 G3wFAJZLcmoc6Uwi56kl1ecu/isZ4chLIGt97wnlb48XO2LYiQgAKafL41DgahbqlK
	 vJbXyfnbcEjQFOLnSsPLactoi2xC1dtwd5rytZwZdCXrsbr2xknxOb/AwBRMtyi/wu
	 5+/5DEdZg+rJQSehvL60c5UArOmtji26e0pGmSydFST+Bpbpc81AiyQfqkWSBNUT4a
	 XdCpZiZ9ZAzK6taLlnMriEeH1wbbFiZ/srkU0mUv2pd7zyrQ3gVcaRXf032XINajL/
	 KIKebC9QeAjMQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 2F5C85FCB4; Wed,  9 Jul 2025 23:53:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] allwinner: a523: Add power controllers
Date: Wed,  9 Jul 2025 23:53:39 +0800
Message-Id: <20250709155343.3765227-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Hi folks,

This is v2 of my A523 power controllers series.

Changes since v1:
- Re-order compatible string entries
- Fix name of header file to match compatible string
- Link to v1:
  https://lore.kernel.org/all/20250627152918.2606728-1-wens@kernel.org/

This series adds the power controllers found in the Allwinner A523
family of SoCs. There are two power controllers. One is the same type
as those found in the D1 SoC, just with a different number of valid
power domains. The second is (I assume) a unit based on ARM's PCK-600
power controller. Some of the registers and values match up, but there
are extra registers for delay controls in the PCK-600's reserved
register range.

Patch 1 adds new compatible string entries for both of these
controllers.

Patch 2 adds support for the A523 PPU to the existing D1 PPU driver.

Patch 3 adds a new driver of the PCK-600 unit in the A523 SoC.

Patch 4 adds device nodes for both of these controllers.


Please have a look. The power controllers are critical for enabling more
peripherals, such as display output, camera input, video codecs, the NPU,
and a second DWMAC-compatible ethernet interface.


Thanks
ChenYu


Chen-Yu Tsai (4):
  dt-bindings: power: Add A523 PPU and PCK600 power controllers
  pmdomain: sunxi: sun20i-ppu: add A523 support
  pmdomain: sunxi: add driver for Allwinner A523's PCK-600 power
    controller
  arm64: dts: allwinner: a523: Add power controller device nodes

 .../power/allwinner,sun20i-d1-ppu.yaml        |   4 +-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  18 ++
 drivers/pmdomain/sunxi/Kconfig                |   8 +
 drivers/pmdomain/sunxi/Makefile               |   1 +
 drivers/pmdomain/sunxi/sun20i-ppu.c           |  17 ++
 drivers/pmdomain/sunxi/sun55i-pck600.c        | 225 ++++++++++++++++++
 .../power/allwinner,sun55i-a523-pck-600.h     |  15 ++
 .../power/allwinner,sun55i-a523-ppu.h         |  12 +
 8 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h

-- 
2.39.5


