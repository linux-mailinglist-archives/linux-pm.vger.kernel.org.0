Return-Path: <linux-pm+bounces-39940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE20CDE764
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 08:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13441300502F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 07:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AA4313E23;
	Fri, 26 Dec 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BcemiGD5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33EC313551;
	Fri, 26 Dec 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766735684; cv=none; b=QfayWL5rkgWqe0BvSrQ4R+N98wMggbRWttKiQKhNv2xGZdel4G4WJxl+9kdzp9F50Ttiy4gXjKT3ntyYEeNcJyJOGyN+k6ygON80RfM7oAkF95NqFobR4atqflbUqJj+vCvlk9Czip6ROnV329hRC/G55giwrEYsiVwSGTLeGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766735684; c=relaxed/simple;
	bh=kz9PDxmH5Ii7yvcVpvpGfxEKgm/fDEaqKM5tlUZdyQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iDISmKoXF/PV3+EjiD3s6plPbiBqp3VU6iGsBSdp0bP+ZoFIGQCncBBywFMiHI5ExAlLSPpUIDaFqNT1Nx8IOq6yyz/grYH+KcKfBgBbEAleGNHQmeCoLBzF8Rpc3MWDY4Mw6NU+yxRbLPErvWA5hv40V7FvVYI/ZVpDvLSGbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BcemiGD5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DB72C1A243D;
	Fri, 26 Dec 2025 07:54:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DD03606E4;
	Fri, 26 Dec 2025 07:54:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 032AB103C8C77;
	Fri, 26 Dec 2025 08:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766735677; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=PoEhtWmofdzKheDBZbzs4RT96pg7d6Q+vffKPOJ3LjM=;
	b=BcemiGD5CJIKdB5rWhb7I4Jm0MawxQZtrBCsNADbFLGkteqcNEkbr7OjF2ezSwwgCdtSNd
	bJShA82xQiRuDcY6FDuzeV6WGwEX5mXFoNV83P+kgEGijfcR9y501+xXm/bZQwrev5WO6R
	/BSnwQs3BUJYuguupKc4GHHw65uXwsm4xiYwq+qBJaC+lEoUFOa3VMTmotXrx9nB8PinhX
	VEWCyhN8YQ4/alrHKrpMFb4kFcI3kKYaYiAlcAftmRiSJCfP72MJTn5Gxz7EqrqkgI8v44
	mWcyrurwUirhdmSs2StpSv3zeq1sOtn9ZgCqsoVyVQeHh25XSsfV5a9eYzgPdg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Fri, 26 Dec 2025 08:54:32 +0100
Subject: [PATCH] tools: lib: thermal: Correct CFLAGS and LDFLAGS in
 pkg-config template
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-libthermal-pkgconfig-v1-1-3406de5ca8ea@bootlin.com>
X-B4-Tracking: v=1; b=H4sIADc/TmkC/x3MTQqAIBBA4avIrBNy+u8q0cJqsqHS0IggunvS8
 lu890AgzxSgFQ94ujiwsxEqETAu2hqSPEUDplgoxFJuPJwL+V1v8ljN6OzMRmKGRTOoNK9qDTE
 9PM18/9uuf98PpMb0zWYAAAA=
X-Change-ID: 20251226-libthermal-pkgconfig-23259b10478a
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

There are two issues with the current pkg-config template. Firstly, the
-lthermal linker flag is missing. Secondly, the libnl3 include directory
compiler flag references "include" instead of "includedir", which leads to
an unexpanded variable when pkg-config is called.

Add the missing -lthermal flag and correct the libnl3 include directory.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 tools/lib/thermal/libthermal.pc.template | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/thermal/libthermal.pc.template b/tools/lib/thermal/libthermal.pc.template
index ac24d0ab17f5..3b8a24d0a8b8 100644
--- a/tools/lib/thermal/libthermal.pc.template
+++ b/tools/lib/thermal/libthermal.pc.template
@@ -8,5 +8,5 @@ Name: libthermal
 Description: thermal library
 Requires: libnl-3.0 libnl-genl-3.0
 Version: @VERSION@
-Libs: -L${libdir} -lnl-genl-3 -lnl-3
-Cflags: -I${includedir} -I${include}/libnl3
+Libs: -L${libdir} -lnl-genl-3 -lnl-3 -lthermal
+Cflags: -I${includedir} -I${includedir}/libnl3

---
base-commit: d113735421da322ea144c9778c433de6ff6bc57b
change-id: 20251226-libthermal-pkgconfig-23259b10478a

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


