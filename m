Return-Path: <linux-pm+bounces-36362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC1BEA08F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 17:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E667439D2
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8B336EE3;
	Fri, 17 Oct 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KuCr1cSt"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AE336ED7;
	Fri, 17 Oct 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715143; cv=pass; b=kUOdWPWVCweC0UtA0lUPJGfuCqA+xS6HYPyoJxmNnguRDNIMLvRLg/Ni895K5CY/R7RvFlXFNE4ec9pJJryhevfCWSq11e5WHya8bl54SsWSWKnK+UqefCmBK/JFMgMjnM6vvPuO1Sl22BcwSKU6g2in6zCcfFSalOZSHL3vN1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715143; c=relaxed/simple;
	bh=AmaXODYloHURxX+81JLzwZ8dcXLJHpYLzG9SfTQfA3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkiDp1j/FUa1Zs5CeBPWqt8GJwUFSbCtTkbsikPZFVhKN2j0dP51xyc7LiBVITiSKim+J1U93jMo8XX8kQ/YOcSeSQKyLhzHoHPJovPs06ULMa+iSwmL/n7bGftSyZcfbQJjIdQOhGE3dleWcW85oRY3tURsYul2jLd5JLfc9ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=KuCr1cSt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760715119; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HtS7KfK859OPjcVOa4NDLnu5LU6Yrr4pqbelxq8+obwvH+ZFFmT1jETGp7XQLOZFDwwG2iK0WbmmMREKfLuOl7FSOdbgBXxrqtM+50qsNAH1NP+8kqK7kJd/tz7Fr79mmd9vDJ14oSE2Um5ZVX5/VeFoZBCHABQ4FJ0RiqnO7sY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760715119; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8yOELnPraOHG4rpw5A06azpzhjqHyhFImhx6f4OO8Aw=; 
	b=Rxu/YqNUq1N9yWGlJDtGT1udUw/Qf2lEcZ4O5fWVnrRZ4qPfbaWwT7CP/kKz2DwQN4nOmmOOUrzUDPRsv4cNYr92hE6TiCzWogkCGlARBYLzI73GeDd2Yp9jYrg6khykjyCLxFIGlUUJuqT9Mp46/uzwmtxEPYSQUlqqM3XU6OU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760715119;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=8yOELnPraOHG4rpw5A06azpzhjqHyhFImhx6f4OO8Aw=;
	b=KuCr1cStpf8NkZhrzQ/qWXrGulCmeXqF0bj0YLe6qJyxTj7TEmJaL4+mkfjaawbj
	97e0lh0PYnbCJmCoY/iCWLr0xw9uEjjm7SIXxSWpBO+V3jJltTNL5yjbxsZYiwWvqsz
	6/SdUVC/WKzsMOaGe5KBuaACnzl8pESdpDzDdrn8=
Received: by mx.zohomail.com with SMTPS id 1760715118219640.0245019859688;
	Fri, 17 Oct 2025 08:31:58 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 17 Oct 2025 17:31:11 +0200
Subject: [PATCH v8 4/5] drm/panthor: Use existing OPP table if present
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mt8196-gpufreq-v8-4-98fc1cc566a1@collabora.com>
References: <20251017-mt8196-gpufreq-v8-0-98fc1cc566a1@collabora.com>
In-Reply-To: <20251017-mt8196-gpufreq-v8-0-98fc1cc566a1@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

On SoCs where the GPU's power-domain is in charge of setting performance
levels, the OPP table of the GPU node will have already been populated
during said power-domain's attach_dev operation.

To avoid initialising an OPP table twice, only set the OPP regulator and
the OPPs from DT if there's no OPP table present.

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 32 ++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index a6dca599f0a5..ec63e27f4883 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -141,6 +141,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	struct thermal_cooling_device *cooling;
 	struct device *dev = ptdev->base.dev;
 	struct panthor_devfreq *pdevfreq;
+	struct opp_table *table;
 	struct dev_pm_opp *opp;
 	unsigned long cur_freq;
 	unsigned long freq = ULONG_MAX;
@@ -152,17 +153,30 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 
 	ptdev->devfreq = pdevfreq;
 
-	ret = devm_pm_opp_set_regulators(dev, reg_names);
-	if (ret && ret != -ENODEV) {
-		if (ret != -EPROBE_DEFER)
-			DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
-		return ret;
+	/*
+	 * The power domain associated with the GPU may have already added an
+	 * OPP table, complete with OPPs, as part of the platform bus
+	 * initialization. If this is the case, the power domain is in charge of
+	 * also controlling the performance, with a set_performance callback.
+	 * Only add a new OPP table from DT if there isn't such a table present
+	 * already.
+	 */
+	table = dev_pm_opp_get_opp_table(dev);
+	if (IS_ERR_OR_NULL(table)) {
+		ret = devm_pm_opp_set_regulators(dev, reg_names);
+		if (ret && ret != -ENODEV) {
+			if (ret != -EPROBE_DEFER)
+				DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
+			return ret;
+		}
+
+		ret = devm_pm_opp_of_add_table(dev);
+		if (ret)
+			return ret;
+	} else {
+		dev_pm_opp_put_opp_table(table);
 	}
 
-	ret = devm_pm_opp_of_add_table(dev);
-	if (ret)
-		return ret;
-
 	spin_lock_init(&pdevfreq->lock);
 
 	panthor_devfreq_reset(pdevfreq);

-- 
2.51.0


