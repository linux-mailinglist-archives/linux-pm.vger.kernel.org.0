Return-Path: <linux-pm+bounces-37229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26873C26948
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 19:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7761A66037
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEAF2E9741;
	Fri, 31 Oct 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PcFqSjb2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q8MVM/Py";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PcFqSjb2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q8MVM/Py"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37034253F2B
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935611; cv=none; b=IABqikHfnScvJGO7O99cXlREEAQ82ytqOnWlxr0C8fnPCcqLs1tNsm/dnViPBMVy7CFqhzdFB0LLFnpgwmvUlOGd2xgDw8tEZwzjiJvaLhpiSj29PhVcFWNYXD3oOP3St3wQUgCbl/tgiC1FZPuV1hgjjyssbgWZsM65JXphRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935611; c=relaxed/simple;
	bh=NW9XXxcITXYpvDE7Whlw3UL02BUp/0RJhgdd8jBQVyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i48ddOx7Hrv5Gv0XUNwT1MEpfI+5XHBEKQdNJmUvadeEdzAxIrG/icBExs5AhvupPmBePJX5ASeSVacAeCpsF+dmmtJvs3XV/kLopdtdHjhsLJVe77+6KfuYqgD20xG298y9rkkYh7AUgsw4sW7it9luEle09prSNJuPOyCuQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PcFqSjb2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q8MVM/Py; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PcFqSjb2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q8MVM/Py; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6BA11F388;
	Fri, 31 Oct 2025 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761935596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sf+5I4mtvTjsPy4fCTVlt4edYy7KKeLFbDhcyqxDQRQ=;
	b=PcFqSjb2OImrc9u4MCIeFAvomRAd/0btIFfVSwBJgA9p6PGfLSDqGc2Oj3YA68AVF2vcR8
	FwNdonTBlM0HlIjWju7CXCaEgUuUoIFVKbawHyO4ZEU/FhzY4cKZ8zg1Hq0/4Q12ojfxgT
	n8B3pUgeI/YV6J0urRVT46KErbVpSZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761935596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sf+5I4mtvTjsPy4fCTVlt4edYy7KKeLFbDhcyqxDQRQ=;
	b=q8MVM/Py2UCBtKGlAaLJGSvrEamt8hALCMkjdhBhRHHRtGepuTAa+FYS22gfmMmYvsXGOW
	AaAdVTB6UNOh+UBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PcFqSjb2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="q8MVM/Py"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761935596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sf+5I4mtvTjsPy4fCTVlt4edYy7KKeLFbDhcyqxDQRQ=;
	b=PcFqSjb2OImrc9u4MCIeFAvomRAd/0btIFfVSwBJgA9p6PGfLSDqGc2Oj3YA68AVF2vcR8
	FwNdonTBlM0HlIjWju7CXCaEgUuUoIFVKbawHyO4ZEU/FhzY4cKZ8zg1Hq0/4Q12ojfxgT
	n8B3pUgeI/YV6J0urRVT46KErbVpSZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761935596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sf+5I4mtvTjsPy4fCTVlt4edYy7KKeLFbDhcyqxDQRQ=;
	b=q8MVM/Py2UCBtKGlAaLJGSvrEamt8hALCMkjdhBhRHHRtGepuTAa+FYS22gfmMmYvsXGOW
	AaAdVTB6UNOh+UBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BE9E13A1F;
	Fri, 31 Oct 2025 18:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ENJpCewABWmTegAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 31 Oct 2025 18:33:16 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pm@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Lee Jones <lee@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Willow Cunningham <willow.e.cunningham@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v3 1/4] pmdomain: bcm: bcm2835-power: Prepare to support BCM2712
Date: Fri, 31 Oct 2025 20:33:06 +0200
Message-ID: <20251031183309.1163384-2-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251031183309.1163384-1-svarbanov@suse.de>
References: <20251031183309.1163384-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B6BA11F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLw7mkaud87zuqqztkur5718rm)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]
X-Spam-Score: -1.51

BCM2712 has a PM block but lacks asb and rpivid_asb register
spaces. To avoid unwanted results add a check for asb existence
during probe and also add a new register offset for bcm2712 to
control grafx_v3d power domain. The decision to use the new
register is implicit - if asb register base is null then the
driver is probed for bcm2712 (the other supported SoCs have
asb register space).

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pmdomain/bcm/bcm2835-power.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index f5289fd184d0..1d29addfe036 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -79,6 +79,7 @@
 #define PM_IMAGE			0x108
 #define PM_GRAFX			0x10c
 #define PM_PROC				0x110
+#define PM_GRAFX_2712			0x304
 #define PM_ENAB				BIT(12)
 #define PM_ISPRSTN			BIT(8)
 #define PM_H264RSTN			BIT(7)
@@ -381,6 +382,9 @@ static int bcm2835_power_pd_power_on(struct generic_pm_domain *domain)
 		return bcm2835_power_power_on(pd, PM_GRAFX);
 
 	case BCM2835_POWER_DOMAIN_GRAFX_V3D:
+		if (!power->asb)
+			return bcm2835_asb_power_on(pd, PM_GRAFX_2712,
+						    0, 0, PM_V3DRSTN);
 		return bcm2835_asb_power_on(pd, PM_GRAFX,
 					    ASB_V3D_M_CTRL, ASB_V3D_S_CTRL,
 					    PM_V3DRSTN);
@@ -447,6 +451,9 @@ static int bcm2835_power_pd_power_off(struct generic_pm_domain *domain)
 		return bcm2835_power_power_off(pd, PM_GRAFX);
 
 	case BCM2835_POWER_DOMAIN_GRAFX_V3D:
+		if (!power->asb)
+			return bcm2835_asb_power_off(pd, PM_GRAFX_2712,
+						     0, 0, PM_V3DRSTN);
 		return bcm2835_asb_power_off(pd, PM_GRAFX,
 					     ASB_V3D_M_CTRL, ASB_V3D_S_CTRL,
 					     PM_V3DRSTN);
@@ -635,10 +642,12 @@ static int bcm2835_power_probe(struct platform_device *pdev)
 	power->asb = pm->asb;
 	power->rpivid_asb = pm->rpivid_asb;
 
-	id = readl(power->asb + ASB_AXI_BRDG_ID);
-	if (id != BCM2835_BRDG_ID /* "BRDG" */) {
-		dev_err(dev, "ASB register ID returned 0x%08x\n", id);
-		return -ENODEV;
+	if (power->asb) {
+		id = readl(power->asb + ASB_AXI_BRDG_ID);
+		if (id != BCM2835_BRDG_ID /* "BRDG" */) {
+			dev_err(dev, "ASB register ID returned 0x%08x\n", id);
+			return -ENODEV;
+		}
 	}
 
 	if (power->rpivid_asb) {
-- 
2.47.0


