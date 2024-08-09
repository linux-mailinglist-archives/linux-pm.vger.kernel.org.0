Return-Path: <linux-pm+bounces-12056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAA194D653
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 20:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068D92826CF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591AE15A876;
	Fri,  9 Aug 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXEH4qjh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7115A84D;
	Fri,  9 Aug 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228518; cv=none; b=k+8/0or7Yw2+p8CQuGWRC0sDMz8T8uOdvw1LX9BRXzyTFcBeBGdscRbe9+I4LuPOOBK6X+hgjKMA/87hVILoaCjm0TLFc1zWhyrQuCDuQkDQSyGkGbdtZ7+/jTu2gbgrWzSFpoZIh7Xee9d5thtAdtpLx6Abfzsol6ev0yaPYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228518; c=relaxed/simple;
	bh=LPjHua/5gF2z4Fh2ZJWQ/eAvbWAMxPRxAHHuriaPjFc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uRldIq9KakFN16djrgXcgzG4gFhqxwZ8dq5bosjnvY1sYoLB9yG6JNiVcjEzICtWu9aruCkXw//t3vuJAvHKL7XDf+2qNYDIdVrsb93Tw2LaDpmf4nlkNL0/BY02EeVtQp7s9gX0ff7UMsvdUXI2EL6WoW46CTx7j8Ybpi5dYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXEH4qjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FF0C32782;
	Fri,  9 Aug 2024 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723228518;
	bh=LPjHua/5gF2z4Fh2ZJWQ/eAvbWAMxPRxAHHuriaPjFc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NXEH4qjhSUzM8s3tjW3yqAtwnDvZK1z2xMS+F7crIuXfJlAmB5tme+Co97o5REiZs
	 EYdreyv8AN5gMmoJP4vR62pbQi6ycEiiO5vkXsSlgcZgYtly0xb7nt3A+E9OMwkl9B
	 ETCbBIbgik8IqJB7tAKGkkI2JKlRDtdEtLXM9NGcGICh/a7Tfb001Sw4ZVCq36+NZx
	 ujCPdT6/Dc9k6LniGzpb9Wv1QSXthPqIy6D/LRvEFuyoxB/sJHssqDB1Hix4aYjls0
	 ZF5bmDxRQ9uULbJOW6tAiaj3sy9Iqg0dTBMACqS2g3/n7BI2uwU7ANktpaMTr0nVEK
	 rHjlyTKWKHOEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348EF382333D;
	Fri,  9 Aug 2024 18:35:18 +0000 (UTC)
Subject: Re: [GIT PULL] Power management update for v6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hQ3O7E3ygvFKbzjkJbx7pddyD9Qc+rE4EFYzJS12oTMg@mail.gmail.com>
References: <CAJZ5v0hQ3O7E3ygvFKbzjkJbx7pddyD9Qc+rE4EFYzJS12oTMg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hQ3O7E3ygvFKbzjkJbx7pddyD9Qc+rE4EFYzJS12oTMg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.11-rc3
X-PR-Tracked-Commit-Id: 64a66f4a3c89b4602ee1e6cd23b28729fc4562b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 850828972588bd5422ab6c917df3f78233df1a62
Message-Id: <172322851677.3872157.18257551027827992680.pr-tracker-bot@kernel.org>
Date: Fri, 09 Aug 2024 18:35:16 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Aug 2024 19:07:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/850828972588bd5422ab6c917df3f78233df1a62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

