Return-Path: <linux-pm+bounces-33509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B26CB3D755
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 05:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA243A8DF7
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 03:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974372144CF;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3cDlirA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACD72618;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756697664; cv=none; b=OenN5vHv6VsHGzP60twqiQxgmQmRRia7vzXBrzlTAc5359jOnfJN4Yl3TTDsGHfvT6SxEiPfB3k9dbTzLYF7vi86LHU7WakDrd0FFnHOwunPq5b5hcAxt7yxMFYyfJAT3oepo8csARzDvbIDxiZcFZnGzOAE29Ih4UVszvgFns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756697664; c=relaxed/simple;
	bh=k7zHlBypQOJw+s2CfqMrmnR8tEArANEnYoH9usBkZQs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=plb+zLtM9d9M3hL8KqJ0jBVRVl0duh+f1z+TzsBs2uli7TtnlQtZhYrYh+3RQyTku5fxqiZtkeJ3cL+ArXeGrsqmfa1GRxP+RrD8WUKbR6O2HtmBgvmoSEsUT31Sk/76d0TRh7KjdowJulXHPxZGZo3KVDZvQdLNoYuG3hos8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3cDlirA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DA78C4CEF0;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756697664;
	bh=k7zHlBypQOJw+s2CfqMrmnR8tEArANEnYoH9usBkZQs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=M3cDlirArTkAsEM6e2vR8Euxl2inbN1SEuUq0K7ySbpJGWv2LSxjEZmRkrk4rkQLg
	 sBR2W4PM5EKpron5J1M2P2811Ffv1afPuEYCqxDt/GuX6qEKdjZLDfTAdzxEHq1btn
	 Zwuf9wIpYY4+O4k9WnQuK9CgIlY33XfGqOSa/xTeKmzZTn7uaUjeDvXocQKANn6WkT
	 MAA/xjvW6r/LrvN1RFBDYX0hLORzDDjYr97bwfQu3MdeMzjdDI0uOUc6YDYVjyx2lW
	 nZ6L3gLyKbWoia8uvFlcFcL2YYNSDtJ91+nNJvEp0SKQ9qDKXitfOmcUf7VX3tFIDQ
	 BzqslBPGYHe3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED91FCA0FF0;
	Mon,  1 Sep 2025 03:34:23 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH 0/8] Support dynamic EMC frequency scaling on
 Tegra186/Tegra194
Date: Sun, 31 Aug 2025 22:33:48 -0500
Message-Id: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwUtWgC/02OQQ6CMBBFr0JmbZPpFGjhKsZFW2a0C0ELEhPC3
 W3URJdvkvnvbTBzTjxDX22QeU1zmsYC+lBBvPjxzCoNhYGQGnRk1MLn7LVrVYpRWeo6rTEO1tZ
 QXm6ZJT3fc8fThzPfH2V1+Rwh+JlVnK7XtBRLIGNFd8jBDKaVhgYRRutrDA0H0kgOGRH+a/rq2
 9L+WuLtIUWk3nJlJYg4HVvnqV8NnPb9Be1Jx8foAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756697663; l=1717;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=k7zHlBypQOJw+s2CfqMrmnR8tEArANEnYoH9usBkZQs=;
 b=4JOx4ljS41aHjmUu7nGdLiySrCSanKtMCBOeNESG19KQW8+6Duw0XnSGaV6BozWSuo2dyYMXX
 /JJiP7WAV26BLPDulgpy4P1EKVZagdpukdmHQqK2HpjK+9p7KLmSXnL
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
Aaron Kling (8):
      dt-bindings: tegra: Add ICC IDs for dummy memory clients for Tegra186
      dt-bindings: tegra: Add ICC IDs for dummy memory clients for Tegra194
      cpufreq: tegra186: add OPP support and set bandwidth
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



