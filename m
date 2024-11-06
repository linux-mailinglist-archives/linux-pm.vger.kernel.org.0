Return-Path: <linux-pm+bounces-17072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131DC9BEF10
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 14:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FD21C2402F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BC1E0493;
	Wed,  6 Nov 2024 13:30:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F51D356F;
	Wed,  6 Nov 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899839; cv=none; b=uyDCYm9adPM7dY82ljbCavowZSdHoxhqQ2HYAwqhVZQxIxdS4qmdIwuHhzFQtOZBAQ/gvY7XGzCDBV/ggkoQCqtP7oW1hpvojuN58G4ecqT873LIGWtWbJylF7Ge13wLOwf/wR0208XSsF0MS/4lwurlh0A7oD8vzXh85peSfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899839; c=relaxed/simple;
	bh=2EaEJLFlmJcjWsYlAVFTf3ZThy1dAY37f7G0UVb64dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JwhRSsqZnGvsf2OHWnK2gIarn5LFZvA3h+p39e4PqUVgChiwAUWX+BM3077Wf7vX3pv00bcDt+UgKG7xiZjQTwUn81qhjtdGrN/vBHgR9i3CTO1w3dx5+bbys8+64aRLcZMdzWxnD9LcvGhBHMZYMuIHXVRG1LQ9oUNHEwgCKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 6597424F9F;
	Wed,  6 Nov 2024 16:24:47 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru [10.177.185.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 16:24:46 +0300 (MSK)
Received: from MBP-Anastasia.DL (unknown [10.198.46.47])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Xk5XS5yTbz1c03C;
	Wed,  6 Nov 2024 16:24:40 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	lvc-project@linuxtesting.org,
	Huang Rui <ray.huang@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1 0/1] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Wed,  6 Nov 2024 16:24:33 +0300
Message-ID: <20241106132437.38024-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 188994 [Nov 06 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/11/06 08:16:00 #26825679
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

NULL-dereference is possible in amd_pstate_adjust_perf in 6.1 stable
release.

The problem has been fixed by the following upstream patch that was adapted
to 6.1. The patch couldn't be applied clearly but the changes made are 
minor.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

