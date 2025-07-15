Return-Path: <linux-pm+bounces-30834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E265BB04FBC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2E84E0F64
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1352D372D;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpQIOFJK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B12D29AB;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552231; cv=none; b=jTO13iAbb/88sTIK9q0cat9h0cNIDNQVIB0erUYO1GMh32ugEBrV/216Ba51dk9E+tz4B5Az79asi0npCv6B8zd6C4QdGhNotlDksO+uw9Xs/YXpmVrYcUppx9f9xacbS7s6M2RWt4xkIkgb+LwOV0IXeOgaLlx+xjm4pH95Kyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552231; c=relaxed/simple;
	bh=OPn3szrWlchRd10WmNpX5YnmLoApC1PT+n7eOQGRQ3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMkOUBy5TB6ozrfdGN/16H37Wo0Z0hUqG8h+uW3fAbQ9dMbP0DsfbkcLu6kJKk9MvvPs88MujPULkc9EPxib1QZ5zZW0MuXABwLb8jT1wkbg9PW95hN27K3GTvTwQZIBU77g5+rDziWb4cJ82gkM8WMQCvo2ZoEnf8W28YM9pNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpQIOFJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD613C113CF;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552230;
	bh=OPn3szrWlchRd10WmNpX5YnmLoApC1PT+n7eOQGRQ3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LpQIOFJKMEgkmtCE8ayaMOwhNFgyML2mfvl4MH+zYxwWIIP2B1K5S2/8zBFc8KGXo
	 wd3FmVOBDPpaGhWGh/Jj1lyyZUbhPhGdbPI7FH+mJ5OsBtHqRmpWUtHFQSzWDkiSp7
	 bm9CLVLPfswfh54TODjgWekjjTlHwTCWaLh2sbtbIc4i+sXsf/8QWxk9rhp3ZXo/XO
	 jRGxMb7CnLPlAPva4uyBFMd1BbuAao0/yYtYKaKe7slD6V4HkrgED7H1XMQyrT6iHI
	 JMPssk4sUf7v3q1K5UroaqmArsIrKOLRL9htTY3cJO3gf/pwYaddF9uFfTULL2TOB1
	 tomlHrTcJuBEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33DDC83F22;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:48 -0500
Subject: [PATCH 05/17] dt-bindings: thermal: tegra: Document Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-5-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=1090;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=05phOL1Dk7sts/Zv8aPXcMDWKmJ0zvrejtZlUljALbM=;
 b=ERUZlXkxLtaEh2lh/a0ee4xRcCMkPQla+rmLuy5X/T5En0QI7paPtwQZk20opHhYzl/JlsWrB
 64PIupUlki9AD0MPObudtulmcSzNSVz8o/rJqeU45DlCIDorqcLcZzP
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add the compatible string for Tegra210B01 SOC_THERM

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index 19bb1f324183bb22bc75630798da67fc834920b8..cf47a1f3b3847d4a0371d0bc711638fc5e3b6cd3 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -21,6 +21,7 @@ properties:
       - nvidia,tegra124-soctherm
       - nvidia,tegra132-soctherm
       - nvidia,tegra210-soctherm
+      - nvidia,tegra210b01-soctherm
 
   reg:
     maxItems: 2
@@ -207,6 +208,7 @@ allOf:
             enum:
               - nvidia,tegra124-soctherm
               - nvidia,tegra210-soctherm
+              - nvidia,tegra210b01-soctherm
     then:
       properties:
         reg:

-- 
2.50.0



