Return-Path: <linux-pm+bounces-33317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF46B3A713
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 18:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C603ADBF1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0C32C310;
	Thu, 28 Aug 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXQaLCDX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678CF322DD1;
	Thu, 28 Aug 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400246; cv=none; b=aHjWo3SHpeL/dULwA8dDdOFqGZXHFmtUJBR9xBUgQ67q0e5szlBtsPQDrrUdGFfwjY1293TRXNOq1xTuDH/ZQb72syClM+tiGZnEn0W4R79f8UNARZfAQdHtav63B4HEMSb3lVAIqbl8ORKIW+hDqzuU8ROasj5cyzUUjxUMbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400246; c=relaxed/simple;
	bh=MyGuywaVJRTnrDuohxHecg+wMfhfMcnjDHdSphNISLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=touLe/oiw878fchlwZrOrsU5hteURvmLtHbRfOaPq218gxfQKfzcfqHgMbgJmiVZlI4b8/zjfwkGeUgGfurpjUabfsUChpoz5z1utR3bWpdtAVYQHXbYaC/7XEfioY0vleKxCB89ERwmlcwDmpsnfh6sW9ma4JQZg20nWG3TdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXQaLCDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCE27C4CEEB;
	Thu, 28 Aug 2025 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756400245;
	bh=MyGuywaVJRTnrDuohxHecg+wMfhfMcnjDHdSphNISLY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QXQaLCDXrSNvTZGGSJ04PeY2E5N2CecKyGaPF5I1bMKQnQUOP17iRP98ODBmpBI7L
	 1toEuUbyvT1yGWjs7pX7Zmx9ZIAK5JLmbBsWgyanglknNmpu44nt70Q2P4Vozv6wxG
	 7B1WwdvCs0Y8Pgw5wp2hHi5aPZ86HYD1BtcPCnBuS9aI0J9d/3qh8LUe/rzlvvcK28
	 mx1mNDW907AMJHhbFVN4oe+9lW7Oz47FvaKrYhJDrWm9N1kKkESx6Gb4NCwN2z3cF2
	 +F76GaiZL9AQce89qXS4Yl2ymtZJl/uk1DKn3HVWNk+Q+Vmg8nvtUhO41wPsEYz2X7
	 EbvIY8TVD0DkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D1CA0FF7;
	Thu, 28 Aug 2025 16:57:25 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] cpufreq: tegra186: Fix initialization and scaling
Date: Thu, 28 Aug 2025 11:57:19 -0500
Message-Id: <20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+KsGgC/4WNTQ6CMBCFr0Jm7Zi2xlJceQ/DorRTmET+WiQaw
 t2tXMDl916+9zZIFJkS3IoNIq2ceBwyqFMBrrNDS8g+MyihrsIojQu10Uqj0U2vEGnGwG9KWIY
 mBCOdNlZBlqdIR5HdR52547SM8XP8rPKX/p1cJQqsylAZfyFhfXNve8vPsxt7qPd9/wKAUAMDv
 AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756400245; l=820;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=MyGuywaVJRTnrDuohxHecg+wMfhfMcnjDHdSphNISLY=;
 b=jTkl4Ze5C2Hk4Gg/ssP9hc3eZzVbpeg/G2YMW+0uFbkBSrM1Is5s3uDGl/NemC36ypPtUO2wc
 +E51dc/pgphCnTJY1zDIBifWBCbDNfAi8M2T/L6m6zrLM1j8mr5kqk3
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
Changes in v2:
- Set max freq instead of base freq in patch 2
- Link to v1: https://lore.kernel.org/r/20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com

---
Aaron Kling (2):
      cpufreq: tegra186: Set target frequency for all cpus in policy
      cpufreq: tegra186: Initialize all cores to max frequencies

 drivers/cpufreq/tegra186-cpufreq.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250826-tegra186-cpufreq-fixes-7fbff81c68a2

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



