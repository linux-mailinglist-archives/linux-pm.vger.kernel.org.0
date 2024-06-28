Return-Path: <linux-pm+bounces-10157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57D91B427
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE41F22F8E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1318028;
	Fri, 28 Jun 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKQTgQyr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1317BD2;
	Fri, 28 Jun 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534955; cv=none; b=HVCIgrBQv4hBgAGIWtzje9sZzgxFXTPSk1PrSJqkIm1lUThpsCC7gW4Cekb2YKmtytwdZ917QQtSqSgcqWZA1vou1iEjAVuXuwR/hUQot78oJplZZsz9lYVVByKGnuTszUu8m1igRHf7NdM+eyqcKkiA1G3rJwmtGHjJG2Zbwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534955; c=relaxed/simple;
	bh=LVyw2iNm3RbgqMlnP9eFW8/6FWEv6tUv1Zx32l1n2ig=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fs9O3vfO7FQfjiJUfJZMdYvF7q9xAvfg4uqE5PmnLs2Rup+8vRjrnG5u5hoi9gDdZ3UyUn6Gpjo9SQVwtS0tZoVVTKMKdZJcNrSxaW8oBqjPQDF3tx20R2RsSxu8RlFixFloVtaaNsWn09hOXqGhFfb9qLpXfR4dGsbomg/VDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKQTgQyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 080C4C4AF63;
	Fri, 28 Jun 2024 00:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719534955;
	bh=LVyw2iNm3RbgqMlnP9eFW8/6FWEv6tUv1Zx32l1n2ig=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nKQTgQyrGnjdGJuw+RR0Xbx0VHxLYKyK7WefbRxPOGZa8KI4JRX/NRjaF7sp/Jvqm
	 fYWPfttRQ+6mnoBmSYr/k0FBmihM69z158dSy3iaztZxBYQRofW2s8KfCT/coXKt0d
	 VsevYf8o3dQi9W89nPIv2rhWFTbLUZVtDvZ3hnMKsn4ydTrx+RfFCWbLhlveQdKeed
	 0mTqjw+ZNImqtSm4lgQ8FJpWsa41VlG7mIxG+3/qjPaEycMyuoYYpULzvu1+XsDrsJ
	 iUeWFOFh0CReM+WxUU6dd/CD2xE5Ry0/QZSWLeRqF4+yyKKOktObKwoSAPCU3VUafC
	 /W7NPp3XqgCAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED8F4C43335;
	Fri, 28 Jun 2024 00:35:54 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jM5kFeijcSf+UrCsX9L3mNY-p4FQ880x7theVX-ObCEw@mail.gmail.com>
References: <CAJZ5v0jM5kFeijcSf+UrCsX9L3mNY-p4FQ880x7theVX-ObCEw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jM5kFeijcSf+UrCsX9L3mNY-p4FQ880x7theVX-ObCEw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc6
X-PR-Tracked-Commit-Id: 529038146ba189f7551d64faf4f4871e4ab97538
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92572d2c08e00a31ddd5d5fe2432ffa59b157238
Message-Id: <171953495496.15056.10267375805313474460.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 00:35:54 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Jun 2024 21:12:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92572d2c08e00a31ddd5d5fe2432ffa59b157238

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

