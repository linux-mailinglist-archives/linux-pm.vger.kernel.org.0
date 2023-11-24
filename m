Return-Path: <linux-pm+bounces-196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787917F8579
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 22:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF94B21630
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E1A3BB33;
	Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBex8qQB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95408381D5
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 192D1C433C9;
	Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700861411;
	bh=nOfWBEduNJ9yZfwz3IP6wbwCTwXWK6SJImz14bYFZlc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VBex8qQBQKINbFA2HrEIIiRSuInHZoUwatM+tfW3RC9GWF5Y1c8Vi38QqvuBVfETN
	 Wjk5Auf+V5fjngeF+ZyfpnoKCOxPyG/upoXm4wVef0i02pp2fuiG5hOc3N2uZRD9AM
	 M+EEyD+BAP0bM7nDd6TIG5suPQHjxUtbpE9n61gWFxBuxyUBUsG7KI/1Z/Y1TCiom7
	 JVtc48Y+3Kswy3LctAeY8IJgMFOneclPghGg434aK5NY+Awoo+0G5d7Zye/QnnDHgh
	 7y0tHxt7JmsTrrqlnyznXG4UEslfmxO5qI4Ods/t+D33PIOjWtqcebyhStpeTiVQcv
	 ZmlHDPAYQXuPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDB80EAA95E;
	Fri, 24 Nov 2023 21:30:10 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gO3nY5nSnsFUha5a9WiOAj6kZLek0sVSB49NiweFw4_w@mail.gmail.com>
References: <CAJZ5v0gO3nY5nSnsFUha5a9WiOAj6kZLek0sVSB49NiweFw4_w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gO3nY5nSnsFUha5a9WiOAj6kZLek0sVSB49NiweFw4_w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc3
X-PR-Tracked-Commit-Id: b85e2dab33ce467e8dcf1cb6c0c587132ff17f56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b345fd55a2b79d6aa92042b19be802425fc353cb
Message-Id: <170086141095.4355.1044345234368406493.pr-tracker-bot@kernel.org>
Date: Fri, 24 Nov 2023 21:30:10 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Nov 2023 19:23:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b345fd55a2b79d6aa92042b19be802425fc353cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

