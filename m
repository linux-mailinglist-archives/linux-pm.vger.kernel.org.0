Return-Path: <linux-pm+bounces-37540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9213C3CBCF
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 18:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EAA4203E9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D673370F3;
	Thu,  6 Nov 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AS2ertLK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70333A01E;
	Thu,  6 Nov 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448641; cv=none; b=BTzFPvhv8b8Zaj/C/q8T1Bc1w4vQKuhnC0q1IauCgHfxdxvvwQBRz/WHyFxUAo4hb5GpUaFsYMzVMF+H3lUN70pToaDBT5jpiU8+ugX1ENnim36J550ngfZVv80wc1PB0MJ0dRIh2HCbuPf+KRFse4PsA8EWV8QiusMXFsCITpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448641; c=relaxed/simple;
	bh=PIV/6Y/pFoGKh3xLIPvWgVbT/oGAbekrJwRYLk2dvqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8Jj5asjxL1oyb/wBW/lL2jIYPZbZsrvKf6f3jmr+f5neoh+FeGET7It5qjjHGNhYTX809d5+/AE1f5alGbhcBsA1hW4AiEzdxpv2S+2VU9PviQRpUrDLUL6T+pJUOWXk5LjlQGRc/f1yPupMQJ1WgSqwpMq7uHFRfdjOMp9Exk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AS2ertLK; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762448599; x=1763053399; i=markus.elfring@web.de;
	bh=QXheh9hmsblQUeoqvF83LlGgbxYzBa1d7bj3+ZyWLqk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AS2ertLKZANiUHAQ8YQzZSss5XZWLgPoKBPyUk1wOtpN6R7vo4MbbQKQr7LGy+Tk
	 KbQ0kKK0VDRwvqChSV/hCTu/t//GtttqI5B4JgmGC4q4ny9ZceGcu6V+PJ3YjU/FZ
	 K/l11heLMU3YvDZr6TvsrEb1pMvwpx6XGMrxttrphlFdG8yQHuC8PU+wrK0RYAvK5
	 lDEaKKpz+LFZZxvlmm7v7Aq+ZuRkg2LKFZZlMizOIjjLYrMjayI0l7u8fSJROWeZu
	 nVbppvWzxkbGmhQuKtjGBo3xRdo7l59roYqc2Wy7ATlTIIlKNgtcWqHCpX10MUhBT
	 URJN/piZbBr/y4aELA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.214]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qvH-1wBCJG2zC9-00vpux; Thu, 06
 Nov 2025 18:03:19 +0100
Message-ID: <77906375-2d34-4861-9e17-1e61dfaaa59f@web.de>
Date: Thu, 6 Nov 2025 18:03:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] checkpatch: add uninitialized pointer with __free attribute
 check
To: Ally Heev <allyheev@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org, Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
 Andy Whitcroft <apw@canonical.com>, Jonathan Corbet <corbet@lwn.net>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 David Hunter <david.hunter.linux@gmail.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Nishanth Menon <nm@ti.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>
References: <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
 <221c2b9b-4809-48d8-af7d-f290d1c2a7fa@web.de>
 <67e28fadf4c20433c964d13d96dafe3514457656.camel@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <67e28fadf4c20433c964d13d96dafe3514457656.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kawVeR+8qwqZq1iisMV9I5yr8L8zOCxulYZUc3scMBcg8GOialJ
 YIGGIrUhOHosA0ujmF7p7JGi4nT3tSIKKPLNnQDl+kLEJMjVHqxwrf1s2NBaLsPM7TKHcyU
 uPSpM/5PUKnc/wsxBhuEFb0dTT/hgd9kRkDm9rb8oqkWT4SWZKjS0nrrfUNHFUxoH5OJolC
 Pet5JJj6LDeAOEmv1B0oQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eLqBvTDkaNs=;QI7FKJJhhshpBOCCPHwR2jv90ut
 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

>> * Do corresponding source code analysis requirements indicate a need
>>   to perform data processing with other programming interfaces than reg=
ular expressions?
>=20
> not sure about other source code analysis tools, but checkpatch
> predominantly uses regexes

Would you become interested to discuss additional software design approach=
es?


>> * How do you think about to mention the possibility once more that scop=
es
>>   can be reduced for affected local variables?
>>   https://elixir.bootlin.com/linux/v6.18-rc4/source/include/linux/clean=
up.h#L142-L146
>>  ...
>=20
> The docstring talks about interdependency issues caused by assigning to
> `NULL` which are very rare

It seems that you interpret a linked information source in a special direc=
tion.
Several developers are stumbling on challenges also according to software =
evolution.

Regards,
Markus

