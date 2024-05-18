Return-Path: <linux-pm+bounces-7967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8FB8C9257
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 23:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C903D281FB9
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 21:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743F44652D;
	Sat, 18 May 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq4dj0TW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494496A357;
	Sat, 18 May 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066367; cv=none; b=T8BGme0uP+rWbMJvbqV0eS/GzBa9glzd4K0BdGckqyed9A7AzVA0OTZhpc09SPg0Tnd1pTl5nUXcl+DjkzOKjFXYsKKd69z2YH1Q4RFOnN1lKPBD3903L5lx1+/esoNxAtJ7UubAa/d/JJUHf+DvDNFnrRvXcUb/OHMmHW0FEv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066367; c=relaxed/simple;
	bh=wx8pCTgtDNQR/Nc5SLFJVRegbdhAFnErIl2kEEKaAA0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RlZXG8b8KadyJKvpHevSP3dm1QEo8YVBu6buP4WtjBfDQn6y8vN73Bfb2tkydrN1xbr4T/AJrR6+yDya1rYgxCfU80U/L6q4Yi0GheziD91gkVcU9eu0OVmKE9Jj49x00Gmygb2lRy0fI1R672vvRs/WSTxBI2RAOw//4oDnuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq4dj0TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEF4EC113CC;
	Sat, 18 May 2024 21:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716066366;
	bh=wx8pCTgtDNQR/Nc5SLFJVRegbdhAFnErIl2kEEKaAA0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bq4dj0TW5i0PbnFyPS7Oehw5H4dd5oY3u4X1xJlZ8lsim6m52hk4S0k2AOrFQdp/U
	 O+KcaPBRil31rzepVCA17BsDjPO41c/uzlNGj81SrP6W8SND+shhzJGqHkuboPcrwg
	 z74Uf9oXIBUJySxdWCm4g2Vai9/wQOApx4GvUwGnpWFYRQPp5XMwBRyD+pFtbKg988
	 Q5eOU1ow2Iovb9TK9d/tsj8v97uGGUM/XKJ9gWkFi4Cbz7cLAQeo0u9MDXjLU8gqta
	 YUeFWA51FBQAJNK2RHbPX7+Hkprws53NXHVW+B+PWZPq60Ee2ABjoQCLP+dpBhlFML
	 vKHfU/sXEtoxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4373C43336;
	Sat, 18 May 2024 21:06:06 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <cxfqbs4vvzniebbpvajkymvjfztst75z5di6dvuk3gyvyiodnl@s5phlkjujcon>
References: <cxfqbs4vvzniebbpvajkymvjfztst75z5di6dvuk3gyvyiodnl@s5phlkjujcon>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cxfqbs4vvzniebbpvajkymvjfztst75z5di6dvuk3gyvyiodnl@s5phlkjujcon>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.10
X-PR-Tracked-Commit-Id: 55f7073f6f59ef2c9e98b70f74118dba62e1aabc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85d46148f8a07aa80199e52a2755304a27837caa
Message-Id: <171606636673.2260.2111975263747141124.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 21:06:06 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 May 2024 18:05:00 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85d46148f8a07aa80199e52a2755304a27837caa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

