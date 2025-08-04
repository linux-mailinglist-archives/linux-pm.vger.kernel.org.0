Return-Path: <linux-pm+bounces-31912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB14BB1A4DB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 16:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550AE189BC1D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E540B272818;
	Mon,  4 Aug 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p072hH0C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28226F463;
	Mon,  4 Aug 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317522; cv=none; b=oLNBqIqPW0AtNRW5I3G8guu4smyJWEhdaTJt5+OLHRtNA7NvgqRAnsdXUqSBDmmqU0nFEwRG6tXdc0eGIKAzD3VNNur//kwKAItNOoKN7H9X0RrT6DCYp2QXseTHAy06BIusOpqwYm7SM3Edhaqbi4oCC843plLsP69/bmy3RCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317522; c=relaxed/simple;
	bh=mAWZyywLB1ip9iUzT4X4Zu/0/IQZja/30TmIx21F/xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCSRRJwdoRk27B+Kht9wpyEywh1+nsqboCMty1iWLk4/fWvhAAQmuT2YZrmj3NhLPKABKVBCcdvJGmTkTvKnLdSJusxfHq4EnV8ncbsW5x/+vs1SsU4UBAArso6EPlzmOdEJR9Wux0+UPK5ll8oVYs6f3H9HJ/qUQjcinfPjOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p072hH0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47CFAC4CEF7;
	Mon,  4 Aug 2025 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754317522;
	bh=mAWZyywLB1ip9iUzT4X4Zu/0/IQZja/30TmIx21F/xo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p072hH0CBBYxBAoDsTtvfWGCWzfO20uAyO6Za3aNZDLir3smkrHZ04yd8upydWi04
	 1KSQjQlD+gBvew1KRdH2lAmYiRpZlCOUMR7C/+oSbC3qII0Ytu+EPIJB5QYFrolLje
	 kQF1+H0+h0yvBWR29iN3oO8fHlx3PRjvTlJjuXCd53R7pk4pQiydpngva/bDZZWQ9T
	 TTZ/6eZ6SmogZQI5BAMhYlh9n522mX+jtRPPw6NUmwS2b5WvKq8ndPW9kCQ6Qvv5gT
	 kD5j9jooP+pEwhaCDs6o2XRzWJeZPCMWK8p+onMHJqXjkWoXR0SSV1LAwfk01QqK2m
	 R5yOo8E5jgkmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C1CA0EC0;
	Mon,  4 Aug 2025 14:25:22 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 04 Aug 2025 16:26:40 +0200
Subject: [PATCH v5 3/4] arm64: defconfig: enable Maxim MAX77759 fuel-gauge
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-gs101_max77759_fg-v5-3-03a40e6c0e3d@uclouvain.be>
References: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be>
In-Reply-To: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754317658; l=764;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=gaoSugHRAz5fOiJGPTrSTYl8U3fwbJdk2k1I718EDsY=;
 b=ZG9Xmwog66bZ8cSUspq6GfK/PeRmbJru5wn9agjtUDDP6k3RzK0VaZzzaMfkTbctuK/5+YMlv
 VGOddOKH0rrDFrORISbF19f5WBqEmXuzmboc/ROIKMOnvlmk2PA+mSb
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

Enable the Maxim MAX77759 fuel gauge as it is used by the gs101-oriole
(Google Pixel 6) and gs101-raven (Google Pixe 6 Pro) boards.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7e04a2905ce4ec71e8263a85f20398f702917390..dd90e72e71dfd45c62942f83db6814f263517a0c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -691,6 +691,7 @@ CONFIG_BATTERY_QCOM_BATTMGR=m
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_BATTERY_MAX17042=m
+CONFIG_BATTERY_MAX77759=m
 CONFIG_CHARGER_MT6360=m
 CONFIG_CHARGER_BQ25890=m
 CONFIG_CHARGER_BQ25980=m

-- 
2.50.1



