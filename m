Return-Path: <linux-pm+bounces-29418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF6FAE5A48
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 04:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFEA47A3F4F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 02:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3E41991DD;
	Tue, 24 Jun 2025 02:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="Kih/o9v+"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD618DB0D;
	Tue, 24 Jun 2025 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750733637; cv=none; b=Fi8F89JKPQFfjw37pdgI+SCc8sX0KlXh5Y63Agzz8JkXhNu/rutk4CeypA75uI8OJNCF0+VKMumIv0Q+EtSDaIGrLhMgsXVJi59+2ZjoRJgIcW+Jl3pt7F8UdAvheLmAdX3qVuC2Y3Hcu9+aq4qeaHZsATT+N59mhtwUvi4JfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750733637; c=relaxed/simple;
	bh=XtSK3TOHXlH7ADDyxdXV6GzxVcMU/rODkPLFQ0KdjcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSNc41LnCyZ2qIBT8racoSUvZxMdo1KQy+z/w7F5/hF46/xuAnEZI44Qg6RPvn2VBKmFYOncvajhKGbNQWccAOh59b7DX2vcaGVPfNldHVDW7HYp6RgPxiUCOlVLG42n+831doK4VyYnPibfFZn2ff3ufzsxfOlSzzumz6qPSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=Kih/o9v+; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id BF6A2213FD;
	Tue, 24 Jun 2025 02:44:08 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 2DFB1262C0;
	Tue, 24 Jun 2025 02:44:00 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 77C863E859;
	Tue, 24 Jun 2025 02:43:52 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 8AB7C40078;
	Tue, 24 Jun 2025 02:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1750733031; bh=XtSK3TOHXlH7ADDyxdXV6GzxVcMU/rODkPLFQ0KdjcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kih/o9v+9NKplD7w/sDmAGNEykum9Q8z1TM3z0aLoPsVwJmZGr6mWAMjd34eRJFKJ
	 xWwQ7/3XWvm4yqREeiDTAMocCsp9cS9Aiq03odvYJA4dKHRkmjV4bJq/EPmxy3UUvP
	 fOaT7ZmNeVplhVF8uVxx7kfTtO1DLKIu7oqzINqM=
Received: from [19.191.1.9] (unknown [223.76.243.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 969414082E;
	Tue, 24 Jun 2025 02:43:47 +0000 (UTC)
Message-ID: <f032284d-25e4-4192-aeb2-1270e497a830@aosc.io>
Date: Tue, 24 Jun 2025 10:43:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: loongson3: Support older SMC firmware
To: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Kexy Biscuit
 <kexybiscuit@aosc.io>, loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250623123321.5622-1-ziyao@disroot.org>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20250623123321.5622-1-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 8AB7C40078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,ziyao.disroot.org:server fail];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[]

Greetings,

<snip>
  > This patch adds support for the SMC firmware found on these devices,
> which I denoted as "SMC-0" in the driver. Boost support is omitted,
> since determination of cores able to boost requires the driver to couple
> tightly with micro-architecture details.
> 
> For coexistence, I prefixed all SMC-call constants with their SMC
> versions, and introduced "SMC-0"-specific initialization and
> frequency-level-setup rountines.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>   drivers/cpufreq/loongson3_cpufreq.c | 287 ++++++++++++++++++++--------
>   1 file changed, 211 insertions(+), 76 deletions(-)

Tested good on an IPASON NL38-N11 (Loongson 3A6000) laptop, core 
frequencies fluctuate between 250MHz and 2000MHz individually as 
expected. CPU frequency scaling governors works as expected (performance 
pins all cores to 2000MHz, the max frequency).

Tested-by: Mingcong Bai <jeffbai@aosc.io>

Best Regards,
Mingcong Bai

