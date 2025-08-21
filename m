Return-Path: <linux-pm+bounces-32840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02243B30737
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E46621E01
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D5352FE4;
	Thu, 21 Aug 2025 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH64e3tC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9821C167;
	Thu, 21 Aug 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807991; cv=none; b=kmSkGIBZBf+cHiZfCj3OYvYNoap54OmdwNx6ngouu4Oqs0t7vDL1LEa4AiJJIF7Ya/zA36FwB5O1Z6HlOpgYUZ05ErAeVW6IYESszT1gCWuK5ELnhQHf8CjTdH69zgYHSM449PrvCj6usoIb/QCYz0AbSkdeHSrKOjgo059VoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807991; c=relaxed/simple;
	bh=IULHUZym/TKFS13x9IJcyXR8NUQ3kXmJT0C6K9wZEWs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=prUH/wf7DewqStIzjYOM3qC1Q06rOr7PLWnp4q2KWvzCTlYrH1RKuhNIg/v6aJopxN/5iLjt6dlJAJyCRNvtovSFzOspqOgQAT1L1LPtpCwcFhKHVs4gXZKP5xaGQmhEZ6AX/H9LvwuiBy9qZvOxa7rjlgV7wbMp5cd4WpwcufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH64e3tC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C13C4CEEB;
	Thu, 21 Aug 2025 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755807990;
	bh=IULHUZym/TKFS13x9IJcyXR8NUQ3kXmJT0C6K9wZEWs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aH64e3tCwLwcwIqrYJxfgsFXDEwdjjubOxJqm7kO17wpY9JF9r0Ut7aFRixejs+Ce
	 a/BcSqnU0671jI5OXb+1hxxn/Vx+/HngikVjFxRW2NX8zHaleNym2SnjipNP+JXSKM
	 T5rHqg1RC4m8HVaIDTNT+5l+l5qm4nMo/BFsP/2ctB6utAXiaCzyA+ZcpzqO/W8ZK2
	 TD+tZ7EebVKy8vHVRsXMRjgOwj8PocyltIx7TfyBRActifXMx7Xt+bQZ5aR37/E2n/
	 siwDNP2t59wtUWLTKj4uLaCo2NmbiTK9g6DFHhtinOztwplAE7up6E51G05j1BhsWs
	 5KLeIljhQFjxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB90A383BF5B;
	Thu, 21 Aug 2025 20:26:40 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j5RTsyryCuqwT0G=0F-eY_ky0HXsXp2kEcCGggFe=ycg@mail.gmail.com>
References: <CAJZ5v0j5RTsyryCuqwT0G=0F-eY_ky0HXsXp2kEcCGggFe=ycg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j5RTsyryCuqwT0G=0F-eY_ky0HXsXp2kEcCGggFe=ycg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc3
X-PR-Tracked-Commit-Id: 094a7c318b29ca792fcee28e448da1ab6627ccea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26d6ed49cd008a326063d82bd731c2a82f2f4378
Message-Id: <175580799953.1187953.1380523403443929894.pr-tracker-bot@kernel.org>
Date: Thu, 21 Aug 2025 20:26:39 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 21:09:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26d6ed49cd008a326063d82bd731c2a82f2f4378

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

