Return-Path: <linux-pm+bounces-34021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8012CB463B6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 21:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367A4A67241
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FEF280330;
	Fri,  5 Sep 2025 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QQWXaIl2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SBgHvY9V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF327FD49;
	Fri,  5 Sep 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100823; cv=none; b=T/I5C8Sm7jK8qG5Tt+wETHtd8s1UK/jxdJcurj84PFMEoFQhm/HE/Ba4UZrTWPG9eODlMOlZoGWuOxI8mhvyUyOdPZ+WxUgUY72kd5nTdwxfaNXK3DAKQdqtDsWI3sKFp6eUNbdpR66FDGUVR2+Ybfb2u9cZfHbCbFpxIJcCyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100823; c=relaxed/simple;
	bh=BKAG6gbAfyiwhHKWbu304WO/aXqY8k5tYOMhQXEOZKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fz/g/VfEFEjqQNkwm/Gr5lLJSYWTYCV3I9ejLEp1eNy2KunazotH6vQXhYvihgL11Ijslcin/y8+ZHREHJNOamX5Bvozo0XQD9nOhEhMCKwrTjbpEhaJPgxKlIQnDntHh+i/RPYYqLedUpKVAdN9KXfVujQJV23/kIxZvmRLvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QQWXaIl2; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SBgHvY9V; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cJRNM20yyz9ttf;
	Fri,  5 Sep 2025 21:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757100819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUyjsTNoyrxlPgnrd8bs9zvExPNmWRDlCJ/WhY73fao=;
	b=QQWXaIl2yypp3jaauXy7SS+q1XAZCxPDkfXCkt8meAKlivJQIJ08eJc9kXJeJAGGOAuep2
	x4a+TXm68xoZXUEV65/1G3EevsteXc7AIkV0feswwQkS9MXLtylhZw05TAHsBVe3D8/FUa
	EV1UBy1sVd6REqLEJzEXN8nlC2lRyLacTa3RTjpu/T3ZA2nzSIEVLwPPnk7Wx+t/96kiPr
	cYu52wcrRES1OA0bTuz1agNc3ZEU3lEw8QynlkRrLVh6p4aq1T1o5AdrkRyh6DqKNCSm6f
	y9/VPFTFJOAhROpw2qkLiQd2bmvshR7W7fILWJ7L0xRNsrk7/06ZlljOiZuclA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SBgHvY9V;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757100817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUyjsTNoyrxlPgnrd8bs9zvExPNmWRDlCJ/WhY73fao=;
	b=SBgHvY9VrXPamq6w+9jLKEjWlTGwuWyETaweVO54VBfi8CboA3KWD2PfkU3wGdIdpZodZn
	MzpRxqNR6oyFKcnKF1YBmPAGklMB+G38JB0C5EW4M7SUB+B9UUVyJvCAoXIhRR0rAvf1IY
	kx4+niJysiHemdxLfi57gmwOs0IKU+WiuM5XmClCEj54CpKZm0oN1TR0vj1GJjWggnKSNN
	GVeCUrfPqRPXGpp6vx4mXKNCtZnZh2yVAJBEISi12yZs4cW9mi5+ZHUBgRcdHrXPDrb82l
	FVzS9AlcRImt10qxgyXPmKky/1WZA69GbXiH5tR3dXHKCzufCIX882YcnuzzFg==
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
Subject: [PATCH] thermal/drivers/rcar_gen3: Document Gen4 support in Kconfig entry
Date: Fri,  5 Sep 2025 21:32:56 +0200
Message-ID: <20250905193322.148115-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 86ts97i7kqoik5j3mkogzf4ktr4378ua
X-MBO-RS-ID: 9cd58b5991c2131c8d4
X-Rspamd-Queue-Id: 4cJRNM20yyz9ttf

The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs.
Update the Kconfig entry.

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
 drivers/thermal/renesas/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
index dcf5fc5ae08e4..f4af8c7f28b05 100644
--- a/drivers/thermal/renesas/Kconfig
+++ b/drivers/thermal/renesas/Kconfig
@@ -10,13 +10,13 @@ config RCAR_THERMAL
 	  thermal framework.
 
 config RCAR_GEN3_THERMAL
-	tristate "Renesas R-Car Gen3 and RZ/G2 thermal driver"
+	tristate "Renesas R-Car Gen3/Gen4 and RZ/G2 thermal driver"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
 	help
-	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
-	  the Linux thermal framework.
+	  Enable this to plug the R-Car Gen3/Gen4 or RZ/G2 thermal sensor
+	  driver into the Linux thermal framework.
 
 config RZG2L_THERMAL
 	tristate "Renesas RZ/G2L thermal driver"
-- 
2.50.1


