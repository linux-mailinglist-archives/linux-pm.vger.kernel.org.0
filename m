Return-Path: <linux-pm+bounces-33417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC9BB3C085
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C157A0107
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA86932BF43;
	Fri, 29 Aug 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="HXjX7YEC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D314F125;
	Fri, 29 Aug 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484555; cv=none; b=A0aegC7r8V2QfANnJF9kP7EqgqlJWyB/V09eC9hw+XMgD73OqSusiWkdShSTqmTFL9yuSJwUV0KxO0g1QRxaEVps4Upef62fj6vWryua3pIkLuWdtPKozd/mNl5lBW4YWqjQew9qFWPQTNaQvljNuJ1JzhdbYYyPfCucI+Fcz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484555; c=relaxed/simple;
	bh=JKCcxAlK8TvFpSk8Bwd4W00kEBYetq9vMdyLZwN3ick=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o4b7bs/fJrFBnC7yAK9cVSqirsFZziO0W4i0BvTcjiQEbLcOUpMLvd9eCVpgetMwnh/petDx++Coq9xkPpMwwjG52BFF10IDUweeTANgeU8uyhDXU4TOu2DMCdmNIw2lq/f2yuMgUi1tuD2WRZsih/zMi7YwmjSJcfiGBZpnJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=HXjX7YEC; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=yDgwwhibV5G6rD0wsVW6JGZiOr/aZ4s7RO0qSoDe2CQ=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756484468; v=1; x=1756916468;
 b=HXjX7YECBV/VZQYLZ4WUzLI5X7f7X41NlS0kc7Isujoh63tPJasWMBaGhlLFrsIokoqibE2q
 NiqCOLeI7tpIyV/sCX4UWg02Jo5+JSY+zOQzBCqWG2L6uDUwjNtMSbXkz2R26efmt6GabFVUiVi
 1vizWN93Jb7m4yso8ZlWDZBPm46PmQru9/E0fPQNZMZqK7iTfMLXclVcy3A36Lpa8Zuk78x/Dq5
 ygSOzPxtGpiqOINmQ05xJ3OM3ZG67ya9sobSZ9mcpBOzZ2tPqTaMnIQRB/Lxi5G/fek4c1b1HD8
 hddumAsHcpjVSIZdMd1r/Ix4PZgCKAOKzI8vHwJBEpDYg==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 8670617b; Fri, 29 Aug 2025 18:21:08 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH v3 0/4] Marvell PXA1908 power domains
Date: Fri, 29 Aug 2025 18:21:03 +0200
Message-Id: <20250829-pxa1908-genpd-v3-0-2aacaaaca271@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG/TsWgC/23O0QqCMBTG8VeRXbfY2dRcV71HdKHbUU+QylZDE
 9+9KQQhXf4PnB/fzDw6Qs/OycwcBvLUdzHUIWGmLbsGOdnYTAqZiUIoPowlaFHwBrvBcsg0FLb
 KZC4Miz+Dw5rGzbveYrfkn72bNj7Aev1K+U4KwAWHPBVaCV2bk7zY1x0fFEf0gcxxnN5sFYP8U
 STsFRkVrMoUFFobZ/1TlmX5APyqmaT4AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2164;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=JKCcxAlK8TvFpSk8Bwd4W00kEBYetq9vMdyLZwN3ick=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBkbLxefDhNeZcY4aarJStZZsfvvx2VtyBNoC1p8ZIPpZ
 Z5UrzmTO0pZGMS4GGTFFFly/zte4/0ssnV79jIDmDmsTCBDGLg4BWAi6QcZGZY68N9/xByordPt
 cWq1ns/e8+EdvXkvY/wZn0QcnOumsYqR4WXc7YtL/K2eyCTsXPRusVLFB7/Ouv6Mif/Ybzw9+rf
 7NDMA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Hello,

This series implements support for the power domains found in Marvell's
PXA1908 SoC. The domains control power for the graphics, video and image
processors along with the DSI PHY.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v3:
- Move driver back to pmdomain subsystem
- Instantiate using auxiliary bus
- Small fixes and refactors
- Rebase on v6.17-rc3
- Link to v2: https://lore.kernel.org/r/20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz

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
      pmdomain: marvell: Add PXA1908 power domains
      clk: mmp: pxa1908: Instantiate power driver through auxiliary bus
      arm64: dts: marvell: pxa1908: Add power domains

 .../devicetree/bindings/clock/marvell,pxa1908.yaml |  30 ++-
 MAINTAINERS                                        |   4 +
 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts |   1 +
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       |   5 +-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/mmp/Kconfig                            |  10 +
 drivers/clk/mmp/Makefile                           |   5 +-
 drivers/clk/mmp/clk-pxa1908-apmu.c                 |  20 ++
 drivers/pmdomain/Kconfig                           |   1 +
 drivers/pmdomain/Makefile                          |   1 +
 drivers/pmdomain/marvell/Kconfig                   |  18 ++
 drivers/pmdomain/marvell/Makefile                  |   3 +
 .../pmdomain/marvell/pxa1908-power-controller.c    | 268 +++++++++++++++++++++
 include/dt-bindings/power/marvell,pxa1908-power.h  |  17 ++
 14 files changed, 376 insertions(+), 8 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250803-pxa1908-genpd-15918db5260c

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


