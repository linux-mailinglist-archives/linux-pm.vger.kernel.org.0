Return-Path: <linux-pm+bounces-39805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9158ECD7210
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28FB3301AB3F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E69343D6F;
	Mon, 22 Dec 2025 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1diPkQW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA430BF62;
	Mon, 22 Dec 2025 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435878; cv=none; b=CTENrU0QoJSgil7qNz2zsyvFfJuxFgBW+FhMap9LFWYPFxEvhDRAAK7AISd7m4cy7P4I5DQA9v3az1Re5JDQ0TGWjlStk1nFUBbACrMkft7awjglM5Xi2T3XZEpRo0vwYToFYK1ZOEvTto2o3+rhCQ3w+Riocu5j5rzwS8tOZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435878; c=relaxed/simple;
	bh=QvJ1CW2dTGSVQI9v1hkF14kO+wZVUTltwp45UZxtMDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFaY1NelKtK1gxdOSLYdCTg87lCkYlpFc1g/vJ6mUbRpmMckHfNPHUkoIbP04OtFgKa777BxiHNxHKKzMDV7W4OkHaBmFHftuDj6k4UwkQjIQAcce+vamWI9Y3erbva9F18aEwPCctprnkGLg9pa0TL+a3FONfUwAdzymCrI9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1diPkQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997FCC116D0;
	Mon, 22 Dec 2025 20:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435877;
	bh=QvJ1CW2dTGSVQI9v1hkF14kO+wZVUTltwp45UZxtMDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1diPkQWUD8viHi49Bj+t7AL3mo311LJJ0cqvIEZddRz7YYFXsFTenawWyC6fLyXW
	 ViUwKvu2DMUbe+E6kt/2DYz2KZ12ieBkB8un3TqtyWegmi9ftTIvdlnvH4ixnprDKB
	 BZK4h6lUKklET0HCNW93DYSyhN94AWwrgjDqY2AcLeDju/9kIa+BQNO8/hUMzOCrwB
	 vo+keM3wp+mEioOmmQnsRANL66xi7zlvmh6BJ1H9kXmRbKaMuRgzLnEulsZCWQciZt
	 j3euIabD1LY0/ylYkQHJ2Fh2QeAJR/ps2sTC7U4ouNRdqqZ6DeJJtya7BR7AWtZkNr
	 PF/bouE5g9b8g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject:
 [PATCH v1 07/23] media: mediatek: vcodec: Discard pm_runtime_put() return
 value
Date: Mon, 22 Dec 2025 21:06:16 +0100
Message-ID: <3690736.iIbC2pHGDl@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Printing error messages on pm_runtime_put() returning negative values
is not particularly useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.

Accordingly, update mtk_vcodec_enc_pw_off() and mtk_vcodec_dec_pw_off()
to simply discard the return value of pm_runtime_put().

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c |    6 +-----
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
@@ -67,11 +67,7 @@ static int mtk_vcodec_dec_pw_on(struct m
 
 static void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
 {
-	int ret;
-
-	ret = pm_runtime_put(pm->dev);
-	if (ret && ret != -EAGAIN)
-		dev_err(pm->dev, "pm_runtime_put fail %d", ret);
+	pm_runtime_put(pm->dev);
 }
 
 static void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
@@ -71,11 +71,7 @@ int mtk_vcodec_enc_pw_on(struct mtk_vcod
 
 void mtk_vcodec_enc_pw_off(struct mtk_vcodec_pm *pm)
 {
-	int ret;
-
-	ret = pm_runtime_put(pm->dev);
-	if (ret && ret != -EAGAIN)
-		dev_err(pm->dev, "pm_runtime_put fail %d", ret);
+	pm_runtime_put(pm->dev);
 }
 
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)




