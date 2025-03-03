Return-Path: <linux-pm+bounces-23269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20EDA4BA4D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 10:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911DF1893AA9
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C661F03C8;
	Mon,  3 Mar 2025 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOpYp0VY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5681EB1B3;
	Mon,  3 Mar 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992768; cv=none; b=uAVVfOOyDbtVC1XXGsYnxAbRH9DJEuZ8Np4H5PToalIgknf/UUqzg3vUPJuqOdxkiUa//8d4JNHkPd3oL+3X2L8+hdNriB916pzzuF99ruL4hQbN1AZO3+NMtuag0yefNdbrcJt7+oS/p7MD4oiene1s9pvXS8b84C54wi2DT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992768; c=relaxed/simple;
	bh=+9m8RepECu3KdDR/xyA11+0D+ttRfCLVaFx8rNaHNQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WYpLDZ/5m6ATSx3KYODICIKvXKikgKJVx+kRExW4YA8AHf3uyU3XvOf9anFP9jgi+eaEzVC7vTq0RUiH6qWXC5qPEtBWYXmKwctqOxpWJyAPluO0z6Cmt5YY/F3g6JE8YILrRsRNyaDNGxPAF8cWDLehIRiNMUIOvJ3oKkiSrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOpYp0VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EA61C4CED6;
	Mon,  3 Mar 2025 09:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740992767;
	bh=+9m8RepECu3KdDR/xyA11+0D+ttRfCLVaFx8rNaHNQI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jOpYp0VYLTlOkN/XKt+X6OhLpSnc9AFrJt/Or1YazKO2uvQImYmQ7PCg6F2rZqI+Q
	 yFDFcLOcrC0FGn+lO2YyynLp8HnXZElVc8olj2FwV8mijSbiSkEM15cqpaPzknooNO
	 66NSHK10jhj0hfAEIed8Joeurtu3UxTRFN5Z8wV4Vx679qy/5FblwoU2ABLrEpl3YY
	 lKGYO04tr4tTgQ+/g7On71CfTbYU2j2YEOX12R5O3nRAlY+a6mKK7ZfvwwdqV3r65C
	 8BVQQcIgf2DNGWoi5sytV/TNiZDcSl9QJyZQoiASh1rRIh4X1k8ry2+z8z/grVhLG2
	 FFNG6B1xtwfmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E38C282C5;
	Mon,  3 Mar 2025 09:06:07 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 03 Mar 2025 17:06:05 +0800
Subject: [PATCH] pmdomain: amlogic: fix T7 ISP secpower
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-fix-t7-pwrc-v1-1-b563612bcd86@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAPxwxWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNj3bTMCt0Sc92C8qJk3TRjYzNTgyRDS4PUNCWgjoKiVKA02LTo2Np
 aAPHs9UBdAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740992766; l=1171;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=rJx19Mccy9v03r4IPzrydNTt9cu21guWRk4PdtQnj/s=;
 b=uqesClxVofnbW/ynh5d/bm2c3Kt2QwEI3r8qy7137qIkThIhcwEJ5t8Lm7peBNEKl3AhmZ73V
 TB14yRL8lI1C2wcDWE5UOeddEEODPuhesytoihG1QQQjHR9llVP55r3
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

ISP and MIPI_ISP, these two have a parent-child relationship,
ISP depends on MIPI_ISP.

Fixes: ca75e4b214c6 ("pmdomain: amlogic: Add support for T7 power domains controller")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index 42ce41a2fe3a..ff76ea36835e 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -221,7 +221,7 @@ static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
 	SEC_PD(T7_VI_CLK2,	0),
 	/* ETH is for ethernet online wakeup, and should be always on */
 	SEC_PD(T7_ETH,		GENPD_FLAG_ALWAYS_ON),
-	SEC_PD(T7_ISP,		0),
+	TOP_PD(T7_ISP,		0, PWRC_T7_MIPI_ISP_ID),
 	SEC_PD(T7_MIPI_ISP,	0),
 	TOP_PD(T7_GDC,		0, PWRC_T7_NIC3_ID),
 	TOP_PD(T7_DEWARP,	0, PWRC_T7_NIC3_ID),

---
base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
change-id: 20250303-fix-t7-pwrc-f33650b190ef

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



