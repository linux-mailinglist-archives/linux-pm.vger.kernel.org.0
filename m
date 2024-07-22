Return-Path: <linux-pm+bounces-11310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2D9394E6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 22:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195631F22173
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43C838DC7;
	Mon, 22 Jul 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnqiHqs1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB536381C2;
	Mon, 22 Jul 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681101; cv=none; b=fJc9/MPMxTp2ZgzSemxDGK04nfZMwVoWmNV6j3J3/gnza0QYaAY9Bwv8qBo77h7GivVCdw9igLls3j0P3kAzDB90bcq3is+SWrrilHAG7sxC/dn5uEeKTEVQfphdlgVTIC0UFMqcBVU3GdC6ITX0MDPqwgxPCiCZSOXNHfFqjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681101; c=relaxed/simple;
	bh=m3j/9DwzlbmW2+roTmBjB2vLr4z5c2EQazwvx/Lsf/g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HGFf0IBVCthMV5e61da2kpI/R94SUSOehDChu0KB3WJQRoCaAj9fcVHoxqrvXzoxTj21NvcjKLzspaVCaSyfVb51s4AShTupk2CYgT6CxuiSSOHnJwzYB5qZIb5zlKvC0PWX6iZ08afs3f4h2D8Fv+UpZqIIATADWPfo3Zja9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnqiHqs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37039C4AF0F;
	Mon, 22 Jul 2024 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721681101;
	bh=m3j/9DwzlbmW2+roTmBjB2vLr4z5c2EQazwvx/Lsf/g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DnqiHqs1IP4TsABcAOPyHusA3rQ3u3axWviJ6+SKYTgAWlWVplPl9QzBrynkb2t3o
	 ct8mHINWXJtD7h4bQgQszVM0dl8Deh2KUlSmYroj+5bKWXF3d04B00JeCOhJ8/ly0X
	 M1OPpRKQaiJqns/e10WDgmsp0k1NO8/QMWGDeuG9jRrWH9AYCxAO13owv32fNdJG6s
	 FCB72ZtxksSxb8jYNHEd3XgVZ+EFDEeOCoO1pc0BsluwMbpcR2jh0F0nDZ6O/eIL5X
	 4zeo1cpmLjuYVIGChWU8uNrK6d87P8GuN5mORqgZ1gAjVo0cO5+S17YQ562tEy1sob
	 EmPbhih0vRdFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28DFFC43443;
	Mon, 22 Jul 2024 20:45:01 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hTH0JtVLWDe1obo0g2fiT4n8zqf72k14eusf9sESLpXw@mail.gmail.com>
References: <CAJZ5v0hTH0JtVLWDe1obo0g2fiT4n8zqf72k14eusf9sESLpXw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hTH0JtVLWDe1obo0g2fiT4n8zqf72k14eusf9sESLpXw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc1-2
X-PR-Tracked-Commit-Id: e528be3c87be953b73e7826a2d7e4b837cbad39d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 539fbb912321ab6361ccc08b72f5f83e8a25c24b
Message-Id: <172168110116.32529.11320864516549771551.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jul 2024 20:45:01 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 15:32:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/539fbb912321ab6361ccc08b72f5f83e8a25c24b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

