Return-Path: <linux-pm+bounces-10112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13A91A5A5
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 13:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907E51C216EB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39ED14EC5E;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDLFp2F3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE414AD0E;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488875; cv=none; b=ZQUFZTe7nIkjs4VAfs60odRRJc4t5fUOb0ieJeyXMllBTFXmKyVvnkWJgmo4hRIFsXHO7yZRFLTpgdmKuhQEGGBQmHoDmM41QE96Mm9AMQB8wkC69g3rMwgZnbqNacWUmf25US2+orGn7PQOkF6wZTbvqE4ji9tfHRxTR2HkMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488875; c=relaxed/simple;
	bh=eyjxy3sxdu3xoTQb6Z89zNdOHxg3M/MGMf8s4ii97+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CABkcBY6RanvXyhjFVV/Y201kYJb9QPuh6OgiQ2CDPJjLXzSVSyJasz+c3yh7jRUkjunxJESGBl1fuw5zx3FV2q+ym4jKIpMX+ZwpXS16aqTPeKHBZ1kisxKN6QwtIyeL08n1oSOUnEoaoTomwM3Ynu+QCB1FohNAS3i2htypFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDLFp2F3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48081C4AF0E;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719488875;
	bh=eyjxy3sxdu3xoTQb6Z89zNdOHxg3M/MGMf8s4ii97+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rDLFp2F3ezKHScCh4xiy2zMKT7119vaePYGsezyMJTEf0gHUygZ77vJiqtPOBOVr0
	 +6e99Xc+Cm8nxJigQbla1J6r4IUo8yG5/5jyz7ojRJAD4DVYLI4wWU/PF+Mn9sH5pX
	 zfbUl6T/ZF+AVgcgxm2b6iatsg762IjB2zz8c2zYuLcvMmDRyqV3xwupRmdTtVWuVE
	 rH6LGjzNV94nPaOwXo/uuE8g2GN2xZqrX0wHvY/dYmhxAoK4IDZDq7sgm6+UHwXRiR
	 NDohfTn4+TPoQtJKlfcpA2bVwqt9msQuoXUPOO8TnEiAdiG+wi06yZZvhPovL6pIs/
	 qq2MDj8Fiuiag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C098C2BD09;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 27 Jun 2024 19:47:53 +0800
Subject: [PATCH 3/3] arm64: dts: amlogic: a5: add power domain controller
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-a5_secpower-v1-3-1f47dde1270c@amlogic.com>
References: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
In-Reply-To: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Hongyu Chen <hongyu.chen1@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719488872; l=952;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=a2Zu+uHx7AvPgs0U7XpBlBsH/P/9nCVcrhSWZWMj+mI=;
 b=QgBeyLD1Kac4MHjy5kyxtif4bCHe3DmeuihH4WAyneRpGvyo31dywxlvvHylqdPXeH7o/vv3N
 QBZtc7xUpsQAbNsGbVbH85wfd+4zPivbRtVm+3Ojs5fVy7LPkc+N2nM
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add power domain controller node for Amlogic A5 SoC.

Signed-off-by: Hongyu Chen <hongyu.chen1@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index 43f68a7da2f7..17a6316de891 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "amlogic-a4-common.dtsi"
+#include <dt-bindings/power/amlogic,a5-pwrc.h>
 / {
 	cpus {
 		#address-cells = <2>;
@@ -37,4 +38,13 @@ cpu3: cpu@300 {
 			enable-method = "psci";
 		};
 	};
+
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+
+		pwrc: power-controller {
+			compatible = "amlogic,a5-pwrc";
+			#power-domain-cells = <1>;
+		};
+	};
 };

-- 
2.37.1



