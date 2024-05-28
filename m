Return-Path: <linux-pm+bounces-8226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDAD8D166C
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 10:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26605B226CF
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 08:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB913C830;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEzPG9hm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E436EB64;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885572; cv=none; b=tuRjwl9GOPYA3JFCR1Uxt4pWo46ltOc37XLBm+fYwPIwYrb1dHn6fFDQ2SK0H9GskF+/ApM5ly6+887mcG/SRSqJGWT5qJdkvEUvdaqxm4hb6akRu3Ffn5PQM5ga1E0+c1TbFvaF6iiXTooCzfg6kK4vX/yHxdE44edMq9ed1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885572; c=relaxed/simple;
	bh=bfGDc5/xHmz//Yt7VOOfRU/PyB095+4Sl6kUXfSweuI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YxCvj1goVoZ+RElRPrgKu6o8v6LSJYFGmoAvvBtbkIfbueg52X9NlYmwoZQd1FoQuQJyJlsCPA11jTIHefmbIgmS1lsRj9Z/zhE+9Fcj+NNM8i9I3uJK/36yUsTjmwrSWG2edlrRlaxZRh0MhMRnMTHREkcyf/HECpQv9j6RPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEzPG9hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37E53C32781;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716885572;
	bh=bfGDc5/xHmz//Yt7VOOfRU/PyB095+4Sl6kUXfSweuI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VEzPG9hm9TDJBx/sr/BqWeQaq8j0nJ6tfgTwk8q9BOFX42wZeunWRD5D/PyFTbzuR
	 5a9QCa7bJ0E2hX60hjdrFVKUFvKPtXOUtVFckIRGUQ6S2xgwH3rzjf6L9N4rWyAuU6
	 nBZ/iJ7E97lhhjJiov1RWbQy2PafWME3tfw/wL21cAspM6rWLLM2edcfrvSg1gp5/o
	 7/tVOyKikA0gSBwV94Ro3S0xoDgbo0gK9IPxIuCJdXoTmCdWMfmxOTWBgIqVM96ejd
	 1lWCLrHj5SUIdxl1x0PzTvUvIcb/W7lLqxR9EIZ5bN/xmMt0RYxPt4dg6k0ZmrjX6B
	 QETqQoMWxt+JQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22624C25B78;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] Power: A4: add power domain driver
Date: Tue, 28 May 2024 16:39:27 +0800
Message-Id: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAECYVWYC/x3MQQqAIBBA0avErBMm06iuEhFmU80iDYUKwrsnL
 d/i/xciBaYIffFCoIsje5dRlQXY3biNBC/ZIFEq1LIVRk2R7OlvCos/DDuhaUbUjWq7GiF3Z6C
 Vn/85jCl9vNEVQmMAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716885570; l=885;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=bfGDc5/xHmz//Yt7VOOfRU/PyB095+4Sl6kUXfSweuI=;
 b=zXzrrh7KUaH5eZOcybvVChgnCMLz6xll9cNsTL81pYUzbiwrYghjd8a/+Z1vCUYKHlv6pZ50p
 kY6IenT6z00DVwq3DTG04hEuWYeuz6PWUcz8Sfdvaw16xH2bdz1h3SS
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add power controller driver support for Amlogic A4 SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (3):
      dt-bindings: power: add Amlogic A4 power domains
      pmdomain: amlogic: Add support for A4 power domains controller
      arm64: dts: amlogic: a4: add power domain controller node

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  1 +
 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi |  4 ++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |  5 ++++
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 28 ++++++++++++++++++++++
 include/dt-bindings/power/amlogic,a4-pwrc.h        | 21 ++++++++++++++++
 5 files changed, 59 insertions(+)
---
base-commit: 456f4f5e6e6d3a2228501068a37ce13fe0b333d4
change-id: 20240528-a4_secpowerdomain-5eb005648930

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



