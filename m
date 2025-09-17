Return-Path: <linux-pm+bounces-34826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B5B7DBD5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9B6163028
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BD7298CC7;
	Wed, 17 Sep 2025 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pc/HPfMP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fikbHzwm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pc/HPfMP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fikbHzwm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3C2882B7
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090806; cv=none; b=Q0AMGY8taiu8FEUnfYhx/ZG+F0QicCDY0AibxgCdXJryS9ePCSRkbOVEZBEEd9scovKc2touRL9bwSccoYQAWsk4f6+1KkZi/EvEcV96MV+JaqGDesSq9CQOZC2QOnVLY8HWoF0d1ZmAVgtUZx6jmWI6SbpS9NJKpLdjs2KL9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090806; c=relaxed/simple;
	bh=4BBJq+CpK16+mXcbFPjHB3l61i5WEgIT+uetcQqJUxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+zVYX4hqeIE7Zlzrp5MW+BGxSPPm+9+igDPc8UHMoQrJ2yBdOG6KuBPqKDCBNQKR6qQgnxeft/3rmj1MmzaDW0mQ9xs2lUnhYfL6VFfzw+HUlqYnPzasHLXz6910+xXUHbzEqdqe7KMED4hkHnhARs4ZY1nwQnW9C0lvGQBcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pc/HPfMP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fikbHzwm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pc/HPfMP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fikbHzwm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48FD021EA4;
	Wed, 17 Sep 2025 06:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758090787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4w5W/MMPZGwGI+oPjICg3mbkOqJguOS5uIj+YXij0E=;
	b=Pc/HPfMPF5szbrub54RWJyOdmSsA2Zli6PStEdwXXXi6ztVVMfqw6GyDhfnN8suG26heIz
	XUaveSsCe5jxMJCUmTi7EnzU2jbO+Dx+gYqhS2YZteUDWUDvQXIM96AJt3jbbGRo87/bmI
	0cXvLA/eKl1mYRjWmmLiJUVtaeppfdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758090787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4w5W/MMPZGwGI+oPjICg3mbkOqJguOS5uIj+YXij0E=;
	b=fikbHzwmfZH6c/8/6q6iKwHjajHaOrHBWI/hDFu6xp4P1rAVy5dDXeW4DK+69iU9aNd6Hu
	QfuNaiE+gsjl8PCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758090787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4w5W/MMPZGwGI+oPjICg3mbkOqJguOS5uIj+YXij0E=;
	b=Pc/HPfMPF5szbrub54RWJyOdmSsA2Zli6PStEdwXXXi6ztVVMfqw6GyDhfnN8suG26heIz
	XUaveSsCe5jxMJCUmTi7EnzU2jbO+Dx+gYqhS2YZteUDWUDvQXIM96AJt3jbbGRo87/bmI
	0cXvLA/eKl1mYRjWmmLiJUVtaeppfdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758090787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4w5W/MMPZGwGI+oPjICg3mbkOqJguOS5uIj+YXij0E=;
	b=fikbHzwmfZH6c/8/6q6iKwHjajHaOrHBWI/hDFu6xp4P1rAVy5dDXeW4DK+69iU9aNd6Hu
	QfuNaiE+gsjl8PCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B84913A63;
	Wed, 17 Sep 2025 06:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OBlSDCJWymiIXwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 17 Sep 2025 06:33:06 +0000
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
Subject: [PATCH 3/4] mfd: bcm2835-pm: Add support for BCM2712
Date: Wed, 17 Sep 2025 09:32:32 +0300
Message-ID: <20250917063233.1270-4-svarbanov@suse.de>
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
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

The BCM2712 SoC has PM block but lacks the "asb" and "rpivid_asb"
register spaces, and doesn't need clock(s).  Add a compatible
string for bcm2712 to allow probe of bcm2835-wdt and
bcm2835-power drivers.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
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


