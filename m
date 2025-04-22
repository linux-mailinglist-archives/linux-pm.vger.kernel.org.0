Return-Path: <linux-pm+bounces-25826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39697A95CF1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 06:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DDA1896A1F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 04:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF061A314A;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUYBj4np"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056D19FA93;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745296055; cv=none; b=jFmE9ViVWN61qId8ETyNYhoDBNCySTom5RyW3GMAn+SudBOHbYwgnITpvue6c1UEjD+1j63B2j1Inq09j7eg8RXKTLjDXWJORlwdQoW3uB0ZS3vXcnnnnHF34bMCNR9EksWn6ZwjZjTX2mosjzR4XWckPVgANxrDg2+S9HIdHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745296055; c=relaxed/simple;
	bh=vTaFEnXPtLBilZRMAVM2qU3oBb5SYIUsJMP83Xqz0Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+P+oUo8Eaww9CsdimfkECp6g7muGfZkGPWqBiSxF2AbVSpqRVL4pgjbcO1WCVrtJt/9WIM1OX/OT5M46vn7jAqi0ZIb3WsKTSx/uGzRFRyl8PBTMZg3oqhC//LGa/Mj4R6+ysxg16dC1cNrlbL9Dpd5oe/MHHxn08M6Mmy3Dzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUYBj4np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26954C4CEED;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745296055;
	bh=vTaFEnXPtLBilZRMAVM2qU3oBb5SYIUsJMP83Xqz0Zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZUYBj4npd8tKt5eXpXbfQ7gJnyJj8T8UfrB3aMvOgQ5LN65pAJH9MsxeZxvDQaCdA
	 JgL9IuZq06wbZjD7MsMlIK/3XHVaWn6ggSeI8r0bJSqIhbpQszJvXkhogY8d0LJQHa
	 Q197EEZEFL67kGCjTvIH/M7Ab0wC5wdD/osWA9j+sEpizb0vC5pJw/Qg2xOUmFo2Iu
	 gcvcn76B4ZjzUXB/lbeW5iR9JVm0f2B/PVHVxZgAKbsB7snVrDckSGAV9meqfaPtEk
	 w6WAeJghnnRTBOVIuFyq1jS/7SXgh068R8dHBVw4fgam/Bh3r/j2G6ULot58lfnS8G
	 1WNoiS9iBoiow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13700C369D8;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 21 Apr 2025 23:27:33 -0500
Subject: [PATCH 1/2] dt-bindings: power: supply: bq24190: Add BQ24193
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-bq24193-v1-1-f125ef396d24@gmail.com>
References: <20250421-bq24193-v1-0-f125ef396d24@gmail.com>
In-Reply-To: <20250421-bq24193-v1-0-f125ef396d24@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745296054; l=840;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=qOjayHUiWoIVkR1SIJGiQLJodRWPSQpu8XYOp3kWbAY=;
 b=ybZ6PARFeANCIx8hbvatk6BWSS9tEWyKaPgfm7I/uNQljR6DONKB9OJtyZx6eFUbNpaO/U28r
 fsALrh2QtcAA1hPFAleWBrnaYJuQSsiImTNKviTBxRZ3z5mMzHVcAH6
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The BQ24193 is most similar to the BQ24192. This is used in many Nvidia
Tegra devices such as the SHIELD Portable.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index 07adf88997b4e3eaa4bd7c6245efdc31fddc9058..307c99c077217ab4b5fac30694a4a316dd51f8e4 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -19,6 +19,7 @@ properties:
       - ti,bq24190
       - ti,bq24192
       - ti,bq24192i
+      - ti,bq24193
       - ti,bq24196
       - ti,bq24296
       - ti,bq24297

-- 
2.48.1



