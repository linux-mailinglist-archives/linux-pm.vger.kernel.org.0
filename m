Return-Path: <linux-pm+bounces-33508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FADBB3D753
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 05:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E371C1898937
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 03:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86120C038;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd/p2rry"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCF1A9F92;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756697664; cv=none; b=A0Kjno57hU98/s+02O7uKnu6OrX8ZjPj4rK4e7ct3Ef5uz/zb5fqnLv7g/b6+k3eIjW2eIIebaxrZ4PJLiaEiOYW6qw+HCUy25+Nj4lpq4iSxJnjzPUhohnZV0UjB5uw0hIYJuum6ZjxL2nGgS4+tDeWE3I+mKyP3L9aJaz7TYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756697664; c=relaxed/simple;
	bh=lTzEzt7B30YSrqMuZRySEr37koys5vP4NQ0cnXVdvZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJ9LK9J/nhPidXFF6mvBfxinZUr+sFRPGW+WCKdCS0kGGja1/wKhmS5Qf/jXCTwlKCxSVtQIvficb9tCMpuUrvPKrOVjGU9VOrEb2+X+slb81vVEKHX+z1XZn9OXKak5lEiyVtpGUNI9UxLFJlF3NWsh1bf/MhJDUD4ITxAw2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd/p2rry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F14BC4CEF8;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756697664;
	bh=lTzEzt7B30YSrqMuZRySEr37koys5vP4NQ0cnXVdvZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fd/p2rryzn9p0v50gWjQVA6Tv6zVsihN+cFiR+gOESjJrDsnJbXQ4T+Qb8lTgpEY5
	 0WhEw+rAvx70RtUco4Oau5R8DywwmeaJKgRNKrRbTxBMhJTEw2TCcqZZ4ILMZhXi6/
	 1Hfn6n87FD1xYVYyu1HCp7GQRcktfqbZddQnY0vPBV7IQD5TioRHLwnaIxsYnvakI7
	 lkQjZ2oz84UlyMHcWR+CpFNLSBw7GEFZ35nHvCTB/4trDXLJv6nFV1S56gN4crW/M2
	 eHiXd1CS6Asw++Hqj3E8tVtNce0E32ygZNN7OeC3OdVuk3R+2562LCNWqM2kSo0PyV
	 krtsZ4EJ3clZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBE7CA0FE8;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 31 Aug 2025 22:33:50 -0500
Subject: [PATCH 2/8] dt-bindings: tegra: Add ICC IDs for dummy memory
 clients for Tegra194
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-tegra186-icc-v1-2-607ddc53b507@gmail.com>
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
In-Reply-To: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756697663; l=911;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=i1j7eBKUtkZ5vfUZNnts2xOfdyQGodjxO0KvmD0RhP4=;
 b=DsCMs3mCHs25MeXk7blwriX5SnFl+i4p+FigIGuQ6iDIVEKzVFl0YJqfY/OQZ+a0hBFREI8bR
 pG3slo4rjT3B/wkmA7gLwUJUKHkMdQuHFkQm/sZFRixKImkWsQcUUTj
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add ICC IDs for dummy software clients representing CCPLEX clusters.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 include/dt-bindings/memory/tegra194-mc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/memory/tegra194-mc.h b/include/dt-bindings/memory/tegra194-mc.h
index eed48b746bc94072a6bd0af7f344dbb6f6618859..a7d97a1a470cd3cfb18c7ef45c421426ea3c7abf 100644
--- a/include/dt-bindings/memory/tegra194-mc.h
+++ b/include/dt-bindings/memory/tegra194-mc.h
@@ -407,4 +407,10 @@
 /* MSS internal memqual MIU6 write clients */
 #define TEGRA194_MEMORY_CLIENT_MIU6W 0xff
 
+/* ICC ID's for dummy MC clients used to represent CPU Clusters */
+#define TEGRA_ICC_MC_CPU_CLUSTER0       1003
+#define TEGRA_ICC_MC_CPU_CLUSTER1       1004
+#define TEGRA_ICC_MC_CPU_CLUSTER2       1005
+#define TEGRA_ICC_MC_CPU_CLUSTER3       1006
+
 #endif

-- 
2.50.1



