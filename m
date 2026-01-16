Return-Path: <linux-pm+bounces-41040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A5D38773
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 21:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77A12307A827
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 20:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE73A4F28;
	Fri, 16 Jan 2026 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwgPnTjd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217183A4AC1;
	Fri, 16 Jan 2026 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595120; cv=none; b=FP1KjPlLUzpPdRSr72WMoVCPc3CsMcRhAo3mKLjfQ1ew5VwfsF/okm9S5t5uvQS8WUkQ3iSEHgvyrzd7I/SUvIqCT7qEnYLfi4wSoMz8ZctllKKMnUYww8+/BgXtvMs86PYPHu9Gvalm7jN7rQY3Vppm47E7LFS7j6JHSesiwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595120; c=relaxed/simple;
	bh=4pSqUqFy/DJezSzAk9B9WSf7WJkEre4+Hl522lpvMUE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AL9uYs33DANdEOiqDATzdvCb1BpiwDONTm1OmPXx3X48Yn93GBY84NPdTd6TPEI08cqPEya/nvhtk4IrxX3xjInNpSg8g2PCMye0xtrWO2RR9r5b1C4rg6dC8JaRnleB79bYSWmvwDhOrtTIqouBk5oR6iALAJ/YdwMibT7uj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwgPnTjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9929C116C6;
	Fri, 16 Jan 2026 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768595119;
	bh=4pSqUqFy/DJezSzAk9B9WSf7WJkEre4+Hl522lpvMUE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IwgPnTjd09gqDPGMxFBGHNStoeZyqfoseYirLvu9kS6tc09IXkqp1N+v8AnSl05+f
	 HO7nz/1dtTjI9BLq5sGLvptFB7s5y2438uciw7dsScNcObOBekQYPKaFUmmgeO66q8
	 p3jKfhr2yq6pTwyFE2VV+rjAKft5v7Gi2Nx0r+I0PtJNO0oFPUfrLt6MAkpThXZaGB
	 +sB9M7hgdrs60qaZCGBMoUCxpHt5DK/DzIj7m0n120HHZBFSlfMSmZfhkLCzveZ2VM
	 e+rPnURRNLsMuan89BxJ57Z7fL5sUgSGgtckHi/9QbTuk5l0tTIORXtzcpEICuNJSJ
	 GaMMlNB3QnXZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78AA7380CED1;
	Fri, 16 Jan 2026 20:21:52 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j6om=j8nB-YcuRN1=cCFeWB1DriOKwkGsRav6+bRJo0w@mail.gmail.com>
References: <CAJZ5v0j6om=j8nB-YcuRN1=cCFeWB1DriOKwkGsRav6+bRJo0w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j6om=j8nB-YcuRN1=cCFeWB1DriOKwkGsRav6+bRJo0w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc6
X-PR-Tracked-Commit-Id: d51e68b7007b9c1c3456c4f93657a153ae3816ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b62ce2547fe8a8ba15857bb974bcad250c5420d6
Message-Id: <176859491116.789588.2160515611989685452.pr-tracker-bot@kernel.org>
Date: Fri, 16 Jan 2026 20:21:51 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Jan 2026 16:42:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b62ce2547fe8a8ba15857bb974bcad250c5420d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

