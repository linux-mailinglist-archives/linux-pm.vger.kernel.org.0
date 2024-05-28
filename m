Return-Path: <linux-pm+bounces-8228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3A78D1670
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721E0283868
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EB513C9AF;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G45asAmv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE27D07D;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885572; cv=none; b=QapQp8yom1tn8RbDZ9WqMzptX7NeoqQsPQ41S+9IEaeCP5ILSmsIJ4m4HnZ3aiYBIeO4DoxG7ldoxFW3U2vLaiXVb1L8LzQnJVp6roqoPRXq6WMJgLsPxrS1hwioWhugJ6O49cIA+dVpXqdv5lYuR2D/Xyxfw7TiS0ZVGWluTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885572; c=relaxed/simple;
	bh=Kj+dnbcQsJtNSINo7zvlXmb60tMjgfrr8JYjVExuHhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYrHtJvkBuc/1ypqGvSVwLRSAjzKatHgSJL415zQXeTGCW9xnzuIiDGYrgVkw6BOFDHxILXMURdC4zl30u48AB/GHsD+SD+WzkPjH2Z8I3by2KmhPq8xzcjBjAk29v5gOwQTelCnsCWGSlwA6B/0BnWhKpjZUJa5/yYGbfc1lNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G45asAmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66975C4AF10;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716885572;
	bh=Kj+dnbcQsJtNSINo7zvlXmb60tMjgfrr8JYjVExuHhA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G45asAmvuYIvV+L9qlMaBrBFgK+DPE1Gnu8rqWsbm3fQ/H34Cv1F0u8/T2JF06INz
	 NEIjvqzzD0VxCVXGueD962xY3sOT06ohLyVY/Q2FmecMW0lxj9akbWt4OFbsYG5+B/
	 BQaYIh1B0ANWhF2IJV+bqjt5fe9ntwYaAWloJGcSqYp1D0A7dOZjD+qJ3J0wctXOXV
	 tQd9dLHERurEsDqcSqFL3EyN+pRFIr/C5i+VP8uIWFoV9nFEOX0eq1qHLmzsR9dM4m
	 DaLzfKlLbjd9Rvki6RT4+utUJ7NepJAF0YpR9kFsKFkNswy6LoTp8gpmrhnUQn2otX
	 9j9Y4DKsZnjvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0D6C25B78;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 28 May 2024 16:39:30 +0800
Subject: [PATCH 3/3] arm64: dts: amlogic: a4: add power domain controller
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-a4_secpowerdomain-v1-3-2a9d7df9b128@amlogic.com>
References: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
In-Reply-To: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716885570; l=1210;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=nbykAnIJ2GCD2WnAPtjMU24T/l4oTV2riXHYjP6paJ4=;
 b=FdbPTyKbc+thp9uswV6KRGymTZOcdUZfBsO4rleZ34pKhtz7H21eiq5madq8Vko4zKXFmJmT7
 LDb0D2hwFMVC1K2zczPowHbHIIkPqRNAI1G/s0o4LEHtMW0ptT2gc5N
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
 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 4 ++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
index b6106ad4a072..eebde77ae5b4 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
@@ -27,6 +27,10 @@ xtal: xtal-clk {
 		#clock-cells = <0>;
 	};
 
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index 73ca1d7eed81..917c05219b9c 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -37,4 +37,9 @@ cpu3: cpu@3 {
 			enable-method = "psci";
 		};
 	};
+
+	pwrc: power-controller {
+		compatible = "amlogic,a4-pwrc";
+		#power-domain-cells = <1>;
+	};
 };

-- 
2.37.1



