Return-Path: <linux-pm+bounces-34079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C414FB476FD
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 22:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23321B27999
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 20:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D8229B8CE;
	Sat,  6 Sep 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSXlFJXv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F71F0E50;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757189856; cv=none; b=seRjS5UHdN0SDvfUFelvLE0K728tTDIsvblfOIfIsrEOTXTiHVhIbDyP6Jjao1F3Ngh5tRZIKHZemJOcBIpkRVpHrz5P22W0nZAZHb6uhAu4MkxaIoJ/NizgJdRYR/VopLsNGG4NUQOy3tVveukdBoRGfAjdPGGkVdc6BXzfHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757189856; c=relaxed/simple;
	bh=fPjs/XG/sJ2XmfKguWHPxGXL7nxrYvrB/znH0ZVkJL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lr1VGyvt85THAJI2Bqmp7FIHj6j2U4dUQxoBAxm+COytyYKJ/W/aUsLaDZQXdZtE2M01gsIGOeSM2N31z/xlj+D/2r63I+DaqVg0+6BggDaQIw+UJE9P3mRwkCYWJ2muSZ4bUHSHFhLSvjd5EsFbv/GUbg+WtUcW9saNdaZvrck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSXlFJXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 907D7C4CEFD;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757189855;
	bh=fPjs/XG/sJ2XmfKguWHPxGXL7nxrYvrB/znH0ZVkJL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fSXlFJXvdTxDjiaCVKYVFuiCZJiQlT/GI9dartYMJQ54PZkzIYZMyK+Od0h+ovY5l
	 Q7qv0BhdJATs4Iup/A5+1IwlI7JOs7ytCwYBjrlGVpQssy7sM4aCtArplg0h129ZLQ
	 JukrdiQRAbCHZ34SUwxUgxz6i2NA3D3FgxMMpSNZhLcbVRoB89nLGSVDU5kZTDuJV2
	 Ep+urTZBqH4qsQdZDD62SNbbFcdKUefUtMBpW6aT7F5h8TjQ7qZV+3LhN5szChjesF
	 pkygmZKgYKQbhP+DnzzWiD9rP7zX/Eqv6kwYQo5VfO6+Hphi4/+TGsdqoSr/M6u22M
	 w5/0FciVEdUkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E994CA1002;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sat, 06 Sep 2025 15:16:53 -0500
Subject: [PATCH v3 3/9] dt-bindings: memory: tegra210: Add memory client
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-t210-actmon-v3-3-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
In-Reply-To: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757189854; l=3162;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=diJJeMdgP073EZ/ZsibqT6kTrEivDt/XgCP+oRB8GuY=;
 b=5NhiBrfv8x3jKspeMBmIqwZcoBUAoTn+4QYvuhcesLc0PW1SQIIMDfhvUD4vhq96Ljaagv6hy
 0GH5/lyBUCoDEEh/iRG7aNcpPSe0mSHIz58ME8z/ulRVuwzbUoLT4sB
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
 include/dt-bindings/memory/tegra210-mc.h | 74 ++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/dt-bindings/memory/tegra210-mc.h b/include/dt-bindings/memory/tegra210-mc.h
index 5e082547f1794cba1f72872782e04d8747863b6d..881bf78aa8b2636bb71954968b0251145d72fecd 100644
--- a/include/dt-bindings/memory/tegra210-mc.h
+++ b/include/dt-bindings/memory/tegra210-mc.h
@@ -75,4 +75,78 @@
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
+#define TEGRA210_MC_NVDECSRD		120
+#define TEGRA210_MC_NVDECSWR		121
+#define TEGRA210_MC_APER		122
+#define TEGRA210_MC_APEW		123
+#define TEGRA210_MC_NVJPGRD		126
+#define TEGRA210_MC_NVJPGWR		127
+#define TEGRA210_MC_SESRD		128
+#define TEGRA210_MC_SESWR		129
+#define TEGRA210_MC_AXIAPR		130
+#define TEGRA210_MC_AXIAPW		131
+#define TEGRA210_MC_ETRR		132
+#define TEGRA210_MC_ETRW		133
+#define TEGRA210_MC_TSECSRDB		134
+#define TEGRA210_MC_TSECSWRB		135
+#define TEGRA210_MC_GPUSRD2		136
+#define TEGRA210_MC_GPUSWR2		137
+
 #endif

-- 
2.50.1



