Return-Path: <linux-pm+bounces-8323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE638D2B44
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 05:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46981F256BD
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A93315B111;
	Wed, 29 May 2024 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c791E4mS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089493207;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952237; cv=none; b=al9PZ52RrAERek03lWzH8pvHHcHrWPTRfnYlx9ogMj2Hh48R5+j9iGEr8MTC0hvTTOOQk5DLLtm6Qhh3uketrkJBxlBIBTL6jc89QM2EZ/QOUaRqQMSHDc7dFPnJboAK7jLIwaUox5NdvBFbhwWMlepKKN4q2/xyMXfct9iNQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952237; c=relaxed/simple;
	bh=SCO+SFRXiKHD6gPKSKfr2t0rbWu65yFZpXELTeORBfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUWGr78+/xLyKkQ7uvq1Xe1QgCPgNW7s3lzQJAvgSMgafpCCqo7a1QA5eBr8CQhMAUhoPCOYTRplsnrjESKS24fo4JgOqJ6D/EhVJFxLYXmRmdRj6wyqHwvPzCnHjSFuQGEjhObqjOoep887tEEYKCKm/eRsp+3AfXlEZtjLHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c791E4mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FB51C4AF0A;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716952236;
	bh=SCO+SFRXiKHD6gPKSKfr2t0rbWu65yFZpXELTeORBfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c791E4mSbk/7QrN1IGOK2J6AHbaKGmGfJdV/kBtBUqrVFeEsC/zW4uqvBw828CrMx
	 GsZRG6eFho56ISgMOCTe97uivzEle6dfboIs8t4qgnukbseUUzmZDFQjFsNx4vHzRb
	 GmKpJLMaJAb0hURj6JbI3xGIPyaWv/1IRJSL5aQWilAZGA31ivQDvMQG1x0Db4JnJu
	 FbBiT5xhIKUTG7S/PtbQXYKA/WnioEWgdiXSdQmc81fK4iwKtqWILFII058Q0TpJ5v
	 hHVR/ekj47Hp3BQloU7XRjm7rKhuBfvcDVXs4H2zT6u3zIPG0hTzEZ2nEaQ52YX9pB
	 r36Pn5DAoyz5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F6BC25B7C;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 29 May 2024 11:10:35 +0800
Subject: [PATCH v2 3/3] arm64: dts: amlogic: a4: add power domain
 controller node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-a4_secpowerdomain-v2-3-47502fc0eaf3@amlogic.com>
References: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
In-Reply-To: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716952234; l=894;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=AmiofDYC3IFCMwy7sO4GQjRfJjCUwOi49fG3NzsnzK4=;
 b=3Bx9xAD4eRBo4zTKnXndZ9mni8Z2V6Ohu2ryGjhp0WUKOdgr0sd2zyuR2P5JOPQ3cObwW2hyM
 smZ8i+VozEdBdtMFmxSbzNCtICyEjW/tjoIEH2qW5BiqBW6Y2XLZCeg
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add power domain controller node for Amlogic A4 SoC

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index 73ca1d7eed81..de10e7aebf21 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "amlogic-a4-common.dtsi"
+#include <dt-bindings/power/amlogic,a4-pwrc.h>
 / {
 	cpus {
 		#address-cells = <2>;
@@ -37,4 +38,13 @@ cpu3: cpu@3 {
 			enable-method = "psci";
 		};
 	};
+
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+
+		pwrc: power-controller {
+			compatible = "amlogic,a4-pwrc";
+			#power-domain-cells = <1>;
+		};
+	};
 };

-- 
2.37.1



