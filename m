Return-Path: <linux-pm+bounces-43047-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jMK0HgV1nGmyHwQAu9opvQ
	(envelope-from <linux-pm+bounces-43047-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:40:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86220178E18
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 508BA30221EC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DF42EFDAF;
	Mon, 23 Feb 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX9ARNsI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8C2EDD6C;
	Mon, 23 Feb 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861247; cv=none; b=SHagQ+HID1QNWjx4VxHkia90XnzFKj4r1CIc2D5u7m/xPTn0nnsvncdZrBmaEB8kK9wYKt12Jjri8+3IpqmEVlDDW6yrt/e0s8quAr1SBCjsV6scpoSaCLuNUHcsAyOgyglZsyq2DPL7K16pgSUwAhjU6xo1qJMEcElCzR6wZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861247; c=relaxed/simple;
	bh=6KqK3Kokr9PTuL04N6S7S6pbl18j/jJvBjYqEnLsud8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BwegTMWV//75yggGIxHZZ5wbE5HNOGh7reF4Vy5aDU7f5+FPvvN4M0yeZPeO/KqA4AltL9V+seKr4n8KTsq86vQfKcfo260F0tRqoVTbof3cdSwEgbWJE1y/jlUKERnE4dQVeGXwzwC6LJOUwwd60i5b/k2AH4zMJBCkTw3JAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX9ARNsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBD1C116C6;
	Mon, 23 Feb 2026 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861247;
	bh=6KqK3Kokr9PTuL04N6S7S6pbl18j/jJvBjYqEnLsud8=;
	h=From:To:Cc:Subject:Date:From;
	b=TX9ARNsIiS/emThJRBXxir+ijCCjmUPfXaP9HgVa7dE7FsfCet83+B8CygA9sUAxw
	 nagjmmuoKL5ukFee1FNWIbgoZKTAras4y5BIiIrS/hoJtnCGU05GNOZ7aXxV1uNhuT
	 g4sXEDho1EqCAhEb57nBPn5jreehBa40q8gI/GlEyFyDqpx0nvhFRehunNzVAvCWrS
	 WpeSNtDP+UWcVAgUAnize11c0fcZevDStQ0MGCUsOsf2/9EIgSKhCfs2V+QipZo9E2
	 weUz7CQ3c+CO4U62SdrUBMntfKdsBlg0atB0NCB9VYnb0C6174IRtvoWgFUGfn+dL0
	 MF3cLTmgqUkhw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Subject: [PATCH v2 0/2] cpuidle: governor: Modify the handling of stopped tick
Date: Mon, 23 Feb 2026 16:37:21 +0100
Message-ID: <3693525.iIbC2pHGDl@rafael.j.wysocki>
Organization: Linux Kernel Development
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43047-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arm.com,telus.net,linux.ibm.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 86220178E18
X-Rspamd-Action: no action

Hi All,

This is an update of

https://lore.kernel.org/linux-pm/1953482.tdWV9SEqCh@rafael.j.wysocki/

that fixes an issue in the second patch.  The first patch does not change and
the changelog below still applies.

When I was thinking about possible ways to address high CPU wakeup latency on
isolated CPUs resulting from the selection of deep idle states by cpuidle
governors, it occurred to me that it is not always necessary to select a
deep idle state if the scheduler tick has been stopped.  Namely, if a timer
is going to trigger (relatively) shortly, a shallow state may as well be
selected because the timer will kick the CPU out of that state anyway and
getting stuck in it for a long time is not a concern.

Changing the menu governor to take that observation into account is a 2-line
patch, modulo a comment update (patch [1/2]).  Of course, the SAFE_TIMER_RANGE_NS
value is somewhat arbitrary.

Updating the teo governor accordingly is a bit more challenging, but overall it
is a major simplification of the stopped tick handling there, so IMV it is very
much worth doing (patch [2/2]).

By itself, this is not going to help workloads running on isolated CPUs too
much, but if SAFE_TIMER_RANGE_NS were replaced with a per-CPU tunable, that
could help people to configure their systems to avoid the latency issue
mentioned above.

Thanks,
Rafael




