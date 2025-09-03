Return-Path: <linux-pm+bounces-33763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080CB42A30
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A689C542810
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92357369974;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKX3WoA1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4132D8768;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929082; cv=none; b=XmDWpsAQ7/xla7MDeFqEs1380A37kyCLxG0bGIhFXY2feYEK3ffW17OrupAJYnKtlQWYVEOJv00TkD18wS7Lzqnp6BD6r+8orVN62+GuXlgtwWGmRwxOwyvcn+Y6rqiSpm8c/YbBi5Xr+gIPJatBvu+kr3X3qgqP5HpWa2KUb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929082; c=relaxed/simple;
	bh=gFOnd9Tvis+cqdyg6z7tcp79CJ2p06seEOHvLMOOC+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nL2sVWz/mxIXrn7IiA/zYce0uS+w4LFiu+AYuxuHhoCCk7FlVGAuorVrYsdlR1IwCS4f2N70SuZR7Wvcmctd3P41VEtJ7dkrEka8/TP+3k9t+gpV0yt3cPih+k9EWryo2nzTWbTFnx+1FS8gmEnFuSMBcaCTl+0PEE7t8V8WJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKX3WoA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D28CBC4CEE7;
	Wed,  3 Sep 2025 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929081;
	bh=gFOnd9Tvis+cqdyg6z7tcp79CJ2p06seEOHvLMOOC+Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AKX3WoA1daNCZO7yDBJgUk6uu36B0/eUpnhY7Xt4nDplDk1vyyhUPe6EXzl5ug2Jq
	 P5xletTbF6ELcCtjoOt86m5cIgpJhEkrOqPaVmf64xT5/PdqylEqpyRpmdvSLt+5kR
	 tepVOWZ412HdyMvQybgLYcbgGD20e3+TRdipP+fjBnFGw/A1TCAyM4VSOctoUbWST/
	 dqw8nrvnLekfxwkxm3i/UqzPsqS+uub+ba2WTHeG8sGIHCNuitFrxXp+2Ad+OWKdBj
	 JCc9Fr5liMNs8n+oLMmwffNDQcqg3fR061tK1AkLyDM0sWTuphyVfpksjQGgo47j3d
	 LwmTnl3KPqXdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18ADCA1014;
	Wed,  3 Sep 2025 19:51:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 0/8] Support Tegra210 actmon for dynamic EMC scaling
Date: Wed, 03 Sep 2025 14:50:06 -0500
Message-Id: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO6buGgC/1XPQW7DIBAF0KtYsy4VYIixV71HlQWGbwepNglQq
 1Xku5c4XbS7+SPN6P07ZaSATENzp4Qt5BDXGuRLQ+5i1xks+JpJcqm5kZIVKTizrixxZa3quXL
 o4LmjenFNmMLX8e39/MwJt8/6tDyXNNoM5uKyhDI0ZtIWLfen3ndatQC47zg3rbeT8jAThPbaa
 PqLqbaDIioFc7IPTr4CPjLV8VMvYEbj3LBJehAuIZeYvo9+mzgMv1XMvyqbYHXGKHo4MUml3ub
 Fho/XaqXzvu8/C/0UaykBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756929080; l=2134;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=gFOnd9Tvis+cqdyg6z7tcp79CJ2p06seEOHvLMOOC+Y=;
 b=7m8WkKu0VNb7sEqCcDhrpHkv7f/U7cahaSgZVOVvIR97hswjw2MAkyV//p2TxDSk41hOQskoF
 GrxPCHZ4hGDBGdPqo3E0mX6eFx9XKgADp0fWytPxmYmB57bPU+kq4/Y
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

This series adds interconnect support to tegra210 MC and EMC, then
enables actmon. This enables dynamic emc scaling.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Assume 64-bit dram bus width in patch 4
- Add dt-bindings patch to document the new properties on the
  tegra210-emc node.
- Link to v1: https://lore.kernel.org/r/20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com

---
Aaron Kling (8):
      dt-bindings: memory: tegra210: Add memory client IDs
      dt-bindings: devfreq: tegra30-actmon: Add Tegra124 fallback for Tegra210
      dt-bindings: memory: tegra210: emc: Document OPP table and interconnect
      soc: tegra: fuse: speedo-tegra210: Add soc speedo 2
      memory: tegra210: Support interconnect framework
      arm64: tegra: tegra210: Add actmon
      arm64: tegra: Add interconnect properties to Tegra210 device-tree
      arm64: tegra: Add OPP tables on Tegra210

 .../bindings/devfreq/nvidia,tegra30-actmon.yaml    |  13 +-
 .../memory-controllers/nvidia,tegra210-emc.yaml    |  13 +
 .../boot/dts/nvidia/tegra210-peripherals-opp.dtsi  | 135 ++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  43 ++++
 drivers/memory/tegra/Kconfig                       |   1 +
 drivers/memory/tegra/tegra210-emc-core.c           | 274 ++++++++++++++++++++-
 drivers/memory/tegra/tegra210-emc.h                |  23 ++
 drivers/memory/tegra/tegra210.c                    |  81 ++++++
 drivers/soc/tegra/fuse/speedo-tegra210.c           |   1 +
 include/dt-bindings/memory/tegra210-mc.h           |  58 +++++
 10 files changed, 635 insertions(+), 7 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250822-t210-actmon-34904ce7ed0c
prerequisite-change-id: 20250812-tegra210-speedo-470691e8b8cc:v2
prerequisite-patch-id: 83adce426963f91482cc0928357dad36705a3328
prerequisite-patch-id: f693f138b5d40cdc45d9066ce48cbcff782253f8
prerequisite-patch-id: 9e3b9b2fdb8d9c2264dfa7641d1aec84fb7aedd9
prerequisite-patch-id: ef4bcc4ddba7898b188fb3fc6e414a2662183f91

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



