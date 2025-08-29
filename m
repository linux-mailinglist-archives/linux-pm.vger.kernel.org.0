Return-Path: <linux-pm+bounces-33356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A5B3B1D2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 06:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2417C5F2E
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 04:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EFC1FF603;
	Fri, 29 Aug 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEuJHAbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348FE17E0;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440093; cv=none; b=iYk/ujNxjr/06gq6IMGTJVLR5zucL8YJbcGBncXVr5KTQE3EBeJiWW8XCQPeJjQLizqsJzDKkQfY63NegRwwW2N7kYSr2KtlIqB8eGv4hi/Knp/N3/pSTGm8Z/vnhAL4OX+Zzr1GxOvHFHGGYjoanrNC/hy4cs8zABq+Wc0L49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440093; c=relaxed/simple;
	bh=VcSv8G9xRrJjt3otAEwpuFiKaXlXE79WuR6v4AadA+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jVAEuSt1GiOgeVPEqos1QVTbUXRX+cg+Z4fWtuq1p5pTJNOJW3so/WyAy1NIZ2K5KRwrrMeICRoznsBakVYHy0mXX16qwz53rhwdx9e/MPV9FH9DbmYET6ZZO1zyB0rSEqZwwx4hTR/iekNc7VCZeqfakbzyvEv6bF8EmATkUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEuJHAbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3EF6C4CEF0;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756440092;
	bh=VcSv8G9xRrJjt3otAEwpuFiKaXlXE79WuR6v4AadA+Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aEuJHAbxIj6UBb0OQUG5nJLwwz4WN4Pzr1BI8FbqBs7o4zl2fif7U9RDYwYsU0fK6
	 miwJjOXQvG9BZgB8Kos8GdV10jZfSRx0kgvFWv2SvLZYna2Nav60mdPTRBoFZVrQFK
	 2vTMgcPZI+AVPTMs4yW5ac8QJTXVOwONLccAyhc3nFafOzHNlhyyq8veP1QKooZuml
	 q1l2T4g49p/F8zSAflDLcnxw4m3ch+02ISHo9fY2K0bWJ4jKEeavaEg3SJPCu+X9W5
	 +Hi730z0h8Ds9c7L1tXQqEPchWTMn5kiAOWosZqr3IbKBafADSLhI/svqz+RFvpmUO
	 IDQRzemYHlTlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99438C8303F;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH RFC 0/7] Support Tegra210 actmon for dynamic EMC scaling
Date: Thu, 28 Aug 2025 23:01:26 -0500
Message-Id: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABYmsWgC/02Ou47CMBREfyW6NZauHZs4aVfiA2hXFMZ3Ai6Ss
 HYWrYT49zWPgnJmNEfnRgU5odDQ3Cjjmkpa5hr0pqF4DvMJKknNZNg49sao1WhWIa7TMqvW9mw
 jOghHqo9Lxpj+nrRv2u++6PAqM35+K3l9L8dQoOIyTWkdGj+6gJZl20vnbAuApWP2rYTRCvwI7
 cR5R59GQ/Py0dUHpxweTuUCyKJsx9tewx99jMNV0+F+/wfe2Va45QAAAA==
X-Change-ID: 20250822-t210-actmon-34904ce7ed0c
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756440091; l=2924;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=VcSv8G9xRrJjt3otAEwpuFiKaXlXE79WuR6v4AadA+Q=;
 b=/424fg+xE/KGEXcg5aiIjDrTcGrW+87Z6V9HPNGlpVacKv5YWnwKTOs5G14szFYM6ZJKsXsHH
 nLlOOFmqTWVBkjI+crN8eDa+20/XhULbbaXtkg+ptu/OoaHfucmFYGV
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

This series adds interconnect support to tegra210 MC and EMC, then
enables actmon. This enables dynamic emc scaling.

This series is marked RFC for two reasons:

1) Calculating rate from bandwidth usage results in double the expected
   rate. I thought this might be due to the ram being 64-bit, but the
   related CFG5 register reports 32-bit on both p2371-2180 and
   p3450-0000. I'm using the calculation used for Tegra124 and haven't
   seen seen anything obviously different between the ram handling on
   these archs to cause a different result. I have considered that the
   number of channels might affect the reporting, and factoring in that
   variable does result in the correct rate, but I don't want to assume
   that's correct without confirmation.

2) I am seeing intermittent instability when transitioning to rates of
   204 MHz or below on p2371-2180. I have noted that if the first
   transition to such a state works, then it continues to work for the
   rest of that boot cycle. But the kernel will often panic the first
   time it tries to downclock. I suspect this is a pre-existing issue
   only brought to light now because nothing would ever lower the clock
   rate previously.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Aaron Kling (7):
      dt-bindings: memory: tegra210: Add memory client IDs
      dt-bindings: devfreq: tegra30-actmon: Add Tegra124 fallback for Tegra210
      soc: tegra: fuse: speedo-tegra210: Add soc speedo 2
      memory: tegra210: Support interconnect framework
      arm64: tegra: tegra210: Add actmon
      arm64: tegra: Add interconnect properties to Tegra210 device-tree
      arm64: tegra: Add OPP tables on Tegra210

 .../bindings/devfreq/nvidia,tegra30-actmon.yaml    |  13 +-
 .../boot/dts/nvidia/tegra210-peripherals-opp.dtsi  | 135 ++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  43 ++++
 drivers/memory/tegra/Kconfig                       |   1 +
 drivers/memory/tegra/tegra210-emc-core.c           | 276 ++++++++++++++++++++-
 drivers/memory/tegra/tegra210-emc.h                |  25 ++
 drivers/memory/tegra/tegra210.c                    |  81 ++++++
 drivers/soc/tegra/fuse/speedo-tegra210.c           |   1 +
 include/dt-bindings/memory/tegra210-mc.h           |  58 +++++
 9 files changed, 626 insertions(+), 7 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250822-t210-actmon-34904ce7ed0c
prerequisite-change-id: 20250812-tegra210-speedo-470691e8b8cc:v1
prerequisite-patch-id: 81859c81abbe79aed1cfbc95b4f5bcdc5637d6bd
prerequisite-patch-id: 98bda8855bcc57c59b2231b7808d4478301afe68
prerequisite-patch-id: 6e0b69d42ea542dc9f58b410abd5974644f75dc4
prerequisite-patch-id: 9e3b9b2fdb8d9c2264dfa7641d1aec84fb7aedd9
prerequisite-patch-id: ef4bcc4ddba7898b188fb3fc6e414a2662183f91

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



