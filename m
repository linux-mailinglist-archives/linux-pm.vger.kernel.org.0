Return-Path: <linux-pm+bounces-34076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58052B476F4
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 22:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 452174E0602
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABB299923;
	Sat,  6 Sep 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFDqry8n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78572820CE;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757189856; cv=none; b=qPhl9mHo/LptYy59pZ0hQe5U8EuC3rgaR6GLFOEIvigjLxk2Y/BIdglnBBWe5agF+IbEV/7pSWxxWO5wilXRcElAGberhjCWvQdQq8U7Ffk2kiwUq9SeHZGQ4m9qAfOI3Qc00rKD4p0QIxFXMES5pSx/zPff1CnFlToYQEK9StI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757189856; c=relaxed/simple;
	bh=h4FTk8uGgBle/y65Nq0TPLgDFPCw5v0+bcCx/Z5KdoY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OmG32ekVvUZu+o2+rN39rj8ka3SgN6L/6b6gfvKNIviIlyEk7wJYrOGyWhM9qp5LeIwwxwSjmfpSc6dG5PzBo/TwhaG3kvsL2WLecNXYYDi5ckzpkJbclFnbz/fsmlVypgTiqnkEqpsxRDPqK2KgsLWis69bQESdT5hHvhngYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFDqry8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FFA3C4CEE7;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757189855;
	bh=h4FTk8uGgBle/y65Nq0TPLgDFPCw5v0+bcCx/Z5KdoY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KFDqry8nwsK0GkLVAb0KUNBSfqDf4l5/sZSyOWmfnzDk13ZSKdf8q97uc6ZJT5+OI
	 6WF8GJpPnT7yUJf9mQ7gxASCiKDrqXRiYAxmTR87ZL726piU81KYJnhwg13bQ8qDaV
	 hAclzJ84L2ARRMiMDMa3jc0cN2ZxAfaIgDPy8g66jqolFwoARcf1XHvc1IXARoE5fX
	 Rdu55q0jqjh/CdhNjVzCYCY3mNTwgZjMu3q4HjcaN3qYuXiC+zZEwWiUSmzPDOeWJf
	 YCUsJjfuhM7IHBgx60fby7Xm/WCYcryVb960gi6eMFZTsqtsRvh5oo/FZN1yIYcEVb
	 1wWIu0x7dCnkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC8CA0FED;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v3 0/9] Support Tegra210 actmon for dynamic EMC scaling
Date: Sat, 06 Sep 2025 15:16:50 -0500
Message-Id: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALKWvGgC/1WPy26DMBREfwV5XVd+BsOq/1F1YewxsVRwYlPUK
 uLf60ClJrs7VzqjMzdSkCMK6ZsbyVhjiWmuQb40xJ3tPIJGXzMRTGhmhKCL4Ixat0xpplJ1TDm
 08MyRSlwyQvze294/jpxx/aqly/Ekgy2gLk1TXPrGBG0hmT91vtVKAmC+ZcxIb4PyMAFce200e
 ZTpm0OFVxWM2d51ygXwiaqWnToOMxjn+lWSu8I5liXln33fyneHvynmacrKab0x8A6OB6HU2zj
 Z+PlaXfeeVfyzHZPPrKhsdddSeRUM7CO7bdsvOGDbWWUBAAA=
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
 Aaron Kling <webgeek1234@gmail.com>, Chanwoo Choi <cw00c.choi@samsung.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757189854; l=2455;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=h4FTk8uGgBle/y65Nq0TPLgDFPCw5v0+bcCx/Z5KdoY=;
 b=b9Y+H4bMc73RlGZcMc7ikgg9jzQGNldmcACy+D5eogJeLGBv7nbHnNZh1tC3mrIxMzNr56E7+
 jyrYRKp1puRA5xQlYW2atZ9oJQII2zNLN4tCPC2rB7LR7lSZCB9/jiw
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

This series adds interconnect support to tegra210 MC and EMC, then
enables actmon. This enables dynamic emc scaling.

There are no cross-subsystem hard dependencies, only logical relations.
The subsystems can be merged in any order.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v3:
- In patch 5, don't fail mc probe if opp tables are missing
- Add more mc bindings to patch 1
- Add patch to use tegra210-mc bindings in the mc driver
- Re-order series to align patches within a subsystem to each other
- Link to v2: https://lore.kernel.org/r/20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com

Changes in v2:
- Assume 64-bit dram bus width in patch 4
- Add dt-bindings patch to document the new properties on the
  tegra210-emc node.
- Link to v1: https://lore.kernel.org/r/20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com

---
Aaron Kling (9):
      dt-bindings: devfreq: tegra30-actmon: Add Tegra124 fallback for Tegra210
      dt-bindings: memory: tegra210: emc: Document OPP table and interconnect
      dt-bindings: memory: tegra210: Add memory client IDs
      memory: tegra210: Use bindings for client ids
      memory: tegra210: Support interconnect framework
      soc: tegra: fuse: speedo-tegra210: Add soc speedo 2
      arm64: tegra: tegra210: Add actmon
      arm64: tegra: Add interconnect properties to Tegra210 device-tree
      arm64: tegra: Add OPP tables on Tegra210

 .../bindings/devfreq/nvidia,tegra30-actmon.yaml    |  13 +-
 .../memory-controllers/nvidia,tegra210-emc.yaml    |  11 +
 .../boot/dts/nvidia/tegra210-peripherals-opp.dtsi  | 135 ++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  43 ++++
 drivers/memory/tegra/Kconfig                       |   1 +
 drivers/memory/tegra/tegra210-emc-core.c           | 272 ++++++++++++++++++++-
 drivers/memory/tegra/tegra210-emc.h                |  23 ++
 drivers/memory/tegra/tegra210.c                    | 227 +++++++++++------
 drivers/soc/tegra/fuse/speedo-tegra210.c           |   1 +
 include/dt-bindings/memory/tegra210-mc.h           |  74 ++++++
 10 files changed, 720 insertions(+), 80 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250822-t210-actmon-34904ce7ed0c
prerequisite-change-id: 20250812-tegra210-speedo-470691e8b8cc:v3
prerequisite-patch-id: f693f138b5d40cdc45d9066ce48cbcff782253f8

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



