Return-Path: <linux-pm+bounces-8671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ABC8FD9E5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 00:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0EF1C22AFB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE315FD07;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9UJzIR3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95885136E1F;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717626930; cv=none; b=tDjsnw3DlIK5jmsUVvC6so6QLouKrSkLxumk/oeFmFHxvOejcw0FEWKt1/mqlTpoItFjSKAMwpxmbEZLnUH89FQZu5sn47sNGY4C0HfmA58e0voQBeeimLZMYWRE+Dcm2w0LRmsXdofEL9u99m0W9FOTJ/vVcisKChqUszLqAOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717626930; c=relaxed/simple;
	bh=NFT78JEO3rOl4YBCn/qBwHrAdP6rpDirKY4cSPcVhn8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HZis6PdWBF3v0izygzLl27opGP/gFYaxe+XxHhbUBrQOGgcnnO5s2R+ijwZviM+Qsqel8I5mBLQUcf06XW4yeY/QPsqoUHZdBssR5skphmh91/JwsjPlF0hty0NVkVF3oOmZU8TAEcwVZfj+BZLlaW8g68H6lFwCugCpqPB3lHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9UJzIR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7619DC2BD11;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717626930;
	bh=NFT78JEO3rOl4YBCn/qBwHrAdP6rpDirKY4cSPcVhn8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y9UJzIR3q+eUFQj9/Vd3/2jeee+JyyPdceL+Ved6IiWZjYcdwKUlHvxK4D4obP+Sl
	 kfqvku9TMtJbSz6t+pCFDy3vbRSwHbv8vVarOXk8w/ZfaqKR6dnzynvjzGmU9+QIcc
	 vskaj1FgdZQ5CVAy5aiY0hqqOQx8ZVKkoV8vNifb4eQ+qg+uUfPOz8FHtv95mmDGqv
	 cGvspskvjJQHJ1e21KuqlAveobTmu3uqCK/d5CvnoD/rhIxYZujHf7OfAOkJd3/rgA
	 sf3U2QIqqTIGTEec5BzpA7P6OWwiDvW5BzXQVY1Ty+7KmSRh3floG7JJgIjHbsGSJR
	 NSAIMRemZVHlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F2A5D3E996;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j5oMnhKttGUxwxAXWC8Q+_0e6HUjTFCumk8WLk9zNRRA@mail.gmail.com>
References: <CAJZ5v0j5oMnhKttGUxwxAXWC8Q+_0e6HUjTFCumk8WLk9zNRRA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j5oMnhKttGUxwxAXWC8Q+_0e6HUjTFCumk8WLk9zNRRA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc3
X-PR-Tracked-Commit-Id: 9b7e7ff0fe44bc6e571ecddbd76fcea7498033c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64c6a36d79a92f9ea22c470a52e4692db660d955
Message-Id: <171762693037.28636.12041999631195038466.pr-tracker-bot@kernel.org>
Date: Wed, 05 Jun 2024 22:35:30 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 5 Jun 2024 19:57:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64c6a36d79a92f9ea22c470a52e4692db660d955

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

