Return-Path: <linux-pm+bounces-20657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2517A16392
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2025 19:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB24B3A5D66
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2025 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854261DFE16;
	Sun, 19 Jan 2025 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="Jq01H3T1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C342A80;
	Sun, 19 Jan 2025 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737311708; cv=none; b=L4aAVCtvJoIOdcSz3D+nkWGyw6ZGtjrPDHnQyfvKv2JM+8ibwaFSAgqku6JqZlzZPeP8pkBvlfrq5vDgg93qNsFnxCbUmSVmX3dG0UBeq4g/y+hZCdS+c3lbhE8gM8qlEK1ClbStPGAw2xGD5HcA8wsODn+mD7/XDSYdNtAQEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737311708; c=relaxed/simple;
	bh=g6prGjsgYXBxT7KCBi5utPdSpQezOubbY0sr4vgdTS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qhfCoiGAfcucW4IoXKfqaepvF7NxpbjARvVs0NbIAzKYyZH6lZsSSV/pCNvYv+WMN74XiSBMykaRY0Ovh8OGK8XgwbTKuhPQ2ttesi4Tlifv4yYb+6f6Jhu7eLNb2OsPFvcXkLMc2Yive1/pU3EexxBqNWoMJPNYx99lzmqEppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=Jq01H3T1; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YbhwP5Kw7z9scJ;
	Sun, 19 Jan 2025 19:35:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1737311701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4V7XghkPcR0oVjcTycJK4e/iLGu3i4fave38Oa1IOEA=;
	b=Jq01H3T1i9TakgR4RHf/FVBZk0960qa693M6NsvAv6GK9k8MblXPQMkB27j/F+tgncsZcJ
	yX6RhpekAyKhyE4qM3b6xgw8fBgCoF2oYUvVulZk9qHKQEr4v/1TKeUJFk1eiSkSpLXi7K
	BdPHE3W3E0ci+N1LP4ADU6WOUKMLacgvXFcfIweOj9oC0MnS+Ind3I4i7gM7Gkjkh5/uOZ
	b1qF9FwuoxPCMVauv8cb8X9BkZKj0Rl5j07Bl4zLg5l33xh8cnC4r2v7FwY5TkL6e55OdN
	CZ5uG9LchWBYO9FhmgDlXXOSQYfpNxRug1dQpqlYVCPHrMNOz6o0SvZ9VHejDQ==
Date: Sun, 19 Jan 2025 13:34:58 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: "rafael@kernel.org" <rafael@kernel.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: [PATCH v3] thermal/debugfs: change kzalloc to kcalloc
Message-ID: <dmv2euctawmijgffigu7qr4yn7jtby4afuy5fgymq6s35c5elu@inovmydfkaez>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 4YbhwP5Kw7z9scJ

We are replacing any instances of kzalloc(size * count, ...) with
kcalloc(count, size, ...) due to risk of overflow [1].

[1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
Link: https://github.com/KSPP/linux/issues/162

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 v3: fix description and email client formatting
 v2: fix typo
 drivers/thermal/thermal_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index c800504c3cfe..29dc1431a252 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -876,7 +876,7 @@ void thermal_debug_tz_add(struct thermal_zone_device *tz)
 
 	tz_dbg->tz = tz;
 
-	tz_dbg->trips_crossed = kzalloc(sizeof(int) * tz->num_trips, GFP_KERNEL);
+	tz_dbg->trips_crossed = kcalloc(tz->num_trips, sizeof(int), GFP_KERNEL);
 	if (!tz_dbg->trips_crossed) {
 		thermal_debugfs_remove_id(thermal_dbg);
 		return;
-- 
2.47.1


