Return-Path: <linux-pm+bounces-19413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925B79F602E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 09:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D337A163984
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC8D1714C8;
	Wed, 18 Dec 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9frgidH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C7165F18;
	Wed, 18 Dec 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510907; cv=none; b=fVcPgot4RO7y/qFotGYyGaS251+yo8g79U7WM+b9uGVgGtc1se2a4Hg6YNiLl6gQsPCXqV5ZyQu2V8wvYJawRMgFTq9wQPHjGB2gd7kDpOZRuVuc7eB6Qeym2yWMZfwFicpE0D+hvV9Pxfkhn76vgh+7zeQrNYExcbsgAYlshhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510907; c=relaxed/simple;
	bh=+QDle9JEkjDQ/QxtUf4707ZXIzare578DXwCr4H8Ixw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q0fipliOcLJ1ill1NWYdNma3qv84SIQdfYspHGPUvGK92zvlgYg81zsK6cYGXuwrQrnLrQSy6xRmlK7xO2Cl0uY4Ywgyn7klCQrLJNFyfugKaKu5BGSoPnmI2jksUILnmCde6dW+mqxb3ICZPed3yGoxCgx9m4lbr9S4LqQh13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9frgidH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9929C4CECE;
	Wed, 18 Dec 2024 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734510906;
	bh=+QDle9JEkjDQ/QxtUf4707ZXIzare578DXwCr4H8Ixw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Q9frgidHErI5z4Y11uXY2cGlaKEHQT+utRObe9PPtfIvrbZfkFNbQBhF02lVFNV86
	 AW6Xoc6zhvgdOsEMdC+Ifz1q/ZgUbDDiPjjhvVNAy7VI/dwwcT/lcTAGXNHpX1oOnP
	 cfVCdr7/OgEkrBHrFt9RVkXi18AvaWewZLc4SorFWi33EJjf7gyjawD7S+QcBfEj9C
	 PtZGVlZsfIPI6eQ8u2KaF6y44GyZhip/CojVAnGYEa/kCsvsx/DchMit+gKnCAoBI4
	 UzUCOFlEOEHJXv4B1VMw7EvVJxVd+sHXvclfuPfwTRtvFhhpopwTCry5TXmL3VfOD9
	 JNdYA91noA5wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E9FE77188;
	Wed, 18 Dec 2024 08:35:06 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v3 0/2] power: supply: gpio-charger: add support for
 default charge current limit
Date: Wed, 18 Dec 2024 09:34:59 +0100
Message-Id: <20241218-default-charge-current-limit-v3-0-b26118cf06b5@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOJYmcC/4XNywrCMBCF4VcpWRtJ0mtc+R7iIk2ndqAXmaRBK
 X130+JCXOjynwPfLMwBITh2ShZGENDhNMZIDwmznRlvwLGJzZRQmVRC8wZaM/eex5XiamciGD3
 vcUDPC22g1FkuCmlYJO4ELT52/nKN3aHzEz33b0Fu1zcs5W84SC54WUldG1EAKHPuEeoOiI52G
 thmB/XppX88Fb0sr6qitaBFbr+8dV1fjFA2LBsBAAA=
X-Change-ID: 20241209-default-charge-current-limit-69ae7945061a
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734510905; l=1729;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=+QDle9JEkjDQ/QxtUf4707ZXIzare578DXwCr4H8Ixw=;
 b=AA7hl+bQkoeVXU0gCuOpYd+ewT4c9d+ccmAsRG23kspyCjmivC0iGHf0yAPSXO4a+n8dNivw5
 WI6XFA2jAHzDHJDSoCaAE5ULGGFE2zlujAAHNBdLZrPL1ovJW6bcqsG
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

With DT properties charge-current-limit-gpios and
charge-current-limit-mapping one can define charge current limits in uA
using up to 32 GPIOs. At the moment the driver defaults to smallest charge
current limitation for safety reasons. When disabling charging is
supported, which should be common, the driver defaults to non charging on
probe. By having a default, charging can be enabled on probe for such
devices.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v3:
- Fix commit msg for "dt-bindings: power: supply: gpio-charger: add support for default charge current limit"
  Add use case
- Link to v2: https://lore.kernel.org/r/20241213-default-charge-current-limit-v2-0-45886fce905c@liebherr.com

Changes in v2:
- renamed DT property charge-current-limit-default to
  charge-current-limit-default-microamp
- Added dependency on charge-current-limit-mapping
- Added intention and use case to commit descriptions
- Added charge-current-limit-default-microamp in bindings example
- Link to v1: https://lore.kernel.org/r/20241211-default-charge-current-limit-v1-0-7819ba06ee2a@liebherr.com

---
Dimitri Fedrau (2):
      dt-bindings: power: supply: gpio-charger: add support for default charge current limit
      power: supply: gpio-charger: add support for default charge current limit

 .../devicetree/bindings/power/supply/gpio-charger.yaml      |  6 ++++++
 drivers/power/supply/gpio-charger.c                         | 13 +++++++++++++
 2 files changed, 19 insertions(+)
---
base-commit: 57cb041f61d4abcf8dfa41259df27d081ab4cb6a
change-id: 20241209-default-charge-current-limit-69ae7945061a

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



