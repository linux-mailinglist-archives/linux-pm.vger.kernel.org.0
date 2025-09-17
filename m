Return-Path: <linux-pm+bounces-34823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F5B7DA05
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01D51BC866D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 06:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57D27281E;
	Wed, 17 Sep 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q4f+VHKa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ggQ3Lvy6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q4f+VHKa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ggQ3Lvy6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5413B280
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090787; cv=none; b=khZ/Cl8g80QaOsiyUX7fh8T/6VgKH9SB7LzcFNp4uTpJLkjNz9DyphlAa8jFbIVVCpzdu178HPYj2HgZrpMof1v4veDj+X0bangbO2osn2tLhokXpSx8ZVmHfrf8b7PbKr9BVg9YeK6KgWhFV2GY7zbVFi7V6tjAnt7/jFAGW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090787; c=relaxed/simple;
	bh=OwpnXyksNzAmNR2kSU9Q8CqRr0SDmzEMylOpOr0GHlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pixzG6HfAmDfEOxquecX206xt7wLb+AxKJ7DxOzaDh0NBKnvwc1IhTiQcwV7K6dGt6tzAkw0392PMGl4LOEJuZPmq/OhzbC4Yw89W98SDmMkH2C1bg5LEHgnbnAcW3VDB/hC/kylk4zK/++DEeqbpDZixoJ7MLTrfXY+bE+wdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q4f+VHKa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ggQ3Lvy6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q4f+VHKa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ggQ3Lvy6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1313E1F749;
	Wed, 17 Sep 2025 06:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758090784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JVNIaZ4JH7HykQzRQnvri/UwzfQxsqoKdmmeam2Dikk=;
	b=Q4f+VHKaoompE8sCs3n+zxgI/XEYtOpZlA4YT5StLBEi/63o4YlFNffoScvxbmNceIitYL
	15pvWvcbNqyIeO4Ovw/30IH1ZFfzxzw6Bb2AUJI8gC9ILVOk3lgUtQ6uNPCfthwY+KhcX6
	EepHWBbWWrF1NP187h+7qKKhJItXmoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758090784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JVNIaZ4JH7HykQzRQnvri/UwzfQxsqoKdmmeam2Dikk=;
	b=ggQ3Lvy6Qu+iw4PQbRNNhDgJZI8lZZPaDBRoZjjB65xTDzhMe+4vkFyUxaUOdhvtkX7kKx
	RkkSzdmNuGOmxFCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q4f+VHKa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ggQ3Lvy6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758090784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JVNIaZ4JH7HykQzRQnvri/UwzfQxsqoKdmmeam2Dikk=;
	b=Q4f+VHKaoompE8sCs3n+zxgI/XEYtOpZlA4YT5StLBEi/63o4YlFNffoScvxbmNceIitYL
	15pvWvcbNqyIeO4Ovw/30IH1ZFfzxzw6Bb2AUJI8gC9ILVOk3lgUtQ6uNPCfthwY+KhcX6
	EepHWBbWWrF1NP187h+7qKKhJItXmoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758090784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JVNIaZ4JH7HykQzRQnvri/UwzfQxsqoKdmmeam2Dikk=;
	b=ggQ3Lvy6Qu+iw4PQbRNNhDgJZI8lZZPaDBRoZjjB65xTDzhMe+4vkFyUxaUOdhvtkX7kKx
	RkkSzdmNuGOmxFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EA701368D;
	Wed, 17 Sep 2025 06:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KuFCAR9WymiIXwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 17 Sep 2025 06:33:03 +0000
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
Subject: [PATCH 0/4] Add watchdog support for bcm2712
Date: Wed, 17 Sep 2025 09:32:29 +0300
Message-ID: <20250917063233.1270-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TAGGED_RCPT(0.00)[dt];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 1313E1F749
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51

Hello,

The following patch-set aims to:

 * allow probe of bcm2835-wdt watchdog driver for bcm2712.
 * prepare bcm2835-power driver for enabling of v3d for bcm2712.

 - patch 1/4 is preparing bcm2835-power driver to be able to
control GRAFX_V3D pm-domain. This is a prerequisite for the follow-up
patch-set which will add a v3d DT node for bcm2712 (RPi5).

 - patches 2/4 and 3/4 are adding bcm2712-pm compatible in MFD driver
and update the dt-bindings accordingly.

 - patch 4/4 is adding a watchdog DT node for bcm2712.

Comments are welcome!

regards,
~Stan

Stanimir Varbanov (4):
  pmdomain: bcm: bcm2835-power: Prepare to support BCM2712
  dt-bindings: soc: bcm: Add bcm2712 compatible
  mfd: bcm2835-pm: Add support for BCM2712
  arm64: dts: broadcom: bcm2712: Add watchdog DT node

 .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 28 +++++++++++++++----
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  9 ++++++
 drivers/mfd/bcm2835-pm.c                      |  1 +
 drivers/pmdomain/bcm/bcm2835-power.c          | 17 ++++++++---
 4 files changed, 46 insertions(+), 9 deletions(-)

-- 
2.47.0


