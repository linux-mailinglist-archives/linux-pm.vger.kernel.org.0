Return-Path: <linux-pm+bounces-9768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC220912AAB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A441F27195
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FD315F3E8;
	Fri, 21 Jun 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="21o2wWoH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239315F336;
	Fri, 21 Jun 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985205; cv=none; b=NVmONKlAm2IgLzuTwPuk9EqzlvMcAe79H9ee3ZzKukXHTqQXFF8WiBRUpx34NL3dVrr3CZgO5Kk7blK24iQ2ZDM/2/2mfj3YPN5meYiJhQ/949xTNXBsVly0mwujwF0IoXjm6dJLc7cS4M8nMRTL/LZrVTwcwQb1rD5afDDW5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985205; c=relaxed/simple;
	bh=GPgLEchZruVRitbipEYfYC0XmxVee3r1w12ag6nTYsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tar49RZxaFYOj/EM0TgjQfUabQbPkRerS9hHbJ9Bjs3WLclx1wfrNnfGw5lJesJCElSgwwoVVhK/KgwsE2ZftqsFLcn4RAmuc4G70DtvB+bPDnxnYnO+wYe3+ctLjCbNAEzOFgQeQ6Pc/Hndhv98vVLRfDGDrvviLyLzGU7CEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=21o2wWoH; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1718985186; x=1719589986;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=sbGk7wulXzOIMg91aRqsVsZOGf+Ccg0ki+XG8mSiHiM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=21o2wWoHTbCBn71ZbD1PVhN8L1TFZpuHhGK8MAw+UMIwKyfAVqPE1y6OtXnUdGgy
	 Kk2P5pAlY3ZxCl8g5L3v+spScnLlYWsW5B5vArnfuvJr2JCQxCXkdGYkMPolrRGAG
	 mV2LLzkXIIL5yM/9om+RO9ueBxZWG9NYyCdAunLqtOPLcfq9NUFgT8Sc7xXCV5rXB
	 H2Idw6iAI8MMv2ZD5RoNmbqCiuIUqqI4wUb6hw/ltUAJSrRdB4xILcZ9kitPKO5Uz
	 kikZSJ4Igj0m+6FeNQFSGg7IKCIwtqcx1BqmvCgU/UU8gxhybMT3I5VxpwL4BbCCq
	 JO9yd8oo1Zns7HhutQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.76] ([62.226.32.41]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLiTI-1s39dL2GCe-00UbEH; Fri, 21 Jun 2024 17:47:31 +0200
Message-ID: <6759ce9f-281d-4fcd-bb4c-b784a1cc5f6e@oldschoolsolutions.biz>
Date: Fri, 21 Jun 2024 17:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cpufreq/thermal regression in 6.10
To: "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Steev Klimaszewski <steev@kali.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com>
 <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
 <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5QkJm8WvoESZ4VDAwZ3Vd4f0aJM7/R/cNI3G49l1iNKwJnzz92R
 zGI9ZJxOTSbp/huwR50hBTqJHAi1kBaqlfjH4cOuyUfuZDONrB5NSUkJqeBSGoOtNV79ABn
 NLwXRxdLKVRzH9LRU87CGl8BEFheyudCrhVTV7RnOMbwPRV0Z755E67LIAGYwBGefixOmPL
 rZAIKfSqq4MV8DW0W3VMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:puLx8lytgao=;OvbuLcUWqO2GqyGm9ZDod3pwNdv
 rvwC2srqJer9lAERjUa7/ZtCcrn7KWrdEt08msoVjDCk8/YeAxQEXk53mARk7IeVZpQIuArtO
 ni5gx7KJl9DnOemlck4YR4cwwYarAOtUhO7s9vVrqunIB4PGB6AddKIdFHAn4Qs8UEkXNgWoB
 SwiyYyX4Xl3BOD1ZYbombwCTHKumSWJn6xik0H2AGeYQ9gkZtAy8+exHRFKEIbiJW7K46sLhh
 vHlSwQMCCtY6a82kD80jbX6mnyT4771zEohuOyI7IbacT2jD06lKLJ5agZu7P3qPTgWx4Ezjf
 UBjOTSCGhQwjkPn1/SJREzKft4aWcpsjh3S7Fsb6D/6YAfTtszP76x9n+jQnxnqCoTvuiqiiH
 Dh6kJaxruwYVgyiUyi+KWyz6/dRjn0H1WYt6lSJiF3N1X/QiLgSMSLklLOJQ5LBB2gMvyzETN
 EzV8HKFdx7UXTKcGcRfMDT5Q8JYP4jE+N4pWEM7b0XuPdLXCBOXobcbPZcGU0zYMxpOcLOci1
 yBcLA9K3Ho9Fdbsln4801ES+JGvzpJsgH8bdzvdRVL+ypEZDB7/allajYJdHoiDen11AP8aqU
 9W2IZIkSTaBjUxHtsHj/ms/WqlyucXHJV4FeQk90Tjx1oDcCpMxFKfZeqCTVvrRq6rgMY8bfX
 /ZIL8bYWK6OAY87ydtR6/AQdzwQ/uwgVjsx0yT3XcvZzu80MR89cKuHFSfPKLbePeGEQVu/7N
 xt3epvlh8ggcERgH8/kZ/iGN+E2mFskxuKboJpgvb+UvB4ARY3h3XI=

Hi there,

unfortunately I experienced the issue with the fix applied. I had to
revert this and=C2=A0 the original commit to get back to normal behaviour.=
 My
system (also Lenovo Thinkpad X13s) uses the schedutil governor, the
behaviour is as described from Steev and Johan. The full throttling
happened during a package build and left the performance cores at 940800.

Cheers

Jens

On 6/11/24 12:54, Rafael J. Wysocki wrote:
> On Mon, Jun 10, 2024 at 1:17=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
>> Hi,
>>
>> Thanks for the report.
>>
>> On Sun, Jun 9, 2024 at 9:53=E2=80=AFAM Johan Hovold <johan@kernel.org> =
wrote:
>>> Hi,
>>>
>>> Steev reported to me off-list that the CPU frequency of the big cores =
on
>>> the Lenovo ThinkPad X13s sometimes appears to get stuck at a low
>>> frequency with 6.10-rc2.
>>>
>>> I just confirmed that once the cores are fully throttled (using the
>>> stepwise thermal governor) due to the skin temperature reaching the
>>> first trip point, scaling_max_freq gets stuck at the next OPP:
>>>
>>>          cpu4/cpufreq/scaling_max_freq:940800
>>>          cpu5/cpufreq/scaling_max_freq:940800
>>>          cpu6/cpufreq/scaling_max_freq:940800
>>>          cpu7/cpufreq/scaling_max_freq:940800
>>>
>>> when the temperature drops again.
>> So apparently something fails to update its frequency QoS request.
>>
>> Would it be possible to provoke this with thermal debug enabled
>> (CONFIG_THERMAL_DEBUGFS set) and see what's there in
>> /sys/kernel/debug/thermal/?
>>
>>> This obviously leads to a massive performance drop and could possibly
>>> also be related to reports like this one:
>>>
>>>          https://lore.kernel.org/all/CAHk-=3DwjwFGQZcDinK=3DBkEaA8FSyV=
g5NaUe0BobxowxeZ5PvetA@mail.gmail.com/
>>>
>>> I assume the regression may have been introduced by all the thermal wo=
rk
>>> that went into 6.10-rc1, but I don't have time to try to track this do=
wn
>>> myself right now (and will be away from keyboard most of next week).
>>>
>>> I've confirmed that 6.9 works as expected.
>> Well, I'd need to ask someone else affected by this, then.
> If this is the step-wise governor, the problem might have been
> introduced by commit
>
> 042a3d80f118 thermal: core: Move passive polling management to the core
>
> which removed passive polling count updates from that governor, so if
> the thermal zone in question has passive polling only and no regular
> polling, temperature updates may stop coming before the governor drops
> the cooling device states to the "no target" level.
>
> So please test the attached partial revert of the above commit when you =
can.

