Return-Path: <linux-pm+bounces-13256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E3D966903
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 20:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D2D1F249C6
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837A1BD005;
	Fri, 30 Aug 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwEGVfQ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F21BCA1C;
	Fri, 30 Aug 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043054; cv=none; b=tmWqzqwLyiZ24x+TXV/2gvhxncAzc0b1zBimTsz5vCVch7NW0mXgPmp15cngyG4LnbGWWUO12LO/pmPE+9Uo34eq4ZSlbYXiycf2gt/B+U4kZKki/1upPnzlND6CbW20/SKvxfoDhmZITGCeSw/agzwua3pJUB7WBbPMN74uoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043054; c=relaxed/simple;
	bh=1F5Zr1jHGe2NL28oBZJXpUeEVvRyt2axvu/CxHtM/NI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rhEO0CXRUODqx9UbylXy4iUTqzxxL9wJdghc/t/LcNnSaCDX59gcXgi3iRH2W4fQxp5d6i4p9D2+Baxk0wv/AfXV947QDHOgrHEojTedxAUpOdKAk2hWhMi1SOU+s7hO095xv6uB0Ixs6+yXB5qPIuWLP11Y0Mn58EJxRje/V9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwEGVfQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E25FC4CEC2;
	Fri, 30 Aug 2024 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043054;
	bh=1F5Zr1jHGe2NL28oBZJXpUeEVvRyt2axvu/CxHtM/NI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WwEGVfQ0oR8+4N0l1pbpfdzAtua3lhfvYBw83Y6SEj/Lk9LwwJVDfX7bwBbYZGoG8
	 3ufUt5FbSvsZZQpoXEG2x4dgG5iDiIXgvL1v3ZE3dpoB5LgHGd75pZYiskjnZmVOlZ
	 iymZuziKWJP7MGotB+ZsPrPtZCfEkVNLvsQUpQOopCyMZfptiCNMNr5gI89J+l/gRC
	 O0XJlbaupzyOvStH8xqCoA97hxWycjv0pxT4n8otmcoVm+5EWaqUse3D4zs1l+oAOg
	 ECQJ9FyOCgqwsmMd3a4JZ5PibLOWUN1yevB8mfMPI7C8orxdvUtl0bnoH4B8I2cIbr
	 ntBGqIcY0lxxw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E0F783809A80;
	Fri, 30 Aug 2024 18:37:35 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jOgpgotLwOMyhURMcfWvAP4rWtWxNbFohqwyEzCJGSSA@mail.gmail.com>
References: <CAJZ5v0jOgpgotLwOMyhURMcfWvAP4rWtWxNbFohqwyEzCJGSSA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jOgpgotLwOMyhURMcfWvAP4rWtWxNbFohqwyEzCJGSSA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.11-rc6
X-PR-Tracked-Commit-Id: 15d75184a86fdd8ba56e17606c3088ac60150ab3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb1a804535adf538532a2f6a27b1c7775efe5368
Message-Id: <172504305591.2681732.12804248463261843245.pr-tracker-bot@kernel.org>
Date: Fri, 30 Aug 2024 18:37:35 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 Aug 2024 18:59:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb1a804535adf538532a2f6a27b1c7775efe5368

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

