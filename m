Return-Path: <linux-pm+bounces-40186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B05DCCF388B
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 13:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1343300AFE7
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D333893A;
	Mon,  5 Jan 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hqgf9yS+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B49113B293;
	Mon,  5 Jan 2026 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616282; cv=none; b=qiKM8Ske+eDMaySyoJJrOEeHhIyBDO65a6muupwFcYObtEu0X9p9mkOlcuJu0JyIIwr6mlJih4sdrGfaKHnzfhYWzxi69+dy8qzOtSydcrdEUBOT+BbwmM0NoaS5Dja+/qjYofc7StrjvzRffmF3KkWZTjOogXRmR+u0czZgDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616282; c=relaxed/simple;
	bh=gyBvfMwzBQ/Y7h4l4Q2rKCWMHW/GDa93wcjZtUxyIXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bdhNggFlYKrDHs+Dac9dWsneFo5rTR8lfl3D86MNlHjymOAESn2Q8HfyRkw4FKcxpE0qmyVzcIm3IrE1JYdgFNoPy3pZkyeE+g6py185QmuqrRPDDuB3Xc12VUvlPfjj3bbo5NZh4OrPiENxnlw3+edKzIg+kI2JROaazoayXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hqgf9yS+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B74874E41F7D;
	Mon,  5 Jan 2026 12:31:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E1D360726;
	Mon,  5 Jan 2026 12:31:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44718103C847E;
	Mon,  5 Jan 2026 13:31:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767616277; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ncRRgZMgnnJ2pFO93YhC4rnge0LWXz/c/w5kVZDP8qI=;
	b=hqgf9yS+0QKlTcin0Tx3N/Uat2wrsXj5H1ZTg8TcSMn7VOIeYFuMIzW8aTXzf0Tg+IMqBK
	cTEg5c8Pj39zambbbjhDY9Wj5Uwjf2bphRwFK1Gtp+tNWKzpGyQ4hSABsBHEfmRWVio9RH
	fPcSiRWQ0Q8eAUhmLWwQxqaUZF7weasytlmjAd0FIbLURbOSybqf9HMj3/fUJw8fQXjIcO
	AfiwZhZE06zzAPNmE7NrWv0MG3e57Nv6zl60jRnvJ6Y9D/AvU1rbf6W+9zYrLsT0SfcQgl
	qagRpVeMdHC74rlm0SJpL8MB43uGCjLKAnESVkbuBOnqmcEORt3g9DsHn15c+A==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 05 Jan 2026 13:31:12 +0100
Subject: [PATCH v2] tools: lib: thermal: Correct CFLAGS and LDFLAGS in
 pkg-config template
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-libthermal-pkgconfig-v2-1-e086bdeddb41@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAA+vW2kC/4WNTQ6CMBBGr0JmbQ0dfkRW3sOwKGWAidCSljQa0
 rtbuYDL95LvfQd4ckwe2uwAR4E9W5MALxnoWZmJBA+JAXOsJGItFu73mdyqFrG9Jm3NyJPAAqt
 7L/Py1ihI083RyO8z++wSz+x36z7nS5A/+ycYpJCiKPN6oEqrhtSjt3Zf2Fy1XaGLMX4B1i+kg
 roAAAA=
X-Change-ID: 20251226-libthermal-pkgconfig-23259b10478a
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

There are two issues with the current pkg-config template.

Firstly, the -lthermal linker flag is missing.

Secondly, the libnl3 include directory compiler flag references "include"
instead of "includedir", which leads to an unexpanded variable when
pkg-config is called. Moreover, it isn't necessary to add this flag here,
since the "Requires" field will cause pkg-config do add it automatically.
The same logic applies to the LDFLAGS for libnl3.

Add the missing -lthermal flag and remove unnecessary and incorrect libnl3
flags.

Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v2:
- Removed unnecessary libnl3 flags.
- Added "Fixes" tag.
- Link to v1: https://lore.kernel.org/r/20251226-libthermal-pkgconfig-v1-1-3406de5ca8ea@bootlin.com
---
 tools/lib/thermal/libthermal.pc.template | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/thermal/libthermal.pc.template b/tools/lib/thermal/libthermal.pc.template
index ac24d0ab17f5..b984c5ecd20a 100644
--- a/tools/lib/thermal/libthermal.pc.template
+++ b/tools/lib/thermal/libthermal.pc.template
@@ -8,5 +8,5 @@ Name: libthermal
 Description: thermal library
 Requires: libnl-3.0 libnl-genl-3.0
 Version: @VERSION@
-Libs: -L${libdir} -lnl-genl-3 -lnl-3
-Cflags: -I${includedir} -I${include}/libnl3
+Libs: -L${libdir} -lthermal
+Cflags: -I${includedir}

---
base-commit: d113735421da322ea144c9778c433de6ff6bc57b
change-id: 20251226-libthermal-pkgconfig-23259b10478a

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


