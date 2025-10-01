Return-Path: <linux-pm+bounces-35628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E5BBB0378
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 13:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E1A16E3FA
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD33E2DC767;
	Wed,  1 Oct 2025 11:41:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3ED2D1319
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318872; cv=none; b=gMp3mrJgEZKYsZsCZk5+iEvFRQMo7AMXhBNmDKwRdKUoAEj9HFOpfGqgPRYLkhAveZLoxCFSxyUdfvPOlAsJ6OpEiOrAoGO3LquBjJ5hwtE8D4y1BAaDjT5Qz15IzItKJj3p8QQAzmkTs2twXEvV8Nr5ypXdAapAVxoh1UkdTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318872; c=relaxed/simple;
	bh=ntLsFEiu5iqg45mHvg0i/VhGZFLZ11eccVxGS2wRk6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oA+EfDxCDorTrTsGJJp5sL09ZynRUXey3Qi7kqKL2m7XuPPMfdTt0+uSBKDB7Ru4n9pCYtHxKKQzjnWWcfFlyS/Gip3XjALT0RDzDn6f2Woa8bg0S60sHY3IUGbSgk0F1v1p31vXrXPLas9ei2P1QxweaO++N3JgAYQ0ITcCwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCb-0006lA-Tm; Wed, 01 Oct 2025 13:40:57 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-001PBZ-2z;
	Wed, 01 Oct 2025 13:40:56 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-000000081FZ-3XfH;
	Wed, 01 Oct 2025 13:40:56 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 01 Oct 2025 13:40:55 +0200
Subject: [PATCH 1/3] tools: lib: thermal: use pkg-config to locate libnl3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-libthermal-install-v1-1-3071fd3f6612@pengutronix.de>
References: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
In-Reply-To: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759318856; l=1159;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=ntLsFEiu5iqg45mHvg0i/VhGZFLZ11eccVxGS2wRk6U=;
 b=SzzkiOTwpcf1TJ7BXhQTDka+ROR3fSi5YXOWWngvPBI91pzkGsr8WKaLwOLEG8XdZfbJczaBN
 SiikRssdXKkBeXg/fz6lgNhXOKSGvAqYVX0bzugvjJzG0CfmrWa/X8L
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

To make libthermal more cross compile friendly use pkg-config to locate
libnl3. Only if that fails fall back to hardcoded /usr/include/libnl3.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 tools/lib/thermal/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index a1f5e388644d31d36f973d3ddce48d036ee0a083..fdde0c4f85b4e511a16c43810590ed45b007a5ad 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -46,8 +46,12 @@ else
   CFLAGS := -g -Wall
 endif
 
+NL3_CFLAGS = $(shell pkg-config --cflags libnl-3.0 2>/dev/null)
+ifeq ($(NL3_CFLAGS),)
+NL3_CFLAGS = -I/usr/include/libnl3
+endif
+
 INCLUDES = \
--I/usr/include/libnl3 \
 -I$(srctree)/tools/lib/thermal/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
@@ -59,6 +63,7 @@ INCLUDES = \
 override CFLAGS += $(EXTRA_WARNINGS)
 override CFLAGS += -Werror -Wall
 override CFLAGS += -fPIC
+override CFLAGS += $(NL3_CFLAGS)
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFGLAS += -Wl,-L.

-- 
2.47.3


