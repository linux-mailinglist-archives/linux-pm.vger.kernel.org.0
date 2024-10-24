Return-Path: <linux-pm+bounces-16410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C479AED4C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367FF285AEE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E41FF05E;
	Thu, 24 Oct 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="NepmM36T"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA41FAF05;
	Thu, 24 Oct 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789793; cv=none; b=PvJX9hkuvIOiI/QyXxmyy440RCYtZqR1KkPqLunZG0JDPdlC0rMqwcCT8XtgDsQCwanGRpsZNW9u2mujp4mPOTUAghr+Enw78U3jIoCEzDKaO16QmD/nfKJfiE2NHZnqD8RMs43DKVfl6HMp9JjkSYFgRpCKrZLO0Y1WrOcoZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789793; c=relaxed/simple;
	bh=E2aCqTy48x9i6+PsxlngJvQsrJiGAg5xpa3iVpu+v2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoNH7FHzJIzhRQwnbuUk8UneXlNh0hF/WanJRtDV+f49Bvu6t9PlwvacH0roSvUXB51/zNQ/pQ/JQKx6mFcguYFTMx1FH9Jm5NnaqQ86kxMyK0IDgMpQW+lbzYbV689LXjlWyk5JV482d9Nh+QYfL0szGvMy8wxAQ9Xpip66khc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=NepmM36T; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789787;
	bh=E2aCqTy48x9i6+PsxlngJvQsrJiGAg5xpa3iVpu+v2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NepmM36TzV2U6xaCSVHRU/CIYMlTPDEr4bPPeSfDbp9dXqcFssTWFuH/ZR96S3kCx
	 fhbqR7nSuSWJBCZ6p8zjhkTmFFYg4Zk4qVg2laTKyZLqZBExxRRGUgfZyBdnb/1lbZ
	 GrLQvfSBQCdKRMiBz2LFf5YPpnLRVglnSVo4PApQW1LttSTZCW4gG3hCmDfH3eY4QU
	 2JKq6gcv8aK2u7TM9Bvu+oyNvnCV38F0XKu+XwzPnCmRyGgmzzwDcY1tc9+G6hsyco
	 nLgxzq7ngs+mUJQhJHLLiytzjjLabFUFdXlIUVJLS7tVA1gjjpKfnxd3LTxdpY8+Wz
	 LfS3wWOe/ovHQ==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-usb@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	Andre Przywara <andre.przywara@arm.com>,
	Parthiban <parthiban@linumiz.com>,
	Yangtao Li <frank@allwinnertech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 10/13] arm64: dts: allwinner: a100: perf1: Add eMMC and MMC node
Date: Thu, 24 Oct 2024 14:05:28 -0300
Message-ID: <20241024170540.2721307-11-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangtao Li <frank@allwinnertech.com>

A100 perf1 hava MicroSD slot and on-board eMMC module, add support for them.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 .../allwinner/sun50i-a100-allwinner-perf1.dts    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
index c6d8264b91b7..29e9d24da8b6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -39,6 +39,22 @@ &ehci1 {
 	status = "okay";
 };
 
+&mmc0 {
+	vmmc-supply = <&reg_dcdc1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_aldo1>;
+	cap-mmc-hw-reset;
+	non-removable;
+	bus-width = <8>;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.47.0


