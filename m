Return-Path: <linux-pm+bounces-15159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEBE99108C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74C2B2BF79
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04A51F8EFF;
	Fri,  4 Oct 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQkyKSWP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E21F8EFB;
	Fri,  4 Oct 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068656; cv=none; b=DmnMmPj7HQ7sLj0TLmIs3t8jnEwCUFa51ubiKEVVqVb4q0LZVp/1bs3YzU6OiCUOaxm5pQaj2H5LcPFCFJQFBIBV6ro+LbuOaBUPJOH0FkI77PWRm6FwTmLKf1WQ4UgkY03r8zdM177sbuDlB/E2CDEvTdeRS1Wa9LJoBNU+q1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068656; c=relaxed/simple;
	bh=1Uz1Rygci5ySms7c9LxIskHBT3XXjGE97Qiyw9fHI1E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cg2IltCW48gs0ns5kCJExuTdePlBF7RsBg4nJPJuyTs9QQNTrjZHgwMRq+/VonaehESYFm54hFUQHEn5lxlGBwlsvrILX80KBmqFQdqQLIAmKIEiWT1oHORrmCJ0eEXurUKADz0rBDjOqwJxjIbtFNmXwJSzJ4n8VMzJVf5Jk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQkyKSWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979EBC4AF0C;
	Fri,  4 Oct 2024 19:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728068656;
	bh=1Uz1Rygci5ySms7c9LxIskHBT3XXjGE97Qiyw9fHI1E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RQkyKSWPR29ZrQc72MquZsUnScJEsNcj17I79M8VUOydRRbZ/yAiKcBNficsDkqnI
	 tZyvZh7GpmZ2Qf8mCXfYQ/rjyicFiE+fCRKJFfmAh8RvugzdMZMun2udmr/682qb8K
	 ypd4XxCdLdF5iJ74nad9GYzPCcq0yk6o7wdvI6RxtT3DvBOIYo/lI/5bqYf+8Xck8Q
	 dFi6diKFwh0UCPYUVWSxrKdSzjrZq4pj1x63yEToQoCDnqgW9/95Fm4Rfcost0aNr5
	 /G5gh8CAYcQoxA5fc69XKgPevi8IiuA28yCGJiNeggYl5FPEu5mXK1Q3imnMS0oK5Z
	 eqU9NzYst3oQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBC39F76FF;
	Fri,  4 Oct 2024 19:04:21 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ivLPtX6F3Le9dR6sh+JLHcP7NFVuZpB5ZU8cXz6EcWvg@mail.gmail.com>
References: <CAJZ5v0ivLPtX6F3Le9dR6sh+JLHcP7NFVuZpB5ZU8cXz6EcWvg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ivLPtX6F3Le9dR6sh+JLHcP7NFVuZpB5ZU8cXz6EcWvg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc2
X-PR-Tracked-Commit-Id: c0f02536fffbbec71aced36d52a765f8c4493dc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d18081de22cb73f0959deb0327292da30c9771c
Message-Id: <172806866009.2706447.1240387913673171366.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 19:04:20 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 19:32:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d18081de22cb73f0959deb0327292da30c9771c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

