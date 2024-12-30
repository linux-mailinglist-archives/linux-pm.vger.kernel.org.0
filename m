Return-Path: <linux-pm+bounces-19848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397CB9FE5C7
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 13:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323ED1882192
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957EE1A7AD0;
	Mon, 30 Dec 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ClHpQJzY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD419F424;
	Mon, 30 Dec 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735560757; cv=none; b=iSeb+gXnjfZIenZDIKoUyYPbv/6lYEsNMA9MfeVviP1/2Q7t4P1Zs5zZVAgN7W1bzcXdmXNi/w7Z4Hp3eGsxvc+2FpHTXn+W9BU38sbLexbc+Ak7Yjzvrg2m19+AH2p8NiRg4VhUpl8/T5dNJ8Z4Nrdu4dQNUUMI6hPGbi6F9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735560757; c=relaxed/simple;
	bh=BKFKBu5QDXNrKpzTkwmwseccE+Ll/7eBIz6NdZKrgCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LctYN/Y4fiKMdR+vKx76DhoIlXCD2ssrvxOjmPd4OIUjqOmE2WfeRnL+t5aHsFTJhzP+bRx5anJ/MkWOL7X9amKxnhUJLjA48q+b2uIA3YIhqYhrDTexKxU6lPLOYm7D+6t+lqIUL856Gn20FS/10dKt+kl8PC2rPlotUYLmo/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ClHpQJzY; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735560744; x=1736165544; i=markus.elfring@web.de;
	bh=vrhfBZO4d8LJrmbj06Hvndc6qxqFtL+h4PzU8edkkqM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ClHpQJzYkGepa/eD4+13QBstu4fHD3oNMtkE+b5mEc7CrZJEMCzrWeXOVmBeRMcv
	 P855zHbyIz4qO5cbJTHVJQylQTXk1SfDZ9I63mdDqjcQmgmVB3c91obr8sT8CCmkv
	 BSv/abWYDlEjGRlfqoPhg93pD+ngLzudgg7OuLAAhol7aFXZ06LNpJu9xnoe2111G
	 +ZonV8G8ktsO1ElFfVU++0HA+qpJIJhDLlnLUEbAZm0QJDV+y+JVqmXumwoNlz6SN
	 VbqglUbGBjrZ1uY6xjnTiu9/KA7ulxLDwiDTONvD6RNNxQM86cjWYti3DwbVH5ajq
	 lBBZEBUcsVrCrnOL9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.2]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOm0x-1t9Kjw44Yp-00NWXx; Mon, 30
 Dec 2024 13:12:24 +0100
Message-ID: <4468a196-ad5c-420e-aad3-becbd64279d2@web.de>
Date: Mon, 30 Dec 2024 13:12:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] cpufreq: apple-soc: Prevent null pointer dereference in
 apple_soc_cpufreq_get_rate()
To: Charles Han <hanchunchao@inspur.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>,
 Marc Zyngier <maz@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, Viresh Kumar <viresh.kumar@linaro.org>
References: <20241230091053.247719-1-hanchunchao@inspur.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241230091053.247719-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VfaTF5vQqPaErO66NQBR7gahShcY2SttGneHvGpX6GLNJj9KqIj
 T/VJYJ0rIMq25R31maw7Ce6PGFBwTbwkVMcGS2OI5dtlKavrUhYujctCV4kNJkab5pODW2D
 UDaxnr4XCjWox/u4O05vql73Z4iMrRaC/BmHvci5rAZJEiyQiHWArVhy33a1Ttor9X6YQ1T
 svDY+6iZvmrQBS7Z9fSDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nvOYYyCpOlc=;B12RUNw+2h3U7p0F0avz17+lx7O
 8BV2jIjum8DVUi5FFUxsV6AClI1tLcMin+4eEEWmhuwGSR8UWNm85NLDt6Wn5LLir9DROKF4s
 okPH15NyP4DIRgVlPCGzuV5KLenQgU0/up4aEq9O4PfOB8x8nVR4niTsmPDLI59IecGjC9kiH
 N8kqwJp27f4Xees3ggfHAUc6O2aEwZNLpHzNfxZWldKpPSZbYKR0hP99KyqE3GT0J/+RrmyZZ
 JZUyXUyIxjvUiq9ygfgHlYaxW5mVd79v1vCnQlo2+r/G8xTIsvuujMiwMYcIQoY54SO1IVKT6
 qfgTIJ+/UvZBNBTN67JfLn3gZkLYFF9yOuJdIaD/YiHBDBJi9oUyq2q6/381L0q8mDmA1UlOf
 0RbhdoP/qkYR78XvHsKu0qDl7QcqlrBw7x1TFVAwEe/M2ucKc3aotQKuNvEtRm1srRtBo0SD6
 Dwj9oJ9QEL5EX7VKnaXXIoGHEcW5MTsqQ20i2TsOKJHo40e1uxHr7vrTVGBZJvYU7lHjmZ4Zv
 FRLGeMDeuWeV5on+X+vWnCpNm4lWKsIxDr8EhZY+lNQ3PCQF/cjn+1OfRxkIWbAJZXsyj5yXq
 /y55lzbRktVlV6Yh9pdJTwsAyVlf4v2YCi9EgMoF5SfAfxVA5EO0lEK95HCB0uVfXc1182HZw
 4tQU/Re3KHSB1Y2v4LxvRp+iWVyh1P54G26oRtlFEWUT+2YdVkohpPgPQv+xtQzsd8xuwatL1
 lQbD4f8ZPjGBp6Yja6yfGNtTRFLUzQh8Ga7PaWEbUEIGe0mRA7Y9k4lL16XIx3dA80uPrXPsb
 aTrNVSD/PzrCf4jFE09YtN/vQMzM6StGC+zKkwwyjYn2ZmbUK3vesPYfwx5vlegQkgotuRIFJ
 OZ0sUlUYheSUx4rZVGAwnuhXwcg/A4kDoFG0rGZoRvNl1JofyrWDr5hMCp84//ugYa+pTmj4K
 kzYfFT/2WfbYmnb1VflP7V5w1zZy5EiiE86xkm2qLmgtkKYpXx5U5k+xveelc85dauMHCtK8F
 JC7hGTMdEX0hLWSWORMquG+GXtPkjzZqo+J4+GKObDOyVOWWOx2iw7/Li/UydDhzIaInoYoBJ
 50tDOuBCM=

> cpufreq_cpu_get_raw() may return NULL if the cpu is not in
> policy->cpus cpu mask and it will cause null pointer dereference.
> Prevent null pointer dereference in apple_soc_cpufreq_get_rate().
=E2=80=A6
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
It can be helpful to provide a corresponding patch version description.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc5#n310

Regards,
Markus

