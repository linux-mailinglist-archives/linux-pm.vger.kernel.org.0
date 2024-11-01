Return-Path: <linux-pm+bounces-16867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6079B8FBA
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 11:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA4281BFD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00D168488;
	Fri,  1 Nov 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="SaEilcJq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035521581EE;
	Fri,  1 Nov 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458221; cv=none; b=oxnexwNedvz3Q4De3ZTm4BFIoHwNubQvWtPhAQ4wOP0vUEAqFUQvbaFp7TfLjXQNZ3uv6rD7avvM9+HOWFkIhGHYQdJH4gA+UAgQN1IYVXY9n8D+sviJFG1BBgObNPkSgDCcJN8Ydu1Ixdvfr5wmNC5Uq6p0LlmM5Z6vWMiWfVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458221; c=relaxed/simple;
	bh=tb1NFtTUUMzBr4q2oDIIgwZdtRaMsN/cepBeUyxcqZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=McuPyYU73cFHgEtmEtscd13p+eyCPX2Pj3MxZduLdZmhkMFqcZb+Cd4f2rD5a5Rf7VE54UGzhi7jpwNEQvjdKqLdRYdb/cBBf3AphTn9Cugok7tg0EGA5tFXABLf/HEfEOK9t3+VlXMAasQK1Qj7KehIHkKxwX9GYRNwD8nl/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=SaEilcJq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730458202; x=1731063002; i=wahrenst@gmx.net;
	bh=tb1NFtTUUMzBr4q2oDIIgwZdtRaMsN/cepBeUyxcqZk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SaEilcJqjF0+CtXAts46k8fhBqj+XwDYIvw9QpEizKQoQF1hmRg/yy2KEbDWIz6Y
	 BnbSVQJA1ReepIAuhSt38vZHNEqJxdofiib+A4LgACKC1sS2d2DKiPwko7ipKNVoK
	 mISj4VnXvFlY5EFe+nAeD05WAwhi3U+ZKCV05KwhtBTplH/9TSEPm2D7CiiH8y7I6
	 UjbFrb08EnK6inSxevyIJ1jw+OPJpt3Iy4XJt1lrql2Du8WyDqsLj32WDE5+reeXh
	 o6ViVQBhAcj1fkcrkZEKcT/BWBZnBBUr6GFSyPnwmHRhjj/bZ9RQtVUbWFfk0OUE3
	 vO6ioblUg1SfHrUv4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt75H-1u02PQ49FZ-00wbyP; Fri, 01
 Nov 2024 11:50:02 +0100
Message-ID: <0090434a-fd04-4646-9582-c0fbf7f95c1b@gmx.net>
Date: Fri, 1 Nov 2024 11:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: imx93-blk-ctrl: correct remove path
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241101101252.1448466-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241101101252.1448466-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:B0IdbMyKXiP0waAdc74rjxA1KINzm/0lAnNVBC01UPbuGUTA07Z
 sukd1BmV0H7pCVjDxcY44HxCQtr96mQD6B/6nadDdcGaySwn9qS7soPMvvHSCaePW3oAmAw
 duzAWnTpROABBeXRbLlh9T28gaLxDBxnSFL8ZoB1ErRm59iF7agDeRG7ePU70xbHECtCZVr
 IUsVAHzznb1xem2FU9thw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zaa83qrhJAE=;PEYLyo5M/5aDJDaBQW7vDzmjBrd
 abUS08kWQm/cRbaSUtHFBTeE8/6265nrjwRlgz5iRgQLUtz09RKdgpH1iC861rNBp7X6EFX+E
 vUPVXEq5i+ePt3AR+DPjEytaam++jk/cdlBnWeXSFuZp/QngqMaJ4/Iy23iErRW6sgQyxcXqj
 vzY9Xq0Yz3gsXZgjsFdg9zI0fw6OdDG0NRcxHcB7mJ5N8XQtxrz7/YbesR6ZYym/HngePP+ZW
 I1jF793zdrIQr6Wgr0id6erghxemxQtKed76/0ecp6+9DKDI/7lIO+++T9zOv4cormOcS2sU+
 xToiO4njP8whDekGLt2AFzpojCafuXf3Qg98Vw2+oraGW8jnyWJLa9lpwuV+Z7rAG2uMQdJDm
 C3L6KvBEeNnid4kQ3QvXARNgcC2WM2+0jlDZHZzDpsEGDQz5JA+/5qxhEMwo1JFIgIuRY5abQ
 hNg2QmSSdOF6/TuFg2UBT72TGuJiQerlVP8TPUZdR53P+DKMFoj/KcRrJ9EFyTxBROZEF0X7m
 UfApHipvCnXv/nZS77Di3uh/q1+u9e5HsnDcXImd6FUEHplrq5VmTflUp4rQevkj5HxHJ1M6k
 WdaiPpOJL6OwwH82fsNMsKfN5SXqCx78DopyPrpUOw69ngmNyPn3jXzRwBaGr4yk6bwz/kjBm
 XsDWT4mL+RlRNQ1X1QbSTosy4DA1YUyASqaRxOpljDbdSv0EkVZKqNhsKB6LnR/hmlt3ahY5J
 KJ0MGLdmXNMX/6/eX93BJBmdZRgSLUzRYxJ6SLKx7p2hOqtfWW4G3Tj7QMOsm4G210K/RRU91
 6BWiwdClEOXMaaPBAIfibaFg==

Am 01.11.24 um 11:12 schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>
> The check condition should be 'i < bc->onecell_data.num_domains', not
> 'bc->onecell_data.num_domains' which will make the look never finish
> and cause kernel panic.
>
> Also disable runtime to address
> "imx93-blk-ctrl 4ac10000.system-controller: Unbalanced pm_runtime_enable!"
>
> Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>


