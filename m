Return-Path: <linux-pm+bounces-37230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E4CC26957
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 19:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B80A1A21893
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE6933EAEF;
	Fri, 31 Oct 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dUBPGBA+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pAyUzm72";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dUBPGBA+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pAyUzm72"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9FC29D28A
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935618; cv=none; b=K0Z7xL7LnCPbBk8mbeMo01FBfJVR6QfKBraoSlIcDdf3qIRCEHky1gq2+ofW8wDmqlxGgkFzxflekKdJq1NfJpLwykht19PdEKp0GE2LCBZDXCYSgaz1ytnLjTPqUH+4Eq+vEMPHNOFYMmDu7INkXUJrN2RWKXHfdGYXeJVlRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935618; c=relaxed/simple;
	bh=w5/GnAi/zUVMBMEyzPHkK27YA16h6MqOVf2gNzHegP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufS2C/GccDMoevhjCbJH8cXX9WfREc6EdZXgqQF26mqwpopWxltwaveGnw2Mb6bNtdWyZ8BidJaR0wiRCoZ9Z34/f88Dy98NQJ8EVb5qvyIrsVX0TYx4ypkJ91Vm/vjlworNB9Y89Anyx2LbxRoAyRVcpbQ+XLkm4UFsCg7Scwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dUBPGBA+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pAyUzm72; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dUBPGBA+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pAyUzm72; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E28641F38A;
	Fri, 31 Oct 2025 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761935597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTw7iWUX8HaZ6Ol9jn6dxV7QLQ2mYM3zWUSbDbp7Gho=;
	b=dUBPGBA+p2/5SFiVzyJWZ5LLo+3i9jsO5eUeUx4SKk/qeyFkLZrm8JVfXEivukyVYcnnNX
	hF31VLhFfkS2dSaFwyxbCFmHUByRwmsHOyuarkD/uxkH70ZUetOJD9spmb+WDnjrxAtfD3
	4TlRcjlHTMhRzpobgxDYpAr1rUTITHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761935597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTw7iWUX8HaZ6Ol9jn6dxV7QLQ2mYM3zWUSbDbp7Gho=;
	b=pAyUzm72q3IlV1VFiso88cyzsmqCDwhU/gbgORlYbk0VLDEzHq3cNmnNaHzKlIXc/3MUfo
	F0aflCR8YZVk+2Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761935597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTw7iWUX8HaZ6Ol9jn6dxV7QLQ2mYM3zWUSbDbp7Gho=;
	b=dUBPGBA+p2/5SFiVzyJWZ5LLo+3i9jsO5eUeUx4SKk/qeyFkLZrm8JVfXEivukyVYcnnNX
	hF31VLhFfkS2dSaFwyxbCFmHUByRwmsHOyuarkD/uxkH70ZUetOJD9spmb+WDnjrxAtfD3
	4TlRcjlHTMhRzpobgxDYpAr1rUTITHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761935597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTw7iWUX8HaZ6Ol9jn6dxV7QLQ2mYM3zWUSbDbp7Gho=;
	b=pAyUzm72q3IlV1VFiso88cyzsmqCDwhU/gbgORlYbk0VLDEzHq3cNmnNaHzKlIXc/3MUfo
	F0aflCR8YZVk+2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AFB813A1F;
	Fri, 31 Oct 2025 18:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uInqFO0ABWmTegAAD6G6ig
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
Subject: [PATCH v3 3/4] mfd: bcm2835-pm: Add support for BCM2712
Date: Fri, 31 Oct 2025 20:33:08 +0200
Message-ID: <20251031183309.1163384-4-svarbanov@suse.de>
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
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

The BCM2712 SoC has PM block but lacks the "asb" and "rpivid_asb"
register spaces, and doesn't need clock(s).  Add a compatible
string for bcm2712 to allow probe of bcm2835-wdt and
bcm2835-power drivers.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/mfd/bcm2835-pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 3cb2b9423121..8bed59816e82 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -108,6 +108,7 @@ static const struct of_device_id bcm2835_pm_of_match[] = {
 	{ .compatible = "brcm,bcm2835-pm-wdt", },
 	{ .compatible = "brcm,bcm2835-pm", },
 	{ .compatible = "brcm,bcm2711-pm", },
+	{ .compatible = "brcm,bcm2712-pm", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm2835_pm_of_match);
-- 
2.47.0


