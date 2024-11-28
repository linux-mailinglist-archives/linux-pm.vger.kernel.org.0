Return-Path: <linux-pm+bounces-18205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0889DB5BC
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60179B29C38
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B931917E4;
	Thu, 28 Nov 2024 10:28:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3809A15383C;
	Thu, 28 Nov 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789717; cv=none; b=GpAm572mUh/ZIOuqGpj13T56xn7s0vtOW/LCfhOmFTh8K07upLlLKqExyWHBEarxe/feQzKPmKrRt8teiPj+wC6SvAstQTP3BgQKs9Eh8nCpUCf0GGefxx8BXJriFVg5P72d2nivRVzFr+Y4L1KSdkY56PhJqsddmCPD83t9hCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789717; c=relaxed/simple;
	bh=A1fyuFy9gsngzEu0z1FTuhaQpjoqcTyIz5KAtOws9TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DA/EB9JpkEA3hGGD7m0kQwbDBEkN9do4yGCudV5HF3CPoJwwOBf+B2vOjvdTyfc5dH4fTml1hBswJLSFQTJPqSaK2ewFbj5/5edKjYFO+DfJ3gzi/QTv4DqxLw2vlIfUx8+mBfAMvrLoZ4kuwSx9DINooq7hjxqgtNeYcR6J5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id A52F21F9AF;
	Thu, 28 Nov 2024 13:28:32 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu, 28 Nov 2024 13:28:32 +0300 (MSK)
Received: from [10.198.18.73] (unknown [10.198.18.73])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XzXb15cJcz1gywG;
	Thu, 28 Nov 2024 13:28:29 +0300 (MSK)
Message-ID: <fd6c77ab-667f-4368-8be5-63e040c362ad@astralinux.ru>
Date: Thu, 28 Nov 2024 13:28:21 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0/1] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
Content-Language: ru
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241106182000.40167-1-abelova@astralinux.ru>
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <20241106182000.40167-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 42 0.3.42 bec10d90a7a48fa5da8c590feab6ebd7732fec6b, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 189476 [Nov 28 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/11/28 08:54:00 #26904895
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Just a friendly reminder.

On 11/6/24 9:19 PM, Anastasia Belova wrote:
> NULL-dereference is possible in amd_pstate_adjust_perf in 6.6 stable
> release.
>
> The problem has been fixed by the following upstream patch that was adapted
> to 6.6. The patch couldn't be applied clearly but the changes made are
> minor.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

