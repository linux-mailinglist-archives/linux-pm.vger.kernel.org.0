Return-Path: <linux-pm+bounces-5001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3687E17D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 02:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD831C20C95
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 01:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DF2134AA;
	Mon, 18 Mar 2024 01:12:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14D1096F;
	Mon, 18 Mar 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710724379; cv=none; b=OqAA82uQaYo4E84fl3xMGLvyPVUHBHDOsv8l3J8dFQWIN8kuNawrzQhEpxPCxTJRaHL6WUshRkuE3jYY5sz/KtrPU9JFa0q/btLYrSeVIw592QA4s1hzT2g6uTTYHoxjNXyUXY/A3WiFXTsdGbueL3dJOvYjbzHhwish1MvafeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710724379; c=relaxed/simple;
	bh=YQHNZw/+pDkOrdqc3nY+J/aL9vD2b94hh83lMstt3/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aYEuyEC4NdE7U2c32ldCaPb0X+GTk2SToxbgRP5xRKobY1tVwRfilJYEAK1DXF2j8ioFJQL1bv/Pb6x0FswWDFOmfKUxfB0Nwb6KjTFeKerrxKVy4maEd5N+tPL3q761b0Mx0OgCYHMmPxEaGQC8gqk+WigBCiaz97fWdUzS7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF18A12FC;
	Sun, 17 Mar 2024 18:13:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50DA33F23F;
	Sun, 17 Mar 2024 18:12:53 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 0/8] cpufreq: sun50i: Add Allwinner H616 support
Date: Mon, 18 Mar 2024 01:12:20 +0000
Message-Id: <20240318011228.2626-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds cpufreq support for the Allwinner H616 SoC.
This v2 is quite some rework compared to Martin's original series from
about half a year ago[1].

The various H616 chips are rated into different speedbins at the factory,
the bin index is then burned into the efuses. This is very similar to the
H6, though the location of the speedbin fuse and its encoding differs.
Also the die revision has a say here, we can derive this from the SoC ID,
already provided by TF-A through the SMCCC SoC ID interface.
On top of that not all chips are qualified to reach the full 1.5GHz,
and the BSP kernel describes different OPPs for each speedbin. This
requires to add support for the opp-supported-hw DT property, to be able
to describe those requirements properly.

Patch 1/8 exports the SoC ID function, so that we can call it from our
driver. Patch 2/8 blocks the affected SoCs from the generic DT cpufreq
driver, patch 3/8 adds the DT binding documentation.
Patch 4/8 refactors the existing speedbin determination for the H6, to
be able to plug in the H616 version later more easily.
Patch 5/8 adds support for the opp-supported-hw property. This is done
in a generic way, so it's usable for other SoCs as well, and the code
will figure out if the current DT requires use of this feature.
Patch 6/8 then eventually adds the H616 bits to the driver, and ties
that to the new compatible string.
Patch 7/8 add the CPU OPP table as a .dtsi to the DT directory, the
values in there were taken from the BSP source.
Patch 8/8 then enables the OPPs for all boards we have DTs for.

Please have a look, especially patch 5/8 might need some discussion.
This is based on v6.8, with the THS series on top, which should reach
mainline in the next days. I plan to send a rebased version after -rc1,
but wanted to start the discussion early.

Cheers,
Andre

[1] https://lore.kernel.org/linux-sunxi/20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org/T/#u

Andre Przywara (2):
  cpufreq: sun50i: Add support for opp_supported_hw
  arm64: dts: allwinner: h616: enable DVFS for all boards

Brandon Cheo Fusi (1):
  cpufreq: sun50i: Refactor speed bin decoding

Martin Botka (5):
  firmware: smccc: Export revision soc_id function
  cpufreq: dt-platdev: Blocklist Allwinner H616/618 SoCs
  dt-bindings: opp: Describe H616 OPPs and opp-supported-hw
  cpufreq: sun50i: Add H616 support
  arm64: dts: allwinner: h616: Add CPU OPPs table

 .../allwinner,sun50i-h6-operating-points.yaml |  89 +++++----
 .../sun50i-h616-bigtreetech-cb1.dtsi          |   5 +
 .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 138 +++++++++++++
 .../allwinner/sun50i-h616-orangepi-zero2.dts  |   5 +
 .../dts/allwinner/sun50i-h616-x96-mate.dts    |   5 +
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |   4 +
 .../allwinner/sun50i-h618-orangepi-zero2w.dts |   5 +
 .../allwinner/sun50i-h618-orangepi-zero3.dts  |   5 +
 .../sun50i-h618-transpeed-8k618-t.dts         |   5 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   3 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 189 +++++++++++++++---
 drivers/firmware/smccc/smccc.c                |   1 +
 12 files changed, 379 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi

-- 
2.35.8


