Return-Path: <linux-pm+bounces-42571-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANE9Mlb6jWnz9wAAu9opvQ
	(envelope-from <linux-pm+bounces-42571-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 17:05:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3DB12F386
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 17:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8567A3008D2C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D585F32FA2D;
	Thu, 12 Feb 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="KXaABoxW"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680010785;
	Thu, 12 Feb 2026 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770912207; cv=none; b=AaL7pbl8NQ3ogtXYSDGVS2uyMhzZoE+MnLVHB+vYy8VIvGDWlARe/czGQVUWarCyVuSaXOTZi11fayVKpfHCWC1L4tUzpG7Gkqqh39zEIVcoqnzGOYCrtSS1DCqey6KHlkx9VKabTXaNQUjMC+X/75qKDC8IJzq8Sj2n72z8NPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770912207; c=relaxed/simple;
	bh=fs4w3huEAMgTOhifbnB9LHX97Yl+dRlz32ijMU82YCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZbSCC2ZsAX81puE3xIyMPVFEkxrqGdTqn7oq2YQNC/eemM5uOG8eiyJyn/vJKpsMrLmdRwflWojQz/0QPrRTR+5+XeB0FVtbcZbGz9t7t49LYJvhjSZe6TGwl5i9ULN/bLWC1/TtgwE8ioU1Vxur0k7qscBxoq5q1mFZlFYqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=KXaABoxW; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fBfzT2Gd0z6Fd4;
	Thu, 12 Feb 2026 16:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1770911765;
	bh=fs4w3huEAMgTOhifbnB9LHX97Yl+dRlz32ijMU82YCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KXaABoxWVsYbLH1gh5xbpYr4RkIYvFazojx35JpLiQfH4ESE2DGnzN62Q3Ua94F37
	 siKuyCVms2KCwFOC433ahcfrLiJ3fER3bl0SM6TK0TeBO0qdMP+UK4s9nvoARTjh1z
	 dol/CxH7oRK5iugLIQ+Vr1cmsz9/jKLWRPdLnjFE/hC0zTMQ3wZW3IuygXylAW5l+h
	 zc53JMrZd0ZP7wDIrWoaww/COLQNBdB4aaW/bRYELE4M4AQiDSyPl5blYRVvVmct4P
	 Pl9DbSHpjFZp3TnN8vmUdLfwycIUswEED7pXhiBHG1CjDfHT/ehNxviJSXRYV5wsP3
	 fhQ9BqZN/rxeg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fBfzT1XlZz4xhk;
	Thu, 12 Feb 2026 16:56:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fBfzR3jgZz8sbV;
	Thu, 12 Feb 2026 16:56:03 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 0A9F1671B1;
	Thu, 12 Feb 2026 16:56:02 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f82b7734-6ddc-4029-b38d-147e9a1de021@leemhuis.info>
Date: Thu, 12 Feb 2026 16:56:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imagination: Convert to
 dev_pm_domain_{at,de}tach_list()
To: Marek Vasut <marek.vasut@mailbox.org>,
 Matt Coster <Matt.Coster@imgtec.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Frank Binns <Frank.Binns@imgtec.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: 
 <194465eda54d1f852a9226cf691ddc5aa208e0a3.1769097977.git.geert+renesas@glider.be>
 <ffdf3982-e22c-4d01-afa6-5449ed381000@imgtec.com>
 <CAMuHMdWMh_oJFg-KtapcTDGvYWZ-hg_ZEJ2=E5Tp1apOEc8tnQ@mail.gmail.com>
 <b3b4f10e-1222-44f7-b308-db7199c67147@mailbox.org>
 <3e0def93-2f6c-4bcf-8ee5-bf607f2ca382@imgtec.com>
 <f5d3dde6-edec-42f4-93cb-459c8677245a@mailbox.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <f5d3dde6-edec-42f4-93cb-459c8677245a@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177091176259.2119832.3617988698706173767@mxe9fb.netcup.net>
X-NC-CID: J5czT71szw5Ql5dY1Tz1SLQRGPcYJeYH0q9GxvoioYLNmk5ORlI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-m68k.org,imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	DMARC_NA(0.00)[leemhuis.info];
	TAGGED_FROM(0.00)[bounces-42571-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,imgtec.com:email,leemhuis.info:mid,leemhuis.info:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E3DB12F386
X-Rspamd-Action: no action

On 2/12/26 15:38, Marek Vasut wrote:
> On 2/12/26 10:00 AM, Matt Coster wrote:
>> On 11/02/2026 19:17, Marek Vasut wrote:
>>> On 1/23/26 2:50 PM, Geert Uytterhoeven wrote:
>>>> On Fri, 23 Jan 2026 at 14:36, Matt Coster <Matt.Coster@imgtec.com>
>>>> wrote:
>>>>> On 22/01/2026 16:08, Geert Uytterhoeven wrote:
>>>>>> Call the dev_pm_domain_attach_list() and dev_pm_domain_detach_list()
>>>>>> helpers instead of open-coding multi PM Domain handling.
>>>>>>
>>>>>> This changes behavior slightly:
>>>>>>     - The new handling is also applied in case of a single PM Domain,
>>>>>>     - PM Domains are now referred to by index instead of by name, but
>>>>>>       "make dtbs_check" enforces the actual naming and ordering
>>>>>> anyway,
>>>>>>     - There are no longer device links created between virtual domain
>>>>>>       devices, only between virtual devices and the parent device.
>>>>>
>>>>> We still need this guarantee, both at start and end of day. In the
>>>>> current implementation dev_pm_domain_attach_list() iterates forwards,
>>>>> but so does dev_pm_domain_detach_list(). Even if we changed that, I'd
>>>>> prefer not to rely on the implementation details when we can
>>>>> declare the
>>>>> dependencies explicitly.
>>>>
>>>> Note that on R-Car, the PM Domains are nested (see e.g.
>>>> r8a7795_areas[]),
>>>> so they are always (un)powered in the correct order.  But that may not
>>>> be the case in the integration on other SoCs.
>>>>
>>>>> We had/have a patch (attached) kicking around internally to use the
>>>>> *_list() functions but keep the inter-domain links in place; it got
>>>>> held
>>>>> up by discussions as to whether we actually need those dependencies
>>>>> for
>>>>> the hardware to behave correctly. Your patch spurred me to run around
>>>>> the office and nag people a bit, and it seems we really do need to
>>>>> care
>>>>> about the ordering.
>>>>
>>>> OK.
>>>>
>>>>> Can you add the links back in for a V2 or I can properly send the
>>>>> attached patch instead, I don't mind either way.
>>>>
>>>> Please move forward with your patch, you are the expert.
>>>> I prefer not to be blamed for any breakage ;-)
>>>
>>> Has there been any progress on fixing this kernel crash ?
>>>
>>> There are already two proposed solutions, but no fix is upstream.
>>
>> Yes and no. Our patch to use dev_pm_domain_attach_list() has landed in
>> drm-misc-next as commit e19cc5ab347e3 ("drm/imagination: Use>> dev_pm_domain_attach_list()"), but this does not fix the underlying
>> issue of missing synchronization in the PM core[1] is still unresolved
>> as far as I'm aware.
> 
> OK, but the pvr driver can currently easily crash the kernel on boot if
> firmware is missing, so that should be fixed soon, right ?

Well, drm-misc-next afaik means that the above mentioned fix would only
be merged in 7.1, which is ~4 months away, which is not really "soon"
I'd say. Or did I misjudge this?

> I added the regressions list onto CC, because this seems like a problem
> worth tracking.

Noticed that and wondered what change caused the regression. Did not
find a answer in a quick search on lore[1]. Because if it's a
regression, we maybe should just revert the culprit for now according to
Linus:
https://lore.kernel.org/lkml/CAHk-=wi86AosXs66-yi54+mpQjPu0upxB8ZAfG+LsMyJmcuMSA@mail.gmail.com/

Ciao, Thorsten

[1] I guess this was the initial report from Geert?
https://lore.kernel.org/all/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com/

