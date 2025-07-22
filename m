Return-Path: <linux-pm+bounces-31277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60986B0D823
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 13:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402FB189BD94
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231CA2E06DC;
	Tue, 22 Jul 2025 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKNu0Rz2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5E23814C;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183590; cv=none; b=Xxupjfj6CLqYh9hwXnlu2FGGJHZbJWeSGvG9WcZy+7fzLVgQbe6r7d5RqsJnM0mZ53ozuL74F2ge4spvTjDfIKm+8sHpMV7Z+Caiuu77ScXOx6Is/VnA+ydFzF+DneOcSdLxhXrcrMY1XkRgESKik22rxOBsMsgN0KQBH4XxnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183590; c=relaxed/simple;
	bh=eHgEpwKuiJOxUGx+eQ4DDMrajmv56QJt7Ld7EdpIPc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X0431ARabzoYp6bE/RfMuuhJM4/krok2mxsf5y7XZqtbdvAnDuvmT2wpdPOSm3HkJ5VBgK3W3O0pcxvPeGjAEo9QNrfPGQg6W6UJM1/RVLtwx3w7Et76z0mxbBEz7FjlXU3TkZAWF57a2qE6jYK57AgwhGYGcFSx/BfDDMsEsy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKNu0Rz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 859AEC4CEEB;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753183589;
	bh=eHgEpwKuiJOxUGx+eQ4DDMrajmv56QJt7Ld7EdpIPc0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pKNu0Rz2SvD4CzdXB4Lx+U5hIYKdNbQ6wNSEUhLHHjjOUc1zU4eaHJRudU4601B4N
	 2UWnciWG8MSMDRFV3ETwbabc+K/H2ga10GZdCePww/dT35hLzV1JRnX8jzVIwBKJIQ
	 PvUdHMAYyMgWnles54Z+L1aDOTzRDJCdZ97O5W3F2spUhb1w81Ad6aVjX95bi6cRQL
	 if3ktV/ZYE1uLEs6KWagcdZxxCUH2pT90HsEhWk/952qtHy8VBdyaR/sRsVPM6uESf
	 oo5aTxlKb7wKRIjpcj0fHp13LS6lGP/eAhmcpexhikJNVVey1/c9nQG68DKpyhfFVu
	 dIqckNwPF3Mdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E17BC83F1A;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] thermal: Support Amlogic C3 thermal
Date: Tue, 22 Jul 2025 19:26:26 +0800
Message-Id: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJ1f2gC/23MQQ7CIBCF4as0sxYDaFtx5T1MF5QOZZJSDDRE0
 3B3sWuX/0vet0PCSJjg3uwQMVOisNaQpwaM0+uMjKbaILlseS9uzFzY5jB6vTBjJ8u1HEfbSqi
 HV0RL7wN7DrUdpS3Ez2Fn8Vv/Mlkwzrr+apVWSnSKP7RfwkzmbIKHoZTyBQq+Fg6mAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753183587; l=986;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=eHgEpwKuiJOxUGx+eQ4DDMrajmv56QJt7Ld7EdpIPc0=;
 b=LsAHDWE+cbFu9I6z5V+jNYNswC/DXYMymJ1Bs7O0kSRFhjliia+LLAEk1K/fy/MTeAsRAV8NO
 SbxVezFceXeDGYxfgV9HAbdUFhoftmYo1rrTRQ/XBqJ7ZZ5yYwIsKSW
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add Amlogic C3 thermal compatible string, private_data
of driver and device node.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Modify the binding file according to Rob's suggestion.
- Link to v1: https://lore.kernel.org/r/20250718-c3-thermal-v1-0-674f9a991690@amlogic.com

---
Xianwei Zhao (3):
      dt-bindings: thermal: amlogic: Add compatible string for C3
      thermal: amlogic: Support C3 thermal controller driver
      arm64: dts: amlogic: c3: Add tempsensor controller node

 .../devicetree/bindings/thermal/amlogic,thermal.yaml          |  4 +++-
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi                   | 11 +++++++++++
 drivers/thermal/amlogic_thermal.c                             | 10 ++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)
---
base-commit: 58abdca0eb653c1a2e755ba9ba406ee475d87636
change-id: 20250718-c3-thermal-cfdf0a2bbf52

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



