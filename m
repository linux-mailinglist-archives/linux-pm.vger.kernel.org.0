Return-Path: <linux-pm+bounces-33764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADDFB42A34
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C384867D2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B9336998B;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6GZYylD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A60B2DD5F0;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929082; cv=none; b=QFgfjXBKeIlK0WvO64m+YxOxVLs1OGOIMt309sgd8cZSom4dqzmiGMdUR3hmYQLhAi7QmH0GRtoG79gOVi/qgNMXGc2e2CGIJjnP3c0vVLQg1SX27MLBrDMnsJ0sYAi718FTBvy4x8nP29atvOtTbgUZtP25n4M5zQdSCoVWMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929082; c=relaxed/simple;
	bh=WvscYjNV7L8ZvTOF8eWp1hlu2vZN99N5LQ99hENMYGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QP0NbsY74jFZozQYamQrmndOvn7e+UTtjtXCJxKKNr/2EJ9w8C5TSWCUUp8evpzXfMDz6QYsDvDfGbC75KCDF0fbmQjnDnQStywJida+Pl0Mire1ZoRm3g9rKycuD+fIV6HMOmIHq9cok76vwoXl+6pW3J31tpO/PBCtYUEFo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6GZYylD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7196C4CEF4;
	Wed,  3 Sep 2025 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929082;
	bh=WvscYjNV7L8ZvTOF8eWp1hlu2vZN99N5LQ99hENMYGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A6GZYylD3bdjJCC6+NJY7WbXhr7gksG+VjvFiyj65disCEAHkwVZgf2K3w6p0dLRm
	 gaPCkQ7tHH57laUQKrhf+s+mzqwKKfrXZ6zr0ABs8LPVNMxVPnhEvfZjbBQMq+D3Qo
	 1GHD6J4cU5HzZMXeUcP1+xOKbyqWr/WJ56A3dwLOG0/FK3rD1vwc0pnlhYyfy1sceU
	 Iysm1VqQI3Ft1p1YG1kWOJr7ap0tUyEZDSwUQeSGgoCjFumW3SXonL7R73Lki/Iuy+
	 4nlMiyYblO9xOrvnRmXy94fJaH7eaNpQICE3GrecmH7Jsz5rVuzkH5tNCnS627TAEg
	 ssdQUf3twk0rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2849CA1009;
	Wed,  3 Sep 2025 19:51:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 03 Sep 2025 14:50:07 -0500
Subject: [PATCH v2 1/8] dt-bindings: memory: tegra210: Add memory client
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-t210-actmon-v2-1-e0d534d4f8ea@gmail.com>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
In-Reply-To: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756929080; l=2616;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=u4jz33x6Ez21364iFx09PcoppaXBOvLz3qVMpDfajQM=;
 b=jwCuxoaY3bOoo8wi4XjARXBSG/QkzkFM5CtaxIZHz+MOPAKmpnL3LAHrzhPLHPWcX020Nnxpk
 zledt4VNotnCt6ZZN/K2+TFgiAVHB4T91Crx4o4ltK6kIY4MLsqFqyq
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Each memory client has unique hardware ID, add these IDs.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 include/dt-bindings/memory/tegra210-mc.h | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/dt-bindings/memory/tegra210-mc.h b/include/dt-bindings/memory/tegra210-mc.h
index 5e082547f1794cba1f72872782e04d8747863b6d..48474942a000e049142014e3bcc132b88bf1a92d 100644
--- a/include/dt-bindings/memory/tegra210-mc.h
+++ b/include/dt-bindings/memory/tegra210-mc.h
@@ -75,4 +75,62 @@
 #define TEGRA210_MC_RESET_ETR		28
 #define TEGRA210_MC_RESET_TSECB		29
 
+#define TEGRA210_MC_PTCR		0
+#define TEGRA210_MC_DISPLAY0A		1
+#define TEGRA210_MC_DISPLAY0AB		2
+#define TEGRA210_MC_DISPLAY0B		3
+#define TEGRA210_MC_DISPLAY0BB		4
+#define TEGRA210_MC_DISPLAY0C		5
+#define TEGRA210_MC_DISPLAY0CB		6
+#define TEGRA210_MC_AFIR		14
+#define TEGRA210_MC_AVPCARM7R		15
+#define TEGRA210_MC_DISPLAYHC		16
+#define TEGRA210_MC_DISPLAYHCB		17
+#define TEGRA210_MC_HDAR		21
+#define TEGRA210_MC_HOST1XDMAR		22
+#define TEGRA210_MC_HOST1XR		23
+#define TEGRA210_MC_NVENCSRD		28
+#define TEGRA210_MC_PPCSAHBDMAR		29
+#define TEGRA210_MC_PPCSAHBSLVR		30
+#define TEGRA210_MC_SATAR		31
+#define TEGRA210_MC_MPCORER		39
+#define TEGRA210_MC_NVENCSWR		43
+#define TEGRA210_MC_AFIW		49
+#define TEGRA210_MC_AVPCARM7W		50
+#define TEGRA210_MC_HDAW		53
+#define TEGRA210_MC_HOST1XW		54
+#define TEGRA210_MC_MPCOREW		57
+#define TEGRA210_MC_PPCSAHBDMAW		59
+#define TEGRA210_MC_PPCSAHBSLVW		60
+#define TEGRA210_MC_SATAW		61
+#define TEGRA210_MC_ISPRA		68
+#define TEGRA210_MC_ISPWA		70
+#define TEGRA210_MC_ISPWB		71
+#define TEGRA210_MC_XUSB_HOSTR		74
+#define TEGRA210_MC_XUSB_HOSTW		75
+#define TEGRA210_MC_XUSB_DEVR		76
+#define TEGRA210_MC_XUSB_DEVW		77
+#define TEGRA210_MC_ISPRAB		78
+#define TEGRA210_MC_ISPWAB		80
+#define TEGRA210_MC_ISPWBB		81
+#define TEGRA210_MC_TSECSRD		84
+#define TEGRA210_MC_TSECSWR		85
+#define TEGRA210_MC_A9AVPSCR		86
+#define TEGRA210_MC_A9AVPSCW		87
+#define TEGRA210_MC_GPUSRD		88
+#define TEGRA210_MC_GPUSWR		89
+#define TEGRA210_MC_DISPLAYT		90
+#define TEGRA210_MC_SDMMCRA		96
+#define TEGRA210_MC_SDMMCRAA		97
+#define TEGRA210_MC_SDMMCR		98
+#define TEGRA210_MC_SDMMCRAB		99
+#define TEGRA210_MC_SDMMCWA		100
+#define TEGRA210_MC_SDMMCWAA		101
+#define TEGRA210_MC_SDMMCW		102
+#define TEGRA210_MC_SDMMCWAB		103
+#define TEGRA210_MC_VICSRD		108
+#define TEGRA210_MC_VICSWR		109
+#define TEGRA210_MC_VIW			114
+#define TEGRA210_MC_DISPLAYD		115
+
 #endif

-- 
2.50.1



