Return-Path: <linux-pm+bounces-14911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56789899E1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 06:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E101C20ECD
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 04:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960FB13A244;
	Mon, 30 Sep 2024 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g7xZNEv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13307149C7D
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727671605; cv=none; b=aMmsPGoBryWQNhKm8HMu3diPm+fzPscpuyh1RZCwuwJnRFE3GCQsZI/Z4ZCVbFU2xp+uMDK/SbIu5RlnzFVh/IhbCsipLuC3NE6CYjqX/HT7pnOaZvYgj8sQi431RSjjoUSZ+pDUOYLHrtiTeqqvnc/FVJAmoTnamsPe9CAZx9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727671605; c=relaxed/simple;
	bh=STbyMC9WSwMw+WWAlK9i+2stuna57HlxKbm8VC3HPjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEv7CfU4+HPIgzoGCkuiGKk/qxAoe/Zustbm+540ctqKV/Axy7fZmnYxvJMNeITECiW9dqsi4fq3CwwEqba5nDs01BZLTr3pWb4Bjxts877THf5CK+E9rM/679tnEVf7nuXKw3YCCFWTOqiFeNk6clTjwu677O2nQZq7CYKS5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g7xZNEv5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068bee21d8so42430045ad.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 21:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727671603; x=1728276403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qN+Z85uKhFcsA7I0FPVuQftO8kS+uCqLckN4FbzXu4E=;
        b=g7xZNEv56fdhSA49oRuEsn3VyFmfHqjiutbmyvsKQuSblyaaMkXBfOrwrpmBCh6GFM
         BgedfFxnq//+3QR0pZSuusImdaGvxKRN54KtjT02VGQSTbMXLS/r52RsFyiiVCzkLClL
         6zmftHQsVRDf4SfALBF1mvQT1j+hqMsnkVSRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727671603; x=1728276403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qN+Z85uKhFcsA7I0FPVuQftO8kS+uCqLckN4FbzXu4E=;
        b=XlnXanxQmzP+GXOd5QybXPaCJ5RNItNQlju3on4JWAnc+53kiMWigsahboO71QISDy
         CTg1txTrK01z2ZKmqGXmf7+YbQYbcVCm5znOT7yINv7qbLFS+fABu+svK7rUiHXaahjQ
         Gz4bZigwD/sRA2LFoMn8PQOZX/6fxfrXjEk9Rpafi5lTNfhSdBbJHR5LxEQuBufYnXiR
         zdjJAIdBU1Y/Z+uBGMaFPwA+k1ezCQLMqWGKAxwQiY75urUcT1pq5aNuuRIJENuakTCb
         iPOsWKdt2BgL9PgKrF9EmvQoUksKkgFLFvcZZ4MJAMuGKcilYoVqU9GJX0uPjk8CX9H1
         WTmw==
X-Forwarded-Encrypted: i=1; AJvYcCXevMDYnBSAp8l1W9rNePXKpcEmxHJd+SS2drHeoC/oYvdD08lo+p6s/2sTAdkzXbU6SuFgdqKAcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7U5YW5zlE7j6RtsYQGhdhzgkihYhTvGtRblAsa2BtXNA1jneX
	r+0PItW1/E6tH6BqnrGjUzmfxDzSC8s0FUwp0ZBPZ1Z8K3n2D3t2Jz3LNwrTsA==
X-Google-Smtp-Source: AGHT+IHsHQaIS+I9VX9gHEq3fHW0VJ8hm8miY4PsryP7g4DCTMesviF4MlhqkaQ76u1RTM6qq7VZ2g==
X-Received: by 2002:a17:903:32c7:b0:20b:6458:ec83 with SMTP id d9443c01a7336-20b6458ef88mr67264665ad.4.1727671603389;
        Sun, 29 Sep 2024 21:46:43 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:659b:6caf:831b:3926])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d65asm46236925ad.123.2024.09.29.21.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 21:46:43 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v9 3/3] pmdomain: mediatek: Use OF-specific regulator API to get power domain supply
Date: Mon, 30 Sep 2024 12:45:23 +0800
Message-ID: <20240930044525.2043884-4-wenst@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240930044525.2043884-1-wenst@chromium.org>
References: <20240930044525.2043884-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek power domain driver contains a hack that assigns the device
node of the power domain to the struct device of the power domain
controller in order to use the devres regulator API.

Now that there is a proper OF-specific regulator API, and even a devres
version, replace the hack with proper code.

This change is incompatible with incomplete device trees. Instead of
assigning the dummy regulator in cases where the power domain requires
a supply but the device tree does not provide one, the driver will just
error out. This will be seen on the MT8390 EVK, which is missing
supplies for the IMG_VCORE and CAM_VCORE domains. And likely all the
MediaTek EVBs, which have no power domain supplies specified. This is
however the correct behavior. If the power domain's supply is missing,
then it should not work. Relying on other parts of the system to keep
the unattached regulator enabled is likely to break in ways less easier
to understand.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v7:
- New patch

The other option is to follow what Rockchip will be doing: getting the
regulator supply upon first use / enable [1]. This will result in less
breakage: only the power domain that is missing its supplies will fail
to be attached.

[1] https://lore.kernel.org/all/20240919091834.83572-6-sebastian.reichel@collabora.com/
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 88406e9ac63c..3580913f25d3 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -353,7 +353,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 {
 	const struct scpsys_domain_data *domain_data;
 	struct scpsys_domain *pd;
-	struct device_node *root_node = scpsys->dev->of_node;
 	struct device_node *smi_node;
 	struct property *prop;
 	const char *clk_name;
@@ -388,16 +387,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	pd->scpsys = scpsys;
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_DOMAIN_SUPPLY)) {
-		/*
-		 * Find regulator in current power domain node.
-		 * devm_regulator_get() finds regulator in a node and its child
-		 * node, so set of_node to current power domain node then change
-		 * back to original node after regulator is found for current
-		 * power domain node.
-		 */
-		scpsys->dev->of_node = node;
-		pd->supply = devm_regulator_get(scpsys->dev, "domain");
-		scpsys->dev->of_node = root_node;
+		pd->supply = devm_of_regulator_get_optional(scpsys->dev, node, "domain");
 		if (IS_ERR(pd->supply))
 			return dev_err_cast_probe(scpsys->dev, pd->supply,
 				      "%pOF: failed to get power supply.\n",
-- 
2.46.1.824.gd892dcdcdd-goog


