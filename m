Return-Path: <linux-pm+bounces-37173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C153C2471E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 11:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0A3401218
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90152342169;
	Fri, 31 Oct 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1l6bPKMJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WJISIQqx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cMG9MK0C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IWYNU1tZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1434166A
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906288; cv=none; b=nWpn4a/3MQGc7qV6X/r5C8yz3IhiSGQaod1B7maEbfmMq4286pFEZYgzZlcoQjtqJzFSfLsv2JriqlyvqkGRVMjdZEoVsu+OVrWZjL2ow1Na5U7CPJ9FZF2NQm1DC8uCJZiWUZW4A0opm4rIrWCUztx+HzSd557rteQrgqM3WSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906288; c=relaxed/simple;
	bh=w5/GnAi/zUVMBMEyzPHkK27YA16h6MqOVf2gNzHegP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/Bw0sXT90A72vbSnxgWm6yUgJU2yJAXcFDcXASFyzX8U3h0jQtn3LHBkURxhRdiYyZ/ni0bg+bcl1pskjwngDHH5zArUyBnL3+ogqto9XOsNU23OyXT3H+rDCLQjtqHcFImxxnNwH56EIVKvg4vnHHlh2rcvmZcpFS3Qfd4L68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1l6bPKMJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WJISIQqx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cMG9MK0C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IWYNU1tZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5FD922189;
	Fri, 31 Oct 2025 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761906273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTw7iWUX8HaZ6Ol9jn6dxV7QLQ2mYM3zWUSbDbp7Gho=;
	b=1l6bPKMJ5mnte7qYgNr+L80hZeYp8e4Ir9swUnEvr/AoK/CXATYuI35gGxPkorqELturq/
	+o7Xh1ds60QrKuo5IAlibr7m4D6IHMEDIrLk+TFURRTITHT/BOEuRSHJmF5UbOny5oHVgh
	NeRKQT8fSKMYU2CpFuuonXHsEW90OWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761906273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTw7iWUX8HaZ6Ol9jn6dxV7QLQ2mYM3zWUSbDbp7Gho=;
	b=WJISIQqxLiiEq8ENgXUIxb9BuIO+Sci9bhzb1gThE5y1eedssT17rIqO5fW1vhw9YCKFec
	wnldVzm6O7gJ8wCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761906272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTw7iWUX8HaZ6Ol9jn6dxV7QLQ2mYM3zWUSbDbp7Gho=;
	b=cMG9MK0CYwsta5C4uuzEP34dymJKbTzgOXZlkj/ZNlFaMznzSIiLOe9Q2/J4I8eQEE3YSj
	+uhQRic0sg03psr8Zd/oPdWY8kIpnxMP0T2m9EvY/CdX8iQIgVNAVAwlJ/nzVvZu/z7Url
	uHQ4IVwOqr1Ch82HOz9E0pO9GbVt084=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761906272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTw7iWUX8HaZ6Ol9jn6dxV7QLQ2mYM3zWUSbDbp7Gho=;
	b=IWYNU1tZeNkzw6GLBQu10zf+oBZAOqIkoLRccFkSyvCzcKGkMfsdHxG1CJxoc+bWHaraF4
	FaOz5pfi23XbfZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4437B13B70;
	Fri, 31 Oct 2025 10:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gC0RD2COBGlqEgAAD6G6ig
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
Subject: [PATCH v2 3/4] mfd: bcm2835-pm: Add support for BCM2712
Date: Fri, 31 Oct 2025 12:24:22 +0200
Message-ID: <20251031102423.1150093-4-svarbanov@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[broadcom.com:email,suse.de:email,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -5.30

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


