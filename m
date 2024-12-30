Return-Path: <linux-pm+bounces-19833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152199FE332
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 08:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E601881DEE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39319EED7;
	Mon, 30 Dec 2024 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="haWzLIcn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52E8F4A;
	Mon, 30 Dec 2024 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543607; cv=none; b=fZh7iHt40KL/Lqfi5Lkj8DdHOFVrMrM+5DL9aVRZ8RFFXJtZxIaVyDy8mv9A8tWFYTkiO32yGBTXxqMOfiF9ahM+Ih0nWH9YdrTxv0PaagjMafQSQ9BaFNaSoLcNxWS6FnQzBtWdgKSqU3VvlnHeDGanq+8qTDJUYdREEasOJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543607; c=relaxed/simple;
	bh=L/SEBdgyZ1rmxBo3u2OzC6TzuWbBUNHksId3IQWff1s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rQqFNTLZepEbUgjZKbRyyGrqF2VdcJhUSNRbP7vBPzM+Y5v1UmaaPYV47C2s660WVksiFwt/E1TitEfkl5sp+rHWIDkPUIR78NXl0WGc4rRarudm2E7bTq+R9zzyiECsyKC8LyiBS4OmUImMIyCyudK0Myz+bwTHMPOJn1TjZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=haWzLIcn; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735543557; x=1736148357; i=markus.elfring@web.de;
	bh=RLxL5SjnatJ2CxT1Dyhq1eTZZV9BxGEXkjm5mWdsrJA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=haWzLIcnFACCyzx+YFoV6uP9nDKZFXbJyFz7jHeLYjh6iGiQRC2IAK9mRC8fSEzw
	 FtQS/p5eamr8N9QsfM3D3HGXm3GMD8NPue4aQD2ztAzQJpe8TNSzQXNRk8VabRhjt
	 WSeghY+mk1l1ig2Z5+u+gVQyifdl/V4N6U5Gl2UXEyOhtnQ2iuRN4tPMwvaHljPOz
	 8pKXnrr38F2GM6aqBEWbs4GWNmHVMBFBLOJv2sRNweTwjsk/jWmPZJLUeA8vPmkrK
	 lLkz4RSCV7ihQ0V1RmwYEFQoOBg7xgS2OG+JjMeTqlBFkThC0uIb3V8GOqc8aMqm6
	 es3dA0sLkGwbwcBTkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.2]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1tL2Mh24Ta-00EiaN; Mon, 30
 Dec 2024 08:25:57 +0100
Message-ID: <5a984b5c-7994-4671-8397-df7780e40c0c@web.de>
Date: Mon, 30 Dec 2024 08:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Charles Han <hanchunchao@inspur.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>,
 Marc Zyngier <maz@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, asahi@lists.linux.dev
References: <20241230035714.72780-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] cpufreq: apple-soc: Fix possible null-ptr-deref for
 cpufreq_cpu_get_raw()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241230035714.72780-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ipNNiP3gGa6cA3yNI4L6LC3uAhq5wmQy+agdhYD/7/4Sh2Ki1zH
 dA6fS5vKwr3nBWFCkcBNr/FAJ50POG1UOP94+HJoq9P1utw13jxVKs1s3LwG5beIoZFpOkT
 KFMpF3xprqBiQVh1tig2kPV6UBaUSZLe8vK6YoL7zNtjk70oJHRyhkI23ECsWpI906MBTRy
 Mhd3CCLHtvVNr8Ef1/zbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xVd1DOexdgY=;4ngZNABOAt+6sHne9eTLjk0tPoG
 LCvwpOw5qdPQ4CA6Xq870NpAzs85VoiFlw9IO5/0TbHscIaqYAG/Qjz8bDjj5Bbe3Q9ySblti
 ZPwVu5OerWcJmHCkcnH+Xpux/BXbXETo3uIOKAV+amwVK1AGr3B6imIhNc4pqkkwImcutAeWm
 RMDNJ9TndQVqH+ri6HDJ++TKY2IabekCk6VFvUpP7ibTl5D0gt3AXBGcCeZ3uJRTSk+lGhGjf
 RjyMNhF/fXWHlq1BAXBvtCM0XekRxYFO5CpsVhGpWhjDe5VqUHQ7152WZYIF0RIU8JXwbcqIo
 bToja1/VcsxR5M0jSwXkjRpKtMeFYul/85RrgDYDjUuKZcv0hPZ1kq1KyETYl4tguneIISHhL
 wNAdsFDdRdK0UalZ3jVWMEK/SYt/j/B/x/eX9n4bBJFh7XYbsrYEU49YSYxE8Q64HXQR+ePbm
 1gIoL4nzTpeoYj8eOEws10gVs5mtOHP4e5NOyoMRyoi34jelLLgdJvh9TF8TWWLw3GvdgtPr7
 5CWO8J6T70n9RjXTD4qMg5YtzQSt2lA3YsfoZ6v5K0C7DCcwUMt3vPlRHFf2Tl0g68hIXP0js
 nhR0x35aFokPzcVE/vyFvlmNcwUYeLqPdIZjPyjYZVDwpR6HWVUGvWtegltfRjN0uQUo/oo1i
 2g4HAcxmma1aW9Ct1jN0xjAByk2M7vGNKeAUuPjJTelrjeFUCLubAPfo08c57fWnojqUiOOY5
 XqcgyIspnffBcNaISTvg8bWWQLJcjEIZPaIWU18B2c2yfGxvMXr2xP1Z/KBD5zv+9rof6xTo8
 4iULaTfTnDlu48yQsTTuL/UhKU1/E8kZ+QZO9O0wuY2NlF0W+d28pE/XqK+hgKiNi+UbhrWYN
 vJuLJIdTbhgWjGsvMcy684dsy3mPuoMWyR//UTFJosCulUktdm5k3ZQXLCu41AM9trCJOv4xp
 kbp7m2RsMqMW6kY6eGpbmJ7zUp5YqGs3ML0pxxernJAeCxwXLGVWkoS0PQ0b/mEUfdK3x12e7
 IqUmVwdVwnD4Cxva8i9M3nUsnrJ9WLUTYU6iww+T3B/9edrYhYeLiWINfj/CsiS2u0g2BUpzw
 oCHcj5J3Y=

> cpufreq_cpu_get_raw() may return NULL if the cpu is not in

                                               CPU?


> policy->cpus cpu mask and it will cause null pointer dereference.
=E2=80=A6

Would the summary phrase =E2=80=9CPrevent null pointer dereference in appl=
e_soc_cpufreq_get_rate()=E2=80=9D
be a bit nicer here?

Regards,
Markus

