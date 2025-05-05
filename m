Return-Path: <linux-pm+bounces-26670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF4AA9FA4
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 00:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4647AAA16
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 22:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257FC285404;
	Mon,  5 May 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDKnu2nY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34C2853FC;
	Mon,  5 May 2025 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483339; cv=none; b=XIo0ES28ZrYtil3VgfT8l8tzPvGzsCF0onXBKsR5T6XywqNW8oXA7lZzJWDYQVstmlEejnsO+LR6u2hgzejgyPym/hmHD6N4F7iqToITkhvDrED4g6ovqdFAa8UeOxE19ZNzpkHmmTMlCTu0G2YyUQHYWmLlRK+Z3CGFSfmt2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483339; c=relaxed/simple;
	bh=xazpbVO5jhA9wM7EuetRd5ydsUqFutYGbsnrlCdoRvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2kk70zOT3EF07c/vVoX/fjTLXjwvCRV+oPSD8QpW89I3PcXXpOgriYl5Vj5NCu9Wa/IZg47plNgaZaC46K/nEt1vGFRRvWPOGQ6D2hzRf4jJrZBqzSGtL3CTG2VAc1MgkeTlY3TU+dxdfCyEMBfmUmVYEFPkP6Qa67UaQz2s1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDKnu2nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8192C4CEE4;
	Mon,  5 May 2025 22:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483338;
	bh=xazpbVO5jhA9wM7EuetRd5ydsUqFutYGbsnrlCdoRvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDKnu2nYV8S/wo+fPLusdWyVvbANH7BYR+AfZIe6l2KhWBIaXJewzesWOWIM4t9hW
	 Mk1F+p2R+JKX6hR+NpEl7cfiPNASPCtqvfQeuX4lXRuBz/EiB5Wnv6G9UZ2p8xQBb1
	 ZlAJ4PHq/Jba0vHZHFNz3W21vh8In1oOyi04UyNcMMmGQhRSHD7X2rfjg4E89Mr0jS
	 3rrvkzPYz5vxx7eQ2iOGgHl/TfEwjwlqdkftcuDAsbLQLhWguSiC9V4491FeTwoVKb
	 NDgG/ldmjRtvnd+noHWOQ+5VqD29KEA4JzQaUq/diml8sIidKmFyrxcrO6fjJwIa2m
	 GgQLle+SESypQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	matthias.bgg@gmail.com,
	jpanis@baylibre.com,
	npitre@baylibre.com,
	colin.i.king@gmail.com,
	wenst@chromium.org,
	u.kleine-koenig@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 041/642] thermal/drivers/mediatek/lvts: Start sensor interrupts disabled
Date: Mon,  5 May 2025 18:04:17 -0400
Message-Id: <20250505221419.2672473-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 2738fb3ec6838a10d2c4ce65cefdb3b90b11bd61 ]

Interrupts are enabled per sensor in lvts_update_irq_mask() as needed,
there's no point in enabling all of them during initialization. Change
the MONINT register initial value so all sensor interrupts start
disabled.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/r/20250113-mt8192-lvts-filtered-suspend-fix-v2-4-07a25200c7c6@collabora.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0aaa44b734ca4..d0901d8ac85da 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -65,7 +65,6 @@
 #define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x0300318C
 
 #define LVTS_MONINT_OFFSET_SENSOR0		0xC
 #define LVTS_MONINT_OFFSET_SENSOR1		0x180
@@ -929,7 +928,7 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 * The LVTS_MONINT register layout is the same as the LVTS_MONINTSTS
 	 * register, except we set the bits to enable the interrupt.
 	 */
-	writel(LVTS_MONINT_CONF, LVTS_MONINT(lvts_ctrl->base));
+	writel(0, LVTS_MONINT(lvts_ctrl->base));
 
 	return 0;
 }
-- 
2.39.5


