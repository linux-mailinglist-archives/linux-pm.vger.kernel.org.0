Return-Path: <linux-pm+bounces-18785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7859E85AF
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 15:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60764164BB2
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB49E154BE2;
	Sun,  8 Dec 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DDSCvzVE"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5814B077;
	Sun,  8 Dec 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733669977; cv=none; b=IKpEOQyv+B9d/ym/UZ1jqsugxbQL8n008jOSk8MVKUn3uFpSsqFWsOfq51EBP8pURCyJPv10qYIq6WQDn75EQl51MtZ45WjTTSd5FlbVxMWZxUeNSuVO/8781gR7OUwZAa/GejjpUU2K0fkpFj2QgMuRxXUsduRTbKNSa63mvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733669977; c=relaxed/simple;
	bh=xAKdt+XUPvyRkhE19c1Wd0o1p1dyMhTM02DujFoE+fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpqlmjTLzb4lzEhRs9yZBvO2lS3DdEfHsZE8Nanpz7FvGtSqxTcWvMRj5191v0Ppy/bzQvolaJ1f93WbpqtHF/p3hTQmQmxuPEEJWwrXcLTuCCpvuvYeMEeqatiRoAo6T+jXZibLIz+TkPgq7om8RBWUc+vR4gRIP12pCuibV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DDSCvzVE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733669973;
	bh=xAKdt+XUPvyRkhE19c1Wd0o1p1dyMhTM02DujFoE+fc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DDSCvzVE9bT2Ixa+Xai9eHEsZ3Xu8HQ4iWxTGQnDLPfK66bSeLdV3ueHoExfhUuUp
	 Fy3ZREPOmIVDtK0nKC3lBXoKjV8PZR8luFWoby91rL4WtfvwTFWiXBJSwvE1gXBQ5f
	 FoTppeyT740usY9ZaKyTBO3N4pdbFn0sElEWN8C4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 15:59:27 +0100
Subject: [PATCH 2/3] power: supply: cros_charge-control: allow
 start_threshold == end_threshold
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-cros_charge-control-v2-v1-2-8d168d0f08a3@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733669972; l=1214;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xAKdt+XUPvyRkhE19c1Wd0o1p1dyMhTM02DujFoE+fc=;
 b=/m2irmWjCvb+/32Yh1ZuYvQFdD+iiny3bpW4IprRJA6kEJYthe1thZIcXseRJ3cNMvvSV97H4
 drdxZrE/9IuDCOyJEmqUb4vMq+z0VCW3iYPlX1nB8FnhYU8k/kUl3w4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Allow setting the start and stop thresholds to the same value.
There is no reason to disallow it.

Suggested-by: Thomas Koch <linrunner@gmx.net>
Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/cros_charge-control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 58ca6d9ed6132af63a36ea4c5bf212acf066936c..108b121db4423187fb65548396fb9195b8801006 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -139,11 +139,11 @@ static ssize_t cros_chctl_store_threshold(struct device *dev, struct cros_chctl_
 		return -EINVAL;
 
 	if (is_end_threshold) {
-		if (val <= priv->current_start_threshold)
+		if (val < priv->current_start_threshold)
 			return -EINVAL;
 		priv->current_end_threshold = val;
 	} else {
-		if (val >= priv->current_end_threshold)
+		if (val > priv->current_end_threshold)
 			return -EINVAL;
 		priv->current_start_threshold = val;
 	}

-- 
2.47.1


