Return-Path: <linux-pm+bounces-33423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C4DB3C0F9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A8D584670
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087BF3375D5;
	Fri, 29 Aug 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xah9DuYS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24C932C32E;
	Fri, 29 Aug 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485574; cv=none; b=ntssr0LewsfiG63dFIw3j3qQ/b/MwNuNP02ulesbZPTDKymfxvjB7Rvjlf0AnfLSa7fAk0rlD3FbZmfHai3BPGyF3pkX77kyx3eYgoz1cJ+F+i+qSYAqogAEnP+SaZ7WNcet1AEkWEsTYeYCZNHWRayP1PjURMxwmsoTixrhkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485574; c=relaxed/simple;
	bh=fiXcohnum/ljLSi2Ha3U37GVm8rvwLfOz6D+1+znAD4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FD5NbSSL6QHdrimK3u6MWsYPvTe8jgVZuJRBj7z4Dijvj5nngmt877CmqvjMehG6HKTgbw+bV7tKDJtNLDSOj7n4aoqS4HQ3QopMDzRcqhBs4PDcLFIQLgc55MNyn5INok0dFK4M/ihwm7aFhtOetxV+Z6TWNRlUbxDpUtZckr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xah9DuYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4950C4AF0B;
	Fri, 29 Aug 2025 16:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485574;
	bh=fiXcohnum/ljLSi2Ha3U37GVm8rvwLfOz6D+1+znAD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xah9DuYSPPss96Fae6gOF866ZDTTp0+rZdm2sEB0UxD2HOW/iSc3SSJ9Z0N8o95xg
	 EsDKjQ6ikyIIYt8NDHFPYlzk3fR6ju53zRI+Mnkmm4sCBsvkvmv5Q803qEgmAFSXJn
	 djlqM4JkdpoA2/uO5J/3AmWd4hiNHDGs/DaL+NTM/Lx11NBq6W8rmXvGhg27qdTNUP
	 7aNP8o2i5EJMox8ot/hnUt4IhTCivVfPV0KqQZIc7moPIqXaow0aRO80nPnC2uE+6b
	 H5UkVQcP0SNYaJ1pHJ306gDSbWbUwrLZteBhZlDQiaDq9n/tWcruN7/Fx4Qz0nLPuD
	 lRCowQe9kGzwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0D7383BF75;
	Fri, 29 Aug 2025 16:39:42 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i8kCoBSOd8=-SO2WR-b1=zCC0jGHgDOq-LrnHixGjudQ@mail.gmail.com>
References: <CAJZ5v0i8kCoBSOd8=-SO2WR-b1=zCC0jGHgDOq-LrnHixGjudQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i8kCoBSOd8=-SO2WR-b1=zCC0jGHgDOq-LrnHixGjudQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc4
X-PR-Tracked-Commit-Id: e246518aa24f1460902725e97d0abf574aec6ade
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa58e4f6e1a410fc06fcffd84b38b61426509605
Message-Id: <175648558140.2275621.14824617819436404660.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:41 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Aug 2025 21:56:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa58e4f6e1a410fc06fcffd84b38b61426509605

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

