Return-Path: <linux-pm+bounces-32018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D98B1CAED
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2983256258D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1529E0F2;
	Wed,  6 Aug 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="HJwTOEJx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877923F295;
	Wed,  6 Aug 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501717; cv=none; b=jKsOD8uQXIXie9hX2V1CAbvjBXar3gHIC3xIp1UJVvfi+IurCeGKOR5EnK3cVVrbIImKFoUheXiKzVJhgkuP2H51ZOd19g9hkgWddBN2Bfvp0ZxDgOskPE42C05Ong84r7cVlcw5mD3q4uuu69/ajGniSbU/qN0ArdciW/UsDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501717; c=relaxed/simple;
	bh=OCq12Yc0a/7Oxk3oGpeH/45uPJl+C1Cx+HEhTuUSHqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ItShKlLAYiyUGiLhK0G6e2MqjtVdxzQpNIdOwwFfJgm1DmrMtYzVt2ccR2my/itTmEsFmZRTLZ4udgsjTDXSAxE3FG0tucDY2IhUpBx3D2L4lavnZzcw9KD/PXf00nBPmQ60MYIDagZJyNPd69rJfajjoKLKBP52wFORVaAjCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=HJwTOEJx; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=qx2Ii0d1wljD8zsF+sV0ysqIc18W0P+YNJtBHNs6vYE=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754501629; v=1; x=1754933629;
 b=HJwTOEJxUjB+/QELnjFqLYBQX+JIpaWvXeeqLVvIJj1AVY59iHTPBDigBXMwQrrfr4xMH0qk
 T3bT5cKHUXhs1X/RlWiF0ONRKcUl6PBvjemjfhnJ7on67AI3rLyQ9MzI4Qx0ooJvoD31hzK1pZa
 Vr8i4kXyoMqkyhC3m/ccqAitSaU02qoXWE/7jjaCJK8BVKcl7MgOwmp4z3D5fdJBKrmDAZzGzEd
 /KScdYwRAPxnICkA4A0X6t3FLlJ5RMFsXV/enWKoAJz8nk80cFlL88CHS3aKBoJWJiKsTsFvwMd
 grfib+8lCt7LitH0/y0CujI/07yy40RNyjHcDYbS6DkZA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 956df8b5; Wed, 06 Aug 2025 19:33:49 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH RFC 0/5] Marvell PXA1908 power domains
Date: Wed, 06 Aug 2025 19:33:19 +0200
Message-Id: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOCRk2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwNj3YKKRENLAwvd9NS8ghRdQ1NLQ4uUJFMjM4NkJaCegqLUtMwKsHn
 RSkFuzkqxtbUA71DEAGQAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=OCq12Yc0a/7Oxk3oGpeH/45uPJl+C1Cx+HEhTuUSHqU=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmTJ/5+vveagHOXpQ77hDM6N5mulE4R2pU1u/O2wE2Xq
 K9CFpUeHaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjCRJYEM//NXlgqcvt3dv/LQ
 Xet5C40ecnn4z3dpiD4qkfD6nbNjWx8jw6Z9Z9NdBQsdTcosQnfdXBO4c+mOGT8/qG35lL3fWfX
 IbW4A
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Hello,

This series implements support for the power domains found in Marvell's
PXA1908 SoC. The domains control power for the graphics, video and image
processors along with the DSI PHY.

The series is based on master as the MAINTAINERS and device tree patches
depend on the very recently merged initial Marvell PXA1908 support series.
That series can be found at the following link:
https://lore.kernel.org/all/20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Duje Mihanović (5):
      dt-bindings: clock: marvell,pxa1908: Add simple-mfd, syscon compatible to apmu
      dt-bindings: power: Add Marvell PXA1908 domains
      pmdomain: marvell: Add PXA1908 power domains
      MAINTAINERS: PXA1908: Add power domain controller
      arm64: dts: marvell: pxa1908: Add power controller

 .../devicetree/bindings/clock/marvell,pxa1908.yaml |  36 ++-
 .../power/marvell,pxa1908-power-controller.yaml    | 105 +++++++
 MAINTAINERS                                        |   5 +
 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts |   1 +
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       |  36 ++-
 drivers/pmdomain/Kconfig                           |   1 +
 drivers/pmdomain/Makefile                          |   1 +
 drivers/pmdomain/marvell/Kconfig                   |  16 +
 drivers/pmdomain/marvell/Makefile                  |   3 +
 .../pmdomain/marvell/pxa1908-power-controller.c    | 347 +++++++++++++++++++++
 include/dt-bindings/power/marvell,pxa1908-power.h  |  17 +
 11 files changed, 561 insertions(+), 7 deletions(-)
---
base-commit: cca7a0aae8958c9b1cd14116cb8b2f22ace2205e
change-id: 20250803-pxa1908-genpd-15918db5260c

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


