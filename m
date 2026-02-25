Return-Path: <linux-pm+bounces-43215-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCLiE1whn2lcZAQAu9opvQ
	(envelope-from <linux-pm+bounces-43215-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 17:20:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D96AB19A77E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 17:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9D53311E034
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146793D6696;
	Wed, 25 Feb 2026 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5yKOSWs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38373D6474;
	Wed, 25 Feb 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035211; cv=none; b=DYDNeWxVYBrLLyQGBaoWzvTWw8TfttcYMGaQi5T/uXvgMkZJynzNR3E2LFonu+d3iKw+mdW5IRUHh0IVvFOQO4W4b1PKibgkdflwKvGLlB6RONnCyQLM7euyZyO9QV6rOGpbrkxIqG1OxxyuHNaFIGCPSodCwGWCZIVNQbky2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035211; c=relaxed/simple;
	bh=Swg6cBoXr19d068hTQFSCJ7C1JnhMFEYMeBBAhp/aic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EGL7T0IU+QokExGK84qswSIztqZDrr6MxlK0nyY2gYS7NkPcDPeiPUIt+AyUHyzBcTBAt41ds33tzSGpv4bzOFimM7qN9E7tcbwjUU2FmqN2difdwyTZgnPeFGyZgCw1gJdhQkoQlhbgujsV3Hcft+uOAhiB3P0qEXqz7Nk3u0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5yKOSWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5E8C116D0;
	Wed, 25 Feb 2026 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772035210;
	bh=Swg6cBoXr19d068hTQFSCJ7C1JnhMFEYMeBBAhp/aic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=t5yKOSWs8to9EoIDo2HWgtu56k87ouUOmYqGMZEDwzQnFz57I3gwamihHJihwG0ZP
	 B1q50U8To1nFvAepP+epZ0R1NSOHvPnOmqoO5Xy8WSnqJRGN5URHT0Q3u8TPbv7e45
	 EEQ8DKKVdiCNN9WgCGrdeCoGovE7UykJJrxeKqvnmMUVspfjQ0AqunbXqhuZyaxokA
	 OfV07B+muQL4Ebe1xofcSrI9tfI2x8glLIYKKzh8RhsWAiPII1f3D1/OOZ19HMZdvJ
	 WKtIJjYPeSaanjKLSJbaK9dUNHaxptUt+RXHB35KPMGDW/ga5X0y9IjBTDUf4kA0Um
	 7MEJpjSciYW6Q==
From: Thomas Gleixner <tglx@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCH RFC] tick/sched: Prevent pointless NOHZ transitions
In-Reply-To: <CAJZ5v0gZBTqnk36P+hTjE-CgSOsy+MP=SXSwHHY+zxr1HbCZQA@mail.gmail.com>
References: <875x7mv8wd.ffs@tglx>
 <ca2b5ede-1922-4540-bc44-a7ff6bec406f@arm.com> <87zf4yt90t.ffs@tglx>
 <5987061.DvuYhMxLoT@rafael.j.wysocki> <87jyw1u7ps.ffs@tglx>
 <CAJZ5v0g-PuFsSit4_xg+B=pDqJauOo=VX55bH+Kj+s=-tpXWTQ@mail.gmail.com>
 <CAJZ5v0gZBTqnk36P+hTjE-CgSOsy+MP=SXSwHHY+zxr1HbCZQA@mail.gmail.com>
Date: Wed, 25 Feb 2026 17:00:06 +0100
Message-ID: <87zf4w7r09.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43215-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D96AB19A77E
X-Rspamd-Action: no action

On Wed, Feb 25 2026 at 14:10, Rafael J. Wysocki wrote:
> On Wed, Feb 25, 2026 at 1:54=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
>> >
>> > Which prevents VMs or other systems which do not have an idle driver to
>> > stop the tick at all. That's just obviously wrong, no?
>>
>> The benefit from stopping the tick in cpuidle is that it doesn't kick
>> CPUs from idle states unnecessarily, so more energy can be saved (or
>> even some energy can be saved at all if the idle state target
>> residency is large enough), but if the idle state in question is
>> shallow, that's rather not super-useful.  And I'd rather not expect
>> default idle to be a deep idle state because that would obviously hurt
>> low-latency use cases.

There are systems out there where even HLT (or the architecture specific
equivalent) saves power magically in the firmware.

>> I must be missing something, so what is it?
>
> OK, if I'm not mistaken, the tick in a VM will effectively become a
> periodic hrtimer in the host and it would prevent the host cpuidle
> from stopping the tick.  Fair enough.

That's the energy side.

The other problem is performance in the guest itself. If the guest idles
only briefly and can avoid the rearm of the timer on wakeup then it wins
performance wise. That's true for bare metal too, but the rearm on bare
metal is less expensive than a full VM exit.

Thanks,

        tglx

