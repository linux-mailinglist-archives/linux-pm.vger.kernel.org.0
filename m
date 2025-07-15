Return-Path: <linux-pm+bounces-30836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB53B04FE3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAB61AA0149
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75482D46CA;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIwLyJ37"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DEF2D322A;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552231; cv=none; b=eiENXwFeMpWkizyFgIzZkFAJ4/wOlS5VKUPwV9jR3H2B6j63jGpLBzMWmDLxDa756pMTEuVDEeNd/2yZCCTsTXNor8IsrU/dghNP1BSS5OTu+bkTENg/kvpPg38znhX9cYK422cbeK81AmvpTILKVse3zUlIVAwyiI17dq7P8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552231; c=relaxed/simple;
	bh=U7hqBRZJvPe2ZYKK+sbf1NH/0zO21KeWiFaQUBxyyNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qipFsXZNpPK1N9Q4Pks98vng+otJXjwApuY9dM/0eY/G6975nsJwlPicB4Fk0Mnv5tuDYmOL1zCPVuXNP2fqvm87LltWmc2DeTYaO5saKVT0VZJnEjWvaflBmrSTZO3vh85L+s65LpikSWLl5zZyx1Bvy4tqS0dkp0g9qxGx0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIwLyJ37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34DBAC4CEF4;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552231;
	bh=U7hqBRZJvPe2ZYKK+sbf1NH/0zO21KeWiFaQUBxyyNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lIwLyJ37J8KgfdGAn5u++SBS9Koh1+FvF41P2W+wK/2Su+WnJAHs38Nr6HKLTKJoK
	 az/VNBvwgI4rU51glYwDA8EK2ajcgtwZbkj/JcvWTMPJPLcXazTYFuRtQmkJfmD5MD
	 TRTycMwFuMjuIX/cGP4XeCircx3aBHcUIMnshP4uPWnF0QIqYjBuAnKEXDgBORcGCh
	 eJ+pk7heWSc1azLNZtkcrUIzXiTBPxdzK3TbuxqC284hE8DnuEh663T7hJhkBbQPuz
	 sTzETzvWjlXqJfL8DC+njNqs/N0MI/M0scB5B1O67ht/QFl6d0SK/Qu23kjQ6WkITo
	 GtnQPZqEV9pCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA44C83F2E;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:51 -0500
Subject: [PATCH 08/17] dt-bindings: tegra: Document Shield TV 2019
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-8-e3f5f7de5dce@gmail.com>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
In-Reply-To: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nagarjuna Kristam <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=980;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=qdGW2Lg8dZdwx0alyGvGFA7+660C1HUDmyePy1D+md4=;
 b=S2PTUB/zf2IzeQX6yEqIQJkLRJrmL1/dRCadc41EMtdoNwo0FZSfNfRDxT7ByMhUatLgP63gz
 a22coA1mYziDW0QdbRTkwBAuWn7/u5qWMNnACzwmAGxBojKRRZsF8RB
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add the device tree binding documentation for NVIDIA Shield TV 2019

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 9cae3268a8274fd3a38580939c79a6f21de48a3f..806190233b9859ad573fe43ac5104887fbadf428 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -174,6 +174,11 @@ properties:
               - nvidia,p2571
               - nvidia,p2894-0050-a08
           - const: nvidia,tegra210
+      - items:
+          - const: nvidia,p2894-0050-a08
+          - const: nvidia,darcy
+          - const: nvidia,tegra210b01
+          - const: nvidia,tegra210
       - description: Jetson TX2 Developer Kit
         items:
           - const: nvidia,p2771-0000

-- 
2.50.0



