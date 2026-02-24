Return-Path: <linux-pm+bounces-43176-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLNNJKkYnmmcTQQAu9opvQ
	(envelope-from <linux-pm+bounces-43176-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 22:31:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF3818CC9F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 22:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB593039EDE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 21:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93366338904;
	Tue, 24 Feb 2026 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czdk/WrW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62225524C;
	Tue, 24 Feb 2026 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968677; cv=none; b=anzl9pHoUaMB6qPHnJhb4fwV2SfKz3sMR529vUSkzASaWn7Y5XTkWu8pPeEuQrEXcFglngvQ1i3Hv7TNg+RIlYleVV74jVMinMtxoH18GcU8ND+cpKSd2mK1Ulo3ZcOpRzBsHCiesGBrJzXQ3RLnOE4AgIpTi0odRXSKkdESKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968677; c=relaxed/simple;
	bh=UbtxL0lwVAdObZWxDmbXqs9I1KiIpKW75KMm1Hf3Cbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKIkZTFxw2NYgBZbVgVdx0kHXRLU2uT5CoNXqjgcry29sMqP56S+5CJHoKzPylWR5grqlj0PRib6BnEDg4zhUwHSwy2BNFxlK3uoqrC7YbVmWe8EOonxAdP7BjefmvWyUy1EkuN7gaxBA3hBRm+/mccaDtbhwRoZmhY5MesUJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czdk/WrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A063C116D0;
	Tue, 24 Feb 2026 21:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968677;
	bh=UbtxL0lwVAdObZWxDmbXqs9I1KiIpKW75KMm1Hf3Cbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Czdk/WrW03CbLQTSWrZr0rP5OWHnw65JiuizHkpcyGPbyYxbaTL34b2hFNKMulcdY
	 Qh9dhSWP+CLLoXcPgzGbqdzKc+AqXqHNj7XZX0UrXng8fVYKRgGzE5/Xl5fsnkinHz
	 WLTJaPSlSZtqkoPbC3lT4siqlR2REBec629SxtDVXtf6gqRuDc0g6S7BlIuw9/erDG
	 9EoGH/V1yC8lDXCZQssx5CvQc/StYvligEEsvJGH/sIkVv9A6L/eWfDW1h1EJNBq/1
	 gDvNQm3aq806qE5qZPoWVDu4WgOyGgZVDUy0w+BL6KvMkq/fdq0X4CanR/CKL0e7GK
	 2xh52QSHs3BSw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>,
 Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH RFC] tick/sched: Prevent pointless NOHZ transitions
Date: Tue, 24 Feb 2026 22:31:13 +0100
Message-ID: <5987061.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <87zf4yt90t.ffs@tglx>
References:
 <875x7mv8wd.ffs@tglx> <ca2b5ede-1922-4540-bc44-a7ff6bec406f@arm.com>
 <87zf4yt90t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43176-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,rafael.j.wysocki:server fail];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: EEF3818CC9F
X-Rspamd-Action: no action

On Tuesday, February 24, 2026 5:13:06 PM CET Thomas Gleixner wrote:
> On Tue, Feb 24 2026 at 09:35, Christian Loehle wrote:
> > On 2/24/26 08:32, Thomas Gleixner wrote:
> >> This happens with both TEO and MENU governors in a VM guest. That's not
> >> only pointless it's also a performance issue as each rearm of the timer
> >> implies a VM exit.
> >
> > This is the (drv->state_count <= 1) case I assume, no governor does anything
> > sensible in that case.
> 
> Indeed.
> 
> > I was also curious about the performance angle recently FWIW, but didn't
> > hear back:
> > https://lore.kernel.org/all/73439919-e24d-4bd5-a7ed-d7633beb5e4f@arm.com/
> 
> Sure, but I can tell you that two VM exits for a 10us idle are really
> harming performance a lot. That's why I noticed.
> 
> >> Keep track of the idle time with a moving average and check it for being
> >> larger than TICK_NSEC in can_stop_idle_tick(). That cures this behaviour
> >> while still allowing the system to go into long idle sleeps once the
> >> work load stopped.
> >> 
> >> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> >> ---
> >>  kernel/time/tick-sched.c |   20 +++++++++++++++++---
> >>  kernel/time/tick-sched.h |    9 +++++++++
> >>  2 files changed, 26 insertions(+), 3 deletions(-)
> >
> > Why here and not in cpuidle?
> 
> I don't care where it is fixed, that's why I marked it RFC
> 
> > We've recently added some code for the single state case to skip
> > governor see
> 
> Duh. I just noticed, the VM has no driver, so this will not end up in
> cpuidle_select(). No wonder that changing the governor has no effect :)
> 
> I set the governor to haltpoll now, but that does not work either as the
> stupid haltpoll driver is built in and not activated as it requires the
> force parameter unless the KVM hypervisor has KVM_HINTS_REALTIME set.
> 
> Brilliant, intuitive and truly user friendly stuff all that.
> 
> It's amazing as always that all the "performance experts" who cry murder
> on everything else never noticed this completely nonsensical default
> behaviour.
> 
> Force enabling that driver and setting the governor to 'teo' makes it go
> away. 'menu' still sucks pretty much the same way as with none; slightly
> less so, but often enough.
> 
> > e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state is available")
> > where that could also live.
> 
> So either ladder or the powernv driver is broken and that gets fixed in
> the cpuidle core. Interesting choice.
> 
> But as I explained above adding something to this hack won't help for
> the VM case with no driver active because cpuidle_not_available() is
> true and idle ends up in default_idle_call().
> 
> So either the governor/driver muck provides some sensible default
> implementation or this has to go into into default_idle_call().
> 
> Oh well...

It looks like the issue is cause by the tick_nohz_idle_stop_tick() called right
before invoking default_idle_call().

After the recent changes mentioned above, cpuidle_select() will never stop the
tick when there's only one idle state in the cpuidle driver, so it would be
consistent to make the default case behave analogously.  The default idle state
is never a deep one AFAICS.

So maybe something like the below?

---
 kernel/sched/idle.c |    2 --
 1 file changed, 2 deletions(-)

--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -186,8 +186,6 @@ static void cpuidle_idle_call(void)
 	}
 
 	if (cpuidle_not_available(drv, dev)) {
-		tick_nohz_idle_stop_tick();
-
 		default_idle_call();
 		goto exit_idle;
 	}




