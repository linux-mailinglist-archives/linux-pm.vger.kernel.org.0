Return-Path: <linux-pm+bounces-36194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E0BDEF11
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 16:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF0D1882E84
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701E2609DC;
	Wed, 15 Oct 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yeqZ4FuS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U2Yb/25Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469782566F7;
	Wed, 15 Oct 2025 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537448; cv=none; b=YE86MMSHBlrRX6/SJAUi1ozlVZRk3+EjDSgyYj3EQJrs2v6yhrgx9jw7IG60oQSWuXwdoAI6wP3e9v2PTObTXXWTEpaGWIXYODgCcSxZABAwO8lnHxA4wHzVtqkjRz7ACWzqsNwpISVL1zsD5Lj252i1efoZGVH+Z7jQWL4MgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537448; c=relaxed/simple;
	bh=hVRuz+dYhhjqt7qTfCIuDOea7yuVm9ZeY94c8xKoBl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bp4+Gu8qb5yr0p6kBdFXfG5ZaFeqEonXQj7yfAE7Aublf6fLsExIoiYU5ib0KC6SKQDwq7wxqWqCEtlIqzdfQk2pf0lY8v0LaN1q1lTZAZUU5/ZzisF4OY9af82DfSVqq7IUm6w24T0mmVaUN9o0V6LeXL8KSL+u9OTZPMWV/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yeqZ4FuS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=U2Yb/25Z; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cmtKB1z9jz9thf;
	Wed, 15 Oct 2025 16:10:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760537438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6yHkGFUgeQQv/Xu03jMdrrfgeEJ+J6H1xw7g/yGp/24=;
	b=yeqZ4FuSun6CGxVP9E9OPvrrzAgIC25p/Nsh2z37FQdVkwlC7dA8CqW01s6Dq6t80NyJj3
	tSUpAOuCDAJOhdU3l7ihc63bYzEN2E8kGzbi+1gg29rtYKU6KYEB3QDGN9JY1Hdd9HudFK
	hvy67mF+qS59PDhFCjWYhn5v5tsy+4lJrrGsTbupfXD9V0k1RSBvIFbRpwlziGHgumfgLN
	ij0wZqz3PQ0LtuyihXRxQ/n6ZqjBbRwwJkxX3lPkMaAUKb+tjS7TsqpdeBxqjLwU12CePA
	UCmoBUC6Qr0cTsxScQv3sybnjXoay5BMJp9VEMvqmq5vRraNCYmLRwehqXUedQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760537436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6yHkGFUgeQQv/Xu03jMdrrfgeEJ+J6H1xw7g/yGp/24=;
	b=U2Yb/25ZKAr0SAiIeUFEWscRQrk4ScPA7MlVJdhngD4YPv0N7Xp9AkFOMFvmrDMnXxg7Hd
	FjgH+Ns8qorUbb6ETVQTr6Q+yMEvWOX4UQuEZ6NDKiIUoe9jjiC94gudlYRxQw5nrgE/+5
	l0jhbxPOdyEjRhMYEDW9BzWI2zy0V5M1J+MVaAfH1X0NZt6Ll8QNrQEhVnAXE705oE1KkH
	Z0Ky7tyNxasIdu1vHw24FFmmUzcGUQ9JiyeUM5igrVlvu8d0P4KdV9a/cxrnqbVzRUboxM
	Y2rG2tqr1KzbVrlgQTYpJO17p/g1azqjSlVV/KpOgYTnUxxQpPVGfYi/gJm8Zw==
To: linux-pm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] thermal/drivers/rcar_gen3: Document Gen4 support in driver comment
Date: Wed, 15 Oct 2025 16:09:51 +0200
Message-ID: <20251015141014.156437-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p8w49a5f6hrrnnnecitdicwun7f7z6g6
X-MBO-RS-ID: e0609ddc3c648950fdb

The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs.
Update the driver comment. No functional change.

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
 drivers/thermal/renesas/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 3223de238d014..a143b087a8ea7 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  R-Car Gen3 THS thermal sensor driver
+ *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
  *  Based on rcar_thermal.c and work from Hien Dang and Khiem Nguyen.
  *
  * Copyright (C) 2016 Renesas Electronics Corporation.
-- 
2.51.0


