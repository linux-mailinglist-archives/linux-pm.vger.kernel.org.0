Return-Path: <linux-pm+bounces-33132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0CB373B3
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 22:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF01684B4
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382127B323;
	Tue, 26 Aug 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpkkL+vP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C81E1E1C;
	Tue, 26 Aug 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239383; cv=none; b=Up/CjsPZupdV5016t7oHgl9e+E6QNBKs4QArnpZ3DzJOWOKxRbBczVq//2HRvcMYQYDsQZ2JvjriQ7OosJUqr0LHSojD3sn0dx5whcXyTolvH/7Fc3MdPcsNlNOyiXrxQUlcI4l/vEXtgk7pff7y78f1QFWK4aesx9W+o8t511w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239383; c=relaxed/simple;
	bh=oVlsbr0Om4iJks3GxT0/vdOhBTnl82lkeLSHLSp9gLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fPGKYec61tsyieI1AXPYbEEZTZM+JaEIvajMOBoiKglcv/1TroGEXbxGXdKGGX+v/y5XJ/ph+w58dBV94FatyA6+niOfV/TmBEmxOt0urIcaB4RmkgRrVxlnVzpQiMnE3HlWT4a28oJ8er0aDW/J/IcL8N6gfqKkLocOi35ZrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpkkL+vP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A70E7C4CEF1;
	Tue, 26 Aug 2025 20:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756239382;
	bh=oVlsbr0Om4iJks3GxT0/vdOhBTnl82lkeLSHLSp9gLY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QpkkL+vPRt6pHKcbP9uQQdLTsaJCV5XmSd58KL0cM/7EXXD5OsOCkOdcv/JaI7LRv
	 4x0LphWz71fZX1HjqGPgqPcpKqX3JzNdlSdckmjs8cQRubw5KBpCJCsvpvxdjSiaaC
	 ZJCtxOPrZOqTtP8XTfOZEOu+3vrTZd5YqzvWCGG7KIOms3MKPvO9G3/af4kxXz7PDR
	 l6GWrqDmuPZGS+I8QXTCmMvF72m0bpapz24Q6rtBa9JaVoXGKB/XD0FJ2+ijbHuELE
	 ONTlkZLV6BkD+rTFNRXBnLTIg6fdIIKQzOk6IqsGhwGrkRu2bAQ+4Li46kBDUHENBI
	 tW4Wm6Xhf9U0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D46CA0FF0;
	Tue, 26 Aug 2025 20:16:22 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH 0/2] cpufreq: tegra186: Fix initialization and scaling
Date: Tue, 26 Aug 2025 15:15:58 -0500
Message-Id: <20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP4VrmgC/x3LSwqAMAwA0atI1gZswVq8irioNdFs/KQqgnh3i
 8vHMA8kUqEEbfGA0iVJ1iXDlAXEOSwToYzZYCtbV946PGjSYLzDuJ2stCPLTQkbHpi9ic4HC3n
 elP6Q365/3w/l+hYNaAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756239382; l=642;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=oVlsbr0Om4iJks3GxT0/vdOhBTnl82lkeLSHLSp9gLY=;
 b=d0y1cj3ZkD/6aUt8GB3zzQTUIqnLEBNCe3MPJ4VbUdTLeQrc51CV9spvqZVqsh390XQB1Chh5
 CEiqpLaufuZBR41VwhRHMCw2W3CqPKrdcp4Cl0ushvieYvHN/Bj0EE5
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
Aaron Kling (2):
      cpufreq: tegra186: Set target frequency for all cpus in policy
      cpufreq: tegra186: Initialize all cores to base frequencies

 drivers/cpufreq/tegra186-cpufreq.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250826-tegra186-cpufreq-fixes-7fbff81c68a2

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



