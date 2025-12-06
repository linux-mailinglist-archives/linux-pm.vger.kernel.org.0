Return-Path: <linux-pm+bounces-39268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2707BCAACA2
	for <lists+linux-pm@lfdr.de>; Sat, 06 Dec 2025 20:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A11308D5BA
	for <lists+linux-pm@lfdr.de>; Sat,  6 Dec 2025 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC66C303A35;
	Sat,  6 Dec 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZjv6B9v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A42BEC45;
	Sat,  6 Dec 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765048022; cv=none; b=fIR3fXX5X20WJVHM9JPw6f9p5iCzNyNzIoa/6VygzGmg+P3TJcCaoi1m2t1UI9Sp4vkdvAGGFDpj7HCEr5M7r11A4rPyNViQ8KbkTAI1vFztfJ2C9h5oWq9OTIzdslU8D/aqwZrjYSMMnJO/g42A2b8alcG41GuvoOON5rX0tnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765048022; c=relaxed/simple;
	bh=qrhhcKcNBfVXQT4eSJlpNHbUO9n+c3ZifsCeZcpf+l0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XlfUSvaoSwOgczQrTVcQFGlVH/owNKojqmd7J11R33xtSOup9l7qNLCt4McE5x9nwvX9QgzoQpYC1kGQDLSA6SWh2qu/NmBPYtzeb+EzwZeEk8T0duNgI8k70bR58LUiadskasc/qrsEG/kxWhGH129Onxi5OfLaRR9jhggRtKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZjv6B9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54973C4CEF5;
	Sat,  6 Dec 2025 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765048021;
	bh=qrhhcKcNBfVXQT4eSJlpNHbUO9n+c3ZifsCeZcpf+l0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PZjv6B9vrvmIyQQJ5bsnxAi1ampdL81fQqwqWjEANWeuJ5RJ0jBZegohkArg3KkSl
	 +Tpogv1gJXOCDpcltC72NFXIz2JOXMum2naGeEEefKeAmZA0Ae06n3LPV4dLLjQNVO
	 ATKf5drsewp1F/ipHd5iXi0hShVLlcT1kpNukFbWoMl4uV0QFegZ6nC6GhUde9NjcU
	 T2NF12I3/y/8MIfgrbe9twidqQSKG1cPyppM8fFEJxilR1dRlBoFpYHEFbqwwu50j0
	 +fWqWBVZ8avCcWzutMRSe06RREUV9/HSXpnEE/C52vz2p+KEF9QjH6wDeGp1QD8kQk
	 s5Q0akuHG3/Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7870E3808200;
	Sat,  6 Dec 2025 19:03:59 +0000 (UTC)
Subject: Re: [GIT PULL] utility updates for Linux-6.19-merge
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKkNX-iyB5Zuk+fRQCaihXSkdZz19FsvB8wD8H+OGw0hzg@mail.gmail.com>
References: <CAJvTdKkNX-iyB5Zuk+fRQCaihXSkdZz19FsvB8wD8H+OGw0hzg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKkNX-iyB5Zuk+fRQCaihXSkdZz19FsvB8wD8H+OGw0hzg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-v2025.12.02
X-PR-Tracked-Commit-Id: 9c0bad7508a81110b3216231bde2a10baf7126f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10003ff8ce7273d1fe045d63d1a5c9d979e3d47e
Message-Id: <176504783795.2170003.12454129453307062336.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 19:03:57 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Dec 2025 10:46:13 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-v2025.12.02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10003ff8ce7273d1fe045d63d1a5c9d979e3d47e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

