Return-Path: <linux-pm+bounces-37174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E8C2472D
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 11:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8093A40720C
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1F342CB3;
	Fri, 31 Oct 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O5UZFdFL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5CSIKl8P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ynmFKMkk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="73hwmyAc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94433FE22
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906294; cv=none; b=Rr7gPKunNXd1bpmKCTH0Nr2gCBKOCE7bZb9A0Od3D+GdruX33vy2TAcmqxagHSnML3jpZCCuAnO8tzgkYZXDeUGTGDP5Duy/PxKL1IbVbI5ddTn2HSfaF7XQkYNTfsRXgRFYn5P0JQT0moPsqDueQicC0sJbc4jWGdvWsIWdWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906294; c=relaxed/simple;
	bh=znuImQ6p9NSU/kNpD9vWhQEQF4tSFGH0VNvNM5jVa3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OifFkxp4Bc5E17NfnpdqTN4AKEeyANKSwsR7y93Xsl4dQCDIcfU8HN7QbDaK4+qkjlZZwYlJ2X/RnlNra2Jml472yWvFJBMGAw8mmAlTJ8hi/F3UkOnfM3XWyUWOl9XcFIGpJ7nEe5h7O7o+j7kH6wmUm17d1kDvvCgfQZ0hwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O5UZFdFL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5CSIKl8P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ynmFKMkk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=73hwmyAc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B08A22003;
	Fri, 31 Oct 2025 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761906274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUyPK8JAqWudplR/2LaZrm1ThRmweJDGU1ip12PgpiM=;
	b=O5UZFdFL24kPXAc/Eq+iDS4umBYxWpRJIe/gFyDCTeCUdax87Wo9Jtg93uIL+lKw8uwFap
	gJ4IbTe8R4QC5/9TdTkbzq0sUKBCh/zuEXqM3p/B0QgBYmtvNyBGCIfiKJUqqR7y7mhyIG
	E7hBkOFQrx/yrVci3LwtVVjnytR7OR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761906274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUyPK8JAqWudplR/2LaZrm1ThRmweJDGU1ip12PgpiM=;
	b=5CSIKl8PX2d4Q5AAA8ug0fAN9qwgTQD9Is7UbKNCAvqSAXlVZVW6tLli/ruoORsfZW8QnA
	OJk2a3no8LarumCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761906273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUyPK8JAqWudplR/2LaZrm1ThRmweJDGU1ip12PgpiM=;
	b=ynmFKMkkkS37BuO1Twi6pN2gXFlZNx1h5pbiUqqQ6La0mdRI10n+qVgbjPMbpAK6AvaXE4
	v3WYsj0RDbdAa7RBWhA50pmuToKLJbKkCQBfcl3Wv4vii2a23UeX4yKc90KfacZhQDBHTm
	UJJU0vgUK3YZhpbZShWMAnzRrWAbNmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761906273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUyPK8JAqWudplR/2LaZrm1ThRmweJDGU1ip12PgpiM=;
	b=73hwmyAc76PAoujBSO3iW4vFjcO3FWXXFKdOMFbAcD4qsLk1PQb2+KGiX3H3EDGdIYAail
	3eYog3EmgRgfKFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF41413991;
	Fri, 31 Oct 2025 10:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WMXbOGCOBGlqEgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 31 Oct 2025 10:24:32 +0000
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
Subject: [PATCH v2 4/4] arm64: dts: broadcom: bcm2712: Add watchdog DT node
Date: Fri, 31 Oct 2025 12:24:23 +0200
Message-ID: <20251031102423.1150093-5-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251031102423.1150093-1-svarbanov@suse.de>
References: <20251031102423.1150093-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com,suse.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 

Add watchdog device-tree node for bcm2712 SoC.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index e77a66adc22a..08905034ffc1 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -250,6 +250,15 @@ uart10: serial@7d001000 {
 			status = "disabled";
 		};
 
+		pm: watchdog@7d200000 {
+			compatible = "brcm,bcm2712-pm", "brcm,bcm2835-pm-wdt";
+			reg = <0x7d200000 0x604>;
+			reg-names = "pm";
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+			system-power-controller;
+		};
+
 		pinctrl: pinctrl@7d504100 {
 			compatible = "brcm,bcm2712c0-pinctrl";
 			reg = <0x7d504100 0x30>;
-- 
2.47.0


