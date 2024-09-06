Return-Path: <linux-pm+bounces-13817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977596FC18
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCCC2878EA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 19:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6BB1D2206;
	Fri,  6 Sep 2024 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm7GlddL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FF1C86FB;
	Fri,  6 Sep 2024 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650649; cv=none; b=qM4NhNbw8Dwk8ywR57pmKkMZDuLOgulGqUTgzGaJ/Bdilq1AH4RSps5MaHgtrOMH7x0sxCixeOUjy6HQFeKRs4BeqN0n6PsDKZIlLgRdZoSniJnuy6TCkQC73Ip9A/4axLaT8dKdp6gNS0d5cNhtmNYHT2gVEEGofhakWXpNG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650649; c=relaxed/simple;
	bh=/DKxByYEJEEIUVOPSy++J5NZgmCOkTnQIADlwaSC9gc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UNRbijL24JBJm/Jtf8fOuXNNu+tPNOABHhbwlzj6LVzwkom9cw32QJFhEWjbC8f7WvU429UyzWN4yUINTy+0fgpjCbw8GJXuAI6Uqom1bf7VmotHJUV+NwaB0iPcWcdRsv7jUBFIdQWJLChgvV/O3NIolPVhRwuRYtwV5ZSTp30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm7GlddL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD94C4CEC4;
	Fri,  6 Sep 2024 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725650648;
	bh=/DKxByYEJEEIUVOPSy++J5NZgmCOkTnQIADlwaSC9gc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mm7GlddLzEcnjqQyN9jjAudmm4LcC4PctriJ0yZOlVabkcL4NkgZ1iDRAGu8ClyxA
	 Qy+Tt+MdF3pF+W/IqBjxy1ezQzlAUNWl+lsGs4jbR+9Ad3kHN3m6aGSQLzXE7CckuE
	 PofxdW5bmXSdQ9R1OzYBmZ9blsYkwQzrucLEXhCU5qfH+QfPqegVsG5swQ82i4AUYb
	 irlgvpzNatMI1EEsg881DBuYOBz5m8cFChTXVN2L6l1hxJlc/MSkAv/AkcJrPTd7xK
	 YwnF5e3cRx3y5Ur1049yrwDPLRnN7dMhTKpnrNCN24BOH1E6eSBhQaLjvSYill64ib
	 ZnOM7cTvLFB4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEA43806644;
	Fri,  6 Sep 2024 19:24:10 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iD3rPCHDrA7ebRr64GPYFaSJ1fF-GcUCf_avXm0_k9aw@mail.gmail.com>
References: <CAJZ5v0iD3rPCHDrA7ebRr64GPYFaSJ1fF-GcUCf_avXm0_k9aw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iD3rPCHDrA7ebRr64GPYFaSJ1fF-GcUCf_avXm0_k9aw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.11-rc7
X-PR-Tracked-Commit-Id: b02d2cf5b220872cd10afe610348b9ec41b9ac05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 788220eee30d67a485a13c34c02f51a82485f337
Message-Id: <172565064923.2501012.2319260835608312987.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 19:24:09 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Sep 2024 21:10:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/788220eee30d67a485a13c34c02f51a82485f337

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

