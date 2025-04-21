Return-Path: <linux-pm+bounces-25809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0DA955B6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 20:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA24169BD4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0860E1E8342;
	Mon, 21 Apr 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXZN4It5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92513FEE;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259232; cv=none; b=JARbEae3M6kOdfB4votXY9uB9uK92pQQqJqKSb6UUJJa7KW8AvRaM6Ms+ITmiHOT6G2fo7fmDTQmtOaz9v+VOtQmOGMK68ip1SmnAIxsmWKua6UH+ja6ZcKN75ZzVACc0msZ+8XcmcrcPoMOb9aY30tmZL7JqMvvZMeKehDeb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259232; c=relaxed/simple;
	bh=qLNiRYeO1WrYRKo8XFM+0fZQHMTw04xZoCDiG8GmDBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjIbgUcphheDVf1szgM9DMORzDNA3EU1X5soUeYQ9Jyhp74WZcH+jzrqimppF+ImDFzxZq0j/zGhn/GOO+uaB2wDCdrX4xdMTAWfcbCb4gl0YEIMcf8tdLl6gFOxyC9Hkaj+8kQVgmq4TnbYREXAlTJkVXd3UBXHVMcu6/z+dIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXZN4It5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4898FC4CEEB;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745259232;
	bh=qLNiRYeO1WrYRKo8XFM+0fZQHMTw04xZoCDiG8GmDBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sXZN4It5CoVbu+OFug+hdtrBYsJ3ABLNezPEEECPrirns47aHT24loReSHa+2qYrH
	 2wYs5ydRVKPrfJFumbGF6xY69LWwSx9iUWQPm58NtUJspZENj62juJd+dNjonpm763
	 OSTloKFD0dzg+y+EnsfcV1CESgcW4/JmuNBex+5Zz+IQzNUTh8a5VuqbLmq+c+y+T7
	 E//xOICSGvlO4FqZhVuVD2F6IRxYsqh77QA8BcWcfU25cW1/2daJTXDvSXzbsSZbkk
	 kvCfCoCchtTrVjk0RB4uZRKYVotFgS9rhxOjPDM21UJR2l+vYA2sUMhxCVD5hY429z
	 F0iJlc0i4zdow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BECDC369D3;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 21 Apr 2025 20:13:32 +0200
Subject: [PATCH v3 1/5] power: supply: correct capacity computation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250421-b4-gs101_max77759_fg-v3-1-50cd8caf9017@uclouvain.be>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745259219; l=1114;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=f0NuHuCRsvILdEaz0eCkw58+qM2h+TcqXwhJ2/+YcfI=;
 b=2QR0PUOyqJGIF5HEIdjTYZyFYYeQnngQYuyDt+nv/btdJkhzALfgAMD1J0icELmwKr0JiNUky
 0R5GJtFjQUqBeNnjC0fKbxcnRbsF0CXgPli970QT//VV9COBsfu71j7
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

From the datasheet of the MAX17201/17205, the LSB should be
"5.0μVh/RSENSE". The current computation sets it at 0.5mAh=5.0μVh/10mOhm
which does not take into account the value of rsense which can be
different from 10mOhm.

Change the computation to fit the specs.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 drivers/power/supply/max1720x_battery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index ea3912fd1de8bfd0d029c16f276316d06e1b105c..cca5f8b5071fb731f9b60420239ea03d46cb1bf3 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -288,9 +288,10 @@ static int max172xx_voltage_to_ps(unsigned int reg)
 	return reg * 1250;	/* in uV */
 }
 
-static int max172xx_capacity_to_ps(unsigned int reg)
+static int max172xx_capacity_to_ps(unsigned int reg,
+				   struct max1720x_device_info *info)
 {
-	return reg * 500;	/* in uAh */
+	return reg * (500000 / info->rsense);	/* in uAh */
 }
 
 /*

-- 
2.49.0



