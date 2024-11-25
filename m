Return-Path: <linux-pm+bounces-18109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849A19D8DE7
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 22:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CA928BE2A
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 21:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7841CDA3F;
	Mon, 25 Nov 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LfjxZWA1"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644D1CD213;
	Mon, 25 Nov 2024 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569669; cv=none; b=OrrLLi7rHG+yrA3aUz7md4eBV+4YHBQXtseP2PYhujqdXBlhAa+RFEOFkHGXbaqhsG2XD/7Qt+drc/LQG0/I3rtNfcCYXINRHJu0yeNAsjk6emc4jnqVhtxs1ifjtbEYbUwT3+peS+hOugWVJTTzHMR+WVhDwGl1u4tdQdJwvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569669; c=relaxed/simple;
	bh=sQrVPAx8ofXaIPbdduARL5wDhf7h7Z3abU3Xpaq7VqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpjfTnQf+HUQ8mjSRPb8UDSpY9YAIbF3xYZqrnJmFxLWo0I2rFSYzPLCdbmrEh3ZziY1q4WnONYszv1RLkOhYnRPefx7H+G9xMQxnEd/EN4xJlosEJE3qOC9GGHFYRMG8xpyUMHLLB92LS7Z0xQPeKNS7FmmPiyEDnLPMG4tqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LfjxZWA1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732569666;
	bh=sQrVPAx8ofXaIPbdduARL5wDhf7h7Z3abU3Xpaq7VqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LfjxZWA1XzodK+vcZt2ELobIJnoZ0J30waBzEjB+mOBv+F+LVvmIhb+mCO/Uk4inI
	 MPkH9OT6035EUWgqmfi5P+tM3fsZLfG0Kyz/7XQ16ZuK3pXBUuQugXhWdBUjoEPNdd
	 yDj8vs8u1B8zx6R+jEJEuLf9LcXTN3T0MoPQyIB/wPqob2lKKY4cvLjz5KvhRHGUH6
	 iC7srjYzegZGXgosXISUw85LJNgHjaAYPf9n12y+fA8O/rmqh6ImamtBo8CtRztFGq
	 ZmcAxvykDgC9I5ia9uPpVO3HFQgCzdhE3Tpl1iQ+ju6pMyPVwWftDfy19lgVFsqAPx
	 y9pi5KwnK6DZw==
Received: from [192.168.1.63] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8AA0917E37D2;
	Mon, 25 Nov 2024 22:21:04 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 25 Nov 2024 16:20:31 -0500
Subject: [PATCH 4/5] thermal/drivers/mediatek/lvts: Start sensor interrupts
 disabled
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241125-mt8192-lvts-filtered-suspend-fix-v1-4-42e3c0528c6c@collabora.com>
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
In-Reply-To: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Interrupts are enabled per sensor in lvts_update_irq_mask() as needed,
there's no point in enabling all of them during initialization. Change
the MONINT register initial value so all sensor interrupts start
disabled.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 2271023f090df82fbdd0b5755bb34879e58b0533..90f305fa6fb659ae9e3db0faf1a406ef1500adf2 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -65,7 +65,6 @@
 #define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x0300318C
 
 #define LVTS_MONINT_OFFSET_HIGH_SENSOR0		BIT(3)
 #define LVTS_MONINT_OFFSET_HIGH_SENSOR1		BIT(8)
@@ -951,7 +950,7 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 * The LVTS_MONINT register layout is the same as the LVTS_MONINTSTS
 	 * register, except we set the bits to enable the interrupt.
 	 */
-	writel(LVTS_MONINT_CONF, LVTS_MONINT(lvts_ctrl->base));
+	writel(0, LVTS_MONINT(lvts_ctrl->base));
 
 	return 0;
 }

-- 
2.47.0


