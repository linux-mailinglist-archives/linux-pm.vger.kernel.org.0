Return-Path: <linux-pm+bounces-38318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A454CC75FCD
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 20:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B5EB928FF8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15A368DEF;
	Thu, 20 Nov 2025 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDGnowUz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5452368290;
	Thu, 20 Nov 2025 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665255; cv=none; b=m0ZWYBEi+uTWe9WUg6+pONQFNH2h1wjsVWCnpTsj1z0xfPAvLtHScb8FdrJ3szI+MOjqwP1ECOmfyQ+jXg01+jbqLOR3OgXEpWXvhyX/VZeAUxrBYnmYUVaU7QeYRlt3aUgrre9z5WQXUQ2GS1VGwC+2XVysHH93006onDhLoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665255; c=relaxed/simple;
	bh=xYbXDA8JNmhuGHnnL0VOsTukyz5ayvAp59xS2UoeXGM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CWWXaibhoHUJe0qN6vY4n0qV4lxLHjHF7r9fm2p3AUy959Yn0YIGusP9mAeLDO7fbEXffNPRJaggbln7LBki75AwXtTpcrbDWWgcKi8CVBvwCTg1gehR0iXCGL2QqqafvTXnlgiUoIyceeviw2HdcjpwW6hHNxFX46RGLQluPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDGnowUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C71C4CEF1;
	Thu, 20 Nov 2025 19:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665255;
	bh=xYbXDA8JNmhuGHnnL0VOsTukyz5ayvAp59xS2UoeXGM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PDGnowUzgAWQIOy49ZPy6rLzmzGgUkWf5Bo/uLOIwQbpgWq2II8jwbTsbW9DwQllb
	 jZrww+R+O/JwvzJls57eP8/00Tpa8O1G+v64jZGw3RQniG904ti+EFoAEFHIW7bnW5
	 19fuoRs7ATUXQXXx/8gsL0GxrLtd6UIbjtQoutJBskWqwzy/iQoF2xjolRVtI6kc3u
	 Y5XnQqsAHoLBrhYC7SEQW7XBemfSTGRAjNoEe4dJnhnuw4axnuqmUC+Je1z0iIHcd1
	 +Kb9ACcBwmjg/LibmD7KTkwsfY5iIcbtitG4vFLaBxeC3rNeXkxArmv8dKQ7cqlGBw
	 6Y9Bd16piRSKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCA63A40FE6;
	Thu, 20 Nov 2025 19:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.18-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jXFO_vQUz6E1LsKdR84NfCb-+nLjGzpJ8sZmt_QcP0Zw@mail.gmail.com>
References: <CAJZ5v0jXFO_vQUz6E1LsKdR84NfCb-+nLjGzpJ8sZmt_QcP0Zw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jXFO_vQUz6E1LsKdR84NfCb-+nLjGzpJ8sZmt_QcP0Zw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc7
X-PR-Tracked-Commit-Id: f384497a76ed9539f70f6e8fe81a193441c943d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07e09c32330c5ad2864b2d52ce6a33e1963ebfcb
Message-Id: <176366522065.1750999.14522053561475130354.pr-tracker-bot@kernel.org>
Date: Thu, 20 Nov 2025 19:00:20 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Nov 2025 18:26:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07e09c32330c5ad2864b2d52ce6a33e1963ebfcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

