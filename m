Return-Path: <linux-pm+bounces-35244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A8B96E98
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209247AF528
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DAF27587C;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL3s6Dk9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAF2571BC;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647135; cv=none; b=Lrg+TeuU1Ty4nXVDcOfLTJlWO10EvhTpEMaLTB9HKEbDzUP4pCFK/Tc/R/vHqZPsFIQQCpNps1vb0QzDnT360J5gz0DY8NAwYEQHb9iSCkZjs3spjLarj8sFAhcE/4XZrigcy8bRh1hHRTDGeINHsjumzR1+jK+M64xYjMUA1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647135; c=relaxed/simple;
	bh=3WlgG06ZOkLQJ3sKxctiH8zHTTaZsOpoBGk+S7tsbOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MpGu06lMHdFKQDNONj/AkQo7c6bWjPjWBLyiMOT0GOPJXWOwNQXdQdvEJoWqRv9mTYBGDwcRGNsLLgAKjjZCXUn54sUNdRJ6Vb4aXUKOmseqDCX29u+XKWgIeSwHC210dGJIkNxqmb6wpuNKQxr1drQ7FpJ4FIQDUtElcNqAtu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL3s6Dk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84B29C4CEF5;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647134;
	bh=3WlgG06ZOkLQJ3sKxctiH8zHTTaZsOpoBGk+S7tsbOs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mL3s6Dk95K/VeGTnJVK7AyM4C5FRK0S6/2LPbWW+SKHESkAgH2rxSLfrsPhSB+sOT
	 1FPuqq1x8tXxh3JUCiq1JFmClIp0JoeOkNGFgbpCGMjnyHHsV7ntck9s+f7IBBQ71n
	 eUbauaOl4PNSff4XB2vTr4fy8pJXPULJaUwFZEvpdDaiXJRox+pjIYbfZf4h2pINUg
	 tkpoGKt7KqTaeOP0iwNIreYuJQKclXEWgjv7z+gNgsk2aFDE/IWQRzHTg237bJRsZ1
	 teBwzJrZjA9C3a4kJkAOj9OVGlpIrgFQmJT+f0rTG+oeoS0LlPtvCnd372hmZ3umSI
	 Yx/lWbhuPHexw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F849CAC5A7;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v4 0/9] Support Tegra210 actmon for dynamic EMC scaling
Date: Tue, 23 Sep 2025 12:05:26 -0500
Message-Id: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFfT0mgC/12P0W6EIBBFf8XwXJoBBkWf+h9NHxAGl6SuW7Cmz
 cZ/L6tNqn2bO8m5OffOMqVImXXVnSVaYo7TtQR8qpi72OtAPPqSmQSpwUjJZymAWzeP05UrbAE
 dNeTBsULcEoX4tbW9vu050cdnKZ33J+ttJu6mcYxzV5mgLSnwdesbjYqIwDcARnkb0JMJJLTXR
 rOjTFftKqKo0JDsQyffiPzEsYG6FWR641y3IHsoXGKep/S97VvE5vA7xZymLIKXm3rRkhNBIr4
 Mo43vz8V161nkH9uCOrOysMVdK/QYDNn/rDqy9ZlVhRUIStVlayPoyK7r+gNOzL7noQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758647133; l=2651;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=3WlgG06ZOkLQJ3sKxctiH8zHTTaZsOpoBGk+S7tsbOs=;
 b=z0v2a8ImXyw4C7krSyxtVQ46J/3UUsgNQMisJ1gGGvT32B3g3VipgCuObglCK0TjDHHqJGiMC
 jIo42o+zbYpBX3w8datMv6EH/k4yv1l6XSp9oA+5PW5AQcwR8kCIz2h
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
Changes in v4:
- Various cleanups in patch 5 as requested by review
- Fix a couple typos in patch 4
- Link to v3: https://lore.kernel.org/r/20250906-t210-actmon-v3-0-1403365d571e@gmail.com

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
 .../boot/dts/nvidia/tegra210-peripherals-opp.dtsi  | 135 +++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  43 ++++
 drivers/memory/tegra/Kconfig                       |   1 +
 drivers/memory/tegra/tegra210-emc-core.c           | 268 ++++++++++++++++++++-
 drivers/memory/tegra/tegra210-emc.h                |  23 ++
 drivers/memory/tegra/tegra210.c                    | 227 +++++++++++------
 drivers/soc/tegra/fuse/speedo-tegra210.c           |   1 +
 include/dt-bindings/memory/tegra210-mc.h           |  74 ++++++
 10 files changed, 716 insertions(+), 80 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250822-t210-actmon-34904ce7ed0c
prerequisite-change-id: 20250812-tegra210-speedo-470691e8b8cc:v4
prerequisite-patch-id: d32dd215b54ac46086377c1ce2c8d53d746690c9

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



