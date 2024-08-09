Return-Path: <linux-pm+bounces-12033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3CD94CAF2
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 09:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA11C22152
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 07:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6191816D9B1;
	Fri,  9 Aug 2024 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fl/YGOaz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6C16D9A7
	for <linux-pm@vger.kernel.org>; Fri,  9 Aug 2024 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187335; cv=none; b=Y8ziVb72Lua7EyDVqrS54XFC9Htxr4PIwpCkEhg2mK5pQ039eNk/iayvorVvQ6Y3xHt5kpGHY9IEUlYaAvjnmEqOO0iAoi4KiHLskicaJKxp6d93ziwI4qgjqonrpAu1uBO08pNLrsUDfI9gPyK23ldPmkWRitoscq1sZIyBw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187335; c=relaxed/simple;
	bh=1N26HGLw//R3d32px3tfcAXifr5s/f7rI6nJGtHpe08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzRKcqg41Og0SyZOmKOzwsJaIG4BxqiJAn28wZir8CzvJr3xKDGrz7t6nn4qjFPBEwt2e0hHB1cYSfrSQLp1UBAwbQmNsfg2yREUq19NmSri+tRm+wL82T2C4firD3YAAuC/UlCBgYdho8ozTkIBUTP8lvdAaBlY66vzqw+RdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fl/YGOaz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd640a6454so16534845ad.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2024 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723187333; x=1723792133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSZy4qeB9prpZkXZFFSCy09Nr7J/x1zL/3+bFofkJV8=;
        b=fl/YGOazmUU8dFbFqU21k8RuxP7J+gnZnpKsbEwNqtEMPOhMvjJoVAvEt7vCkNt3NZ
         zTWgnXORGRooqQ7cloprrqg4/cwPZuTUnDCUk9DCX5I9MHde+1aVgd6hRXtI42IGLp2A
         OqKwcXDxTGRG+DEFj4IV8TeDoQRL3fFXwyIaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723187333; x=1723792133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSZy4qeB9prpZkXZFFSCy09Nr7J/x1zL/3+bFofkJV8=;
        b=fBZ8z3DMD8iEOQqgqhkbiRgi0Err+SFMqZQoIFJ3Rle8aATR52wlwm/gunNJD4uHf9
         TRU2uZlBWiUY76wdFKaI5CgxY88HhG4XC+nYaXLA4VrHZofsRMWtX1VKB87hikCVs4RS
         mtTq4VSrdoo6+6v0S5iS8X4+Rwe9e42pByYFWZXnFEgCA+Q8gr3s1qHbcAo0UBGb2qzt
         RJhktK+xI2FSIgs2TLuVnRjunoNJ9BcIh7AQIKdE29EcK7mPgES0s5WdP5yWa79LbetJ
         8nk2ruUR0duqgFUp1aPe7rPUQo4RbP2BgFz36tSOyiM0lIb8isHSUPWrT2L53FR4IGTJ
         eZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqdITg6mVgGi865BbBK5fkJjlg7va4IlHlGNDfxFGG5ZmKM2M/V08O7mMOdBZ5BK79Wt5gMnPuF+sP82+aA1xd8o3NbW0PmeA=
X-Gm-Message-State: AOJu0Yww3HtmJMamkUURHFZ8YZSisCDdfHCjLMbCAvDr1I1c1xt8P+DR
	hqBuDqeVSzzDAQHYwDPKFFxnxWlXGvlgv11r9ZO1bbFzZmhxfqazuAdeHPFw9g==
X-Google-Smtp-Source: AGHT+IEojA8/Dm/IiJ94OPxhJiSpOpo4eMo23qz6LSsMPk8j238AnhJYY+ravisXXY3kEbh0Zu1A8A==
X-Received: by 2002:a17:903:41ca:b0:1fb:7435:c2cc with SMTP id d9443c01a7336-200ae5e6889mr6909505ad.45.1723187333055;
        Fri, 09 Aug 2024 00:08:53 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e48b:2b26:14f9:21cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59294515sm136254215ad.244.2024.08.09.00.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:08:52 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Cc: Icenowy Zheng <uwu@icenowy.me>,
	Mark Brown <broonie@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2] thermal/of: support thermal zones w/o trips subnode
Date: Fri,  9 Aug 2024 15:08:19 +0800
Message-ID: <20240809070822.2835371-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Icenowy Zheng <uwu@icenowy.me>

Although the current device tree binding of thermal zones require the
trips subnode, the binding in kernel v5.15 does not require it, and many
device trees shipped with the kernel, for example,
allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, still
comply to the old binding and contain no trips subnode.

Allow the code to successfully register thermal zones w/o trips subnode
for DT binding compatibility now.

Furtherly, the inconsistency between DTs and bindings should be resolved
by either adding empty trips subnode or dropping the trips subnode
requirement.

Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Resurrecting this patch specifically for MediaTek MT8183 Kukui devices.

Changes since v1:
- set *ntrips at beginning of thermal_of_trips_init()
- Keep goto out_of_node_put in of_get_child_count(trips) == 0 branch
- Check return value of thermal_of_trips_init(), if it is -ENXIO, print
  warning and clear |trips| pointer
- Drop |mask| change, as the variable was removed

I kept Mark's reviewed-by since the changes are more stylish than
functional.
---
 drivers/thermal/thermal_of.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index aa34b6e82e26..f237e74c92fc 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -128,16 +128,17 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	struct device_node *trips, *trip;
 	int ret, count;
 
+	*ntrips = 0;
 	trips = of_get_child_by_name(np, "trips");
 	if (!trips) {
-		pr_err("Failed to find 'trips' node\n");
-		return ERR_PTR(-EINVAL);
+		pr_debug("Failed to find 'trips' node\n");
+		return ERR_PTR(-ENXIO);
 	}
 
 	count = of_get_child_count(trips);
 	if (!count) {
-		pr_err("No trip point defined\n");
-		ret = -EINVAL;
+		pr_debug("No trip point defined\n");
+		ret = -ENXIO;
 		goto out_of_node_put;
 	}
 
@@ -162,7 +163,6 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 
 out_kfree:
 	kfree(tt);
-	*ntrips = 0;
 out_of_node_put:
 	of_node_put(trips);
 
@@ -490,8 +490,13 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
-		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		if (PTR_ERR(trips) != -ENXIO) {
+			pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+			return ERR_CAST(trips);
+		}
+
+		pr_warn("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+		trips = NULL;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
-- 
2.46.0.76.ge559c4bf1a-goog


