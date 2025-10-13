Return-Path: <linux-pm+bounces-35947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA9BBD1D23
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 09:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 116A64EC889
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 07:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299FA2E92B7;
	Mon, 13 Oct 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AyQkphUp"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0C2E8DE2;
	Mon, 13 Oct 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340886; cv=pass; b=KawHxvkAGVv4nSDnSF3dRWXcQK0w0QRnQ2ZGRI9uSD2Mum3i3QjT0RTLyc0Qi4uKOaAqswpL4CaLuiNL1K5TrntGRFnVNG/BiMIn+RNc7oagHLmMp+XaxgPOwDT3JaJuYniqaPoMB0C5+EccGc69bYhY9QrErx5MKpPW15+tBI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340886; c=relaxed/simple;
	bh=A9EJJL6HpVd5HlAevCxk3ja2iF96RJMdvndegCmdfHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n7N5sjOVkmODBskkMZhzKVoBfHQxRDLXQAl9GY9MmG+0FVnQl/s7OO7tgDaCUE6JFZFGcwP4nRMXYhy+nFu4UL3rQMfZ3hK82lBBn/FF4ugtwBh5NoFP5NjRENB9wKkIpp04eWke/vGf1rHQj6+2lLiVujK7/kkESjVsYgIX/kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=AyQkphUp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760340856; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SjXvJu+0aw4xckUH7lck7ICJqmaQGmv80hZYTOYLzaknZ/8xvlq40ClTC57fIcoHd8npb86VG9Y8lEFYP8CWAJEvMZFdWwfz9Q4n5JKT2SGvqV8rfh+cCdhe+5JVurMrcqsK60NYFDSgDxX3niuml8J5RovrZIniTi9GqQJuqoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760340856; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5W/p2P/EoHtENGM2zw+O/fNV3kIkZkb90QJ9eHXBW54=; 
	b=gE5whtZRfMU5IMkCVkgFMHEhfjktbPhtMbgGr4vQdbe8mWOdNRIRzegLrH7jsL145/7aGuxFzlzzwcAZ5dgCi9udaiFhlT+esw0IxjaHCWUFvIi9OTEgBeLDqxyIJovNDWB6ERCTrLU+0dJit5IOKLN2k8ILkmO7rCrfvbnl9Ec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760340856;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=5W/p2P/EoHtENGM2zw+O/fNV3kIkZkb90QJ9eHXBW54=;
	b=AyQkphUp6sUYT5/8R3SRYFj/3pk43NQrIK4FuMU8/rbecKhdT1duMmIYYbA5MWbd
	SN1oQaQk9FDra61sc+sC5xzMQzrrkY705gZaEYDtDjYy86oVaZwSQ2IflTsDYOZubCV
	nqESgaDlUGDIofIb0f2bW7So6LUxQQbbRZIucH1g=
Received: by mx.zohomail.com with SMTPS id 1760340853910318.69177918268304;
	Mon, 13 Oct 2025 00:34:13 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 13 Oct 2025 09:34:04 +0200
Subject: [PATCH] PM / devfreq: rockchip-dfi: switch to FIELD_PREP_WM16
 macro
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-hiword-rockchip-dfi-v1-1-4f2a63098553@collabora.com>
X-B4-Tracking: v=1; b=H4sIAGur7GgC/yXMQQrCMBCF4auEWTuSxBpKryJd1GRiBmlTJ7UKp
 Xc32OX34P0bFBKmAp3aQGjlwnmqMCcFPg3Tg5BDNVhtr0abCyb+ZAko2T994hlDZGyMdjo617R
 WQ33OQpG//+qtPyz0etf4coxwHwqhz+PIS6dWdzYtijfQ7/sPfxY7wJIAAAA=
X-Change-ID: 20251013-hiword-rockchip-dfi-41060f664820
To: Yury Norov <yury.norov@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
drivers that use constant masks.

Like many other Rockchip drivers, rockchip-dfi brings with it its own
HIWORD_UPDATE macro. This variant doesn't shift the value (and like the
others, doesn't do any checking).

Remove it, and replace instances of it with hw_bitfield.h's
FIELD_PREP_WM16.  Since FIELD_PREP_WM16 requires contiguous masks and
shifts the value for us, some reshuffling of definitions needs to
happen.

This gives us better compile-time error checking, and in my opinion,
nicer code.

Tested on an RK3568 ODROID-M1 board (LPDDR4X at 1560 MHz, an RK3588
Radxa ROCK 5B board (LPDDR4X at 2112 MHz) and an RK3588 Radxa ROCK 5T
board (LPDDR5 at 2400 MHz). perf measurements were consistent with the
measurements of stress-ng --stream in all cases.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Hi Yury,

as promised[1], here's the follow-up patch to move rockchip-dfi to the
new FIELD_PREP_WM16 macro after the LPDDR5 changes, which caused a
conflict during the last merge window.

I've re-tested it on three boards, as outlined in the commit message.

Link: https://lore.kernel.org/all/14358105.O9o76ZdvQC@workhorse/t/#m6b5b01cb30a04745ea3167a660b4794c608f387b [1]
---
 drivers/devfreq/event/rockchip-dfi.c | 45 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 5a2c9badcc64..5e6e7e900bda 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/bitfield.h>
+#include <linux/hw_bitfield.h>
 #include <linux/bits.h>
 #include <linux/perf_event.h>
 
@@ -30,8 +31,6 @@
 
 #define DMC_MAX_CHANNELS	4
 
-#define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
-
 /* DDRMON_CTRL */
 #define DDRMON_CTRL	0x04
 #define DDRMON_CTRL_LPDDR5		BIT(6)
@@ -41,10 +40,6 @@
 #define DDRMON_CTRL_LPDDR23		BIT(2)
 #define DDRMON_CTRL_SOFTWARE_EN		BIT(1)
 #define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
-#define DDRMON_CTRL_DDR_TYPE_MASK	(DDRMON_CTRL_LPDDR5 | \
-					 DDRMON_CTRL_DDR4 | \
-					 DDRMON_CTRL_LPDDR4 | \
-					 DDRMON_CTRL_LPDDR23)
 #define DDRMON_CTRL_LP5_BANK_MODE_MASK	GENMASK(8, 7)
 
 #define DDRMON_CH0_WR_NUM		0x20
@@ -124,27 +119,31 @@ struct rockchip_dfi {
 	unsigned int count_multiplier;	/* number of data clocks per count */
 };
 
-static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl,
-					u32 *mask)
+static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
 {
 	u32 ddrmon_ver;
 
-	*mask = DDRMON_CTRL_DDR_TYPE_MASK;
-
 	switch (dfi->ddr_type) {
 	case ROCKCHIP_DDRTYPE_LPDDR2:
 	case ROCKCHIP_DDRTYPE_LPDDR3:
-		*ctrl = DDRMON_CTRL_LPDDR23;
+		*ctrl = FIELD_PREP_WM16(DDRMON_CTRL_LPDDR23, 1) |
+			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR4, 0) |
+			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR5, 0);
 		break;
 	case ROCKCHIP_DDRTYPE_LPDDR4:
 	case ROCKCHIP_DDRTYPE_LPDDR4X:
-		*ctrl = DDRMON_CTRL_LPDDR4;
+		*ctrl = FIELD_PREP_WM16(DDRMON_CTRL_LPDDR23, 0) |
+			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR4, 1) |
+			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR5, 0);
 		break;
 	case ROCKCHIP_DDRTYPE_LPDDR5:
 		ddrmon_ver = readl_relaxed(dfi->regs);
 		if (ddrmon_ver < 0x40) {
-			*ctrl = DDRMON_CTRL_LPDDR5 | dfi->lp5_bank_mode;
-			*mask |= DDRMON_CTRL_LP5_BANK_MODE_MASK;
+			*ctrl = FIELD_PREP_WM16(DDRMON_CTRL_LPDDR23, 0) |
+				FIELD_PREP_WM16(DDRMON_CTRL_LPDDR4, 0) |
+				FIELD_PREP_WM16(DDRMON_CTRL_LPDDR5, 1) |
+				FIELD_PREP_WM16(DDRMON_CTRL_LP5_BANK_MODE_MASK,
+						dfi->lp5_bank_mode);
 			break;
 		}
 
@@ -172,7 +171,6 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 	void __iomem *dfi_regs = dfi->regs;
 	int i, ret = 0;
 	u32 ctrl;
-	u32 ctrl_mask;
 
 	mutex_lock(&dfi->mutex);
 
@@ -186,7 +184,7 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 		goto out;
 	}
 
-	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl, &ctrl_mask);
+	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
 	if (ret)
 		goto out;
 
@@ -196,15 +194,16 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 			continue;
 
 		/* clear DDRMON_CTRL setting */
-		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN |
-			       DDRMON_CTRL_SOFTWARE_EN | DDRMON_CTRL_HARDWARE_EN),
+		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_TIMER_CNT_EN, 0) |
+			       FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 0) |
+			       FIELD_PREP_WM16(DDRMON_CTRL_HARDWARE_EN, 0),
 			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
 
-		writel_relaxed(HIWORD_UPDATE(ctrl, ctrl_mask),
-			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+		writel_relaxed(ctrl, dfi_regs + i * dfi->ddrmon_stride +
+			       DDRMON_CTRL);
 
 		/* enable count, use software mode */
-		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTWARE_EN),
+		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 1),
 			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
 
 		if (dfi->ddrmon_ctrl_single)
@@ -234,8 +233,8 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
 
-		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
-			      dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 0),
+			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
 
 		if (dfi->ddrmon_ctrl_single)
 			break;

---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251013-hiword-rockchip-dfi-41060f664820

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


