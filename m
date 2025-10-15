Return-Path: <linux-pm+bounces-36204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65D7BDF819
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 17:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6443AF6C6
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA47733439E;
	Wed, 15 Oct 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fo2U0x4z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GjWAXZRo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A20326D4F;
	Wed, 15 Oct 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543972; cv=none; b=VZr3v4eqPh/ELVoYZbPm4tBnD5kB5lls2/zGZQCsjz7XKvRzUhUq8mQl4t5hOCWf8dccyOk03/fglyg3cq5zO6mZfCxji2ZhKiyfu7Dn+aYryFi8XOtJOP/rpWVUvOdTuKAKj8A+7bFga/108PY2ElSVVt7CBGOBhytb7VP58fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543972; c=relaxed/simple;
	bh=O60ztTKjUGPwjsyLeDu6TYyivr5YcwoXVuDMEcpRr1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cRhpBGrvHXuI2bVkF2wCAbK3gSfiAJVQpSnd7frgXIczmuLggoczm3Z4UbAfbvCDdDzOnpHuh8UvOjqnNlupnJum7qzM2oQ3g5IxI8ZPCof6oopKpud/iiIIcp8uGY8boVoQtHt1Iy3SNG5lrXzIXUN6kW4ODB0KIGeA4VdlJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fo2U0x4z; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GjWAXZRo; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cmwkf6nTxz9tLf;
	Wed, 15 Oct 2025 17:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760543963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZVBU7yZYTKgZhbNlkFacT1Auj/1xRXbeqP+sCIsTIzM=;
	b=fo2U0x4zofZfWYXHnC+LiyrpfGWJqvzsRPnPA27qR9o5Yw5CfGy/rND1ReI2yiwLy+EUzJ
	6nO5jmtmafcDB8azAatTbTM7ikEJULX7JLFdhXjFCFUnMqc6OEpaL010+2LRMay6hJartd
	4u6QaukCqb5XdLXxRdvE0ZmSVwzR9yclXxKfFreEwl/bJsy9iIOwuKElJebrmpg2rLLyAE
	Rh8kekwzKvrOW+xqPCU0ODHu1VJYRhKRxeKyKwDIB5QyzCLB9N0lH6Fg6/QMV9iZP3Kf7+
	1MGJOOvsry1+zru3U74li/jpWHeeYT/NtBvC8m+o8pc1truBm2IOl5t2dIUt+Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=GjWAXZRo;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760543961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZVBU7yZYTKgZhbNlkFacT1Auj/1xRXbeqP+sCIsTIzM=;
	b=GjWAXZRobL9mwmxnqm/NN4YISQQHo2Ne1usRhhuNmQTa3EUHcRHWtg+NKppIY909R42NO/
	Grb0eu7vFV2s91GMjOhFIFKmmds+zLVoElnbDrpYOX94jjjirWl2xWXB0gU/6AVXZEICBu
	xZqev+EwtgbUfI5VNq9Nz68rcNuirhlpRKN2AZfhMtaiH3NRtzWFKvibAIuXmVcx8vfVH5
	k6MVyiPOitUU/Vxmvbi19sxyBEtX0JDamlNFIlR3M6N0LqyoxcDssCu5zvwwv8VlX1nfGp
	ZIGq1txCXeT0cT9JHhOqtqqkza8bp+Kyun/ccROj9+WSsW2JhBYdYrHFF1U2Rg==
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
Subject: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and RZ/G2 support in driver comment
Date: Wed, 15 Oct 2025 17:58:52 +0200
Message-ID: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ca9chrweauawbj7f43euturdyxr5a4y5
X-MBO-RS-ID: 690e1a3710378926475
X-Rspamd-Queue-Id: 4cmwkf6nTxz9tLf

The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs
as well as RZ/G2. Update the driver comment. No functional change.

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


