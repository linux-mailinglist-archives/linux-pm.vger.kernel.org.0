Return-Path: <linux-pm+bounces-31280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14ADB0D82A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 13:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34B1560492
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9882E3AF7;
	Tue, 22 Jul 2025 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCrJ071E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC102E2F10;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183590; cv=none; b=lzX8+nEitqXnO+h6gKY0PdHiNsPnv5PVm7lCT9FNmL9bElxgtZmzohuWDDPk/PLd+IrdsjnDKczBx4oMhe2rxIKlOhcVQgxOdfSvO70OFXa7HGsLBAeIzejz91TTW+nsdP1750CIbHMfRrfnvEr1RYzNPtS1B9+alQAwX2woc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183590; c=relaxed/simple;
	bh=VIow2Oh79+ksdUzwuxUSWaFAQ/Cb/re8rFKTI6k85j0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wtggv1gyTS37zChRLOW9aOLj/33/PBq3pevZ2MxySDWiVw+m0IUBa3NzccrVfMNOAUejbxV8PMwzpkwIeAC7Fw+shrbYHfNOKSm2FuxxQe+wBsnKViNpsaNQv56tVbKEMX95l2TvVWqw9hL860J4r/vENytqKDrvK2VjUtaGXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCrJ071E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6B38C4CEF6;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753183589;
	bh=VIow2Oh79+ksdUzwuxUSWaFAQ/Cb/re8rFKTI6k85j0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tCrJ071EseGnJPK5qXEaZJ3TkfZ9KKJugPXtXESn499s0IH/TV3RmMfhlzTllnhep
	 eq1ESGsI1PfEDInAfqM/ZU0d0U4vvQzcdge0IbdNaAQtwkWEc+KZJfdjxeMD+aRxnp
	 1IJG5XOf3fsxrLBTC0NTp523BfHKdH3uD0ml9LlDLCew0OYPXtMKs8waGIvP9A1h/t
	 RdV5+p2Td3s/CuG5HY9bv9BaJ9I5dyw811L3BWnopj97RxMyKeiPMUGBbB2SiMPIzk
	 sZiSIV3va0mNdFIJM4ASl4iVKHDb+H9nx64SzURs0NalT7wwJL7JfAxLEx4lYIGdcT
	 2b/uKQ3ZwjPrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E80C83F25;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 22 Jul 2025 19:26:28 +0800
Subject: [PATCH v2 2/3] thermal: amlogic: Support C3 thermal controller
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-c3-thermal-v2-2-b2231b4be79e@amlogic.com>
References: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
In-Reply-To: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Liming Xue <liming.xue@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753183587; l=1585;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=8XB3aK58Pggx5wnTbdR3sz0nyiYdXkHkRUiHqo4F+k8=;
 b=EaPPDTlRO84fqaozVJ58Tw29Pt8gBKnOdXcHobVHZLPyZAIRrgWWbmmHMqjy+WX0wWQ7rMa17
 dDWRgvoforgAt6VocVBtVccPUis5r/OMN/AiefFc/OHk1HkFezSSg00
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add the thermal controller driver for the C3 SoC family.

The main difference compared to other Amlogic chips lies in the
offset of the sec_ao base (referred to as u_efuse_off), which is
handled differently. Everything else remains consistent.

Signed-off-by: Liming Xue <liming.xue@amlogic.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/thermal/amlogic_thermal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 5448d772db12..d1b08119c818 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -226,6 +226,12 @@ static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
 	.regmap_config = &amlogic_thermal_regmap_config_g12a,
 };
 
+static const struct amlogic_thermal_data amlogic_thermal_c3_cpu_param = {
+	.u_efuse_off = 0x108,
+	.calibration_parameters = &amlogic_thermal_g12a,
+	.regmap_config = &amlogic_thermal_regmap_config_g12a,
+};
+
 static const struct of_device_id of_amlogic_thermal_match[] = {
 	{
 		.compatible = "amlogic,g12a-ddr-thermal",
@@ -239,6 +245,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
 		.compatible = "amlogic,a1-cpu-thermal",
 		.data = &amlogic_thermal_a1_cpu_param,
 	},
+	{
+		.compatible = "amlogic,c3-cpu-thermal",
+		.data = &amlogic_thermal_c3_cpu_param,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);

-- 
2.37.1



