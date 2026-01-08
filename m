Return-Path: <linux-pm+bounces-40471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A4CD041A4
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 16:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ECBB31D393C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890682D321B;
	Thu,  8 Jan 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3Qrp9Hl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B238F9C;
	Thu,  8 Jan 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885807; cv=none; b=NesrzPHI6lEIw6y4x/l+jpsXITibOk7dHGRknaoUmKerE0ZJixYEuiXfUWNLflGKbfJGSxK1mTXTtk671iC17EGSoedUZvSU7Y+kzx0muK9zoCsv6QZiksMKoD/HwOjqpUd0VW6qVnCHmEChJvJbl/Ku5Oy7YKVKAgX4kgWw+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885807; c=relaxed/simple;
	bh=lKUjOpQjsrio8LVg2MdCngrlvUGtYnTK5X3c+0ZSIYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZKK7llP6Hecw6bAsp//RLPNkYYvkLW2UUbIQQpmImHkl3B8W9dHs/W1U7yRWXrTRQFHkltYpiwxfswku7g26xM+VvsiA0DncBK025uw64jvGGFlWvY+dW3Vy3/Puiv5oKpYagVyuyKFiJw6326knuR4kaNSxc2cgyiq3DaE1czM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3Qrp9Hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC136C116C6;
	Thu,  8 Jan 2026 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767885807;
	bh=lKUjOpQjsrio8LVg2MdCngrlvUGtYnTK5X3c+0ZSIYo=;
	h=From:To:Cc:Subject:Date:From;
	b=n3Qrp9HlW1xrqaqUaRwRMbdaq/9N4aGFW+NM127LkZkMDfTYE4inb+azVV5tht7i8
	 QsiGoMvagiPVlUKtIhp50p11MBGyT/TtnjAgAoEnjQtMXrl/15OJku0y6IHN/07uNJ
	 QGsr1YwJnD1wFYjKKISVfoNwpJQvNUi7pJ5CziFdSl83plkXG2W5KnmhDhXHQMmOLc
	 UcnVy8PVrDXgtNGiPfhCjTe9oQ3Z3oXNuxxV7Dg3XKXi9q1DhINovMiOPShOc9dx3E
	 HQFrEh6/fCgDhY+qmXcUfod23YvO7XjP3Y50sqsx4wzPxHcI0DQtYmbiAP6/GuOtiV
	 FGWJ+3+xMegew==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, linux-media@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Subject:
 [RESEND][PATCH v1] media: mediatek: vcodec: Discard pm_runtime_put() return
 value
Date: Thu, 08 Jan 2026 16:23:21 +0100
Message-ID: <3396476.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
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

This is requisite for converting pm_runtime_put() into a void function.

If you decide to pick it up, please let me know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

Originally posted here:

https://lore.kernel.org/linux-pm/3690736.iIbC2pHGDl@rafael.j.wysocki/

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




