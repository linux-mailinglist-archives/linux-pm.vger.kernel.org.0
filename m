Return-Path: <linux-pm+bounces-8325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A496B8D2B49
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 05:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47AC1C21756
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 03:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4586D15B125;
	Wed, 29 May 2024 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEjtP2qp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A826AD3;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952237; cv=none; b=lfl2r63hoO+IGsrWtDmu4yesHmcH5BNxLOo96JDIIwIBjTUqe9aKGkpvT56KVeLlFmi77lO/mpqr7nDHm/wehIPGL6SdmCbQqqO8E+u2QLcidZymNTq4AGVVcVra2xAhplUJeINKWPK3Wm3NLPzABhE/7qEQ0771hWy8CvSgrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952237; c=relaxed/simple;
	bh=IgTEkVYd46Ru6As3hGpXvTy9hURuoQjJ4M75ryPeIBQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BisOGRmFy9/EaTHmnR78fUotZhoQlk3VadEBGosdgknopQBu6BUT4YnjseaQ0e0eeI8qEZB+a0icTILy0SDBcVsxMlREikjDF39F4vdkPWhBVk9pADJuMwaobERI009D6udPdGoCJRr+NaqFUGgaS7AsggYCB+Eu0gLqpC3q1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEjtP2qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75CD8C2BD10;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716952236;
	bh=IgTEkVYd46Ru6As3hGpXvTy9hURuoQjJ4M75ryPeIBQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iEjtP2qpfamyS3nvDrUSSup1aUJp1DCxrxKAQnLjRU3bipLyP9uPtTgQ2BlSXOH7X
	 VhELVBibjy1+hdD6T2B6q502EG5X+U8nF6lUMHio2aGTnHvBLekQVyBmFKL4AMElKf
	 7bYsgkaTp8+qy1qVYBltii6CwZE2g3hwWhAmlSDMOPv2rrWTVTw4/o9jILPQqpDPCr
	 f2ILY7/ObIeJWeud+xb0LfEXuL1/USd6bKLfl9pTCwn7ymAwFSpFzcdTXB3pvIcTUM
	 cpR74z4XNBRn8fCwii+38+u5pQOV4/GXjssJznC2nexlxT+uy9/KhvlVKGKwFxXi+e
	 Tl9tO14kBAZYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6CBC25B78;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] Power: A4: add power domain driver
Date: Wed, 29 May 2024 11:10:32 +0800
Message-Id: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKicVmYC/32NQQ7CIBBFr9LMWgwg1bYr72EaQ2HaTiLQgKmah
 ruLPYDL95L//gYJI2GCrtog4kqJgi8gDxWYWfsJGdnCILlUvJYN0+qe0CzhhdEGp8mzGgfO67N
 q2hOHslsijvTem7e+8EzpGeJnv1jFz/6rrYJxJnVrL3ZsByGbq3aPMJE5muCgzzl/AZKJC2S0A
 AAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716952234; l=1048;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=IgTEkVYd46Ru6As3hGpXvTy9hURuoQjJ4M75ryPeIBQ=;
 b=NG8/Fqi40DTnl0o5BZrocIxFVchLkBPLoaxBqkwU1c+QmRw1GofHLrZpide+starD0xgZ4tj8
 Zw/S3CC56lyAm7+MtKdIyrDDYx5Z2i6Gxtjne3EEM8NHZ1PdjdFaSsW
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add power controller driver support for Amlogic A4 SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- dts: Move power-controller node to be a child of secure-monitor.
- dts: Include power head file.
- Link to v1: https://lore.kernel.org/r/20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com

---
Xianwei Zhao (3):
      dt-bindings: power: add Amlogic A4 power domains
      pmdomain: amlogic: Add support for A4 power domains controller
      arm64: dts: amlogic: a4: add power domain controller node

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  1 +
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 10 ++++++++
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 28 ++++++++++++++++++++++
 include/dt-bindings/power/amlogic,a4-pwrc.h        | 21 ++++++++++++++++
 4 files changed, 60 insertions(+)
---
base-commit: 456f4f5e6e6d3a2228501068a37ce13fe0b333d4
change-id: 20240528-a4_secpowerdomain-5eb005648930

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



