Return-Path: <linux-pm+bounces-25814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C216CA955C7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 20:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAACC1895ABC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B81EB197;
	Mon, 21 Apr 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th37WpDG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353221E9B19;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259233; cv=none; b=rCapnMmml13EYXx1tf+It8j/zdbwn47lNkN3VDtkPIlm5TuAlpePnsOi/Sw3Qf0CiE2hcq2OyRLR29WDE7EWtbXDDtWyl8ZRQlisABFqT+bz6z+Y4YfpMFx5Kfpu6TPEygV+hH80qOu7TUN8JNsXttDv2c6z7kvGaaEQ3T/48QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259233; c=relaxed/simple;
	bh=T+XZ9Epqso4lamigfMKzOTzFq0QKydck3UHjfbzbL0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHqwJQvmQzcWX6ymZY+YFJ7+ycI9fV3B1P/lNvlfJYFXP8dJb8CfDg2hDyuCHeCvK/7bgONVED8njBWJrX0W3zm8wlstlElZ+/bmdhsK8MfPzHyUGTzUe/URLTp43CnsaxJ8hDJoXlRngmmp9FKN/N6NpdInP4Mw0G2RYGp+reY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th37WpDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95BB9C4CEEC;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745259232;
	bh=T+XZ9Epqso4lamigfMKzOTzFq0QKydck3UHjfbzbL0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=th37WpDGQt9xC4RgS/LADrR+yO73bwalelu34kTWDJNleDZBH2kCKeRre+qAkQwIB
	 NObIO6YF3Sqgkx2lCYzbo7cb0I8LWO4bBfJeqnuFHjSHx/cOslv8aMkL2foMnoj8zg
	 2hBBJypKcn1obezkhRiIiE8WFAcOuYaNwWW1UJRE5w3SDpUnRtG+rajimCt3RL6cNi
	 az2bIP7PZuLSCfA+fUZ50vU3YHVPEKSw0M0zbTphOQsSKXrpgSwmkAE2dZy9FMsg7f
	 PVe4Cpe8Fr7dyFaxu4AP8WJPvGPmssaYYYY9tGMz3uc4c3txMbAxmQr+4PvPBzbo0H
	 j2eXZxk5uJi6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD2FC369D5;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 21 Apr 2025 20:13:35 +0200
Subject: [PATCH v3 4/5] arm64: defconfig: enable Maxim max1720x driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-b4-gs101_max77759_fg-v3-4-50cd8caf9017@uclouvain.be>
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
In-Reply-To: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
To: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745259219; l=716;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=yx0SuiaIbKa84b0oToxMe11+jBYaoqB6+UxBMxg24/I=;
 b=S4zPayfzajzMowy0sNp4LipgsT+1+PUeJdTK+n0NuKabzZjL2EvVQiQMMnXcIpKHrDKznUtrj
 WElm0l00aQ7BToIlo3UQkw5psKfjjVw4jqRjkKhjGZOddyMy2l7IAWc
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

Enable the Maxim MAX1720x as it is used by the gs101-oriole
(Google Pixel 6) board.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a22116781169611482179b10798c14..4feaebca340b1bc613c4f4ea9f1ff3b6686b092d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -687,6 +687,7 @@ CONFIG_BATTERY_QCOM_BATTMGR=m
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_BATTERY_MAX17042=m
+CONFIG_BATTERY_MAX1720X=m
 CONFIG_CHARGER_MT6360=m
 CONFIG_CHARGER_BQ25890=m
 CONFIG_CHARGER_BQ25980=m

-- 
2.49.0



