Return-Path: <linux-pm+bounces-9791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA0D912E30
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 22:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21704B262CF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 20:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D76316B750;
	Fri, 21 Jun 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="o/bQAOwa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E212BE9E;
	Fri, 21 Jun 2024 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000018; cv=none; b=iu4JFuVHjALJeEiYpmQugTYMQyVr9ri4LGvyUK3U8OTW4ZSQAPMRSgnWsy547YWaEiT30AMAItOh6I6CV0PNlXbNX88we1MrNAH9lDNJ5mYcMcGmi15POhg14CXHH2iwfPpHQgUvRaNbVku/i5sDqiUAJpRkll7hy4Y2FmBYxLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000018; c=relaxed/simple;
	bh=FI/0tEmc4OrzQICRAJDQmwB80W2DKE27iYV+3AqZ6ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vB5Q+yAVQFMw+ecHzM138ZsZss/117LK/qVpc4WVvIvkVlNaYqpLoUkUo+CWdfWDwwGXxOJ/WPm4tRB9ZnrI+Z/62s/4Qqhk+XaiJuS1HngZKLyNY+HZ9FG1iqJoYspJI3EQLqe/U4lSyK8YVTA49u64dKmbF+DBr5nJtnl4IXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=o/bQAOwa; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1718999993; x=1719604793;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=w39pSbtwaT7fcka6jbgmU/6r3OCDP6+qZhZfAsB82t0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o/bQAOwaeV7wjwdmJYfFmOUz4Vn6WjJOvdpHUSKaMBhJNkt4tmszbrLG+AD8yH9A
	 rFt14FAPymoaqYnEf4FHCuZco4TP3itvRz/tqlJCkWshElkM/aFH/oMx1t6Cj+pnw
	 DLaY9LDmfJ1XkBATxijkAwwcIKMgD9vgoJSAs0mL03StCbprEoqaglto98WeWfgW3
	 noiA4GLHuBtz47iZNF89WeyQB3KZJfWjA85fLvIBbMs9KWfk39mSG57ckfVllP8Hg
	 208+/+liY9qEGlc/ybe8hvU2EzRvWOkm89n4A+UJ0DZSSiIVkuQk7E9FaPw6TWrHj
	 L2zddy3QB3QW0pSjiQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.78] ([62.226.32.41]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQuLB-1rxq7K07c7-00YZXv; Fri, 21 Jun 2024 21:59:53 +0200
Message-ID: <ebb02ff6-e0d3-45d0-b78e-7785d763e01b@oldschoolsolutions.biz>
Date: Fri, 21 Jun 2024 21:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cpufreq/thermal regression in 6.10
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Steev Klimaszewski <steev@kali.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com>
 <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
 <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com>
 <6759ce9f-281d-4fcd-bb4c-b784a1cc5f6e@oldschoolsolutions.biz>
 <CAJZ5v0gueSnaci601OkVq9_Ui09k8EsByRL08tFkzDoDGJpp6g@mail.gmail.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <CAJZ5v0gueSnaci601OkVq9_Ui09k8EsByRL08tFkzDoDGJpp6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:seB3cm46O0wXLMy/GWgAZ4NghxwXbMYBfOyobMg2dbPB3R1I/Z5
 7fI3/4HcSp3d1eldVUqhv6NpswMrsDh7ns8QmTTuwU8C0QUoAI/2roUFr6hGpdBPY+gG6XM
 A5pHDvXyGUqk8oTB41MYjiNOBHLwUkIa6/caikA0LdyfDKYFeY/7mcrZJF909Zev0ID35eD
 01j4C3R5ShiRkqNh/qcgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ADKfqHl0ZVc=;QS4uLQ0fszDmH+IRyIqyycSIX5D
 AehWkLL6/hM5zKmPxXvUPbWGBQhtwtFEUbiIJeNVmnvfUQACO3k4Byf7ybcejkVr9Hkla5853
 NVwu0NjIlnc0oeXF+UipNeP/drU73oM+fNPmMGC9SOa54kR7BAR3qKcHj9AtHEslk1gNnMU6+
 olvtJWBxuVCEGujWbXnGFLo83xfUxmuFFXPU3mAtP7PEMqUZrcSNB3vZ3P1+qGtzaQVlNykxs
 wnU63rDsWe3U0AHNtK0m6mo5l4JQHzKG33Z2h2gxIY2PFPvfr7E4KC28zbemo4FBmaKehgH18
 Qib9JsRQ04owdGC5a0wDoKeW/ay9xK9eBHChXvSFskemxdk9DyBQlDA2si3iawPruB6OqhFyV
 ljlh2yYTCZ0HnwAnBAh/XGt4J/tr8CIUUj8QGju8i14Vt9g3E4ojjwTghhW9f+q0pN+SMzzFR
 Dn3djFoRYOuuQxFWTUHrQgo8pGJGrT6WsgAOGI1U8PJwjSaBb2HFnoYzGD5nvi0+IN601wsHo
 f2VSLBB0hu2leGNbw+2ijgUA9U/tSS/gLSVfIfGHETaqEXcE/nXAjRx8lfLKsVCKcwe/7D8Su
 0ipUzu/m/qxnCAkLzE+AMG1dyVQWPRbWnw0gcSX8PdNm+y6jGlFKxri1qExrGoEX142/HdSIL
 562oauKvcNrLIiMSzC1rYYMqAMsLQiSy/22mEhPopTUuyKtazzzIo2+u3F3+3Cd7d0pEWJny2
 3jztBf2dKbBPJNVMd9XIlW+TB7scmQ7M2jnUmerjdgSohsuJrv8H/g=

Hi there,

thank you for the fast fix. Applied, built, installed. Test is
successful, performance core scaling up to 2995200 comes back when skin
temp drops below 55=C2=B0C.

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Cheers

Jens

On 6/21/24 18:41, Rafael J. Wysocki wrote:
> Hi,
>
> On Fri, Jun 21, 2024 at 5:53=E2=80=AFPM Jens Glathe
> <jens.glathe@oldschoolsolutions.biz> wrote:
>> Hi there,
>>
>> unfortunately I experienced the issue with the fix applied. I had to
>> revert this and  the original commit to get back to normal behaviour. M=
y
>> system (also Lenovo Thinkpad X13s) uses the schedutil governor, the
>> behaviour is as described from Steev and Johan. The full throttling
>> happened during a package build and left the performance cores at 94080=
0.
> So can you please test the attached patch, on top of the fix?

