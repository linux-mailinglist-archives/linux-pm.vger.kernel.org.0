Return-Path: <linux-pm+bounces-42794-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEeeFzIAlWlOJwIAu9opvQ
	(envelope-from <linux-pm+bounces-42794-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 00:56:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D015210F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2367B30276AE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 23:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582C0330679;
	Tue, 17 Feb 2026 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J65r6F2j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567E284B3B;
	Tue, 17 Feb 2026 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372570; cv=none; b=n7+ZE3C9ct1ZPTNdebJwcPP5y+fu5n/yNPJCFngZRNpm6AewbtFeIdIrFgSLCpYaesi7lCNL4HLC3dPCD6is/hJN9QnMdUc5QuwyIE8IekcA8UHgq9I7H3sF9aKwLmYxdQgjVpEwkN9dlfrsxPbbLjoNnMEp+A6Nl0bv8HiPVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372570; c=relaxed/simple;
	bh=2QaOtwO0WjzERIW/q3ZeXgj4ztG9y2DQYGmIGAKPuR0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HpSm6cDg3+QTz/0n2GivVdIwYbygXDQ1K0bpVHpU17/oEuQcv6lcTc8uuFniqd0bUmz6e+NrQNIdAAQY8vTifIkbpVQ0fPv6Yf9TyfrTisG7/8vFND8Ew28ZiuDFj0Mbc+MEtHPHwHkAMGrdbfDef09KyWiq5JwBJoKO7HAwMwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J65r6F2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168CDC4CEF7;
	Tue, 17 Feb 2026 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771372570;
	bh=2QaOtwO0WjzERIW/q3ZeXgj4ztG9y2DQYGmIGAKPuR0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J65r6F2jNYk+UDlRfQvFUQy8NueLgfgpDtVqbslWlZsO1bifrliYQHxsA1n7vA+5M
	 6zLAWdoqONbFgdzJJ/ZIaPyHGp/yTC+m679bsTiAH0qBpet+ekQeMv+SNjGwlbkhX3
	 gRDKCfs6ujloHzcnhYzBZawjIFfkkYJBBK9D43GRJ7Q2TTrGpVU7gQIb07A/uMOAOd
	 MtfCkk8DMUBwnWhPZFY8YapJb3UzDwIuNr4l0/rEYKSZjWKva8g39QyHT4b+pSuQAV
	 qXGKHN4DqfFiyO11mrV+Un5gNfCyhmehxNyAjNsXGGu56Fv92QqObSGuyyiCpUVxSk
	 CcKXL/4rRcBZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1813806667;
	Tue, 17 Feb 2026 23:56:03 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat v2026.02.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKkX_A4++yaM54so4+Y0Pz87c362ggAbPo8C27r7gw+NHg@mail.gmail.com>
References: <CAJvTdKkX_A4++yaM54so4+Y0Pz87c362ggAbPo8C27r7gw+NHg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKkX_A4++yaM54so4+Y0Pz87c362ggAbPo8C27r7gw+NHg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2026.02.14
X-PR-Tracked-Commit-Id: 51496091dd37b405e6e399a9638da3f1da3f4c64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2961f841b025fb234860bac26dfb7fa7cb0fb122
Message-Id: <177137256175.743170.8887962698247021982.pr-tracker-bot@kernel.org>
Date: Tue, 17 Feb 2026 23:56:01 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42794-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB2D015210F
X-Rspamd-Action: no action

The pull request you sent on Tue, 17 Feb 2026 13:13:12 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2026.02.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2961f841b025fb234860bac26dfb7fa7cb0fb122

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

