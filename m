Return-Path: <linux-pm+bounces-34196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D166B4A1F5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A163A9C2B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 06:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B23D302157;
	Tue,  9 Sep 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGCt/yNd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B118A93F;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398894; cv=none; b=QoEzol28lzscz9KKmBkG20mSxWFEniagJrG730Lr+M4mp0tqkWl8qVvaFvMQHpxYL5wtBARGUzeKsE/bgBO6DL/yXqrNsO2pQwabkvL58pBnpTe9N+biETk+PZfFQnILImRlVAJ8K1QOjXG7darWdH+csLhMn5LNOjYZtwR0dlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398894; c=relaxed/simple;
	bh=+TPugvusqL3MFUtqbV61oju44pY2erZnaLrcqrSXMw0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B+LaANm/uHp/v7vRrKBl6PUfqblFtZ4PzUYSE82G7TKWYtXK2rMXnN8f2uIskItG8WmKcJbs0yE5FiD0WRo/HSe9k6ejO4KOPUzUQzkj/KEcVsmMDkrIM8+J+UhhfhDnceVLkzZZwrkWh43hWPo34NwDNN+ocN/EKpTVzEaG3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGCt/yNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58897C4CEF4;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757398894;
	bh=+TPugvusqL3MFUtqbV61oju44pY2erZnaLrcqrSXMw0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MGCt/yNdmcqG8p1qc4nlUUsaE/rji/Hvi2RClXvtcKpZN3sxr7vJ7K4I8jHe9Dn9d
	 eIdlm0AsALNbTHs8ZHZSHAS//iCzJuHXxKnkzJ+kyxLSgiEd/ra2wgBVnwWYfxs2tr
	 Tf5giMSi68afW5b5VdYjcQ1VzwNQbSkw9ZPxfpVY3RzO0Gm8yD+0NV3R3EDmYcmIZF
	 vOawIYCny3gzGzX70P6QC38RR7vWjpVQFdMX1iZjB2Tby6ofifpJwUGCTO11OMbSiG
	 sL1JJeWqJIwgLPV1tvqkHtVhbbj62SYB7DXdO3oDZB/jmpIEA1uz0al/MBi9AVCnvR
	 ohHmk1vWSwFVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449F9CAC586;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 0/8] Support dynamic EMC frequency scaling on
 Tegra186/Tegra194
Date: Tue, 09 Sep 2025 01:21:28 -0500
Message-Id: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjHv2gC/1WPy07DMBBFfyXyGqPxuH4kK/4DdeHHOLVEmtZOI
 1CVf8ckC2B5R5pzz32ySiVTZUP3ZIXWXPN8bQFfOhYu7joSz7FlhoAKLEq+0FicsJrnELjBvhc
 CQjTmxNrLrVDKnzvu/XzkQvdHoy7HkXlXiYd5mvIydMKjNEn0QF5GqZPCmBKBcSfwijwKQAsEw
 P7aNLnDRf+6hNsjtSK+l3OTfEpWBG0dDqtkPyaXXJe5fO07V7GrHBgp/k9aBQeuwcQYlPQKzNs
 4ufzx2pzZedu2b8KgVpoyAQAA
X-Change-ID: 20250823-tegra186-icc-7299110cd774
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757398893; l=1966;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=+TPugvusqL3MFUtqbV61oju44pY2erZnaLrcqrSXMw0=;
 b=iK2GdH/ePzlNW4B7UF/cmnZZrVv0wHjuHNsT2RcusqUZ7OYZEASWN+vKkZAZlkSFPJOfMqxax
 ifP9WYAc3ebDwQHBOwdayPC2FLSYY/fPHm/Hb9Jc2zSqmeV5d+1zJop
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

This series borrows the concept used on Tegra234 to scale EMC based on
CPU frequency and applies it to Tegra186 and Tegra194. Except that the
bpmp on those archs does not support bandwidth manager, so the scaling
iteself is handled similar to how Tegra124 currently works.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Use opp scoped free in patch 3
- Cleanup as requested in patch 3
- Move patch 3 to the start of the series to keep subsystems grouped
- Link to v1: https://lore.kernel.org/r/20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com

---
Aaron Kling (8):
      cpufreq: tegra186: add OPP support and set bandwidth
      dt-bindings: memory: tegra186-mc: Add dummy client IDs for Tegra186
      dt-bindings: memory: tegra194-mc: Add dummy client IDs for Tegra194
      memory: tegra186-emc: Support non-bpmp icc scaling
      memory: tegra186: Support icc scaling
      memory: tegra194: Support icc scaling
      arm64: tegra: Add CPU OPP tables for Tegra186
      arm64: tegra: Add CPU OPP tables for Tegra194

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 317 +++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 636 +++++++++++++++++++++++++++++++
 drivers/cpufreq/tegra186-cpufreq.c       | 152 +++++++-
 drivers/memory/tegra/tegra186-emc.c      | 132 ++++++-
 drivers/memory/tegra/tegra186.c          |  48 +++
 drivers/memory/tegra/tegra194.c          |  59 ++-
 include/dt-bindings/memory/tegra186-mc.h |   4 +
 include/dt-bindings/memory/tegra194-mc.h |   6 +
 8 files changed, 1344 insertions(+), 10 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250823-tegra186-icc-7299110cd774
prerequisite-change-id: 20250826-tegra186-cpufreq-fixes-7fbff81c68a2:v3
prerequisite-patch-id: 74a2633b412b641f9808306cff9b0a697851d6c8
prerequisite-patch-id: 9c52827317f7abfb93885febb1894b40967bd64c

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



