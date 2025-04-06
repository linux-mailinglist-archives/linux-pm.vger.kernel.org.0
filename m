Return-Path: <linux-pm+bounces-24863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34573A7D003
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 21:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9822188D68A
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3041B5EA4;
	Sun,  6 Apr 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1HCZpn+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94EE1BBBD4;
	Sun,  6 Apr 2025 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743969087; cv=none; b=uJsXU3KPeMaHL4RHmF7j2rn3eBcYI1Icp4a4CfZLGbHhwexXK/d/lNh7zoZcTjAgo0ouy7QbYXlt0tv+6/NmcFMZegFzo7l0yiTRPaSzbU/xTtaKpGyHPVgjp9Ge/ryZq1X5sPyFdKmQ7aRc5qxJ5dtVovqTE3WLqGC3YEFFhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743969087; c=relaxed/simple;
	bh=Bpf6ZJ3/ONL24038t3AjsemuCc9/tLqbyRJHezzefss=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CzkPuCpyato0i18G/1pN1dS2vmgPh4F08tvs8jMPmnPnlZ00FtIth42UTWhYZExHwOLXEmg92f081crgOJ3QpkzzzGJLbOqapzMbvVC9X4blLOSIjIhOYLjOgH6++zxwdkcVKkZ2XK9yIcy+OH/KUZ4ft5mhIcp009XbIuCc9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1HCZpn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A29C4CEE3;
	Sun,  6 Apr 2025 19:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743969087;
	bh=Bpf6ZJ3/ONL24038t3AjsemuCc9/tLqbyRJHezzefss=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F1HCZpn+LVy5tk8hb+ixJGcEV0wZ6fvbMtNlzwdL0Eey7mhA/VG/Umw9TUkwNkvck
	 JItaVXggXGMRWwDaMCIZEWuiVDQeIBQcH48IkKrlfZGOvocQXdB5mmlC6ORvGl1rmq
	 cyrv3e4P3CU0el+G3QGRHCJa1pSickfki2Svh6+7gYea1yXXjPXLiXiFW0PWDu37Ao
	 gs9jTX/qtFE+SAOBz+/JcvIY/pJ//MjZBc/4zjM+rzJhYhynf5jvvN0ErVm0AOmUKO
	 yoAABdrGVBMQhnNKFZ7Up9CsCXFNOg9KsTco/lzaPkG23ius1I/8ERdCIGB42tTHQu
	 u/LSMIMnQaHPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EAF380AAF5;
	Sun,  6 Apr 2025 19:52:06 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat-2025.05.06 for Linux-6.15-merge
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdK=2NjoVYPFO3EbKgmdrhmgDx9Q-0Zk0tYHhaBEgNzdfJw@mail.gmail.com>
References: <CAJvTdK=2NjoVYPFO3EbKgmdrhmgDx9Q-0Zk0tYHhaBEgNzdfJw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdK=2NjoVYPFO3EbKgmdrhmgDx9Q-0Zk0tYHhaBEgNzdfJw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2025.05.06
X-PR-Tracked-Commit-Id: 03e00e373cab981ad808271b2650700cfa0fbda6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 710329254dc303cd3b2df1a24674adecb1189385
Message-Id: <174396912478.3949691.16565957433822707597.pr-tracker-bot@kernel.org>
Date: Sun, 06 Apr 2025 19:52:04 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 6 Apr 2025 15:05:25 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2025.05.06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/710329254dc303cd3b2df1a24674adecb1189385

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

