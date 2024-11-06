Return-Path: <linux-pm+bounces-17086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2599BF51E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6472828E0
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2181207A3F;
	Wed,  6 Nov 2024 18:20:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22267537FF;
	Wed,  6 Nov 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917210; cv=none; b=YPnpmVt4Cz6hGJlR1rskjJQLZdkFRA4xdaGus+IQOWysU4JbKhPuakpmVtWVkaEvuZjmCoARZU9Kz3DvPbBtPuv1o7/2c1oJBI66yq8LbGoqTRrVq816WJyFcdaSHrgoLWQrCbJQgIjr+NtN5XXQu1fsTcWRlTxhxbco6u0+fw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917210; c=relaxed/simple;
	bh=XNfmruMTITRXL4vGR4glrXD+8hOGE1OJq2i/lAjqqAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOhSkiS5qOO+CnFnNWbij4BpIq6d+61XsKwB3X8rCiDfuhczAkN4IDaaA2X6n2mOR8KBNx/hLDNLO3OIBR1Lq9P1EvOWIv1RrNgSVriJl+KF+Lxr32LsLoh6R2O5CmvdmhqRS4TLQ5Dy1OwpbYWyPht5P68P6IqbNfHBlSSpACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id C88071F9D4;
	Wed,  6 Nov 2024 21:20:04 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 21:20:03 +0300 (MSK)
Received: from MBP-Anastasia.DL (unknown [10.198.46.47])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XkD5G39mpzkWsC;
	Wed,  6 Nov 2024 21:20:02 +0300 (MSK)
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
Subject: [PATCH 6.6 0/1] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Wed,  6 Nov 2024 21:19:57 +0300
Message-ID: <20241106182000.40167-1-abelova@astralinux.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 188998 [Nov 06 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/11/06 15:41:00 #26827080
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

NULL-dereference is possible in amd_pstate_adjust_perf in 6.6 stable
release.

The problem has been fixed by the following upstream patch that was adapted
to 6.6. The patch couldn't be applied clearly but the changes made are 
minor.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

