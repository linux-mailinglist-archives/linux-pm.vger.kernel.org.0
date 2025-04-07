Return-Path: <linux-pm+bounces-24872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE08A7D9A0
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 11:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6961168B68
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F6224259;
	Mon,  7 Apr 2025 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ALjTthH5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED519F40A;
	Mon,  7 Apr 2025 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017891; cv=none; b=l5to9ASVcqwQLALoPsuySMD/dgUbnvAe2GZOZzN2lAyKs1a+XB1oQnl0yW5F4npcVknPlLhhZ7eKVKAnNiB1syP5JUGgrr4VhO3ZRYGQoKDIC3g1EdvlvuvsPg+R3D8lgAjTMYNi58ynMugTXezCTHbAoyadkXFXhLF7eAz/z5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017891; c=relaxed/simple;
	bh=Y7Wep/Ex4FCqkpNl8itbZHa4HzPYS0ZPyqV7jJZj6mE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZHH0z1ScamMgfoCOvIOkjDpB83lqW0wr5m2Ln1Ym+lDE/QG9fgopJNOkff0SpE0F6TT+Y2LkpCn4RDqcBH7xWcThn0MQ+Wqfkr8M3lwzI6WTI+lRPI3hOlAGawXeUfxV0iJrc5IvB6vWV6+RQ80J3AkIWbsQ+QjmSnVT2hQO4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ALjTthH5; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744017886; x=1744622686; i=markus.elfring@web.de;
	bh=Y7Wep/Ex4FCqkpNl8itbZHa4HzPYS0ZPyqV7jJZj6mE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ALjTthH5wW0M30q6hXCIj7OJtGa+JU2F6TkjCN/dm7W0ozIiQNLSq8CE6dFBSU7s
	 L+SLuE0uByBzoQEgd0kJJpVjln7qSMZRl6lbzoEeSQ54iOA9ql5kHIHGTqSpyBhws
	 LiCHlcNoieFdxtAhlmIv+CsnL0sOo8bTtay6LMl8U+PbMQSXDnY4huTk0MerGQUL0
	 EFBbG3fjnbHT07FYjBJyNFvqXiXCQeTwDi8PRbtRgOkgOa3TJc3Dwhz9IJy1BAll/
	 azBhmksdGzkaaQTafyW52nIq8QS1Zhnugb8sHeFTtibgwWy77qb26ujlIwUHb79xw
	 mx6YSa+Y3EaXmQrhiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnG2Q-1tKiwE1oKC-00am9q; Mon, 07
 Apr 2025 11:24:46 +0200
Message-ID: <46d19d22-bd7e-4bfb-8cd0-205d6cd55509@web.de>
Date: Mon, 7 Apr 2025 11:24:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-pm@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla
 <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
References: <20250405055447.73925-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH] cpufreq: scmi: Fix null-ptr-deref in
 scmi_cpufreq_get_rate()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250405055447.73925-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zrwSZtb72r6Ymls6zRupndXyWr82t7wtXvEnv4NziLlT2xnmKdS
 zc2vwYBwvu3Fw9FUbEUysVQGROZq3g8tYELwiRhJpHansNTw7QoX68obh7R1GCnF89Km5K2
 RsnNTCo+nOui+SC9S5F4XMw7o6WJW4uL0MqqSN0W0XqpKX1UXMFFC8wceJfRYOZm3SsuVrx
 oYGJtZy/8gSCfqE1Kr0Vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:80qe5cnW1V8=;NckIWCSnzH9bSPLAp2QcPrOsMmY
 ipRzMR30Nx1/FOduRWLVuVLas06AEhR21RyMRp6TTM6LBmepA5cepKpyGn6n4aRYilimRAl6J
 Q9qENjJknwyfeTa19pgtE8B0kljVPY3lI6/KvGgPYhtHhuA7cOSDix6/s09IZvDhArLXPpNyH
 MQWoQBk6N9ZC0flAbLoL/2FvY6CPxjEOsIXaQ499/YUUhYT+iJQ8gI8956bE7LZ6XPo4Q9Oa8
 ZkhfD/rfQwPwhosiC6tE8TV/Z6+abm28pC75LUlI+QJe1vJY/a16t3s0iIpckLCkibOuVo2zd
 FJ2ORgwqj52EmopP1E4d2hHq+kWJQ5x5uWeLGr50n8IVxUdyIdbC4qQNnfdjHUTMfJkV9KLsE
 LRjDXI7Z6j7Y05viLVzW6edeIhmgjkjBqdyiJu2Ryyo7kXceA6ckb4JZzhq/dYU0dUmGLY+ho
 ZLQSXMcUZz+5VNE2tu01G8DQKOgh/lZqLwLuwi31X/QIaJ8ct5X7IJx9cW15UNyIqB/g7KOf8
 ywjtVJPgoeClsUjFa0iMFzbMgEFGOmIfy6p9/4Jw3QkQrGhsyN57Pvf1tYLhxGDXuJmodJsVw
 OfUUmMt/OaE81eiXwzkj2fA5Gr/crVonBtGjXTaqS6jmAWQOZMrVfL3xL1alN6QR/aR+u3Alg
 ri35pZPn6YOjaVm700nzB+wac/aJAI6xu4lPPjkagqqgx3PwPPFwYOogacOJz7S13cCSXJwkY
 bXUZ8iuBQfSNKDoJIhl55E1G05LUpAWQ8Qaj/DqalQDJIemQvwNHfu9JgxKiSb23ibCzrTEec
 uYCi9jYO4OY5ZYCtYxx2LgjVbaQGMhLCbEy4xxSdc8qBaD2c4/w9x993v6RkO4Z9VoaYS9qYE
 6HcISyHh1DdnNS8qqKYzfcSrm9fzPind3wpzVUnPDmNiOWl/hX5s7I+gWE/aTdzhG9aXK2y/v
 2tIaXj8h0RkJNME36RVMH9AFjjmDwiH9aEx1bFm+cwn312o/TKNeBheP4EZypef69VJC0E1gY
 wjbWG1MJNwF/glqsQcJG+jmXzVMcqBVLRLZ15ZEMj48OEgWFFbsspCrADwHyIKYMxEEp2dSae
 4Hst70TqNGIweaahd0bGMHa6NyXqOJ/RHYiEVetPWG5gX8BB4SFLVXoHROJ0+elVoGCDhzfMv
 z0VGR5N3j8NA9HJ7XTZ3L30JYGCMHGKiW+G6P9Ln7V4tfRapuvErg9/c9y8BWacOYBkug2drK
 N0FX1pKRqHCWruezIMLqMZsj1i1gXjSaLoIIywy/QPvu8n6DlFPycLGyua8BhmaGz31RVk5vK
 ml4nmSgY0zwSHXdo2X10x8sQ8o+2alUFHJGQmwcPOl7OuI9/E+qO/E2X7eA6Wc7di/WR1FZox
 T/6mhkVfB3euZYBdeH7KNtACPOi52tROhXYPvLEpoCaT5nGgDzewxxOpO1rIbzKGQVSOqgM5D
 GvyR6uyl9emyVu17tXU0gKRhCJ3URlBV/QAp1u4Bp5ZYjJ3ym

=E2=80=A6
> Add NULL check after cpufreq_cpu_get_raw() to prevent this issue.

Can any other summary phrase variant become more desirable accordingly?

Regards,
Markus

