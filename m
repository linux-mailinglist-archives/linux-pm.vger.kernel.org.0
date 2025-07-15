Return-Path: <linux-pm+bounces-30835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA2B04FC1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35A816E2B5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B787F2D3750;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo1lKPta"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB32D29C3;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552231; cv=none; b=h+yZHIVDda+y4z75GsQmqXV7oig9yT93k5dtw3ylDgy5MG79T3DoB4KSUSPGI+FQWPVdqs1biHQf13Tl2CYdzFJ1Q6paCKBF9MTxM9dsX1L1VKKBJ9kCO9FQsYt5ZKjC8jEcGHiEmhsvVupueoj8rzTQivvy69k26YX931MQx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552231; c=relaxed/simple;
	bh=NWmyLjJ+pZUJFrZ4rkC1nd1VWhd5SOk1veK/za+8ulM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVUAI4qxXWcsbyolfGonVV8vsVxQPNZn53g6vS8XyyJPcjW/0SWSuvznYUosDq7eofzJpKc5Ga9N+EHguG9keXy1XjlUR83uI0MfnrjVY7ubzKZ/RvHb4LyKlGkTgfyDmtehDKN31nVdn2gupLBgHt8SnW5GHYeb0hnH6LiNwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo1lKPta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0A56C113D0;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552231;
	bh=NWmyLjJ+pZUJFrZ4rkC1nd1VWhd5SOk1veK/za+8ulM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fo1lKPta8/0NICHH1lZUGWUu2iKqLzBPCx4bIiVYDjeJUguriddk2cL3jDpzcAg1T
	 9ySixynD5ktjW7s9VrMyVzsm+M1cd3Skecq0E/6rwKOp/36z98Y/O2FR2JakOuss9b
	 8xmqITQ0hEpqmQwqx6sbWikc0suDk+gloVIlYJsT7EnxPGo6n9l4M6dCktzuLPjn9k
	 cLphSUcA7AG/IJbmXmAaucQ7MbkRuvYUBTIESqZPk33e5W6aUPKvl9M13Q/+ZYsDlf
	 mFoR1BzaiQr0uovi0wrHooF0qlAD5sLlMnblrAQYc+dRWrvLlerSBz/NGddGwaErN5
	 TxQ5FiiHxEecQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AC0C83F2E;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:49 -0500
Subject: [PATCH 06/17] dt-bindings: clock: tegra: Document Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-6-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=1553;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=v/eU4/Zbau/0drZs69pubd0H4hdpQftQ1XoOMJlu6DM=;
 b=G9Twzppau8KbstCQKxzCRCRpTGrNB+antQiJeq1WCfUYuIE6VYKSzvermTojlmY9fOLbOKvrA
 WJK9KxQiJzIBU/91EcyplXqJVkjI2JGdQ3/KQpL8FfgFl3wusseWPNu
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

* Add the compatible string for Tegra210B01 clock and reset
* Add Tegra210B01 specific clock bindings

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml | 1 +
 include/dt-bindings/clock/tegra210-car.h                        | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
index bee2dd4b29bfe391caee346aa5afad49772c2c41..88cce500bbc43de934f6c56152e5b2d006f8a8bb 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
@@ -32,6 +32,7 @@ properties:
       - nvidia,tegra30-car
       - nvidia,tegra114-car
       - nvidia,tegra210-car
+      - nvidia,tegra210b01-car
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
index 9cfcc3baa52c6eef0439c859200cf44446a1cd17..27485d9b80f68fc0e7668a8abbd1b821f62035dd 100644
--- a/include/dt-bindings/clock/tegra210-car.h
+++ b/include/dt-bindings/clock/tegra210-car.h
@@ -409,6 +409,9 @@
 #define TEGRA210_CLK_DMIC3_SYNC_CLK 392
 #define TEGRA210_CLK_DMIC3_SYNC_CLK_MUX 393
 
-#define TEGRA210_CLK_CLK_MAX 394
+#define TEGRA210_CLK_UTMIPLL_60M 531
+#define TEGRA210_CLK_PLL_P_UPHY_OUT 532
+
+#define TEGRA210_CLK_CLK_MAX 533
 
 #endif	/* _DT_BINDINGS_CLOCK_TEGRA210_CAR_H */

-- 
2.50.0



