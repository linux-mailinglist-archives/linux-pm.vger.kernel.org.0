Return-Path: <linux-pm+bounces-22075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E6A35B73
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 11:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71BE189385A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6B245B05;
	Fri, 14 Feb 2025 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8feyJcL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC13622D4DC;
	Fri, 14 Feb 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528507; cv=none; b=a6zkKOxS8wBdShWUtsXsTl5xtH7vEMpNoMCJmJxm0nJ+sHcUzDIylDG6LpOquYz44XWGN1BfT93mOTERtYxY3swTRD/Ni6boPk9B8zEAHKFbJoce3NNd4cL8GfJb4Jjni8IufPnazm4NkYEq/btGsvfWCum1iMK0HNAaS1jnEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528507; c=relaxed/simple;
	bh=pYWOVv2YgBk+hHsU4p1XSlOeZGmwpLux9SKrE4vfdLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TlunYYg7YyCwhvR/BkDKTf9nJUIlWY4svomkC6Qsc2+7ZIPR7Fdk8DhrR2qYZuORcEmGK5ehFFfERLervlh+xtdJm9V3TFe5gefJ2KwJgkqjg7Xg3krAQbKYGOa0HwltLQbAK951md9AiUz2mEdwc2w6/qWe1eFa0Ftj52ky9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8feyJcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52363C4CED1;
	Fri, 14 Feb 2025 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739528506;
	bh=pYWOVv2YgBk+hHsU4p1XSlOeZGmwpLux9SKrE4vfdLA=;
	h=From:To:Cc:Subject:Date:From;
	b=m8feyJcLK4Qaond2t8DsMSsHMn9vYOaSx71jTXptlxbQWC4wOh6NLMgLNz9Bl/Ft8
	 OV9cw0tO1h0Y+BuJ04vemMIQgYjQ1Vr5TjFkpibfYLwviQszKkoul3+ZJwvD+1lqAn
	 zOHQodafnEHI/A+dzSnfBBZzp7PDX8fnl++rWAOrzxo53SruvQ1m7IP55vJuQrN/VQ
	 4070OyAoBEQAPq7g8zY4iXeSqrfgkIVgRYvOXV/WsZ/VfsMaEKB67FNgLjNPpBWZe1
	 +8RDPiTttmFC1u+uGq5vzRwVxUwCQAPLzMXpeKuCuTmsaNZHZem3/x6bXanWskrugj
	 7Uta20TRZOVtw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tispX-000000000mv-48Ps;
	Fri, 14 Feb 2025 11:21:56 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Liu Ying <victor.liu@nxp.com>
Subject: [PATCH] bus: simple-pm-bus: fix forced runtime PM use
Date: Fri, 14 Feb 2025 11:21:30 +0100
Message-ID: <20250214102130.3000-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The simple-pm-bus driver only enables runtime PM for some buses
('simple-pm-bus') yet has started calling pm_runtime_force_suspend() and
pm_runtime_force_resume() during system suspend unconditionally.

This currently works, but that is not obvious and depends on
implementation details which may change at some point.

Add dedicated system sleep ops and only call pm_runtime_force_suspend()
and pm_runtime_force_resume() for buses that use runtime PM to avoid any
future surprises.

Fixes: c45839309c3d ("drivers: bus: simple-pm-bus: Use clocks")
Cc: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bus/simple-pm-bus.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 5dea31769f9a..d8e029e7e53f 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -109,9 +109,29 @@ static int simple_pm_bus_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int simple_pm_bus_suspend(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+
+	if (!bus)
+		return 0;
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int simple_pm_bus_resume(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+
+	if (!bus)
+		return 0;
+
+	return pm_runtime_force_resume(dev);
+}
+
 static const struct dev_pm_ops simple_pm_bus_pm_ops = {
 	RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_runtime_resume, NULL)
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(simple_pm_bus_suspend, simple_pm_bus_resume)
 };
 
 #define ONLY_BUS	((void *) 1) /* Match if the device is only a bus. */
-- 
2.45.3


