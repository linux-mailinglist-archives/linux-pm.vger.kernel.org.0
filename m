Return-Path: <linux-pm+bounces-17084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37889BF4B4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 18:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEF11F2495D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 17:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7522076DF;
	Wed,  6 Nov 2024 17:58:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564120408D;
	Wed,  6 Nov 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915931; cv=none; b=TfF5RMB+uwZ4Ei3qQQsxYOxsanOo8z6SxsBq5uA26T5Xtk3k+11E9bxhMBPcZDjTfRbXgGpUIRWf+N1m2jV7mZQXV7miy16UL4FTnjE8QwTQttWbesdbI1r6giVXiBgWxfZwxYHTMfpw1jxzOn9SFMl8pVNeXiwV7aUY1drKF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915931; c=relaxed/simple;
	bh=vpSZueTCVDNlO0388ur1IGgrtb/PEfMr8Nvwewr1XY0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eZDHUwInHvP/G5NUtgREj420WjrwRQSGvVRi3naP+hNyjHAiYw8g9RehHAzUT+KIbUeHEZHpWLbbRITEUGDM6P16GT5W8t3hAdBCW/n1bg5tG0utMy3aZzCnAnBX3BWQPwDVwjqOLWp7L5kVrPeyf/JUqukNRNMakR4E2LqokzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id B83E92501E;
	Wed,  6 Nov 2024 20:58:44 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 20:58:44 +0300 (MSK)
Received: from smtpclient.apple (unknown [10.198.46.47])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XkCbz62VKzkWsC;
	Wed,  6 Nov 2024 20:58:02 +0300 (MSK)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 6.1 1/1] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <20241106132437.38024-2-abelova@astralinux.ru>
Date: Wed, 6 Nov 2024 20:57:27 +0300
Cc: lvc-project@linuxtesting.org,
 Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Perry Yuan <perry.yuan@amd.com>
Content-Transfer-Encoding: 7bit
Message-Id: <CB41EF06-3DEF-4682-84AE-7E74D6FB448F@astralinux.ru>
References: <20241106132437.38024-1-abelova@astralinux.ru>
 <20241106132437.38024-2-abelova@astralinux.ru>
To: stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
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

Hi!

I found out this commit should be backported to 6.6 first.
Should I resend this letter after it is done or I may ping it later?

Anastasia Belova

