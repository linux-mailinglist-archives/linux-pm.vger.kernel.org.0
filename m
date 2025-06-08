Return-Path: <linux-pm+bounces-28263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6409AD1448
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A242D16882C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A601254876;
	Sun,  8 Jun 2025 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzaMzJsW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569CA224FA
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415234; cv=none; b=kYZ12Vn5j/hBYJsN0N/2EpDC9NIQnySlljfeVQtf9GUswOOcLsA3VpKyaaP6uUkxNvKnsJ7x+qBjdgFNjsCwscc2gAVxYL3/5GtTUa2ZwsEP18lDtHpVDRvHtgn5Ojc5iKxXGQ67jbMwjDEb0X5LyLgIxq1szdQDKyc17basClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415234; c=relaxed/simple;
	bh=tC4bN7/oX2CSIZDOv0m5Rw+30FigfgLCD5+SuQCMSBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo6iTERzLRdWgNlzfCiboMGNTqm5r1hBVGe7XIq+/kJrJ7J1xdKpvYbJ6ZbO+Cofy5CwOuaCUKuv3AYiwdXWAccVIBCauHES40flSfqtJyUo2fWvHRFIbwHcOGFRClXWDErdenFXpp3IR1da0oFbGsF8YUrifUp5Z5huT2P2wqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzaMzJsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF818C4CEF1;
	Sun,  8 Jun 2025 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415234;
	bh=tC4bN7/oX2CSIZDOv0m5Rw+30FigfgLCD5+SuQCMSBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzaMzJsWWI/NIKeIK4RzB1hUVOWUNxf6v7WeyZAbGoCDbiysPCNGpkAWrr4mCSTP4
	 A0MipYmRY6e8nwvIq71qqOwYFX8OhWSe2ZB6iPBs312ONx8YQN866DIbebvf2+chBT
	 nngYk/6j3fw2SeN2ffm4zD5bZB+A4L2kiIqYK7WqYlzy41vVhuuw8kbfsS4AYMXJeg
	 GfkoksrXS9sa8DC+gNOy1osX0i9J+xHHIm2TweZZsFMdy0syZrWLRMqT/C69Wo/Ffn
	 ilSQdv8m8MkThz5qDFzeCZ8oQH631Pf4jce0qUXmByzprsYZyfGhgh2Ul4mT8NQ5gx
	 rM80Scya9kyNg==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 10/10] power: supply: bq24190: Free battery_info
Date: Sun,  8 Jun 2025 22:40:10 +0200
Message-ID: <20250608204010.37482-11-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608204010.37482-1-hansg@kernel.org>
References: <20250608204010.37482-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call power_supply_put_battery_info() when bq24190_get_config() is done with
it. The "struct power_supply_battery_info *info" pointer runs out of scope
at the end of bq24190_get_config() so there is no need to keep it around
after this.

Note technically this is not a memleak fix, since all battery_info data is
devm_alloc()-ed so it would still be free-ed when the driver is unbound.
This just frees it as soon as the driver is done with it.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/bq24190_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index f0d97ab45bd8..cc6dad8f8e58 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1982,6 +1982,8 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 		v = info->constant_charge_voltage_max_uv;
 		if (v >= bq24190_cvc_vreg_values[0] && v <= bdi->vreg_max)
 			bdi->vreg = bdi->vreg_max = v;
+
+		power_supply_put_battery_info(bdi->charger, info);
 	}
 
 	return 0;
-- 
2.49.0


