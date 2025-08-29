Return-Path: <linux-pm+bounces-33354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371AAB3B124
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 04:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058E3582FB2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917C421E0AF;
	Fri, 29 Aug 2025 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slMLHvHy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF74202C2B;
	Fri, 29 Aug 2025 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435696; cv=none; b=kYWy5fmuUm6do44z+tEt17tFQo6em017gVEGaVekHzFEIpetVLFynBFFAJa6z7Fmujmquj3a3FAroNQzbBFNmDDyXDREajfWHqfZveIsc9e2rcuTDx6XnzN9w6UnsK4x5AZwp+3PYjpsOIZ9BMYzZ04ez5rb8wQopBsuDtgPyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435696; c=relaxed/simple;
	bh=F7mq3mQpR2KiFF/AsoLrSfDqZtvtQRQwU8TA3URhotg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iNB3zT1DqjS50o/kDBl+SNkF67/kXpU7AB/h9WddmLeZ77GqQmkYEh0xStfE5r+s4JuJypz/UVbYGx6QjiZiXBpp3ZOdmnetK0oJaxvleLq3rPWR5TgMEPTKFpJHdXadSd6XRPHgK3QiX9FFwSH7+10llpEoHtpl/Hj3DlSnbng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slMLHvHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6A8BC4CEEB;
	Fri, 29 Aug 2025 02:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756435694;
	bh=F7mq3mQpR2KiFF/AsoLrSfDqZtvtQRQwU8TA3URhotg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=slMLHvHyafDhPCe0/9oRwMQ2RedSYZsT+qxvwejiuTQF6Wb+dDxq6vODJcy9cmRxu
	 3ozzxwpI/u/ZS0LEGDbX/5JMSRhhlqRlyni0bBRByRwGSB7vgfPg4OroxC5/FkpwX8
	 +Lc3+GLSgkYT7rQS9tPwLjE096tbF/e6I7uH9KOeYj1VvLlWQLmbdRfXLa/X6u6YHe
	 USX0npNafB3OcGXgyT05Gr93xK7/pz96lmYg337GEGkp0Klu7Yl9ESgb8dOg49Fbep
	 8psESQSkj487WDX3qqR62W4FwbJdZ29Oo+an244qxOko/JSiuyncgfnzjGOu0LOsIP
	 FNtpRnhU/XgtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1554C8303F;
	Fri, 29 Aug 2025 02:48:14 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] cpufreq: tegra186: Fix initialization and scaling
Date: Thu, 28 Aug 2025 21:48:11 -0500
Message-Id: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsUsWgC/4XNTQ6CMBAF4KuYrq1pi0Bx5T2Mi9LOwCTyY4uNh
 nB3Cys2xuV7k/fNzAJ4gsAuh5l5iBRo6FPIjgdmW9M3wMmlzJRQudCq4BM03khdcDu+0MOTI70
 h8BJrRC1toY1iaTx62A5pe7un3FKYBv/Z/kS5tn/JKLngVYmVdhkI4+pr0xl6nOzQsZWMas/on
 4xKDFpEODuQIPM9syzLF+p8uT0DAQAA
X-Change-ID: 20250826-tegra186-cpufreq-fixes-7fbff81c68a2
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <luceoscutum@gmail.com>, 
 Sumit Gupta <sumitg@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756435694; l=1054;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=F7mq3mQpR2KiFF/AsoLrSfDqZtvtQRQwU8TA3URhotg=;
 b=hcKAb77AQTURPlJpbuRsaDf23cZNJC0uF3xq1QlBO+4Q1VRhNuTeQHpmXNZ4jVjEyAgD+AEq7
 Wi0QuMejFeZBR2lqd5CUVhAlkWGvjLMtIkcpD6XCw07MIo0qWZGINYQ
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

This series fixes an issue with shared policy per cluster not scaling
all cpus and with some cores being initialized by the subsystem.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v3:
- Use more clearly named variables in patch 2
- In patch 2, fail probe if no cpu rates reported by bpmp
- Link to v2: https://lore.kernel.org/r/20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com

Changes in v2:
- Set max freq instead of base freq in patch 2
- Link to v1: https://lore.kernel.org/r/20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com

---
Aaron Kling (2):
      cpufreq: tegra186: Set target frequency for all cpus in policy
      cpufreq: tegra186: Initialize all cores to max frequencies

 drivers/cpufreq/tegra186-cpufreq.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250826-tegra186-cpufreq-fixes-7fbff81c68a2

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



