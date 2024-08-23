Return-Path: <linux-pm+bounces-12846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CAC95D9D4
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2024 01:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FA1284224
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 23:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B87E1CDA1B;
	Fri, 23 Aug 2024 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js5mppXJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1E1C93B6;
	Fri, 23 Aug 2024 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456727; cv=none; b=XeiMoYmBh0mtXaXLzyIyhVG/RMiM1YCOzpWPEAtkImukVvUQG/G0U/IA62acgjLIDxYauT46+ewqE4cVa0MvgIYeMZRLc/1FfN3nNSXEYbxeKrbq5N2ziyyY/WWYsijpzgMEyZ96x5FizVi4SWdewO20mr8/4kv/calUoN2y2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456727; c=relaxed/simple;
	bh=97RkvVqDiquHu4el9jIWCYXwt+vCyE/hBiWybFhjUqc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rviCRZBZA3zaUraKfm4TG32Ut9WPjxxLUT1ysB01yeZmnm8kiMLygeoqeSJERzVJZ1AnAjeiNnctolJar6CNqFdWgdJ1kNVgEwomFaHykV2252qyjRf6GnII6S1nXMT5ZQgamFXtGth/VsgAgVnf79lTeD9e+xCw41968gWlCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js5mppXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F55C32786;
	Fri, 23 Aug 2024 23:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724456727;
	bh=97RkvVqDiquHu4el9jIWCYXwt+vCyE/hBiWybFhjUqc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Js5mppXJpgTcD5poMdRrwwmN5bmorjt7mpsjBU3bNcpKrhn1gARvxFntFcdjI0cnY
	 lWg4bGjeW8UG8VacS8VCmjQIXqwoQOmdMbjCkHYXNsEqVqVeqLwd+DRiX04vHOFJwN
	 6uPOOVAbD1V6hGPF22rj1hu84iVvV9TJwojY027aj1p2nZsHmIE9hxbBNnIX4VkalO
	 E9dYdFjGCHH2J9X2M2i6S2b0IaHt2FKMpCu1C0hG3VyUkoP3rBIEp1i5sU0x3CEG5V
	 wouM1rRc3LyhM/6YMZdJxrQLVha6xJ6lvdzgQWbDQ4NzewZZLlf+E0qzSFe6Yw3voc
	 d7lcGbrPfZihA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC13804C87;
	Fri, 23 Aug 2024 23:45:28 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hKYgjNEwQd+veUh01goACD4L1BWAsj7h-=4NCfFwRN-g@mail.gmail.com>
References: <CAJZ5v0hKYgjNEwQd+veUh01goACD4L1BWAsj7h-=4NCfFwRN-g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hKYgjNEwQd+veUh01goACD4L1BWAsj7h-=4NCfFwRN-g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc5
X-PR-Tracked-Commit-Id: c0a1ef9c5be72ff28a5413deb1b3e1a066593c13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ae4e48b67eaf8a140ac3a6f0f8ea2627a174aca
Message-Id: <172445672681.3112782.11591599052022145162.pr-tracker-bot@kernel.org>
Date: Fri, 23 Aug 2024 23:45:26 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 16:31:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ae4e48b67eaf8a140ac3a6f0f8ea2627a174aca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

