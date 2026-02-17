Return-Path: <linux-pm+bounces-42761-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M71LeKDlGlBFQIAu9opvQ
	(envelope-from <linux-pm+bounces-42761-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 16:06:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E814D630
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 16:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2DD73044647
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D26936CDE9;
	Tue, 17 Feb 2026 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tBM20F6v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091E36CE03;
	Tue, 17 Feb 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340711; cv=none; b=Xo5f6GLXXUNjT+ht3J/kr3pp1BhxmRruIsC5pRsA47EXGcWXEoeCIp4HIFYG6qbPd52cgjzRdX6oppU3fgD/vNNrt5ROZtiCcMGZB5SYoyFQjW1ol/EEqb2XQkMp2Tv5m3rDDladd1MF6K1yMJHKrmiNESoqJv9qFO1pt8OZziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340711; c=relaxed/simple;
	bh=Uj3A+uw54BzyCfx95n4zmoy30oYwLQtauz/Cs7N3a38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZEBSl48HST6FXuiv2xy/Rwgkkn4+5ncc2jPgG56eHlizY9RQKdwkchI2h5N//7NHkHcVR5gDYXwhTcTGe/qMhSAiqgfPB7UuN480D0vwwisjbLu68CSCXxAWHrMySswKOxxCrx7A32ShhJOvvTh9gY9MnWV/uQubPxCy0qDFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tBM20F6v; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fFjcM01nbz9t7D;
	Tue, 17 Feb 2026 16:05:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1771340707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IELzt1btZWNz2sWorU6uElBs2/8ePm1rr87gY2eyhpk=;
	b=tBM20F6vy+PwjgtJyif1W55HpRRImexlGgIc9ppk+sPnju2au9UcbE7ER1nQLLxzjWcJc8
	sqqPueTUNw6bpS73HFvfl3wHMcG510MErYAQAyuqfMlEf2t5tBDZhhP/lgKRVutI+jzI77
	sJIFezk2JpQafxvKpcoS2qA7dAVLgaBnq/eKZwpi7BYJRRGuASA63InjRuMYW4X+8x69Cw
	SJR+cA0qpwLd72ORRweULnHiL7VJdAZjpl9uFVCeVLJ2MIXq9ZfSSp9wcKCEB7M5KzekH1
	VQNL3cgAxgUnu10FkF4H4IrRsxmV9rBZmuiNLtLLaiRZwxqHs4s7yugRdBZUtw==
Message-ID: <01531a0e-b7e8-43b4-98c8-016fbbea6081@mailbox.org>
Date: Tue, 17 Feb 2026 15:54:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/imagination: Convert to
 dev_pm_domain_{at,de}tach_list()
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Matt Coster <Matt.Coster@imgtec.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Frank Binns <Frank.Binns@imgtec.com>,
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
References: <194465eda54d1f852a9226cf691ddc5aa208e0a3.1769097977.git.geert+renesas@glider.be>
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
 <973ca923-3654-46be-a9b8-8d38cd7d4a59@leemhuis.info>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <973ca923-3654-46be-a9b8-8d38cd7d4a59@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 608b86c2272fd929af8
X-MBO-RS-META: hjp3nb4da91yuydp1zpcadnfoofodi57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42761-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: 516E814D630
X-Rspamd-Action: no action

On 2/16/26 6:28 PM, Thorsten Leemhuis wrote:
> On 2/16/26 14:37, Matt Coster wrote:
>> On 16/02/2026 11:38, Thorsten Leemhuis wrote:
>>> On 2/16/26 11:58, Matt Coster wrote:
>>>> On 16/02/2026 10:11, Thorsten Leemhuis wrote:
>>>>
>>>> We're currently trying to force this issue to reproduce on hardware we
>>>> have on hand; we'd like to see it fixed properly as much as anyone.
>>>
>>> Yeah, no worries, I never doubted that. But getting things properly fixed
>>> can mean "revert, fix, reapply" when it comes to regressions in Linux --
>>> which is something that should not be seen as something bad, as Linus said
>>> himself (see below)!
>>>
>>>>  From our side at least, I don't believe this is a regression at all.
>>> In the end what matters is: some change afaics caused systems to not work
>>> anymore that used to be working -- that makes it a regression my the Linux
>>> kernels standards. And those by the same standards must be fixed, ideally
>>> quickly. Find a few quotes on that from Linus below that explains this
>>> better.
>> I feel like I should reiterate that the commit we're talking about
>> reverting is fundamental to support for one of the only two platforms
>> currently supported.
> 
> That might or might not be relevant, see the "back and forth" section
> from the Linus quotes.
> 
>> And that the changes to add "support" (just
>> bindings and DT) for the affected Renesas platforms came several months
>> *after* this.
> 
> Ohh? That might change things then. I relied on the info from Geert and
> Marek – and would be glad if you guys could sort this out, as you are
> the experts here (and I already got myself way deeper involved then I
> wanted to).

I already replied to Matt on this part -- I don't think the kernel crash 
is related to any specific platform. That the R-Car platform triggers it 
only means, that the crash is real and should be fixed.

