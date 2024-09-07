Return-Path: <linux-pm+bounces-13842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7A97031B
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 18:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30477283CD0
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEA315ECDF;
	Sat,  7 Sep 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WJGWcuXg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7418030;
	Sat,  7 Sep 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725725435; cv=none; b=TU4TJSmZ2viDHr3vhpQ8xAxOfnJR84hWn3Mtl/srjKg7wGVwiFJszBjyP8P56/1Q6kPGgsnap1sHMuAnD/1VQJy9Gr+6pxcx9fliGdRj1CD/dDRI3CgEirh9fbRx8TlZ+TNNWgJL/NDLvdRi+brNVCCh4aSF3XbTiAyHAmxii9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725725435; c=relaxed/simple;
	bh=Ugp61IROkC/lOhDqejlDeSWuUWpF6Fmjqq1c9KRVQcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJn9AGu7LB2huTps6O5ZoLCWv2x6MJqkEa5zPN2mmJucWl7bFrZXiUZyIKKt48uZ81f1clvMPgqgDWKe297660bT+tvNxh5yslc8xWiCqP6/caLIJimxH2Pb2ieDtyBUSZ3xeGYNr7bCpikAjuzXNDFhJ5B3WlQIaRRc1HEqwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WJGWcuXg; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725725425; x=1726330225; i=markus.elfring@web.de;
	bh=Zch/7RsOkPMYqhdi+SXCgxMZs8r9uQoJW157WFzA8qw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WJGWcuXgL7jfWIrx0Xtg37SqcdnktjUkfStBZbDXPTGJq5hRmmu7kpapK/aHBAhG
	 10gV3j2Wq75D8KueuL1MVm1nH4j+WFCk+vRKcBY+xhDmL988nKk1R6ytvZvFNsD2M
	 M5ZAbhJUzsaH1YQwyUUAasrQrBjjpPs8hLjcuwpR1k7X408Di4o6y8xkmj1EDBF8b
	 LffpjcoKG90UPnH7zJvnpilQCAfcXd2zjkNXNHTDT6RIZzDOf0mF8kd2ru1IoI23X
	 2OZuM0QbDZKi8afjSffF2laaPCyegdd6OHsIeFXSZHHc0uGz8Rb40N7P+53ZiOFeD
	 KTlMb3c3fmqyKbZ7Iw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1sUCg90Bfg-00INlf; Sat, 07
 Sep 2024 18:10:25 +0200
Message-ID: <2ab8c121-3fef-4d4d-a7b1-7892fb54b680@web.de>
Date: Sat, 7 Sep 2024 18:10:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: mediatek-hw: Fix resource management and error
 handling in mtk_cpu_resources_init()
To: Riyan Dhiman <riyandhiman14@gmail.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c1e8c2f1-d123-4e72-a774-f15daa156afb@web.de>
 <20240907154254.4704-1-riyandhiman14@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240907154254.4704-1-riyandhiman14@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gVA7yHmIp591hFhBzzBwE027VvnIRQAtdZIdzxOyzPig36tB3b4
 u5hPaKZf1IH37Lr0LJ3mWfxcOnmiTFVOw4Ek5vo61EDrqe86J0BCNbNuUw+wOt0pQPJSNLx
 16LffmDrOVrlXoHGBGlHc426kXH1E1nvQz0Ph6ojSEACarew1amWJar4tZ6TDC0cG8VTfH1
 DCDgSE58XaxKQKeQzZ80Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GJEgDvg7pSk=;SvRF3u5F02Kr2mzGNozsS/en31W
 5Onm1tGnt18eWGTZYtqyyWeaMdPFb68hFyZJ+FHOcm6/AAYSx4LQvGFesDXIBZ9pcm9Qges4Z
 03L0l9HoSKEcTOOJ47yibDfA5r3ja8YF5lcLY7Stkgcex3isCTxf2WeZrKJSaZncQJWalDXiI
 Izw7HpsKl5VDLoKnEaz9JF3imJC/iBogG7X0TAQVh3XDfCsU3G5wSLrA9yL73+ooZAL4kk+l5
 q2L7dM9PZHOOn2hjyUNTOVAgfGMUwyAuPvDnzh8dvZqU25Aj2tT2BF3ZYuOeBE8vjzX4aAASn
 Tac8eVyevBGJhRVKXR9CvA/9QkfrfSGPWbQs/ixIgFj3efHToUvebvSjQoZcLcQRv2UBB4g0m
 zJFgpWVkwRQ2xqykpAP71kEPbXRGSvsa+HmgJsoqB9l2a1l2mGB2X5wHjI/es3KElF+yWUYeP
 BsvoWiQlQJ/kD/7wqBn9yDm+yeO35GPX2EsKTUwHC6wXKA3hchPxhKApa7X9EU13GZQpsn2gi
 0txXi47ko6XdIJDrCLRsBUFYV7O2rCuxdOAGPUl4abbfk1jXZa2XMzKuJ/y0aBAI3ASqzQSae
 X2XXTc6+/yoscRZV89kMSOaz2Kpch6N+T9GMHFLR8OacKl8q7IQx331P23UNlyX2Ggyw3fP4x
 GMEczRJUFbV+/oVOMtgQfTRhd8q1PDCKd6UtXMn/+s35Q6MzB51dP3j2Ym3dDwq8U/zOmy7Ef
 vaxEZC4J2Mj9Fqmh1mLoGz9BzJeyl6EF4/nIAvEPLx5aTYjGRuQ34WJYwg072r2ApD3gHdlV5
 IgVr+RqiTfNq1I9LDin7WvAQ==

>>> Memory region and IO memory were not released if mtk_cpu_create_freq_t=
able() failed.
>>> Added error handling to ensure that IO memory is unmapped and the memo=
ry region is
>>> released properly to prevent resource leaks and ensure all resources a=
re cleaned up on error.
>>
>> * Would you like to improve such a change description another bit
>
> Should I elaborate a little more on the issue and explain the fix I have=
 created?

Please take another look at guidance from linked information sources.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11-rc6#n94


>>  also according to other line length preferences?
>
> Can you please help me a little bit about this?

Yes, of course.


> Is it the character lenght of subject?

Not directly.

The summary phrase can eventually become more succinct.


>> * How do you think about to add any tags (like "Fixes" and "Cc") accord=
ingly?
>
> Should I change "patch" in subject to "Fixes" or =E2=80=A6

Obviously not.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11-rc6#n145

Regards,
Markus

