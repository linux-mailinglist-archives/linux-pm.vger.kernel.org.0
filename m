Return-Path: <linux-pm+bounces-37228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD22C26945
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 19:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 737E4348B19
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81E2EC0B0;
	Fri, 31 Oct 2025 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iwX7Axxi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i6Z+0iKm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iwX7Axxi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i6Z+0iKm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA12E9EAE
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935605; cv=none; b=S/0P35ehA+oVfXt6wDvhVYqt8BZMAHXUSRMGJCbjYdYq7LfQGFuFMgKN83YnqveEKf5bogoDsA5DdPGp7eRhCdCSNfL3k8YMILAQJvu5pQ3CbTAGTzIbr1QzuOg0bxtb6tl6JiAESOWpWdYNRb0p8yCtJuThy8muluDRhlsY20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935605; c=relaxed/simple;
	bh=jMDf2JsWg8aLp6iR1YoSo6thKSfJ8cpoz1OuofRcu+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPgSnqV2Ax7gM9dIyldqoCXfNNrkZ5uz8z2IDDdJlJw+flyVHBnB+2gg1oHAyZLGuS5Dm5+Lcr0vv24eNofYQW9EUHsGCL/hKVOMHQ4XBKoLvqxobcHphhF6kGBDyGTqTR4q2psIZT/a37JFUj2YTurx+PYnNd5rQzkogWSNOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iwX7Axxi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i6Z+0iKm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iwX7Axxi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i6Z+0iKm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29C181F387;
	Fri, 31 Oct 2025 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761935596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0L12JIWMWS76Dv2VBM1uGPm/iNOwe9xrhrPlZ8auzRE=;
	b=iwX7AxxiJQ9UHY1MBoDN9k+KuB4lcg+/KujXgwqC3TVJX/B4c7cW5uKN0ezd6uSS3WjLtO
	qKEKqV0h6kZJSuUQHdn5OyBrz7EH2P7cHPgGifwfc6yFhGo6R7YSG0WS9B3jOq6GKZGu45
	60+3KXCO0QQWk9VXdocobi2YU1kLGmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761935596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0L12JIWMWS76Dv2VBM1uGPm/iNOwe9xrhrPlZ8auzRE=;
	b=i6Z+0iKm9UDfACGYMv3KZ0msq1E3+IJEyk8kVKpwnZAd58MiL+/O1PpoYK6mBQ98mnAOIA
	WpnjaMCbuD/hSECw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iwX7Axxi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i6Z+0iKm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761935596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0L12JIWMWS76Dv2VBM1uGPm/iNOwe9xrhrPlZ8auzRE=;
	b=iwX7AxxiJQ9UHY1MBoDN9k+KuB4lcg+/KujXgwqC3TVJX/B4c7cW5uKN0ezd6uSS3WjLtO
	qKEKqV0h6kZJSuUQHdn5OyBrz7EH2P7cHPgGifwfc6yFhGo6R7YSG0WS9B3jOq6GKZGu45
	60+3KXCO0QQWk9VXdocobi2YU1kLGmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761935596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0L12JIWMWS76Dv2VBM1uGPm/iNOwe9xrhrPlZ8auzRE=;
	b=i6Z+0iKm9UDfACGYMv3KZ0msq1E3+IJEyk8kVKpwnZAd58MiL+/O1PpoYK6mBQ98mnAOIA
	WpnjaMCbuD/hSECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F92113991;
	Fri, 31 Oct 2025 18:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gflIIesABWmTegAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 31 Oct 2025 18:33:15 +0000
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
Subject: [PATCH v3 0/4] Add watchdog support for bcm2712
Date: Fri, 31 Oct 2025 20:33:05 +0200
Message-ID: <20251031183309.1163384-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29C181F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 

Hello,

Changes since v2:
 * 2/4 - Use maxItems instead of wrong minItems in else clause (Conor).

Comments are welcome!

regards,
~Stan

Stanimir Varbanov (4):
  pmdomain: bcm: bcm2835-power: Prepare to support BCM2712
  dt-bindings: soc: bcm: Add bcm2712 compatible
  mfd: bcm2835-pm: Add support for BCM2712
  arm64: dts: broadcom: bcm2712: Add watchdog DT node

 .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 38 ++++++++++++++++---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  9 +++++
 drivers/mfd/bcm2835-pm.c                      |  1 +
 drivers/pmdomain/bcm/bcm2835-power.c          | 17 +++++++--
 4 files changed, 55 insertions(+), 10 deletions(-)

-- 
2.47.0


