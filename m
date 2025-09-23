Return-Path: <linux-pm+bounces-35246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F7B96EA3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6441E19C58A5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFCC2773D1;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTwfp26Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D325EFBC;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647135; cv=none; b=TuoT0OF49/guvZn3+dPkzPrnTXBjGkeNS0PagE/7IRDfgEnQweOdmUShNSBzoS14pXMt8h2gDOXHBn8+XuYCrQnuV/ASMjgK2yCmto1LzKyOYQbBZ8UUvtIc2xbovdnoWPyJFxOCvRsq1PG5cN9PqUcIrMVxQZfGs3Jpf8d47Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647135; c=relaxed/simple;
	bh=rG4+omkF84SilAm2tXPH/yWo7/93onr5c13GGKcL5xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouZyClkmRrIIKAoxO+yQBa1QyOeb57SbhCEKn/n4CykaU9ci6MTsCwwoPMQK02gYNfBvrDOt+LFNgxOJqFwnp+4CkQhvDgfqCw/ta0wgp+RjlDWcb5f4scvG8N19DYZUlJw5C3Nc4ZLUKwgRuH6FJ4I9aaoHb0kmy7aWt8yGMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTwfp26Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0E4AC4AF0B;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647134;
	bh=rG4+omkF84SilAm2tXPH/yWo7/93onr5c13GGKcL5xc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YTwfp26QxXCJASw8NJFFSRAE755I2uO6yPKtt6UFG8k7a+Arvne0/ibvjOQrkHzlX
	 toMUqKYu93om4t36kd3JeXywJRl1suA95Epo0mXaMq4rYgr7quwEPxjw2o3M2/r5Rm
	 RxBpTjUYHp8fs7L8+VJsWPYpCiKM1kV2WBgDSKPIX6KDq+TdvLNT2aYuSlqpFe03Jo
	 EQWN/G+IE309bmVC1Q9wwT98hhobcd2pYpbhccr4rQ2oRbVLeaWwlp52ChXK/fuBNa
	 p5ko3QNPKPUrDwiGjZMN4bohVOZk0fxHC0vRH9zn0WW5w1sjOuxjD5lB6CYSKUVg9f
	 0pkSd3qTuerKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB98CAC5B3;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 23 Sep 2025 12:05:30 -0500
Subject: [PATCH v4 4/9] memory: tegra210: Use bindings for client ids
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-t210-actmon-v4-4-442d1eb6377c@gmail.com>
References: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
In-Reply-To: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758647133; l=16920;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=yLZZH3d2tuTDNl+jOJGGAmur2VSUWoWP3XBgx8EZyDw=;
 b=3vrrQ8IHaXmJ1JOhNf9t24Z4XQy1tjNHcHU1Xk2WtxqgDG8L4VN5c6nzdZxZVvF+Pwc1ElHtF
 /LGon4P7jPtAPGWHBvz0+quJaHUzmOt/+uaO6ZBML1x+bUYckdmi5Uw
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Since the related binding is being added, use that for the client ids
instead of hardcoded magic numbers.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/memory/tegra/tegra210.c | 146 ++++++++++++++++++++--------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index 8ab6498dbe7d2f410d4eb262926c18b77edb0b3d..3c2949c16fdef4911682da5e3cbfb91899e34c87 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -9,11 +9,11 @@
 
 static const struct tegra_mc_client tegra210_mc_clients[] = {
 	{
-		.id = 0x00,
+		.id = TEGRA210_MC_PTCR,
 		.name = "ptcr",
 		.swgroup = TEGRA_SWGROUP_PTC,
 	}, {
-		.id = 0x01,
+		.id = TEGRA210_MC_DISPLAY0A,
 		.name = "display0a",
 		.swgroup = TEGRA_SWGROUP_DC,
 		.regs = {
@@ -29,7 +29,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x02,
+		.id = TEGRA210_MC_DISPLAY0AB,
 		.name = "display0ab",
 		.swgroup = TEGRA_SWGROUP_DCB,
 		.regs = {
@@ -45,7 +45,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x03,
+		.id = TEGRA210_MC_DISPLAY0B,
 		.name = "display0b",
 		.swgroup = TEGRA_SWGROUP_DC,
 		.regs = {
@@ -61,7 +61,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x04,
+		.id = TEGRA210_MC_DISPLAY0BB,
 		.name = "display0bb",
 		.swgroup = TEGRA_SWGROUP_DCB,
 		.regs = {
@@ -77,7 +77,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x05,
+		.id = TEGRA210_MC_DISPLAY0C,
 		.name = "display0c",
 		.swgroup = TEGRA_SWGROUP_DC,
 		.regs = {
@@ -93,7 +93,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x06,
+		.id = TEGRA210_MC_DISPLAY0CB,
 		.name = "display0cb",
 		.swgroup = TEGRA_SWGROUP_DCB,
 		.regs = {
@@ -109,7 +109,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x0e,
+		.id = TEGRA210_MC_AFIR,
 		.name = "afir",
 		.swgroup = TEGRA_SWGROUP_AFI,
 		.regs = {
@@ -125,7 +125,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x0f,
+		.id = TEGRA210_MC_AVPCARM7R,
 		.name = "avpcarm7r",
 		.swgroup = TEGRA_SWGROUP_AVPC,
 		.regs = {
@@ -141,7 +141,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x10,
+		.id = TEGRA210_MC_DISPLAYHC,
 		.name = "displayhc",
 		.swgroup = TEGRA_SWGROUP_DC,
 		.regs = {
@@ -157,7 +157,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x11,
+		.id = TEGRA210_MC_DISPLAYHCB,
 		.name = "displayhcb",
 		.swgroup = TEGRA_SWGROUP_DCB,
 		.regs = {
@@ -173,7 +173,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x15,
+		.id = TEGRA210_MC_HDAR,
 		.name = "hdar",
 		.swgroup = TEGRA_SWGROUP_HDA,
 		.regs = {
@@ -189,7 +189,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x16,
+		.id = TEGRA210_MC_HOST1XDMAR,
 		.name = "host1xdmar",
 		.swgroup = TEGRA_SWGROUP_HC,
 		.regs = {
@@ -205,7 +205,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x17,
+		.id = TEGRA210_MC_HOST1XR,
 		.name = "host1xr",
 		.swgroup = TEGRA_SWGROUP_HC,
 		.regs = {
@@ -221,7 +221,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x1c,
+		.id = TEGRA210_MC_NVENCSRD,
 		.name = "nvencsrd",
 		.swgroup = TEGRA_SWGROUP_NVENC,
 		.regs = {
@@ -237,7 +237,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x1d,
+		.id = TEGRA210_MC_PPCSAHBDMAR,
 		.name = "ppcsahbdmar",
 		.swgroup = TEGRA_SWGROUP_PPCS,
 		.regs = {
@@ -253,7 +253,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x1e,
+		.id = TEGRA210_MC_PPCSAHBSLVR,
 		.name = "ppcsahbslvr",
 		.swgroup = TEGRA_SWGROUP_PPCS,
 		.regs = {
@@ -269,7 +269,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x1f,
+		.id = TEGRA210_MC_SATAR,
 		.name = "satar",
 		.swgroup = TEGRA_SWGROUP_SATA,
 		.regs = {
@@ -285,7 +285,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x27,
+		.id = TEGRA210_MC_MPCORER,
 		.name = "mpcorer",
 		.swgroup = TEGRA_SWGROUP_MPCORE,
 		.regs = {
@@ -297,7 +297,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x2b,
+		.id = TEGRA210_MC_NVENCSWR,
 		.name = "nvencswr",
 		.swgroup = TEGRA_SWGROUP_NVENC,
 		.regs = {
@@ -313,7 +313,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x31,
+		.id = TEGRA210_MC_AFIW,
 		.name = "afiw",
 		.swgroup = TEGRA_SWGROUP_AFI,
 		.regs = {
@@ -329,7 +329,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x32,
+		.id = TEGRA210_MC_AVPCARM7W,
 		.name = "avpcarm7w",
 		.swgroup = TEGRA_SWGROUP_AVPC,
 		.regs = {
@@ -345,7 +345,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x35,
+		.id = TEGRA210_MC_HDAW,
 		.name = "hdaw",
 		.swgroup = TEGRA_SWGROUP_HDA,
 		.regs = {
@@ -361,7 +361,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x36,
+		.id = TEGRA210_MC_HOST1XW,
 		.name = "host1xw",
 		.swgroup = TEGRA_SWGROUP_HC,
 		.regs = {
@@ -377,7 +377,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x39,
+		.id = TEGRA210_MC_MPCOREW,
 		.name = "mpcorew",
 		.swgroup = TEGRA_SWGROUP_MPCORE,
 		.regs = {
@@ -389,7 +389,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x3b,
+		.id = TEGRA210_MC_PPCSAHBDMAW,
 		.name = "ppcsahbdmaw",
 		.swgroup = TEGRA_SWGROUP_PPCS,
 		.regs = {
@@ -405,7 +405,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x3c,
+		.id = TEGRA210_MC_PPCSAHBSLVW,
 		.name = "ppcsahbslvw",
 		.swgroup = TEGRA_SWGROUP_PPCS,
 		.regs = {
@@ -421,7 +421,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x3d,
+		.id = TEGRA210_MC_SATAW,
 		.name = "sataw",
 		.swgroup = TEGRA_SWGROUP_SATA,
 		.regs = {
@@ -437,7 +437,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x44,
+		.id = TEGRA210_MC_ISPRA,
 		.name = "ispra",
 		.swgroup = TEGRA_SWGROUP_ISP2,
 		.regs = {
@@ -453,7 +453,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x46,
+		.id = TEGRA210_MC_ISPWA,
 		.name = "ispwa",
 		.swgroup = TEGRA_SWGROUP_ISP2,
 		.regs = {
@@ -469,7 +469,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x47,
+		.id = TEGRA210_MC_ISPWB,
 		.name = "ispwb",
 		.swgroup = TEGRA_SWGROUP_ISP2,
 		.regs = {
@@ -485,7 +485,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x4a,
+		.id = TEGRA210_MC_XUSB_HOSTR,
 		.name = "xusb_hostr",
 		.swgroup = TEGRA_SWGROUP_XUSB_HOST,
 		.regs = {
@@ -501,7 +501,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x4b,
+		.id = TEGRA210_MC_XUSB_HOSTW,
 		.name = "xusb_hostw",
 		.swgroup = TEGRA_SWGROUP_XUSB_HOST,
 		.regs = {
@@ -517,7 +517,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x4c,
+		.id = TEGRA210_MC_XUSB_DEVR,
 		.name = "xusb_devr",
 		.swgroup = TEGRA_SWGROUP_XUSB_DEV,
 		.regs = {
@@ -533,7 +533,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x4d,
+		.id = TEGRA210_MC_XUSB_DEVW,
 		.name = "xusb_devw",
 		.swgroup = TEGRA_SWGROUP_XUSB_DEV,
 		.regs = {
@@ -549,7 +549,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x4e,
+		.id = TEGRA210_MC_ISPRAB,
 		.name = "isprab",
 		.swgroup = TEGRA_SWGROUP_ISP2B,
 		.regs = {
@@ -565,7 +565,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x50,
+		.id = TEGRA210_MC_ISPWAB,
 		.name = "ispwab",
 		.swgroup = TEGRA_SWGROUP_ISP2B,
 		.regs = {
@@ -581,7 +581,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x51,
+		.id = TEGRA210_MC_ISPWBB,
 		.name = "ispwbb",
 		.swgroup = TEGRA_SWGROUP_ISP2B,
 		.regs = {
@@ -597,7 +597,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x54,
+		.id = TEGRA210_MC_TSECSRD,
 		.name = "tsecsrd",
 		.swgroup = TEGRA_SWGROUP_TSEC,
 		.regs = {
@@ -613,7 +613,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x55,
+		.id = TEGRA210_MC_TSECSWR,
 		.name = "tsecswr",
 		.swgroup = TEGRA_SWGROUP_TSEC,
 		.regs = {
@@ -629,7 +629,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x56,
+		.id = TEGRA210_MC_A9AVPSCR,
 		.name = "a9avpscr",
 		.swgroup = TEGRA_SWGROUP_A9AVP,
 		.regs = {
@@ -645,7 +645,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x57,
+		.id = TEGRA210_MC_A9AVPSCW,
 		.name = "a9avpscw",
 		.swgroup = TEGRA_SWGROUP_A9AVP,
 		.regs = {
@@ -661,7 +661,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x58,
+		.id = TEGRA210_MC_GPUSRD,
 		.name = "gpusrd",
 		.swgroup = TEGRA_SWGROUP_GPU,
 		.regs = {
@@ -678,7 +678,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x59,
+		.id = TEGRA210_MC_GPUSWR,
 		.name = "gpuswr",
 		.swgroup = TEGRA_SWGROUP_GPU,
 		.regs = {
@@ -695,7 +695,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x5a,
+		.id = TEGRA210_MC_DISPLAYT,
 		.name = "displayt",
 		.swgroup = TEGRA_SWGROUP_DC,
 		.regs = {
@@ -711,7 +711,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x60,
+		.id = TEGRA210_MC_SDMMCRA,
 		.name = "sdmmcra",
 		.swgroup = TEGRA_SWGROUP_SDMMC1A,
 		.regs = {
@@ -727,7 +727,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x61,
+		.id = TEGRA210_MC_SDMMCRAA,
 		.name = "sdmmcraa",
 		.swgroup = TEGRA_SWGROUP_SDMMC2A,
 		.regs = {
@@ -743,7 +743,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x62,
+		.id = TEGRA210_MC_SDMMCR,
 		.name = "sdmmcr",
 		.swgroup = TEGRA_SWGROUP_SDMMC3A,
 		.regs = {
@@ -759,7 +759,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x63,
+		.id = TEGRA210_MC_SDMMCRAB,
 		.swgroup = TEGRA_SWGROUP_SDMMC4A,
 		.name = "sdmmcrab",
 		.regs = {
@@ -775,7 +775,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x64,
+		.id = TEGRA210_MC_SDMMCWA,
 		.name = "sdmmcwa",
 		.swgroup = TEGRA_SWGROUP_SDMMC1A,
 		.regs = {
@@ -791,7 +791,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x65,
+		.id = TEGRA210_MC_SDMMCWAA,
 		.name = "sdmmcwaa",
 		.swgroup = TEGRA_SWGROUP_SDMMC2A,
 		.regs = {
@@ -807,7 +807,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x66,
+		.id = TEGRA210_MC_SDMMCW,
 		.name = "sdmmcw",
 		.swgroup = TEGRA_SWGROUP_SDMMC3A,
 		.regs = {
@@ -823,7 +823,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x67,
+		.id = TEGRA210_MC_SDMMCWAB,
 		.name = "sdmmcwab",
 		.swgroup = TEGRA_SWGROUP_SDMMC4A,
 		.regs = {
@@ -839,7 +839,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x6c,
+		.id = TEGRA210_MC_VICSRD,
 		.name = "vicsrd",
 		.swgroup = TEGRA_SWGROUP_VIC,
 		.regs = {
@@ -855,7 +855,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x6d,
+		.id = TEGRA210_MC_VICSWR,
 		.name = "vicswr",
 		.swgroup = TEGRA_SWGROUP_VIC,
 		.regs = {
@@ -871,7 +871,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x72,
+		.id = TEGRA210_MC_VIW,
 		.name = "viw",
 		.swgroup = TEGRA_SWGROUP_VI,
 		.regs = {
@@ -887,7 +887,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x73,
+		.id = TEGRA210_MC_DISPLAYD,
 		.name = "displayd",
 		.swgroup = TEGRA_SWGROUP_DC,
 		.regs = {
@@ -903,7 +903,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x78,
+		.id = TEGRA210_MC_NVDECSRD,
 		.name = "nvdecsrd",
 		.swgroup = TEGRA_SWGROUP_NVDEC,
 		.regs = {
@@ -919,7 +919,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x79,
+		.id = TEGRA210_MC_NVDECSWR,
 		.name = "nvdecswr",
 		.swgroup = TEGRA_SWGROUP_NVDEC,
 		.regs = {
@@ -935,7 +935,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x7a,
+		.id = TEGRA210_MC_APER,
 		.name = "aper",
 		.swgroup = TEGRA_SWGROUP_APE,
 		.regs = {
@@ -951,7 +951,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x7b,
+		.id = TEGRA210_MC_APEW,
 		.name = "apew",
 		.swgroup = TEGRA_SWGROUP_APE,
 		.regs = {
@@ -967,7 +967,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x7e,
+		.id = TEGRA210_MC_NVJPGRD,
 		.name = "nvjpgsrd",
 		.swgroup = TEGRA_SWGROUP_NVJPG,
 		.regs = {
@@ -983,7 +983,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x7f,
+		.id = TEGRA210_MC_NVJPGWR,
 		.name = "nvjpgswr",
 		.swgroup = TEGRA_SWGROUP_NVJPG,
 		.regs = {
@@ -999,7 +999,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x80,
+		.id = TEGRA210_MC_SESRD,
 		.name = "sesrd",
 		.swgroup = TEGRA_SWGROUP_SE,
 		.regs = {
@@ -1015,7 +1015,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x81,
+		.id = TEGRA210_MC_SESWR,
 		.name = "seswr",
 		.swgroup = TEGRA_SWGROUP_SE,
 		.regs = {
@@ -1031,7 +1031,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x82,
+		.id = TEGRA210_MC_AXIAPR,
 		.name = "axiapr",
 		.swgroup = TEGRA_SWGROUP_AXIAP,
 		.regs = {
@@ -1047,7 +1047,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x83,
+		.id = TEGRA210_MC_AXIAPW,
 		.name = "axiapw",
 		.swgroup = TEGRA_SWGROUP_AXIAP,
 		.regs = {
@@ -1063,7 +1063,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x84,
+		.id = TEGRA210_MC_ETRR,
 		.name = "etrr",
 		.swgroup = TEGRA_SWGROUP_ETR,
 		.regs = {
@@ -1079,7 +1079,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x85,
+		.id = TEGRA210_MC_ETRW,
 		.name = "etrw",
 		.swgroup = TEGRA_SWGROUP_ETR,
 		.regs = {
@@ -1095,7 +1095,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x86,
+		.id = TEGRA210_MC_TSECSRDB,
 		.name = "tsecsrdb",
 		.swgroup = TEGRA_SWGROUP_TSECB,
 		.regs = {
@@ -1111,7 +1111,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x87,
+		.id = TEGRA210_MC_TSECSWRB,
 		.name = "tsecswrb",
 		.swgroup = TEGRA_SWGROUP_TSECB,
 		.regs = {
@@ -1127,7 +1127,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x88,
+		.id = TEGRA210_MC_GPUSRD2,
 		.name = "gpusrd2",
 		.swgroup = TEGRA_SWGROUP_GPU,
 		.regs = {
@@ -1144,7 +1144,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = 0x89,
+		.id = TEGRA210_MC_GPUSWR2,
 		.name = "gpuswr2",
 		.swgroup = TEGRA_SWGROUP_GPU,
 		.regs = {

-- 
2.51.0



