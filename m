Return-Path: <linux-pm+bounces-33090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67EFB3554C
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 09:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719875E14DD
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 07:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AAD2F99A6;
	Tue, 26 Aug 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iscT6gSZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E722F83B6;
	Tue, 26 Aug 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192718; cv=none; b=KythlgmitbvCnaCzc3bnr4tv8yIS4klkdyqlJQEvo3aPZNdEH6/1vwitL6fm9//jfRThrCIoB0PgqMb+4S6ow/sBgek6OO4LYOUsT1AeBeX7L7xQWGf+/QO/BYy7A2hrfabMStA8kBPfaRynAJ4FFrZLKpCeBXmOEXOQYVrYTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192718; c=relaxed/simple;
	bh=i0Nfy+9gssKmarkh7J2+cP0xs3hncTO4KeRTAk5qZO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huZCbrkCTK5qj8SdSa93deVIwK8fDWjid2kS60gGvJvxOa7BupriDWtdPTLDtMFDIWV0jDu3cRdstjVwVrsalkS2Vi41PwEeRVg3yqUAkcTNVJZi+okgG0mPEuUCLc+vSth/xb8qUOqqOGycYHZYBYb2W6OY4LciSTvalYon+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iscT6gSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BDD2C2BCB7;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756192717;
	bh=i0Nfy+9gssKmarkh7J2+cP0xs3hncTO4KeRTAk5qZO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iscT6gSZf9IrQsmHBTplipM+0F9X9OI8CwAzh0KIFSezDZwQHScS8J/8uoohKSUUs
	 KBWZcz3v4+r7ykZS64xQcl9bUFHXYLBsXsx7VbqzgoU2nHVpR0ur5q5S8iOu+ZyLhr
	 YPQ4mcjX4bCSzTB2hzQIvxOZsUJ1hhTwH7qY70WWRldfwv0Z3CVADnoDY/AL8z2X0w
	 7MDg8Dw/Vkdc5pK0aXCZDhu7MX3AgpZIlwUT8AeB+ksROrBq0vm8ynlp3veYmCxdkq
	 N1M5S6rI/o4xKWeYuf8omNKus4x6V/hEwRKrAM2UW2pkOqOiiaIf/kVNQ/1XSxYcr8
	 4rQUrZbMgNM6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93069CA0FEB;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Tue, 26 Aug 2025 15:18:35 +0800
Subject: [PATCH v3 8/8] arm64: dts: qcom: x1e80100-crd: Add charge limit
 nvmem
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-qcom_battmgr_update-v3-8-74ea410ef146@oss.qualcomm.com>
References: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
In-Reply-To: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 =?utf-8?q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756192715; l=1892;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=nz0xqUIFES4rZCFzolpsU95uZVTcAXXyGgr1rWpbGA4=;
 b=DtfgkJIdv343kcIVoBWGlbvfyvBVocOucPuihWubpjjDuFsrX/vYpzAfcFgXdtNSKANvONaOl
 83AnAvPj5lSDPvb5Z24TD+c7MHXCLo7Ic+6QxroMCMFUFp1JzvbD6i1
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add nvmem cells for getting charge control thresholds if they have
been set previously.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1-crd.dtsi         |  2 ++
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index c9f0d505267081af66b0973fe6c1e33832a2c86b..8c3d30dd936ef9b12867971f5f237dd12484072d 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -82,6 +82,8 @@ pmic-glink {
 				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
 				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
 
+		nvmem-cells = <&charge_limit_en>, <&charge_limit_end>, <&charge_limit_delta>;
+		nvmem-cell-names = "charge_limit_en", "charge_limit_end", "charge_limit_delta";
 		/* Left-side rear port */
 		connector@0 {
 			compatible = "usb-c-connector";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
index c02fd4d15c9649c222caaafa5ed2c777a10fb4f5..abf7afe5127d7b8b572513234e00009ce837837d 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
@@ -239,6 +239,26 @@ reboot_reason: reboot-reason@48 {
 			};
 		};
 
+		pmk8550_sdam_15: nvram@7e00 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7e00>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7e00 0x100>;
+
+			charge_limit_en: charge-limit-en@73 {
+				reg = <0x73 0x1>;
+			};
+
+			charge_limit_end: charge-limit-end@75 {
+				reg = <0x75 0x1>;
+			};
+
+			charge_limit_delta: charge-limit-delta@75 {
+				reg = <0x76 0x1>;
+			};
+		};
+
 		pmk8550_gpios: gpio@8800 {
 			compatible = "qcom,pmk8550-gpio", "qcom,spmi-gpio";
 			reg = <0xb800>;

-- 
2.34.1



