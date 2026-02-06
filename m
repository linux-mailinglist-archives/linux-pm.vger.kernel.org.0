Return-Path: <linux-pm+bounces-42242-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMBBBPt0hmn/NQQAu9opvQ
	(envelope-from <linux-pm+bounces-42242-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 00:10:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 698471040E5
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 00:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5EED302C92A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8530ACEB;
	Fri,  6 Feb 2026 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/7s/ocr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D81A9F82;
	Fri,  6 Feb 2026 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770419389; cv=none; b=HpWGstq56tnDW3ZXwdh7q29zBZl8wuetkKfrhKjqc6bGkBYVb2AumJCTgdkDtKolz6+e7oppesBk4oyhhOoc4kcsVFUfj9LMJVtMkwr/GoSO0UXW10Ih94zmMTNf7jPx8Pf61Wwi1JkmzGTgAeyQs1PSWGmQBiVmgItXr0PszjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770419389; c=relaxed/simple;
	bh=vyqHlPcIjJzfjfUclMOSj5CAGDDQYLSQb6hr9O6C4tg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ahLk/gjMqkPeP9G1w1aFNZB7i72DWUx1FVJO9tHsgFiVI2495dbeaMaNUcxnx7sLh7Vw6bcIGfawkBRgI5SE1vJ/OxNwSUF8OCQFrw0mQk9w82WOUxkN5BkWig7EIvMMMXx7A9EifJroXSokZaxvxX68JY77ehtOBMyFxhQBnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/7s/ocr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5CBC116C6;
	Fri,  6 Feb 2026 23:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770419389;
	bh=vyqHlPcIjJzfjfUclMOSj5CAGDDQYLSQb6hr9O6C4tg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J/7s/ocrhVq758pfRLOV1vWxxtyoVXM/JUO5tDRHFoz6u9dIQSfgIu86xs7+3hFO6
	 fhtwBO0B79e3mXTxdMAAy4C8fQ4sCACjcG46JHEdIFIqcTk9CHkOkZZWJWBbhkGTyr
	 u1RAmCZCTwTIsK/Mlig38laDtzsOhFCuxC5KvwVxTKEqJVta54oodPgro/PsZA0T0y
	 IQR+7dmBMoH+S0TpG8SIVCGX59zoepPryFhWEeVNrCMQlNFdf+8FCiBm77JtyEjHkE
	 NdBpwV8Owc3RROqCo7OFAM5ENjkgkcDSIdU4Z3pZ6ik3DQeepvNTO5ppGCORwhCKCz
	 D81SCq25MDZkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8553C3809A17;
	Fri,  6 Feb 2026 23:09:47 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.19-rc9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206110555.539300-1-ulf.hansson@linaro.org>
References: <20260206110555.539300-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260206110555.539300-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3-3
X-PR-Tracked-Commit-Id: e2c4c5b2bbd4f688a0f9f6da26cdf6d723c53478
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dbc3577107008883a9d4275e4b67cd3b4dfacf5
Message-Id: <177041938605.1109628.5377895406191503833.pr-tracker-bot@kernel.org>
Date: Fri, 06 Feb 2026 23:09:46 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42242-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 698471040E5
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 12:05:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dbc3577107008883a9d4275e4b67cd3b4dfacf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

