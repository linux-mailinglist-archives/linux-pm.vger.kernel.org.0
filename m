Return-Path: <linux-pm+bounces-42708-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PY/BFLxTk2lD3gEAu9opvQ
	(envelope-from <linux-pm+bounces-42708-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:28:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBD2146B4B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB63C301874F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C572DAFDA;
	Mon, 16 Feb 2026 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Y2fF7fR4"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48042D5C74;
	Mon, 16 Feb 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262903; cv=none; b=OsmE621QIkF/1VGQAiizWoNv0l1RxbQoRAUv1t4FOGUMM9lBgtjdo5TRKhuGzwxi4Abfy5BguPZfKHQggFpl0sALs5MvkhsDE8fuxp/Gs4PtBoxeS751fj8i6C2cRWWury4EI3LVW4N/Np6HqLoZieED5t5mV15OQVDhoNsLLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262903; c=relaxed/simple;
	bh=V60Qq5xAu33W8d4d2LDyItq3JD04OsRTwwnEJcb4BXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5p81GUh0atx0QIKkBAAdvHnCO8fnWiCIF5kAs+iWYDMDBYvQ3dR0qv9rmI3gC1r/JVaoZ2KTqYzLPm0G9zVWHZdWibyp87zE9Hh8N++GWkCKMRaje/x/97VrCGGiDQJ4PQhBH/ApEkHnFkNa3KwVE1sF0HlYsko64qYTsAkCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Y2fF7fR4; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fF8r36q1Lz4FD3;
	Mon, 16 Feb 2026 18:28:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1771262900;
	bh=V60Qq5xAu33W8d4d2LDyItq3JD04OsRTwwnEJcb4BXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y2fF7fR4sZSuthgunStz7w+juxDg/tnO6zZnNIf/4z8j9s0aUfYBoz9GTpH7lRGsL
	 6wq93VZGyBZmAUjtpwdSYnQ2/uZFl2t7Zfe1K5Of2klo4tlJfYE97auxC4cnqql/nz
	 aH8JeKp3LPREYHrudO8iyLLIvWw2zAVEPyu0Nqu5maZGEeFBpamRtMKnjgphqTRZNY
	 Q5NMV/ZoiceSDpzj7xO1kU4z4ndIu5MWgfHTUdz7PS27u9Qiq/OIPIdCb16aLWppvs
	 qlUfvprqlR4mwJwC6GnhNHXi8HSH9cvLlwLc+DW6IjchlczOfnK4RjEAQACuVOBQDN
	 wUTvc5sUu6MNg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fF8r36565z7vrh;
	Mon, 16 Feb 2026 18:28:19 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fF8r2359cz8sZP;
	Mon, 16 Feb 2026 18:28:18 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 5DAB1673D8;
	Mon, 16 Feb 2026 18:28:17 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <973ca923-3654-46be-a9b8-8d38cd7d4a59@leemhuis.info>
Date: Mon, 16 Feb 2026 18:28:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imagination: Convert to
 dev_pm_domain_{at,de}tach_list()
To: Matt Coster <Matt.Coster@imgtec.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
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
 <f82b7734-6ddc-4029-b38d-147e9a1de021@leemhuis.info>
 <fcf5ab75-029e-469e-8b2a-51fa5c2a2374@mailbox.org>
 <95fd3f52-c3ed-40c5-920f-11e8767f701d@leemhuis.info>
 <CAMuHMdV-g+3kTaG6Ost4iHo1Tdi_H=qscLBkBRWuR+6DG5c=SA@mail.gmail.com>
 <1e8e416e-e474-4288-9686-1ba2b88e4946@leemhuis.info>
 <21b1fd77-252e-4fb3-aa65-1c26043c5412@imgtec.com>
 <9c1b2671-3374-4d84-ad14-07dd499bb934@leemhuis.info>
 <86e23062-e439-41f3-9750-d87fa5b85447@imgtec.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <86e23062-e439-41f3-9750-d87fa5b85447@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177126289794.943165.17784038713473654524@mxe9fb.netcup.net>
X-NC-CID: AjV1G+1qi0A50p5fD7769aC/jkB5VYhyTxmItNVrQNIkz8NMXTc=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mailbox.org,imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	DMARC_NA(0.00)[leemhuis.info];
	TAGGED_FROM(0.00)[bounces-42708-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leemhuis.info:mid,leemhuis.info:dkim];
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
X-Rspamd-Queue-Id: 9EBD2146B4B
X-Rspamd-Action: no action

On 2/16/26 14:37, Matt Coster wrote:
> On 16/02/2026 11:38, Thorsten Leemhuis wrote:
>> On 2/16/26 11:58, Matt Coster wrote:
>>> On 16/02/2026 10:11, Thorsten Leemhuis wrote:
>>>
>>> We're currently trying to force this issue to reproduce on hardware we
>>> have on hand; we'd like to see it fixed properly as much as anyone.
>>
>> Yeah, no worries, I never doubted that. But getting things properly fixed
>> can mean "revert, fix, reapply" when it comes to regressions in Linux --
>> which is something that should not be seen as something bad, as Linus said
>> himself (see below)!
>>
>>> From our side at least, I don't believe this is a regression at all.
>> In the end what matters is: some change afaics caused systems to not work
>> anymore that used to be working -- that makes it a regression my the Linux
>> kernels standards. And those by the same standards must be fixed, ideally
>> quickly. Find a few quotes on that from Linus below that explains this
>> better. 
> I feel like I should reiterate that the commit we're talking about
> reverting is fundamental to support for one of the only two platforms
> currently supported.

That might or might not be relevant, see the "back and forth" section
from the Linus quotes.

> And that the changes to add "support" (just
> bindings and DT) for the affected Renesas platforms came several months
> *after* this.

Ohh? That might change things then. I relied on the info from Geert and
Marek – and would be glad if you guys could sort this out, as you are
the experts here (and I already got myself way deeper involved then I
wanted to).

> [...]

Ciao, Thorsten

