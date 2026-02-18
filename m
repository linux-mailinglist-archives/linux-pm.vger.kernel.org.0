Return-Path: <linux-pm+bounces-42834-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDYKJBkHlmnxYgIAu9opvQ
	(envelope-from <linux-pm+bounces-42834-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:38:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79124158C3B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35B7E3008C3F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE2A347BA9;
	Wed, 18 Feb 2026 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3WcIKbg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA39346FB5;
	Wed, 18 Feb 2026 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439875; cv=none; b=dch1AFWGLayu+B2gCUqb+MFC+llr7nM24RNkPx4H6fk+l+2dMCjCJzVpUmwp7vdGhlzUhPXMU2/pZVWFazG7g0WXCFg1/IsozMh2TNoEFg9GMZdg86CS6B4LokapyeVyqd02UZcWgBrtOy3GFSk4t3BWY3dRrg10NtT2+Zww6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439875; c=relaxed/simple;
	bh=2VvhhQaQxPJo5weKPzFQWtm+sXdQroMhsxRXMUaEwJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QND7/yIFMxC+5l9nreDHkXVZ8Uu5LPChXdmus19UFhnagVEwMmnQbDXOnJmbP167OayeHR5j6rKdn4zROL/OGyQYHK+O1Sm/WtmgeuAKGZWP0MOsxqfbI6VXArGr1MibiNYxgP69vBH4Gi3eKrQg8v2UR5eD3Q3/3dcTSkgYwBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3WcIKbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D713C19423;
	Wed, 18 Feb 2026 18:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771439875;
	bh=2VvhhQaQxPJo5weKPzFQWtm+sXdQroMhsxRXMUaEwJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=p3WcIKbgOahLK1oETFOdoPGPvwmslhhaJRE96sOi9hVqtB5lq0JzllwBSaBA2ATzu
	 6JWZr+3HOTiScniJRWHPs98ntkT+3d11yHfFai1j90K+AnJALdRIdxMIJED6sBQh8K
	 r0Dsx3khdgBaT/qNsqMlHAVfsFokeB9NAnG4xFjxlESzqHWWt9XyvTMe25VMLSKe5o
	 iz6uEoNkh2ZW60BeySsfBvkeRD9YGFzZGgbp3EN3L6fXM156P+7kz+Q5Kvw/dOq9Ip
	 StlYI3loWyeCsHQ7zTzfTcqVZUH39nnvDTUb5ZL23HOprD/P9/ykZ5gLjfH/JnmTmI
	 3JNay3pz9ActQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Subject: [PATCH v1 0/2] cpuidle: governor: Modify the handling of stopped tick
Date: Wed, 18 Feb 2026 19:34:38 +0100
Message-ID: <1953482.tdWV9SEqCh@rafael.j.wysocki>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42834-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,arm.com,telus.net,linux.ibm.com,gmail.com];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 79124158C3B
X-Rspamd-Action: no action

Hi All,

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




