Return-Path: <linux-pm+bounces-37231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80732C2697E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 19:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FEA427F2A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528392F0C6D;
	Fri, 31 Oct 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PkJIaNbF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JboD07Dh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mPScrzR9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fRNXJIsU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B12DE6FB
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935625; cv=none; b=T0/0Zr+5+3mp2CJnwxlvnlF1nZjG21rTQcRVfzqm8dncZdGAz+TUcLAEZFWtcE0g9sIqza/KY+hho/7jz2uG2r5nIHoT/VucFY5Oqe010R0sg/qxjov+3oVFXEV3/MicMRySzySQfcw8DPBwl26wspbvw3TysswlzS/+ztz6eeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935625; c=relaxed/simple;
	bh=znuImQ6p9NSU/kNpD9vWhQEQF4tSFGH0VNvNM5jVa3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVt5EDKekNKfwx+oEHTLuyEQlfwX3D2e5T2SXifwfVmEo8jDrnTOYNIqu8oh25t19S6N0Sjl1Iku2fSsz95Zon1W0fi6YRAXdtEgvqQNzhNnZlzUtwAhEHBgWgY8DTbpr+xTsnGr1cwz3YzZjb8dwEOvO1Y7bp4TwcT8dbh8tL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PkJIaNbF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JboD07Dh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mPScrzR9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fRNXJIsU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FF991F38C;
	Fri, 31 Oct 2025 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761935599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUyPK8JAqWudplR/2LaZrm1ThRmweJDGU1ip12PgpiM=;
	b=PkJIaNbFkJ+tGnUzeOqcAJvsnB7hnurbnya/au1U9KqCWFFYKbyejfEg/mVZD/1RYh6FBj
	LlZCC5e0VQTHnS3Ew0fsUmAAeblv5jZt4qcd+rVTjJ4JMtuDN86fXr8+Wx+I2oCY1kUb7C
	kXXQdE5ISe4K0xeMKJubhdS1C0r5n5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761935599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUyPK8JAqWudplR/2LaZrm1ThRmweJDGU1ip12PgpiM=;
	b=JboD07DhvfSMkw7SJaicojzh3/KnYhpNggSyEWcSMO6emvqXo8KiAApoLjVT2PQaeY3kRq
	e3t5uom+f/PryHAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761935598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUyPK8JAqWudplR/2LaZrm1ThRmweJDGU1ip12PgpiM=;
	b=mPScrzR9lZpxhWIBdzwqVE1eQpONQlFwy4r7+/E4uF/Y8SbOd+qBYED2apTqQi/PnfZAeu
	eQgVR4ka8X9LDxqIbIo2pIC2MiUs80YcXV2DmJO28o02FBjZf2YJ92OAXgrKZo1jV9RN3V
	iLc5bVoOFcRjbjrgb/5nWG46rhMvwY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761935598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUyPK8JAqWudplR/2LaZrm1ThRmweJDGU1ip12PgpiM=;
	b=fRNXJIsU6uOgFvB35Eq5/AMM89K/5ASw0imiJDGw6ACJONBdwuJCearraxpS8OqosS7y0a
	SrEmkDRVmt3mSoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E97E613991;
	Fri, 31 Oct 2025 18:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EMe5N+0ABWmTegAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 31 Oct 2025 18:33:17 +0000
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
Subject: [PATCH v3 4/4] arm64: dts: broadcom: bcm2712: Add watchdog DT node
Date: Fri, 31 Oct 2025 20:33:09 +0200
Message-ID: <20251031183309.1163384-5-svarbanov@suse.de>
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
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]
X-Spam-Flag: NO
X-Spam-Score: -1.30
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


