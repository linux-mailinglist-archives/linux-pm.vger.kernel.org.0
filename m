Return-Path: <linux-pm+bounces-10201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13791C447
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0AD1F2301D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ADE1CB32E;
	Fri, 28 Jun 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OagCDvRZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3BA1CB327
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594065; cv=none; b=j3gzE+LIbkH/r269dIwoz34u31m6Q13+ZAJyN1qx6cdqq8XYaDOTB1UTVMZOXnLuf6LpaKbY+GxUcgPJLr/uHVr+QXOd6IptqCeNAdTfhbvcgOlGduv2dnD2hdSpyENLi8YT0mxxczJqjxYj8cqZ098KK+MvnrjAVgyIfnnc8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594065; c=relaxed/simple;
	bh=em+l1CcFkji2wXAgZpviYerEoQVg2BbEEAG9SgjTLaQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lUejYQsyCVQQHN7TIdzYykiueHYgez85wzePHN2YOLNwstlAe8MSdR9Oi5nEDtcUZpm9ldFarepOnkBvEtU6Us5dopFWeYXWRA54o3/sMsJ50VkdLkD9OMLt7TByw2g5DHUQBqfHrZBveX3t5OQbjC9EyJL/n7lrBSOrzH8BnrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OagCDvRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03CE0C2BD10;
	Fri, 28 Jun 2024 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594065;
	bh=em+l1CcFkji2wXAgZpviYerEoQVg2BbEEAG9SgjTLaQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OagCDvRZ8j/oiV3k5s1duDNW7uTre+pwZkMtncy7NU3yPvxZ/mwEq3JchnCF5cusb
	 0n08cc81knFwb1uebTXsqHgj5UsR/83E7dOT2nzoTYz3eq65Hli9iDJbikJ2rtQd63
	 bXXU6MvGku09K607Mol65PsBMLmzqLygcXXbJxhzDaVqGHOu4nMgvraj3ytwsfgABT
	 sElpuy+7jiDDIdtJA1DGNOVQoHQRl46YxwF71iFxkJm6hynBrogquk09kHM0v9mq8C
	 cPzi74oKJQW5hcVx0lpjjVlUbVeFhxfAYV/JD+AtABvy5mq52W+2sqqfZ2dDQ4fO4t
	 105D3I/m7HhhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E86F2C4332E;
	Fri, 28 Jun 2024 17:01:04 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat fixes for Linux-6.10-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKkkG-xe30hMorCYzmB-gJAZ5Y1ugQPs8ma=8b3DHGm2Lw@mail.gmail.com>
References: <CAJvTdKkkG-xe30hMorCYzmB-gJAZ5Y1ugQPs8ma=8b3DHGm2Lw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKkkG-xe30hMorCYzmB-gJAZ5Y1ugQPs8ma=8b3DHGm2Lw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/v6.10-rc-fixes
X-PR-Tracked-Commit-Id: b15943c4b3351173d5f3b0d87362d2994a89bb66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 234458d049b81d27e76410360a98dc20b295d064
Message-Id: <171959406494.14402.18068472219631821032.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 17:01:04 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Jun 2024 00:36:53 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/v6.10-rc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/234458d049b81d27e76410360a98dc20b295d064

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

