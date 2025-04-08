Return-Path: <linux-pm+bounces-24965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160A6A815C3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 21:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8301B86539
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 19:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312E1DE894;
	Tue,  8 Apr 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="poz33RYU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2C17C91;
	Tue,  8 Apr 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744140232; cv=none; b=gayLfNzEuOkL/Cl/s7uynY2mHCAUCgkhbCs1XVv6WriOMEr+rLDDwhmNDQwL4PN1GthevJBKpkDYw8fkB8pxmtsJoyOfwBxjGQ+wLnuHni4da+GTzL0sv0ISAvyegQULUyvHSro7ztVAMBO43Pe2vvDtPexfjPh01sgt8nqQbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744140232; c=relaxed/simple;
	bh=njXDunu8UU/gaBoTYCsC/ZawgbQ2Yst9LDw4Ej6ukIc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GlTTM4ItEoXktfXEFqY6+TBoCb8PVrmmzA0jqfdXl56lBcOYgde8QmwIlpKeCwql00LsFSRs0JsGsrsMqicYPkx2YgVDqEBC2b3PSMkMrOuOdBIo0s6WWHtZV43UQ1t0/fMQhZcoUq0h/Rj/jM5AixVJztVi5UzsFYnQIf8FHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=poz33RYU; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744140216; x=1744745016; i=markus.elfring@web.de;
	bh=ORupiyOALZSaNO8QGxFuqMgWPsdK6vWbY5xqB7+FD4g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=poz33RYUkIlroB64JgZAmjwnKgWt6wwNTRNFJm/r46hUuPziJrW/pAIB+xY9fxw5
	 EGrGjdwbC8PGcBpGKkTmQf864VfCa5bWzJPC4tSGz24u7dzHvH7d5r412AcLgM43Q
	 MuM2aSUY/wozg0wFojwvcCOk7QvnV9b7KbaGpgqfbi727b8FxC9gypZof24FqL0gA
	 EwAp2vDqUwaSGmF+Fb1uR+1iYWqIf3yG6T2LSluJ3YGyJ0QOcOTwjn2xuzk+SMTiU
	 g5/RaniUPh+SXeN0//TWDi69ksMxlv+v+1/HlXucjKf+l6qoFmiv1Os9bo/qhWv32
	 0XhOKPGbHulo+JuWLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.41]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1tfaow2U3q-00KORa; Tue, 08
 Apr 2025 21:23:36 +0200
Message-ID: <0558b7f7-8c69-4664-afc6-bae4fdc6f071@web.de>
Date: Tue, 8 Apr 2025 21:23:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, arm-scmi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla
 <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2 0/2] cpufreq: scmi/scpi: Fix NULL pointer dereference
 in get_rate()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u6uFVW+ak15/uxBv+EyE+kavakv+ju2yYmazNaogRVKiCXjwIcx
 EcVxW4Pj6WLQTxQtX2FFlS5b3rD7YK2TjwSuySlbDy+ov3KNlK+SuK4sLTBGj97qjo3pxmV
 /ZSIBQZxHOODq/I5u/6evY1BS4JJ1tcYBhllVw8j9t/Z4Jc20RL9G2K+Pz3CY7eg0YriQMC
 tX9xZnoZY1jQ1tG89hYbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+CIQkeTljWY=;Pnys6I1QlDPG6ZGflL/7mdQAKbH
 v3OY17uA/UeJkYP3ncV2ZDzO84Q8w/J1VuTtc5jKnzoFMFeSFpTtHd4Ll18QOR0Xf0dXDSwNY
 UzCbc5C7/frB9IQ2LIua/tBDMi7ilUjEDuftfoAuul2vPsbPWmhUdfLT4Z96lnBsOdxuvi1qy
 QxEBKVKxp6EZ7tcHX7IQuk7wFUCwOIFTkeKEx9tIjCn+kiHiOqI8Y5mGB0ztJauExjG3HpL/m
 AplLRoF1jADfOKFFAgztzXLgjLMPVbcpi5L+c26No5QLfC+xLD5sk8iR0fP3Oy1jsmzQ+Pt5T
 7TdS8NCajChL6j8l0fow+d1swEwZrVE/I7TxP+spKlM9+GLdOeQZgpR2F7L9RIgDVESO8Pfgn
 TEvJEWreon/3sc5D+5dTT3cSWc9jEVn0/OmKGt1MizxbB4ryt4DlYr/wPkcgM1ItS3ElaNxph
 mhXwjeJdEbHRpKZs3BjrUNPbdbPMeatpvmAvgVZfP+vql97bFB2Kjb3WALotk3yoBQGAlYo0+
 o5b/l/4h4lLrH89TtH4pxx2xGYssu3jyClSAy43kh43/dph/J0N2Xmgo29rUrggEWFhmFwRIQ
 eiZW6HmR7yhzOYPi1f0L6+lrdtJEDwNdcBPu5R7ZBNPQorYb+xgPT3pyVcm5xNcjkWKSF+kFJ
 l26hawZGHLFVNGIAdbYniFrKhvGB4qV4mkRvnQvkSz17wh+7jSZTc3TmwkByPALErfQheLp7P
 RuBxgEhWpKclzR0cTqfaYaO0Nr7yRBpnDpd/G3UQcgfmxKiosExGZkWAoGlBIE2BQK20kzH4H
 m5/TX+7B4ktlJgUYRTqsd69YGiRJ15/9ErR19RFUTHsV1vfZlnA7HqeWHnt7RzjBb/bDwGf0M
 H9W/yEYHSN+LlOAGgluks6XzGa1iKs6d0krfdQkKIQitFmuCLCXID+NbROt20vZfBE2240pxX
 yHHJ69xcPMbarOfH+egFF6t2ZP1LQ+DSSyVWaqjlcQTdV2Hxj4Fw3G5HBGUdE3Kd4vZr9ZOlh
 31weAWMY/XHAyex63z8H4hpCRqNwdo6rkaXxzBd/ImksS7R9XBLwbTPA0lQl+GVOcixDP0srj
 WG1CBDo7dKsJCFATHG+FS+pPm3FH9y0yhdYWhDrM6aiWwAkl0/afpzKn6xckDCK7nzxXSsGR2
 1tXH8eTrnNqM/jxzOlzUry2zXxOBStY3ml+BwVFGlW+IFoI/B98JYx0kSCegc6w9ZHlqAbvPZ
 APbsHyfFki52ilFk6LyHZOx3BxnG9Izj8EqX4CoSKFnYJ2cJ47CJ2HwGbPEO1teVElj3cm4Ia
 nkmh7b7x7Z/aQrrFCViL+YF4td7OYARAVOQH2n5TUBEM1ZY2ARV/I4eErldUI1go7csqboh4J
 X06Go6wmsMrgB5Kk0v6JNtzFUuDI8o7ylETHKozZHEl1FnvkM3N0IE7OGT3EirYWXfGBgzpHm
 7DLsdclVnCUXEpGgDK6iDCbabI6MUkBdRdwLg0Kf6FU8JFu0D9/k0XSPAnPjxqgbKQ6/b7A==

> This series fixes potential NULL pointer dereferences in scmi_cpufreq_ge=
t_rate()
> and scpi_cpufreq_get_rate() when cpufreq_cpu_get_raw() returns NULL.
>
> Henry Martin (2):
>   cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
>   cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()

Can any other summary phrase variants become more desirable accordingly?

Regards,
Markus

