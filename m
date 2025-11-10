Return-Path: <linux-pm+bounces-37741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB7FC4735B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 15:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEE91349B27
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646041F30AD;
	Mon, 10 Nov 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d5DJnlEk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xn7CL6qY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3F18A956;
	Mon, 10 Nov 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785044; cv=none; b=THxeHryKl5ROtCKyJyeI1KBUFfxmNPNpD4KJ+PM9+xlctRsjGdl9PlnXuzUVo8X1yMknQnpfTyFuV8Llq4RNVgvLt2I2hBqch2eJlwYPji2msBKazYOg5/fQ1LaqW3oJA4lmnDLIbfuRYBDcCKN2qE4GaJX8rQyeUcn3GFffIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785044; c=relaxed/simple;
	bh=SQoXk74WqLHLGZm8XGpIjPfQL0lJE+7kuDFG/sPKul0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NenebNxp1ViUQJBKiDlkLUxuyuVKnVQ86XO57ZeP9NeNxl9ym92o6bKQA+gMlQE44YaTS1ar0trQmm659vB6CwPoAVAmWQWRGdpHpGqelHTSqa+9JeNXciAOlCo9C1gPAuktHiLbx7DanLeQ/alEVV6q/kdQT09NIX2WKYMFL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=d5DJnlEk; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Xn7CL6qY; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d4sXJ036jz9v72;
	Mon, 10 Nov 2025 15:30:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762785040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bt/BZHmOKtUX9N0i2fSw7wnNW+thf9V01OfBsoitRQw=;
	b=d5DJnlEkYWcNzUzazb0T1t4HWFbOQpY8Ml5lqwNIU6haPseuIh1tIKoWaBz1O4SELNzrEI
	E1SNoAJD23WMN8j+6Mw93jua4V0/I9FD0m2VOgADATc4NdMW5q3hPGrZRMRqSRZa6jtWsK
	9i+i1xAob3OXd3a4TNjo7DK8WWm97TmhNi4sEVkriQ6jzBcPAOpVK7Ydc69ibUVR3d5Hwq
	+fDiziTFERZnCy+/6cRJFchy4UDRVwQ5UWVNb3YsHSaMDKFoSqj1Lakz8FIsSJereCHFcG
	auY0hfq8zqtiowN6Oy1c7egr2lQs5fgnH2GXxV+XzEab1DamoZMmkSb93AlRsw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762785037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bt/BZHmOKtUX9N0i2fSw7wnNW+thf9V01OfBsoitRQw=;
	b=Xn7CL6qY07ieismVMeDNSKD/HEL6yhRuy7pkl+iSjuL7EqJsUFZjJ8j+yrbcBKVl7TsBDH
	GzmAPVYsEDt8QZK4TjfFSNXhOdIyHqM0ltrbUR6EmKulvDwAEegINjaLkkPHyMObY7uxDe
	1gsaOP3O7oKnS2ieYq3aXes07KLpF7H3WUhV81vLml2z/UkuMla2Y8HcTlv9ZctoMPVPou
	LcRrQHFxwI7DzHgHBBD0uahTX0v6yYYGlLxkdGvHGR+ImAF/s8rfITejSRo4fhKjFHxTbH
	gvbiROKdoheGefM4OhzO1U4eazgbP1Wk6yJY9cfOmUR4woPw7ye/pypVNVxIZg==
To: linux-pm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] thermal/drivers/rcar_gen3: Document R-Car Gen4 and RZ/G2 support in driver comment
Date: Mon, 10 Nov 2025 15:30:13 +0100
Message-ID: <20251110143029.10940-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8bae5651a9c543495e9
X-MBO-RS-META: omgrfswpzwnczhsa71f8oh4sr1ucmgei

The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs
as well as RZ/G2. Update the driver comment. No functional change.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Fix up the commit message, include RZ/G2
V3: - Replace Gen3/Gen4 with Gen3, Gen4 and add RB from Niklas
    - Add RB from Geert
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 3223de238d014..1f4f02e939ef8 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  R-Car Gen3 THS thermal sensor driver
+ *  R-Car Gen3, Gen4 and RZ/G2 THS thermal sensor driver
  *  Based on rcar_thermal.c and work from Hien Dang and Khiem Nguyen.
  *
  * Copyright (C) 2016 Renesas Electronics Corporation.
-- 
2.51.0


