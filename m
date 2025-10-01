Return-Path: <linux-pm+bounces-35626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE5BBB036F
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 13:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EA217C145
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7272C3263;
	Wed,  1 Oct 2025 11:41:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3D2D9EF3
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318866; cv=none; b=DQep4B3EprOyjs7eaqgBcYrb4N9gPDCxRWwxkagqbpUXKii3ju+y0eO/wnTnQbwKQhBjN7xt8Ga6emYZF901tkYwKNScJQMIW39js/avReRKn43BSwaZS7MN4gWZpKUJoeNM7p4GmVVgr6qwY9HREArHI2oCSd89dUpSi2d3MUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318866; c=relaxed/simple;
	bh=+v2vvAqcHagB/C/+KdfLz1rNq1m+3Xlq6Y0GMJwkUpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VW1Kau1BB4ZQISZM8mmA+02HtRpQUUR5NEq6v+Lie9MtjcaXrHtH3CoX7EXejRtTbFYLknjY7UjrXeHMNfeERRjkt103rHEONPLhnnL10V90fKXHrmgTcqn/ITk3GgXVdoZmKjdpXRgpFZnm2wP3sxD6CvvcIoY9/AizxFMywkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCb-0006l9-Tm; Wed, 01 Oct 2025 13:40:57 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-001PBb-30;
	Wed, 01 Oct 2025 13:40:56 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-000000081FZ-3YpS;
	Wed, 01 Oct 2025 13:40:56 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 01 Oct 2025 13:40:56 +0200
Subject: [PATCH 2/3] tools: lib: thermal: don't preserve owner in install
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-libthermal-install-v1-2-3071fd3f6612@pengutronix.de>
References: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
In-Reply-To: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Emil Dahl Juhl <juhl.emildahl@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759318856; l=1105;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=a2t3Jgg6ZT4N7aIkHuuOSj/xuMgYoif4tSnJKDA+4rg=;
 b=RKucA8DjTmWMV84NWMy04bQpZa7ZYSgy4Hotlke4jo3/RONephFFKZKTPzHW9Ox7Az8oV9wtx
 WrqLeuT//a6CI2d9+co1Ie4NQlsN9ObmVHlLfeNlTgATk2FcgXC5Kov
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

From: Emil Dahl Juhl <juhl.emildahl@gmail.com>

Instead of preserving mode, timestamp, and owner, for the object files
during installation, just preserve the mode and timestamp.

When installing as root, the installed files should be owned by root.
When installing as user, --preserve=ownership doesn't work anyway. This
makes --preserve=ownership rather pointless.

Signed-off-by: Emil Dahl Juhl <juhl.emildahl@gmail.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 tools/lib/thermal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index fdde0c4f85b4e511a16c43810590ed45b007a5ad..41aa7a324ff4d76351b89d7d7cf382df3fc14052 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -139,7 +139,7 @@ endef
 install_lib: libs
 	$(call QUIET_INSTALL, $(LIBTHERMAL_ALL)) \
 		$(call do_install_mkdir,$(libdir_SQ)); \
-		cp -fpR $(LIBTHERMAL_ALL) $(DESTDIR)$(libdir_SQ)
+		cp -fR --preserve=mode,timestamp $(LIBTHERMAL_ALL) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \

-- 
2.47.3


