Return-Path: <linux-pm+bounces-18783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7529E85A7
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABAE164C0F
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231B14F9FA;
	Sun,  8 Dec 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kGfTZjG/"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137D149C4D;
	Sun,  8 Dec 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733669977; cv=none; b=bdLxR/g6kTYicMMt1bmEnMGiPZRz+8kocisawghMNfWO8sK0aCVz5TUdaJH3npVRgEP2FvUEWWcS90KvuWtcydk2OWM4GqH6lHVwmB6YFo9wWP4VmRtIkfehx1+2mEIKMj9+F2ATXPqb/q71uQJmro+GGjqP5snvtfWc+ctSc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733669977; c=relaxed/simple;
	bh=za3Dkm3Zck5C4BmBz90pqL2Z3JihLGLCqJq5inSro9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jypyMz/tVwNIeKJFRItvw2z0328Jfg0BVawo68AnPAjcRg2mkV6goR4FuVslMuhysA+wyvFm2u+1BahiDGV+Cb90lx+jPlQ+4FZ08MYGwQHUNANbE/gnranweRO7i9npARMs03cl+gwSziQF19mu/CwHnNrYrvLZVmdyyGV7wn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kGfTZjG/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733669973;
	bh=za3Dkm3Zck5C4BmBz90pqL2Z3JihLGLCqJq5inSro9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kGfTZjG/1FQM6BZi5NANBbvq7rCk+3XIE5MSu/bcvg804QjUlzq2m9T5Xxf11Aqvi
	 Lp+lt3rlldgY4dkZ5sca5sxGGQPTnZLsQZRc/xYgQaqjl6bnEPkdWLLmc1POO0HyED
	 g/HoaQn+uqjOJJJ3gHmwAejcXd33wT0f9xxW+MAY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 15:59:28 +0100
Subject: [PATCH 3/3] power: supply: cros_charge-control: hide start
 threshold on v2 cmd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-cros_charge-control-v2-v1-3-8d168d0f08a3@weissschuh.net>
References: <20241208-cros_charge-control-v2-v1-0-8d168d0f08a3@weissschuh.net>
In-Reply-To: <20241208-cros_charge-control-v2-v1-0-8d168d0f08a3@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Thomas Koch <linrunner@gmx.net>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733669972; l=2140;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=za3Dkm3Zck5C4BmBz90pqL2Z3JihLGLCqJq5inSro9w=;
 b=+0EygRWKP9SttMXFlFgC9ncZpGD99nkUvVZGjw06/U4VxGBhCFJqTpVtZNopI4yKgl9mBS5kQ
 d1KlWsmvkthCrk7KUbcH6JbEOsAxCH1nrhdy6vVZH1XFtzNT8SyFHB8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

ECs implementing the v2 command will not stop charging when the end
threshold is reached. Instead they will begin discharging until the
start threshold is reached, leading to permanent charge and discharge
cycles. This defeats the point of the charge control mechanism.

Avoid the issue by hiding the start threshold on v2 systems.
Instead on those systems program the EC with start == end which forces
the EC to reach and stay at that level.

v1 does not support thresholds and v3 works correctly,
at least judging from the code.

Reported-by: Thomas Koch <linrunner@gmx.net>
Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/cros_charge-control.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 108b121db4423187fb65548396fb9195b8801006..9b0a7500296b4d7eb8cd53153e148926bb98aec1 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -139,6 +139,10 @@ static ssize_t cros_chctl_store_threshold(struct device *dev, struct cros_chctl_
 		return -EINVAL;
 
 	if (is_end_threshold) {
+		/* Start threshold is not exposed, use fixed value */
+		if (priv->cmd_version == 2)
+			priv->current_start_threshold = val == 100 ? 0 : val;
+
 		if (val < priv->current_start_threshold)
 			return -EINVAL;
 		priv->current_end_threshold = val;
@@ -234,12 +238,10 @@ static umode_t cros_chtl_attr_is_visible(struct kobject *kobj, struct attribute
 {
 	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(attr, n);
 
-	if (priv->cmd_version < 2) {
-		if (n == CROS_CHCTL_ATTR_START_THRESHOLD)
-			return 0;
-		if (n == CROS_CHCTL_ATTR_END_THRESHOLD)
-			return 0;
-	}
+	if (n == CROS_CHCTL_ATTR_START_THRESHOLD && priv->cmd_version < 3)
+		return 0;
+	else if (n == CROS_CHCTL_ATTR_END_THRESHOLD && priv->cmd_version < 2)
+		return 0;
 
 	return attr->mode;
 }

-- 
2.47.1


