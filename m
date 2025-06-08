Return-Path: <linux-pm+bounces-28246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E2AD13E0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AD4168D92
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9251A5B91;
	Sun,  8 Jun 2025 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOlE/EVh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE41A314D;
	Sun,  8 Jun 2025 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749408771; cv=none; b=pJ2NcWI1r988NKKPoxKgOfW6qGBvZ6loLjs0k0Fi9vRxx5HbgOPCs0qVoNnNcdBrQAjX0MeeIYUnDR+dlOG7cVq15MrFsBUHNUO5fnqwcIM5VA+tQY169hnVKkSqLuR26m/tv6TUI1Rjo1cCckEQS6PE0ZD+W2okSXcohDudZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749408771; c=relaxed/simple;
	bh=26lYZgkHQdShUoigTGZrWmLTlyD+mBAld3OXUl/Rypk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h54wqQFvVjv2ivnxoVtlBuv9N/OnAgz4HcfjyxJP1mtUoTp3ZXzqNFuk8Qz2smQcqmpdjI4Qa/H+eFMSHJgcFp5F2rrxGCqN/NDHUFQrmQV+B7mev04mjaNOAhZmjrklCG70X0EuuQZO84ZF+WxgUWdf7/wBuiMBnZ2cWuWAGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOlE/EVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823FAC4CEEE;
	Sun,  8 Jun 2025 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749408771;
	bh=26lYZgkHQdShUoigTGZrWmLTlyD+mBAld3OXUl/Rypk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZOlE/EVhPC/NcKuplx1Gzh7yHFjxqsVvi3DGeA+g0yrqBR/GnPQRru42/OjefsFtz
	 coq7OKYaTt09vG8+MLKeNThJh04x1D+r77EFvzqeaCYcpMsTZi2kvx55HiwFWghXg4
	 NWxaMrtTqtjDRXxYPGBINW+XkJAZLv4t38txJUdkBgYX3NP7a+ng7f7uMxVqQPJpRB
	 Xnh0RYIzLeyoQAv1x47c5cFyTbn3mJwopVHSgrAcPJ2YtYQ8BXy5RMgFgKWlsP/pA7
	 3bIlb/6326zPoHcn8+P1FwcehyXvXDSEI1Oi85vzfHi+nGePg+Oa+MNAvnBEOGQsZJ
	 CsWSvBVrh4JVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE14A380AAE2;
	Sun,  8 Jun 2025 18:53:23 +0000 (UTC)
Subject: Re: Fwd: [GIT PULL] turbostat 2025.06.08
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKkpMWWtfSFqEqzjSxcvSqUjjcTC6+Yub8Q+Twu+PM99mQ@mail.gmail.com>
References: <CAJvTdK=9R+A=b=NY5OM2jiSupofrnJOKXrFCGeXfAfN57VhE_g@mail.gmail.com> <CAJvTdKkpMWWtfSFqEqzjSxcvSqUjjcTC6+Yub8Q+Twu+PM99mQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKkpMWWtfSFqEqzjSxcvSqUjjcTC6+Yub8Q+Twu+PM99mQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2025.06.08
X-PR-Tracked-Commit-Id: 42fd37dcc432df1ea1987232d41bb84fcb7e150c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 939f15e640f193616691d3bcde0089760e75b0d3
Message-Id: <174940880237.385950.9062730259647447034.pr-tracker-bot@kernel.org>
Date: Sun, 08 Jun 2025 18:53:22 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Jun 2025 14:23:44 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2025.06.08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/939f15e640f193616691d3bcde0089760e75b0d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

