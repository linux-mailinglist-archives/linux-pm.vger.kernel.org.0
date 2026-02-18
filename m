Return-Path: <linux-pm+bounces-42835-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGF/JW0NlmmNZQIAu9opvQ
	(envelope-from <linux-pm+bounces-42835-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 20:05:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B796158E2F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 20:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62AD63008265
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A09341060;
	Wed, 18 Feb 2026 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjvIsyB0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573C258ED4;
	Wed, 18 Feb 2026 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441512; cv=none; b=EL/P5ve7eAwEztLwk6G9MVtDaaZL64rIS4nPEuWUtrVmsxN0o6dmRrXnmVK97ZLnqEBYxmcQFpbwEV/srZTsDPQr1lUbKcRl4BU0Ac7h2blc5dXfAhuUykzk+KW5KMPIe/BJeM4cbtVWh4jq9nIx0YiKf2+9oipeWUO5PNkUULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441512; c=relaxed/simple;
	bh=dEJWv2gJYTHajdyWfvb9LhUDZWad7Eo8u/emXeoT0vI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XAA8o6x0kl6qSVBUHIg4XkFB1BPFkFpkc19J3zex/Wv+1Tv0ptyNBnF1FcBlO6ILyL2IogyhXwx7SZwSG/9JojT6z2ommnZCOJvkVjAKLjMzrveB/+0AODk2/8mHeRAiWjqPdZ082jVeatvZ+r3WfD5SDn4fMBbpQxWiFzMjOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjvIsyB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73831C116D0;
	Wed, 18 Feb 2026 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771441512;
	bh=dEJWv2gJYTHajdyWfvb9LhUDZWad7Eo8u/emXeoT0vI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YjvIsyB0vq5B7Lt2eXXFnH5Mqew76vRsEukkgfX4EylJfBXmSsuYD+1s/kuItQ45C
	 4IDsKU6qfn6fNxzIzXiip7e+mOGppgWGi4tp1R9EjNPkr13bOOtGHmfxoP4pNaOikw
	 TAdtnt59XJdtZO9M02C5nASSPP3RyixPaXl+66jIj3WNP+lXHmExhyj7a/twQUtNun
	 8pH3G+LFQm3JF6Bob9hjuKTIKqD6ZApDcGJa+GzQ6H9XsuiIduIAr9lKymJOyuzB73
	 RHKcMnJtJNDTxdO5FD9ySrBpC293fVIn/0gKbrUQuj19z5V4CCgTF8O/kAvCZdutqt
	 imIpwf+nqH11g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B48A380CED1;
	Wed, 18 Feb 2026 19:05:05 +0000 (UTC)
Subject: Re: [GIT PULL v2] turbostat-v2026.02.14+AMD
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260218054436.705622-1-lenb@kernel.org>
References: <20260218054436.705622-1-lenb@kernel.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260218054436.705622-1-lenb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2026.02.14-AMD-RAPL-fix
X-PR-Tracked-Commit-Id: ef0e60083f768b32cda17b1b0ca9519405db89a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ad54bbbc9c512ba3bc90e4368264bcf15c25759
Message-Id: <177144150371.1508448.10169846904300633550.pr-tracker-bot@kernel.org>
Date: Wed, 18 Feb 2026 19:05:03 +0000
To: Len Brown <lenb@kernel.org>
Cc: torvalds@linux-foundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-42835-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B796158E2F
X-Rspamd-Action: no action

The pull request you sent on Tue, 17 Feb 2026 23:36:51 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2026.02.14-AMD-RAPL-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ad54bbbc9c512ba3bc90e4368264bcf15c25759

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

