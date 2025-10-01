Return-Path: <linux-pm+bounces-35627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3D7BB037B
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 13:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E2B1925317
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 11:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4AE2DC33F;
	Wed,  1 Oct 2025 11:41:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629A2D8DA3
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318871; cv=none; b=FJXtFQWa8RWTExD16GDvMgBLgc9x2vUyEp2tbRmS8Yl1IM2hMeCeBq4JCfW4cQN6SxtYbVq6fzV0vGCnKzsb9mlzrkewJzMddRuF2sHh76XFGeTNC23tAZs+7o3QLn5HB2eT6YACpOsiyWmVFB1oyNmt+oFYfgi7bd5aduvCu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318871; c=relaxed/simple;
	bh=sCVcLFGSHBgzzlgCNeih1gUgQqgivxmdb4FjukvBAmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UiBGD41nAdumzxf5u2vehaNxEd0Ytd2MAIV6wepYHjNjWeYFQMYTjjEjxQaVCsE/rswV53vNpMQ4dt6GHFQqc7P5IWyEsD1xWNBBo2hLGQI9eI1kWunTrwekNUWxQlPxhk3Re/tO63fF/0pNUCpto9JRyzYSo7h/0YUx8PlHLOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCb-0006lB-Tm; Wed, 01 Oct 2025 13:40:57 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-001PBc-31;
	Wed, 01 Oct 2025 13:40:56 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-000000081FZ-3ZmJ;
	Wed, 01 Oct 2025 13:40:56 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 01 Oct 2025 13:40:57 +0200
Subject: [PATCH 3/3] tools: lib: thermal: expose thermal_exit symbols
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-libthermal-install-v1-3-3071fd3f6612@pengutronix.de>
References: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
In-Reply-To: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Emil Dahl Juhl <juhl.emildahl@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759318856; l=1350;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=7+99HolQ3vKPiYZj9kA6mhNE7Y7l1NRpdmL61qkcvDQ=;
 b=ItLahm49/P2FYDQB9rfkpJV7pmpab07SAEAEYHVD+xZTUJ8bG2ut/qYgSd66JTNFDjGAgdrVA
 +bDlDhxye/UDEDlWReOBW3BASv1h3YpIZEj6jpQWQljcguICXW9HwfH
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

From: Emil Dahl Juhl <juhl.emildahl@gmail.com>

Remove duplicate entry for thermal_init and add the missing entries for
thermal_exit and their respectives in cmd, events, and sampling context.

Signed-off-by: Emil Dahl Juhl <juhl.emildahl@gmail.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 tools/lib/thermal/libthermal.map | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/thermal/libthermal.map b/tools/lib/thermal/libthermal.map
index d657176aa47fb52f2db0178069624d2feb9d0c27..1d3d0c04e4b6125f81e6e670fe3c10ab79e681d6 100644
--- a/tools/lib/thermal/libthermal.map
+++ b/tools/lib/thermal/libthermal.map
@@ -1,6 +1,5 @@
 LIBTHERMAL_0.0.1 {
 	global:
-		thermal_init;
 		for_each_thermal_zone;
 		for_each_thermal_trip;
 		for_each_thermal_cdev;
@@ -9,9 +8,12 @@ LIBTHERMAL_0.0.1 {
 		thermal_zone_find_by_id;
 		thermal_zone_discover;
 		thermal_init;
+		thermal_exit;
+		thermal_events_exit;
 		thermal_events_init;
 		thermal_events_handle;
 		thermal_events_fd;
+		thermal_cmd_exit;
 		thermal_cmd_init;
 		thermal_cmd_get_tz;
 		thermal_cmd_get_cdev;
@@ -22,6 +24,7 @@ LIBTHERMAL_0.0.1 {
 		thermal_cmd_threshold_add;
 		thermal_cmd_threshold_delete;
 		thermal_cmd_threshold_flush;
+		thermal_sampling_exit;
 		thermal_sampling_init;
 		thermal_sampling_handle;
 		thermal_sampling_fd;

-- 
2.47.3


