Return-Path: <linux-pm+bounces-35625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D59DBB0375
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 13:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9003C0A8F
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D502DAFD6;
	Wed,  1 Oct 2025 11:41:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D92D0629
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318865; cv=none; b=p8Nm9VQuSJ+EfTqVDgZPiEBXEIsZ7eFgGFgP72Lfn2NMVIwU0htA5J6lqJT9DrLHsDkL2kUncJ7ttgGNY9UllmTu7msEFcG/HFZSILq2QMVpsBKcJOyKWgp3eoJ250VbKR8WtYu7oUH+iZ7WEdRTTqFB0Hjt9Ho+5n+BHx1HOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318865; c=relaxed/simple;
	bh=Q5FxtEYvVOpMUeP3v6q8TEC3bcul3a6j2vMZSItNoU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GGKHEZPuBZvRlxTIYii4jEaL8CKM+7eU9S/7zta7B2jvf5Zcmmu3+jWUL3lqy9aNra8dACSPJSpDO0olxQc5w3TAK10ZX2+moLBx0K4NzwuJZM/iaWMOIQ0+yQqRp6Ztdug11eTBcolwnjyVbN9zc/3wH9eo+zE0CMtBWjDW+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCb-0006l8-Tm; Wed, 01 Oct 2025 13:40:57 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-001PBa-2x;
	Wed, 01 Oct 2025 13:40:56 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-000000081FZ-3WS2;
	Wed, 01 Oct 2025 13:40:56 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/3] tools: lib: thermal: compile/install improvements
Date: Wed, 01 Oct 2025 13:40:54 +0200
Message-Id: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYT3WgC/x3MQQqAIBBA0avErBtwDKO6SrSwmmrALFQiiO6et
 HyL/x+IHIQjdMUDgS+JcvgMKguYNutXRpmzQSttSClCJ2PaOOzWofiYrHOo6kYTtZbHykAOz8C
 L3P+0H973A3HYoypkAAAA
X-Change-ID: 20251001-libthermal-install-0682119aeb35
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Emil Dahl Juhl <juhl.emildahl@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759318856; l=683;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Q5FxtEYvVOpMUeP3v6q8TEC3bcul3a6j2vMZSItNoU8=;
 b=eTICfwMUVRxdyvxdLlGY2fUhGjpheeTQ0VRqe7lqU+727EuUUSjwGbpTCSkdrXEmrCIu4njzk
 pw2NHCqIkJQAHlja8Tx0AvPxE4kbGzX4kcakr3HXqkzgIHCAwquVHJk
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

This series contains some installation/compilation improvements for
libthermal.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Emil Dahl Juhl (2):
      tools: lib: thermal: don't preserve owner in install
      tools: lib: thermal: expose thermal_exit symbols

Sascha Hauer (1):
      tools: lib: thermal: use pkg-config to locate libnl3

 tools/lib/thermal/Makefile       | 9 +++++++--
 tools/lib/thermal/libthermal.map | 5 ++++-
 2 files changed, 11 insertions(+), 3 deletions(-)
---
base-commit: 50c19e20ed2ef359cf155a39c8462b0a6351b9fa
change-id: 20251001-libthermal-install-0682119aeb35

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


