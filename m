Return-Path: <linux-pm+bounces-18841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB949E9C74
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F55C1889435
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF491F0E3F;
	Mon,  9 Dec 2024 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MjR0SLvi"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC41F0E2D;
	Mon,  9 Dec 2024 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763645; cv=none; b=tzXhMMnj3Uin030hml65XFCirkqBGJYaMtVkXyvAeWEou/ybW+v60jeem5N5+k41h+8YinoP8/IPsRxIXarcFv+OBaF7wTgsPzAVhSrEubHsG+T76ZRaKTXcdgwHQEhlVZ7H8qCuogxIf2+b+9vNnpjhZN594G0FH1d2IXTr2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763645; c=relaxed/simple;
	bh=xMYKnT9eI6CI0S0/AklVxM6Kv41jw6IBy8E+3bue+m8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYc/PZWIvCY6e30sO1ZVJnVCWG3RREu4Te/AdNS0U6cIgKbcD9PWl5MmmW/aOnHQgdL2bYENn610CiLdM9IUTIhUCzQ5XyKfZ+oArTSWJgA3fO2ZL/CQfUkOQ6GjOfJMqHAFGpSVvnLHCGiZ+oYeh5VMujhbzyQdhkJLIfmQj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MjR0SLvi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733763642;
	bh=xMYKnT9eI6CI0S0/AklVxM6Kv41jw6IBy8E+3bue+m8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MjR0SLviV2ERCh7BvRdUqkr0nKF7qktLzoCHJlIOvVPXHBQJO70b67Nb4+L5Gej3g
	 cRUrV8lYhNnanEKb35QH2IPO9YLQu2gC2IsUAcbDZbCHFVSP1F+bR6UUDYMI50M3Id
	 PlDAH+VqQqMDxb1WQx6ZisTx7cpvhmeLQKCBWdIR9rL2UPAJnrge/lhlTdtBTqBAek
	 IyfAZx/56PeB+r4H7SY9TE7P/7uDxwxI67Qg8Mw4cZH4HkufcwwfXH8iZsaMORwC+t
	 BH51lb7N1j9xjIVnRtC638hXAiAXGVHzJQtMGH8IpXPiZolWLqJWwYZCj2ILMhLTQw
	 QJY/ShJL/T5sg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 62BAF17E37C5;
	Mon,  9 Dec 2024 18:00:38 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 09 Dec 2024 14:00:05 -0300
Subject: [PATCH v2 4/5] thermal/drivers/mediatek/lvts: Start sensor
 interrupts disabled
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-mt8192-lvts-filtered-suspend-fix-v2-4-5b046a99baa9@collabora.com>
References: <20241209-mt8192-lvts-filtered-suspend-fix-v2-0-5b046a99baa9@collabora.com>
In-Reply-To: <20241209-mt8192-lvts-filtered-suspend-fix-v2-0-5b046a99baa9@collabora.com>
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 04bfbfe93a71ee9e3428bfd7f8bd359fe9446e88..38668b5b34c7375d3a3b0dcf8dcc965a254776cc 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -65,7 +65,6 @@
 #define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x0300318C
 
 #define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0		BIT(3)
 #define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR1		BIT(8)
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


