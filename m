Return-Path: <linux-pm+bounces-26714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE7DAABAC5
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 09:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6D53B9976
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92CE1FFC7B;
	Tue,  6 May 2025 04:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ctClDiCY"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5A21A445
	for <linux-pm@vger.kernel.org>; Tue,  6 May 2025 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506446; cv=none; b=HHvjkAiJ3WdGhzCnLR87WKudFaVzouC/34bYdHdX84m+WxYumP6l1SAluuCIgN6r33olXArydV2Ys7/DFoAQ8ysX2/cnXxEC55wMQgR/Zc/FGFhEKHxG+9Cb+DdPx4du6aPI7bGInUOQruLKYYYxP4gHNrOoO3YPkP4h9e0P5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506446; c=relaxed/simple;
	bh=MpJtj2k90/R/ZOoHP69VoxpHyRxw/wX2WoCFPoZVpbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDsnbeu3T6bCuwoBbYp4SnThouKd1nE4hcrLbWylRzHA5gHtQPZ852DaTvLppoOIiF5+lOIiklo7Jbmz6DunkoGDT1HQBIvAdJ432L1bpX9jXsahMlwZi0ZFgwBftLAZ98U7CIj5DXPuCqd3h5/UD2ronspUCxtVvQcL+s+t0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ctClDiCY; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=oxQVnNs9YZqPrPyfH/jZOPEmVtQcKWJk/VJMzNWni3E=; t=1746506443;
	x=1746938443; b=ctClDiCYirA8Kp5dhaxjBxW1hSsd9q8/Esi48pkdErfsS2QGHct4OG2th9A+/
	8ZZsXS9uwC6NIyBS1fBFlO5uhS7LCsUmUxsFRlkMFbOS06r64wPrTmiSDX32IO4Rqnwb5OOKj5TTL
	3x9J1ltSst2wTLYXu8fXJyn9FZBIzlYbl6ppv27HsxL5NYtVDutOmwqkQBppLvoUIyYBKKOHAKnck
	QE4j+AZxb0129a28Ta4t5NQo0/sgH0y3vvl5SdCB6e5JVBToDybYKCgaf4iN7XEJ82x+mpVzGD3O9
	jl4NSJXZPzZOHCeGhqqFooVl7lZ43PyOrw9RXAZDZkm5GXwTFg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1uCA6j-00BxgU-1T;
	Tue, 06 May 2025 06:40:41 +0200
Message-ID: <4c3542ad-0476-4f65-a4f9-0bb874eac207@leemhuis.info>
Date: Tue, 6 May 2025 06:40:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
To: Francesco Poli <invernomuto@paranoici.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-pm list <linux-pm@vger.kernel.org>,
 Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, Justin Forbes <jforbes@redhat.com>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
 <d06fb5d6-b8fe-4c4f-9ee9-6710c05cc51e@leemhuis.info>
 <20250505225545.7ed30f420ea8d1b6f3d9b0ce@paranoici.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20250505225545.7ed30f420ea8d1b6f3d9b0ce@paranoici.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1746506443;31364a0e;
X-HE-SMSGID: 1uCA6j-00BxgU-1T

On 05.05.25 22:55, Francesco Poli wrote:
> On Mon, 5 May 2025 18:06:30 +0200 Thorsten Leemhuis wrote:
>> On 25.04.25 17:07, Francesco Poli (wintermute) wrote:
>>> Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>
>> Lo! I'm wondering if the the DESTDIR usage in this patch is wrong, as it
>> caused trouble for me today when it showed up in -next. During debugging
>> I furthermore found a related problem.
> I am sorry for the trouble that my patch caused, [...]

np, happens :-D

>>> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
>>> index 835123add0ed..9c2b5f71fee1 100644
>>> --- a/tools/power/cpupower/Makefile
>>> +++ b/tools/power/cpupower/Makefile
>>> @@ -2,6 +2,7 @@
>>>  # Makefile for cpupower
> [...]
>>> +	sed 's|___CDIR___|$(DESTDIR)${confdir}|; s|___LDIR___|$(DESTDIR)${libexecdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
>>
>> While building -next kernel RPMS for Fedora the above line lead to the
>> this build error today:
>>
>> """
>> /builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT/usr/lib64/systemd/system/cpupower.service
>> Found '/builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT' in installed
>> files; aborting
>> """
>>
>> This somewhat cryptic error message means that the path
>> "/builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT/" ended up in the
>> file "cpupower.service"; RPM noticed that and rightfully aborts the
>> build, as that path should not end up there. It's inserted by the sed
>> call in the last line quoted above.
> 
> Yes, that seems to be exactly what happened.
> 
>>
>> I could easily fix this up in the RPM spec file with another sed call,
>> but wonder if that path should end up there in the first place. Not
>> quite sure, but I guess it should not (removing the first two
>> "$(DESTDIR)" in the line with the quoted sed call would fix that).
> 
> I probably misunderstood the purpose of DESTDIR.
> 
> I thought it was intended to define a custom final destination for the
> installed files (as in "I want the whole thing to be installed there!").
> 
> But maybe it is instead intended to define a custom temporary
> destination for the installed files, which will be later relocated to
> the root directory / 

Yes, that seems to be the case:
https://www.gnu.org/prep/standards/html_node/DESTDIR.html

[Looked this up yesterday a few hours after sending my mail]

> I can prepare a fix for this issue, if others confirm that the intended
> purpose of DESTDIR is to help package builds.
> 
> By the way, should I prepare a v3 patch, or a new patch on top of the
> origin/cpupower git branch?

Shuah has to answer this, but from what I see the vast majority of the
maintainers prefer a patch on top of patch already applied to a tree
that is in next. And even if not it's often not that hard for them to
fold one in the earlier version.

> [...]
>>> +	$(SETPERM_DATA) '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
>>> +	if test -d /run/systemd/system; then systemctl daemon-reload; fi
>>
>> While investigating the issue I did a manual local build using
>> "make DESTDIR=~/tmp/out libdir=/usr/lib64 CPUFREQ_BENCH=false install"
>> to take a closer look. That make call then made systemd ask me for the
>> root password, which I found odd. Turns out that happens due to that "if
>> test -d" command quoted above.
> 
> Yes, this is another aspect that seemed tricky to me.
> 
> I thought that the "systemctl daemon-reload" should be automated
> through the Makefile, but I agree that issuing this command is not
> always useful or desired.
> 
> If the "make install" call writes the 'cpupower.service' file to a
> location where systemd does not look at all, then reloading the systemd
> daemon is pointless. Also, if the EUID is not root, reloading the
> systemd daemon is probably not what you want to (or can) do.

+1

> Maybe it's better if I drop the "systemd daemon-reload" command
> entirely, and add something to the 'README' file 

No strong opinion there, but I'd say that is the right thing to do, as I
assume most other software on install does not do that either (but it's
just a guess, so I might be wrong there).

> And thank you again for reviewing these aspects of my patch!   :-)

yw! And thank you for your work on this!

Have a nice week, ciao, Thorsten

