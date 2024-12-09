Return-Path: <linux-pm+bounces-18800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D69E8FE7
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70F3164E47
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5E215F72;
	Mon,  9 Dec 2024 10:16:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0E18E02D;
	Mon,  9 Dec 2024 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739363; cv=none; b=HqlrHAQftgmz/Sg9z0D/uWrugjs9wtb0Rjy5p6+Z8gVb/A1z68lgwCdxt0DWiqZeah6qq2Vq0ULtM4sOhfCjIesG7vP7ZPhs1jEiKLUtT+QQytlc0ZezwmDhmRkC+Q79O9ww2r63/89IeSszmUrVmTzW6/nhoQaV0cnPsj6yH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739363; c=relaxed/simple;
	bh=Ci/uyiK+X5PVM3nismQleymTg3dIZL8LmEEN0ogKsY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvNVt1PNDXC3HjUXt5GwhkO2TyTwee01l3UIlbJkHKSzV4rR/MZgI1J/rj5mUNW/Oky1OTk/ba/FHfQFu1aG9Jp4GpcQXex496NygA0e3jo/ZeDZENpWKD/6q8Hg1zVvombCOWJ+HvatO/+K6MfDj7pqzISlZMKXCfqne+2n5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 4BA9324CCB;
	Mon,  9 Dec 2024 13:07:52 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru [10.177.185.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon,  9 Dec 2024 13:07:51 +0300 (MSK)
Received: from [10.177.20.58] (unknown [10.177.20.58])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Y6Hc62m21z1c0sJ;
	Mon,  9 Dec 2024 13:07:44 +0300 (MSK)
Message-ID: <a322a1d3-344e-4054-b7d1-2522f2b82511@astralinux.ru>
Date: Mon, 9 Dec 2024 13:07:04 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH 6.1.y] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
To: jianqi.ren.cn@windriver.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, ray.huang@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209041951.3426114-1-jianqi.ren.cn@windriver.com>
Content-Language: ru
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <20241209041951.3426114-1-jianqi.ren.cn@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2024/12/09 08:28:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44 5149b91aab9eaefa5f6630aab0c7a7210c633ab6, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 189711 [Dec 09 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/12/09 07:23:00 #26951691
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2024/12/09 07:18:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Hi!

If I'm not mistaken, backport should be accepted to a newer stable 
version 6.6 first.

Also I’ve already sent it [1]. However, I haven't received an answer yet.

[1] 
https://lore.kernel.org/lkml/20241106182000.40167-2-abelova@astralinux.ru/

Anastasia Belova


