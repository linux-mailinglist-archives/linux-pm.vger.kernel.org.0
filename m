Return-Path: <linux-pm+bounces-15553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F69D99ACC5
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D167B27ED2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34E1D0DDD;
	Fri, 11 Oct 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNJujq/I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388871D0792;
	Fri, 11 Oct 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675245; cv=none; b=EFNzx7aabR8JRy5VRyB+55+Hwxg4EsOGoAk+blZYzGbMvFWja8XD22jSSFCvLjpEcNiYg3EioTjQ9Ei6hCR7poMsJPn6DL5a1JOltLXxQ99y8LSecsuhWsWcg92vjKAsH33Ky1ENKCQH+qgtO6YfyeewNqDA5+2HZ6m4QOlOMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675245; c=relaxed/simple;
	bh=LrnAHHjKrMaPENPKvLAaiHFvMZLfT+t7KEC/PNq+bWc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xv6tfeEMPjpk6f6J03py+bIlYQ+gY6f0fGLsLT3U4cYuizrRCSFLctWzaMAEqZ8gOMjUETMvrhXxeE2TtbZOk0EVqyGaWeQ/YTdfnkEdti92KWRgm4A7SR+dGR33ULBi9+5KM9PKFjrT8thfXEX262ElhlorNaRkWeRHA4LSFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNJujq/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD33C4CECD;
	Fri, 11 Oct 2024 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675245;
	bh=LrnAHHjKrMaPENPKvLAaiHFvMZLfT+t7KEC/PNq+bWc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hNJujq/IsclNToWPaF6CTL02LxDGfOYR94D71nDNuIkooixXyK0FDVPKmDP2LKTpR
	 /UfaG6q3CqAKRUYyPEqejxeAy1DAfjYlbZU6efaIkKCuuIvYuNDAzDiFA6x30fuhoQ
	 F+RR31RH8/mJp7mtSJcvStj5OSBDh2VEafNNDnSeKkNYOQ3aRtgQeNgDlF3I8JmUeZ
	 C3UZTNEswwFImBij1ybYnDbgzsWSEPFJUdJdF/NyhWruUew8FT4P4fTOGuklfTst7t
	 DRfiPYy8oXJA7fz5wSlrvOPFCLX7+1f9wJEA9mG5KsPsOBBO+GftMbTXMvaJZ9wEOm
	 g2rwkuoV43gpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5AC38363FB;
	Fri, 11 Oct 2024 19:34:10 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hRoN3qAgCi6sZzUxyk0oeiRAB11d6QoFXm+YvxUT79NA@mail.gmail.com>
References: <CAJZ5v0hRoN3qAgCi6sZzUxyk0oeiRAB11d6QoFXm+YvxUT79NA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hRoN3qAgCi6sZzUxyk0oeiRAB11d6QoFXm+YvxUT79NA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.12-rc3
X-PR-Tracked-Commit-Id: 827a07525c099f54d3b15110408824541ec66b3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8fafb690b7c2dfd6e388248a817fd7d1fd2420f
Message-Id: <172867524956.2975359.5071470135961838356.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 19:34:09 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 17:38:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8fafb690b7c2dfd6e388248a817fd7d1fd2420f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

