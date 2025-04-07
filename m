Return-Path: <linux-pm+bounces-24871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF62A7D960
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 11:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B9A7A1393
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDE2212B23;
	Mon,  7 Apr 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PDj4qvNT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6447E110;
	Mon,  7 Apr 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017446; cv=none; b=tdO7Rn8eDR7zKEY1O97/YB6I2zZIGJYyhXS1/eYaXFQcua7ISHaCaHlcyMthf3rSOSE5cDAul9etLd740ftO/IYEFREpH8oB3KlVDtrJ/n+YViojX3psVIYZlzSHHAJDsYQC09f2PsY5cI75FqpvF7X6D6HbAoDNqHhe7SySJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017446; c=relaxed/simple;
	bh=fXVnyYZ2BcK24UjtsZeOKwEmhM+VYm+slcB3WCTfcKE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LngTqOlMVwcwYBcoqho3C596GprIiIil3g8voEbQEpcb1CFn+YljOkNEJTrohUUoDbqzDmPdDXSk0zA8VVsfn1zGL3tSY64oqZz0WbbpTBRr3SabRREAkieC7f0NpIsxhJxHBSL3AsM3qSgneV2oESo/LEfVfRI3VNWoW2Uv/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PDj4qvNT; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744017441; x=1744622241; i=markus.elfring@web.de;
	bh=fXVnyYZ2BcK24UjtsZeOKwEmhM+VYm+slcB3WCTfcKE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PDj4qvNT6VBaWmkX2q3DXbDivd9GQUo7Pc5DwaEBDczDxElE92X+WBeWdqsMnICu
	 Tfhim6ldfMEQGBQZ2+OspldJ7UHOfxDQ9RhA59gKtKe51RFJBx0E8qTk5/YUikJ/p
	 KjoY/40WpdWY/emBVraNAKae3S4SQEI9wOZnHpmT0zNijTeUxIOEGKFSt4njoTY4v
	 5VgCiq3/akCixGsWXt1Z/hA0kLZDumpNp7ByZjyV1R4L/897wHvZsVy/A2uprIhCU
	 fImnzhMGM9IJIP156lSGahMbbR3hlRjF4MMKCxLT7EdzspB52gFTpCc21zO2Tdvq+
	 hKmz8yiIt6IGB5CJ6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gbY-1sx7kh1FBK-00wGw4; Mon, 07
 Apr 2025 11:17:21 +0200
Message-ID: <e23e7566-fc04-46bf-9d77-317d8a23c146@web.de>
Date: Mon, 7 Apr 2025 11:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, asahi@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, Viresh Kumar <viresh.kumar@linaro.org>
References: <20250405061927.75485-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH] cpufreq: apple-soc: Fix null-ptr-deref in
 apple_soc_cpufreq_get_rate()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250405061927.75485-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HFpgaG3Y83cljGQvayNhWLmLMgaKy9NE39RP228CGSUU5E/0Y8Y
 UaizXSpqLlB5h1T/i+EFDKsXgbY4ZE4+h23eapPXDfKvPDfeZ3XVky/ZX6hOekzgqjsZQfJ
 J69RPVYhUutyCeZihLPYFRTVgigYhO7qPb4FItMfnqtNGGCZus7K+muKDHOMEawBH32dq6X
 rZwBlPgZf6a7DNbXOt3Gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:20z4uXMhqt4=;G/EikhJIvhLDD2AYSrqiRmLM2rw
 UoZcyiuBUqWx80NRPAb8n6MixxN2z1yq0o65iCbD2YQNCidUvdL17rKiJ+6ws10yg+6ziejQf
 WErYmmUM716lNyXFAu/n5CbCHbVUefVU+owSP7K06OG2UFMEVLod4LfVUXLef8GHofT4y+Zxl
 KrZhpKG9e/6XST3Fvq4tUgYVNmgJHHh9zOtD9pdDLnh7rTD2iTKYAo1rEOwQS+CJpCnOG3kLG
 a3ZDpq0iewKuVe2ouqVJtPU6jCdeA6KM/I6u7qgKwwzG0xUAEufLR4isLPrnA6TIea6N6MdVi
 cYpZGBEKpVGmPUHSjPUtO9rJa1Ci6g7aqjJ9ZQrkF96hUh73DgQhv2EGtlGg/AbCJyCv5SAtT
 Cgfro8zQWKAChb9AWiRJFingr+7MMFcZDYcuHuAtsyx34QnR8ze8FdacsPifvmwupCh61Cq5H
 IPQdjwAvustdEeQmA6EPZt/SFTMO8dauzbOpmJ3wDXlO5A82nfSSJyge/QxwfY+JuJdb/6ErU
 /RWEQheCmsyQ2UAWLruyinzv0mpA8vy7BoCGZGQm1bdpsBX0FsQmK09aj1iWDtxdSwRIOaTzQ
 Doq+AyekjowH+YKedkE2sV2znTqSg3oQYMJ6k+zh1d4B8e3CP4JUg76v9P1jLeSaLxBcTiLIj
 h7/UUO3qgRwir/FqhMloK7Bry3zBMrGXaonlasTZ3+imSeZq1kKKEcAqM/OxTZj61+fvrpdyW
 +aj37j9Qd4EZGTfl5W0t5P0DJi/6bTppYqKerqdAw9hWPTmJrEPjQjUo2T/dj5W8Mlpzc8CJs
 /fF95LpCfipn9CuDBwWtvCbomY/Za0mWu97g6PSiUFDAj8BcuuIYTKXErtMhkVLAleWz4YqJO
 AjEhrmfXIyini9IoBS62eE//R0vpuwEocOTxaKtP+AB5TslQb16hcAi8scLtFHV0vCeKT2NQ6
 kVrQ/RjQpSo6DXdq35EOs0KlxMHLI5klokQaE0hrb4gp+kCn7WsjsBvEl0zeRiRGh1fN3A8NR
 Oo3s8qYjR2d5h8kuulZLUk/vyRUNCjaDljz+40658gA2L7wM6nfzYHYTSZG9hoyCE2TAa4duW
 FHlyuvyn+mwPy8oGduKH4DQLGTLNe+PzFGzs+4GcOqm2l5NV5zhqk9Kwg/WCZHIY9QGr0Zk2L
 gVE6LBlh4iFngHCDnq4wnngYGmKCiAViGbtN0PsGI39KIC2MAuDPKFY2LrUF02XXqdGGyCjFb
 aoxEoshX5XwFeXVFdVlF+N3VEReWDpvjMO7a7VGuESQRcfqSpq3r9s/ic4z97oErjUrhTCApa
 KYIawPlYJIqhv0jamWaqBXQBo3HfUj1vh9yIRvmm85Vqwa+RX4VI3Kmd0FvevBZAfMrxHSGfN
 CN1MQX9VF/EWuQvVXDrRL5uVTDzE/cvmHBQ+DgmGwkpy9PH2HvJIt+5FxWlK0Dn9yIQb2HNO2
 w0/Z2OCMXCV1uTIPCYnVekGN88c0HWbthL9EerqI2nmd4Vpej993VT46zreVMLQt0wAM2nA==

> cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
> in the policy->cpus mask. apple_soc_cpufreq_get_rate() does not check
> for this case, which results in a NULL pointer dereference.

See also once more:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.15-rc1#n94


Can any other summary phrase variant become more desirable accordingly?

Regards,
Markus

