Return-Path: <linux-pm+bounces-30846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F7B04FF9
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229164A76F0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24382D8365;
	Tue, 15 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvHKlI9S"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A122D5C8B;
	Tue, 15 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552232; cv=none; b=Ep0L7HA0cWZWeYx3IXBKo3NBNi0aOty8uA3Ey9grenrbXntbcNateIJI7ciaGOyFk62mUV/GMUWuRTUlngYKqYecmFGZzuVpzo8x/QuDP8/WxVryl9ZywbZHrJ/tMkV+dTxaSaZlsiuMbpR5svHg2H96V/xofil1ij5a1RccuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552232; c=relaxed/simple;
	bh=mUuqTsy+EYHpE2zyZ5AVAZT4+XlL0RD5C8Ve3AERbD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzVOlSmo1zZT0UpK4qGuC2vLcEUlFfiuHgFR4kT9+1xj9LlbICKPGQNM5w9VYZF3VhWxE0YuHM3hhhpqqUSwNxIlje/9TSJiGepqRH5ZiVjk4QP133GPJq1AwbbRF0FwKQohb308x8m2pV3Dgg2m4pA/UrYlz3tJ5tToHEYz5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvHKlI9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D282DC4AF4D;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552232;
	bh=mUuqTsy+EYHpE2zyZ5AVAZT4+XlL0RD5C8Ve3AERbD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FvHKlI9SRu4rVgwp5CRDLvLWV8INByaAFVmhFgqcPFAjLQAopkNnfAP0LYg1UjBHJ
	 InNF4Cikx6d5nt8yDOENlEP/1qO5EJ7lmIr5us0iNzW5IgwamVFStZsKld8foDYm6d
	 D7N+yAEA9j7z4qRmGsFXJ0eAnwVuABos2Oz2cS2sDFfOsYg23gwRdERkZZhzvpV9iT
	 uej8Zw8FzbPtlXJ+CvU19fCzm8UkXMxP4kme6FFHdQC+JrDAboWXl/uGcc23+Xn3Rm
	 llkTST+4OWAQCrVTQH9u+udAYz6Q0YRZ0aqmYpttitLWeIhzJhKZaAgs4h6ysCLCwj
	 LUhTqh1zhWx1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19EBC83F27;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:46 -0500
Subject: [PATCH 03/17] dt-bindings: usb: tegra-xusb: Document Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-3-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=897;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=SJeTsauuKP0+H7jkmqGKY8VKb/OI6/mySaMOj0+bvYI=;
 b=yP0lTSFS+l0N6akf6j/Cx5vcgWxbeDL25VLHkBqPLHnPqGgYP7JniA3VxMZeSd3vKOtlkIUzs
 QsCWwkRQTthAZcI5/X4dFlCPXtsob+ynCYeNWGvmCj7J3v6PypT99tp
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add the compatible string for Tegra210B01 XUSB

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml
index c0e313c70bbaba4f5da9cb090ab6f3027d274a2d..543355118282f52b276a087185709320dd8e09d6 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml
@@ -15,7 +15,9 @@ description: The Tegra xHCI controller supports both USB2 and USB3 interfaces
 
 properties:
   compatible:
-    const: nvidia,tegra210-xusb
+    enum:
+      - nvidia,tegra210-xusb
+      - nvidia,tegra210b01-xusb
 
   reg:
     items:

-- 
2.50.0



