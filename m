Return-Path: <linux-pm+bounces-41741-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNRgOLj7e2n4JgIAu9opvQ
	(envelope-from <linux-pm+bounces-41741-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 01:30:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D9AB5EBC
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 01:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230E4304AAEF
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 00:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B8280023;
	Fri, 30 Jan 2026 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlcG0obH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486427F4F5;
	Fri, 30 Jan 2026 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732942; cv=none; b=BEnRm8C8bTnD1KmcCPTEF3/xAYgE9KPKEWnuyb3OMi1qwa7UzbfDyq5djLzBJN6zjwVRXW0k+MjFSCXVgvTcsSBcgm70l0nl9D4V7qUzYCYZlT+Ri1utO4VnozYpd2OOklWEQaQ1kxywN2GW2KL9dqgp3jzvR2QMWUBikhKC4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732942; c=relaxed/simple;
	bh=EDfvHvej+3AK/c7xQEWBIQn+d1R1w01t163Fh8B3sPc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DVdSTYof0CmVtejqmgydsPCrv368Gx+0X+8Zmb93kraa/JJWPfozmR8AwA3ejNzIHGNfrQcp9R3c4gVxJYOx36ohcp8O9/omHaQcPIcmq/YEdSHkhJUkIbxEE5nbvxJpcuw5Ayj4hkrVd0JYftFLKz0PH0VAOg7dMlp7OZkFRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlcG0obH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A7FC4CEF7;
	Fri, 30 Jan 2026 00:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769732940;
	bh=EDfvHvej+3AK/c7xQEWBIQn+d1R1w01t163Fh8B3sPc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MlcG0obH1oS7Ueb6whBbMUkn4m180vtDR4gyIyZpwfPk/uLp/tkDjLrGBOc51cr0H
	 V/bdK4aaWSwwXkxTdyTnfW/Jgil9LkSawY5wMA/EfTR9rK8L/7wdROMdn2eJtIPnOK
	 +FPjyyteKzDVzWm2bz+t+o5kHkOUAXee0uPoshMlwuSSOZWu+s9MojpEfl1mAAn2Qy
	 2g5c9TsjcE454zz6zP6DFdtFY3G/qvTYabQ1R5lwarenN3Ed4FGMhMThmLyW5C61NO
	 s0nPXLyESXjMiO5A9TFaCJI3+YvASN+6x9EhvvzratNpO3x7PCxtWEMgMLpDUCN/cD
	 yM+O/pk2kDzkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11AB5380CEDD;
	Fri, 30 Jan 2026 00:28:54 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.19-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jNT2zChGFdwx9PNx6W1Vk+Mp69dFEos4YLSGgN6gUp7g@mail.gmail.com>
References: <CAJZ5v0jNT2zChGFdwx9PNx6W1Vk+Mp69dFEos4YLSGgN6gUp7g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jNT2zChGFdwx9PNx6W1Vk+Mp69dFEos4YLSGgN6gUp7g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc8
X-PR-Tracked-Commit-Id: 1730daa3b425ea8c88ae599af6e1a4957bd2d81a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d310797262f0ddf129e76c2aad2b950adaf1fda
Message-Id: <176973293268.3113374.13494062338975929940.pr-tracker-bot@kernel.org>
Date: Fri, 30 Jan 2026 00:28:52 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41741-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47D9AB5EBC
X-Rspamd-Action: no action

The pull request you sent on Thu, 29 Jan 2026 21:35:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d310797262f0ddf129e76c2aad2b950adaf1fda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

