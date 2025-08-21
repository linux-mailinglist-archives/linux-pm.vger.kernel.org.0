Return-Path: <linux-pm+bounces-32802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49947B2F662
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 13:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A7D581018
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B889B30E852;
	Thu, 21 Aug 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="LfGu6AX6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B712281530;
	Thu, 21 Aug 2025 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775171; cv=none; b=uyLFhClpBtJHMAGLwXf0bG5ecps3P4zHOZmgCT0rTGqtFjtQJenlObDW9ziUCvIGYZZ8jAH6Aa1LtC0YdBPsADc3Y8RdbS5ZbJ/AHFx+hx1y3DpMlj8GzMzQ1vRwJvpZlv2+b+IRrLU/S4gk2tCTa26polF4VXxiELCxUKaB4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775171; c=relaxed/simple;
	bh=QZBYqJR9GIOU0pjiUfjKPUr1zZosXiQty5puvKsrKBs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rHOIlpKyuQzGE28insZ4BGNHZ33Se5pIjpGrFMBY5TQ6ahnt2SKymOUDl6ZZT6NNZxyqc5xu0QGYLOe4Snk1nqgiy2R9CSOHc6Oxc7BBkjYAFccdl5O7Ho0+GHBJYTHBS5ZAq3NvmXxmihc3o7Lq56kQZn5V2vb72sUj4zcLBTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=LfGu6AX6; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=zuDXhUaVbI1o+IrkCJM4dgOmXoR3k3IRboJF1ey+iOo=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755775103; v=1; x=1756207103;
 b=LfGu6AX6zn3iHGQrTUMlYAzfuvKD9+w7FLpMrRhe+UpBuYg+uqjoyFw+mjHz5okN1A9i+N8e
 hYc2N2WdQBjQQ9hpylriRcHU4LOkyTGs+DMtM3c7/JXU/L9vOm1cYHPAr5A0iBXlziY/erduAUT
 Nn1e5icbR0XnrLVwaU7sf5uDW0cz4l3SEvIj056wXLcAlc2FTCjWVUHmN3E/eoI79kr5bcNRhlE
 qnnmWFi7YQEEnt0CIt+7UG1HW07AehFx3+1BQbPPP6ih6eothChCcOZj7cx0kxrqXiNhcnV8VrE
 /Q6zoB+ycVLDF4hTvFx0eb//6q5h7H45k/NZRtu6GEniA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 4292832e; Thu, 21 Aug 2025 13:18:23 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH v2 0/4] Marvell PXA1908 power domains
Date: Thu, 21 Aug 2025 13:17:42 +0200
Message-Id: <20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFYAp2gC/13OQQ6CMBCF4auQWVszLYKUlfcwLLAdYEykpNUGJ
 NzdSuLG5f+S+TIrBPJMAepsBU+RA7sxhTpkYIZ27EmwTQ0KVYEV5mKaW6mxEj2NkxWy0LKyt0K
 VaCDdTJ46nnfv2qQeODydX3Y+yu/6k8o/KUqBQpYn1DnqzpzVxb7u9OD0hItsjvPyhmbbtg+EU
 vYusgAAAA==
X-Change-ID: 20250803-pxa1908-genpd-15918db5260c
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=QZBYqJR9GIOU0pjiUfjKPUr1zZosXiQty5puvKsrKBs=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBnLGerCXv1py7VieHLCO7a/P9lJIrJWStb+pPKuK9GVK
 m1CjBYdpSwMYlwMsmKKLLn/Ha/xfhbZuj17mQHMHFYmkCEMXJwCMJFVuxj+F/soLiya3nja7EVK
 oG3xCZ+Z0/PCZfq2l1b2LN1vy5knyfC/zlGj7nn3+ecyVTKffffWZi4y+ZBhlNVs3j6/t4z7wS1
 mAA==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Hello,

This series implements support for the power domains found in Marvell's
PXA1908 SoC. The domains control power for the graphics, video and image
processors along with the DSI PHY.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v2:
- Move driver to clk subsystem (domains are instantiated by clock
  driver)
- Drop power controller schema
- Drop RFC prefix
- Rebase on v6.17-rc2
- Link to v1: https://lore.kernel.org/r/20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz

---
Duje Mihanović (4):
      dt-bindings: clock: marvell,pxa1908: Add syscon compatible to apmu
      dt-bindings: power: Add Marvell PXA1908 domains
      clk: mmp: Add PXA1908 power domain driver
      arm64: dts: marvell: pxa1908: Add power domains

 .../devicetree/bindings/clock/marvell,pxa1908.yaml |  30 ++-
 MAINTAINERS                                        |   5 +
 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts |   1 +
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       |   5 +-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/mmp/Kconfig                            |  14 ++
 drivers/clk/mmp/Makefile                           |   5 +-
 drivers/clk/mmp/clk-pxa1908-apmu.c                 |   2 +-
 drivers/clk/mmp/clk.h                              |   2 +
 drivers/clk/mmp/pxa1908-power-domains.c            | 253 +++++++++++++++++++++
 include/dt-bindings/power/marvell,pxa1908-power.h  |  17 ++
 11 files changed, 326 insertions(+), 9 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250803-pxa1908-genpd-15918db5260c

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


