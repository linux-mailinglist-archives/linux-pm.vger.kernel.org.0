Return-Path: <linux-pm+bounces-34824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6130BB7D8C8
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E7A484FFB
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DFB29A30D;
	Wed, 17 Sep 2025 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="08NWMzMt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E+Lx8joe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="08NWMzMt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E+Lx8joe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8229A9F9
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090794; cv=none; b=bNWjjA94c8NWeJQ6XKAlXi8SduWW3nNz1CXas7Mm1yApNEB0PDSlDhOCt8dni+nA3eOR8g0/i02kD/UWGNtVgPtI/wBgkfaIauPASEMMsQSbY/F6Zo7evrXB+M5Gu2tZMPap17xhfUPoZgX+Ku9Gv3YVxCk3z9AtcL+t5xdvYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090794; c=relaxed/simple;
	bh=BA5LJvVXo2NscfsRCAxpCvSgyy12F/lb6qmt872utOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiu9b/81bOiI3x/xbsC7/Y5hjz5C/FsqqE6tj+Xg9CGTVtgM1dzkqxnOJPlZkiA7C6SwZvEsKPgF6Xwz9cItKP7rCMVAsag2/P+7XhXzczjKI+mMSiyHXGggbiVd/uJbuKSj0Q43L9vPnZFTKF6jqPfoYnNvC6s9cUDJgS8OKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=08NWMzMt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E+Lx8joe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=08NWMzMt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E+Lx8joe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B7BF21E40;
	Wed, 17 Sep 2025 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758090785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8/pa2LbEvgl9X3+G3QMRkcLt8ATvzwHE9Kdtn1XYAY=;
	b=08NWMzMtc/jlbCJEQjlvsIIBGeLoITSpKwuy/pySyNuQt4TU8NtWW/X8grD+31YoV9zwpt
	jnQ53NvSWqGgYQTz3ql1ERDmI/B1ZxYfZFPoGJ/LeohDpinGN3l6YWJE9BsNXoEabBRVb8
	vHJf+QXS0mH8uZU1Npslt8RvOTYwqwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758090785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8/pa2LbEvgl9X3+G3QMRkcLt8ATvzwHE9Kdtn1XYAY=;
	b=E+Lx8joecgq7TJWKNCNvUEfqmM20ecji3WV5E7aK2Dc8C2AqveuVOnIgAsIhA5Kc5urHYj
	+VkUT0HpuspNmZAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758090785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8/pa2LbEvgl9X3+G3QMRkcLt8ATvzwHE9Kdtn1XYAY=;
	b=08NWMzMtc/jlbCJEQjlvsIIBGeLoITSpKwuy/pySyNuQt4TU8NtWW/X8grD+31YoV9zwpt
	jnQ53NvSWqGgYQTz3ql1ERDmI/B1ZxYfZFPoGJ/LeohDpinGN3l6YWJE9BsNXoEabBRVb8
	vHJf+QXS0mH8uZU1Npslt8RvOTYwqwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758090785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8/pa2LbEvgl9X3+G3QMRkcLt8ATvzwHE9Kdtn1XYAY=;
	b=E+Lx8joecgq7TJWKNCNvUEfqmM20ecji3WV5E7aK2Dc8C2AqveuVOnIgAsIhA5Kc5urHYj
	+VkUT0HpuspNmZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2170E13A63;
	Wed, 17 Sep 2025 06:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kOjbBSBWymiIXwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 17 Sep 2025 06:33:04 +0000
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
Subject: [PATCH 1/4] pmdomain: bcm: bcm2835-power: Prepare to support BCM2712
Date: Wed, 17 Sep 2025 09:32:30 +0300
Message-ID: <20250917063233.1270-2-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250917063233.1270-1-svarbanov@suse.de>
References: <20250917063233.1270-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]
X-Spam-Flag: NO
X-Spam-Score: -1.30

BCM2712 has a PM block but lacks asb and rpivid_asb register
spaces. To avoid unwanted results add a check for asb existence
during probe and also add a new register offset for bcm2712 to
control grafx_v3d power domain. The decision to use the new
register is implicit - if asb register base is null then the
driver is probed for bcm2712 (the other supported SoCs have
asb register space).

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
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


