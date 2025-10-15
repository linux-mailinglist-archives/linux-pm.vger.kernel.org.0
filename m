Return-Path: <linux-pm+bounces-36160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E481DBDD446
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701713A5977
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 08:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2772F533E;
	Wed, 15 Oct 2025 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sNse4HvJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvzOw+Zz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sNse4HvJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvzOw+Zz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574431579B
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515201; cv=none; b=vCiZuTceVXvAE6R12OSPWGz0/N/eDYWEfYL+rnIN8e1ixf0WoJ8mjdXw338sJdG05+PdGbqiAAfTfudXunBF2WlHBNaTJf/6BR0m/ISf7BTLarPyFgQtS6ODW4WGpVtSHo7daWzroUa647f/NAJoBfE6mqPV9sGEqRK7st2rPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515201; c=relaxed/simple;
	bh=ySWBIPTKNqdzBxcuPAFf4SAyKo7DjMdWV4luwQPD5FY=;
	h=From:Date:Subject:To:Cc:Message-Id; b=Mxi/4vrk2oZQa0m9Uv5Lps8BGowkcKuFbyuod6GJNHN4pI1jvxGG9szAZsX10aTyhIoxY0H6aPqkTKfIh6v20Sz5UtsVasza80HjhYgNwcO9dsxTG5jE6S7DW6MMa2+bpNksC5inQUJ4eumPFEivd2J++FHkZVjqDcy8F9Rd9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sNse4HvJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvzOw+Zz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sNse4HvJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvzOw+Zz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.200.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF01F38D00;
	Wed, 15 Oct 2025 07:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760515197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
	bh=KaGaeGgggGLEPX8mQgiYIqbuaBCc76yCkZJPmhA8qRE=;
	b=sNse4HvJ0k1Vd/XtzAwPt3pQEHgfssLgpnSfX3QuX2ho0O1tbU0zdBYD2JP8A+IoLxdXKk
	thheFxky+yCaEkhFBfCkaOm0D+xeJUwsuVpEdZD7JN0TmIZCPfBPJfAXzgP2hLgIrZ+wvr
	5uRs0qXYeoNcve+W04BqnJIA/hVX8ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760515197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
	bh=KaGaeGgggGLEPX8mQgiYIqbuaBCc76yCkZJPmhA8qRE=;
	b=xvzOw+Zz1sRCIxivhzGtX37Z9IFFqYT7D1n5d9Ao5dYU/ng4cUM4Wcu3/Xvy3AEW9nUyHY
	sIPmi1VAoz6gE2BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760515197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
	bh=KaGaeGgggGLEPX8mQgiYIqbuaBCc76yCkZJPmhA8qRE=;
	b=sNse4HvJ0k1Vd/XtzAwPt3pQEHgfssLgpnSfX3QuX2ho0O1tbU0zdBYD2JP8A+IoLxdXKk
	thheFxky+yCaEkhFBfCkaOm0D+xeJUwsuVpEdZD7JN0TmIZCPfBPJfAXzgP2hLgIrZ+wvr
	5uRs0qXYeoNcve+W04BqnJIA/hVX8ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760515197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
	bh=KaGaeGgggGLEPX8mQgiYIqbuaBCc76yCkZJPmhA8qRE=;
	b=xvzOw+Zz1sRCIxivhzGtX37Z9IFFqYT7D1n5d9Ao5dYU/ng4cUM4Wcu3/Xvy3AEW9nUyHY
	sIPmi1VAoz6gE2BQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 8F40620057; Wed, 15 Oct 2025 09:59:57 +0200 (CEST)
From: Michal Kubecek <mkubecek@suse.cz>
Date: Wed, 15 Oct 2025 09:56:31 +0200
Subject: [PATCH] power: supply: use ktime_divns() to avoid 64-bit division
To: Sebastian Reichel <sre@kernel.org>,
    linux-pm@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
    Linus Walleij <linus.walleij@linaro.org>,
    linux-kernel@vger.kernel.org
Message-Id: <20251015075957.8F40620057@lion.mk-sys.cz>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	R_BAD_CTE_7BIT(3.50)[7bit];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[lion.mk-sys.cz:mid,lion.mk-sys.cz:helo,suse.cz:email];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -0.80
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The build of intel_dc_ti_battery module on i386 (32-bit) fails with

ERROR: modpost: "__udivdi3" [drivers/power/supply/intel_dc_ti_battery.ko]

This is caused by 64-bit division of ktime values by NSEC_PER_USEC. Use
ktime_divns() helper which handles the division correctly on 32-bit
architectures.

Fixes: 8c5795fe5527 ("power: supply: Add new Intel Dollar Cove TI battery driver")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 drivers/power/supply/intel_dc_ti_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/intel_dc_ti_battery.c b/drivers/power/supply/intel_dc_ti_battery.c
index 56b0c92e9d28..c26209ef9577 100644
--- a/drivers/power/supply/intel_dc_ti_battery.c
+++ b/drivers/power/supply/intel_dc_ti_battery.c
@@ -141,7 +141,7 @@ static int dc_ti_battery_get_voltage_and_current_now(struct power_supply *psy, i
 	if (ret)
 		goto out_err;
 
-	cnt_start_usec = ktime_get_ns() / NSEC_PER_USEC;
+	cnt_start_usec = ktime_divns(ktime_get_ns(), NSEC_PER_USEC);
 
 	/* Read Vbat, convert IIO mV to power-supply ųV */
 	ret = iio_read_channel_processed_scale(chip->vbat_channel, volt, 1000);
@@ -149,7 +149,7 @@ static int dc_ti_battery_get_voltage_and_current_now(struct power_supply *psy, i
 		goto out_err;
 
 	/* Sleep at least 3 sample-times + slack to get 3+ CC samples */
-	now_usec = ktime_get_ns() / NSEC_PER_USEC;
+	now_usec = ktime_divns(ktime_get_ns(), NSEC_PER_USEC);
 	sleep_usec = 3 * SMPL_INTVL_US + SLEEP_SLACK_US - (now_usec - cnt_start_usec);
 	if (sleep_usec > 0 && sleep_usec < 1000000)
 		usleep_range(sleep_usec, sleep_usec + SLEEP_SLACK_US);
-- 
2.51.0


