Return-Path: <linux-pm+bounces-37170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EBCC2470C
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 11:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D8C3BCB5F
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859D033F8BD;
	Fri, 31 Oct 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K1ATfEJY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FCliQ5k9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K1ATfEJY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FCliQ5k9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3D33B96C
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906274; cv=none; b=tymKFa57JY8uRnYcn7hKNua1M1ETATwlrN/1I3KLHXyXqi8zZ7qJfVi8jKue5EH+m9qgPh8PSClqT2ClXO454iKk5GIrkZEaL80mWytfyKA6pWTIpNqDHHORGQL5vQNK+a746fIWhkJA51+wWbfHpbLn1kdUlUwscqYExYI5iQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906274; c=relaxed/simple;
	bh=fJfeP8iJvfjrSjfGVdFX0HSWrueuPbA418jHovxYc8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tm1DbZNAxbbFlBu+ygmUZINFqM7qnVkW27xLvj/gt00P9sPKaDoYSYij+NuBn+nWyVaLFzwjQMlvsm6E3yD1nZujxkXBkJZ2DjmtBlB1HceCldg92MmNDD506OxY50zBGNakqO+Sd1i/r/xDaPQ5zR6ak7wU/qQg4xul2kyzdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K1ATfEJY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FCliQ5k9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K1ATfEJY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FCliQ5k9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C84911F7F6;
	Fri, 31 Oct 2025 10:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761906270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zY0i1hFTvnmr5huB9hek+Pwb38AvUIlNlPpVHaoc8LQ=;
	b=K1ATfEJY2wgCmakj9Mn7eXUwOQTo7p8hriAyF8Pp0zIGTbgC0aUW/5WywNukmy3k2wsR6X
	FM8gSuUkWvt8AzfAIl/jL6BIo5w1r4LiXhHJvs5ltWPF39QoLiBFR8HbF3GoDdKlxum7N3
	+kWyWp2yq3IXwo/uOooyi/ty4eD0xik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761906270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zY0i1hFTvnmr5huB9hek+Pwb38AvUIlNlPpVHaoc8LQ=;
	b=FCliQ5k9446MKozyZLYL8ujtLdKji86DJeUhRsZUPnF07kvy9Wq9c5q4gcF72BNyPdxxOI
	bJyumw4j3awSAnBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761906270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zY0i1hFTvnmr5huB9hek+Pwb38AvUIlNlPpVHaoc8LQ=;
	b=K1ATfEJY2wgCmakj9Mn7eXUwOQTo7p8hriAyF8Pp0zIGTbgC0aUW/5WywNukmy3k2wsR6X
	FM8gSuUkWvt8AzfAIl/jL6BIo5w1r4LiXhHJvs5ltWPF39QoLiBFR8HbF3GoDdKlxum7N3
	+kWyWp2yq3IXwo/uOooyi/ty4eD0xik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761906270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zY0i1hFTvnmr5huB9hek+Pwb38AvUIlNlPpVHaoc8LQ=;
	b=FCliQ5k9446MKozyZLYL8ujtLdKji86DJeUhRsZUPnF07kvy9Wq9c5q4gcF72BNyPdxxOI
	bJyumw4j3awSAnBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1600213991;
	Fri, 31 Oct 2025 10:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UwO7A16OBGlqEgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 31 Oct 2025 10:24:30 +0000
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
Subject: [PATCH v2 0/4] Add watchdog support for bcm2712
Date: Fri, 31 Oct 2025 12:24:19 +0200
Message-ID: <20251031102423.1150093-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
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
X-Spam-Level: 

Hello,

Changes since v1:
 * 2/4 - add else clause and move $ref inside allOf (Conor).
 * 4/4 - span reg space size to 0x604 (Florian).

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


