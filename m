Return-Path: <linux-pm+bounces-39222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B561CA598D
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 23:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 386BD3155F98
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 22:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661F327BE8;
	Thu,  4 Dec 2025 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g696lonn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E912F49EB;
	Thu,  4 Dec 2025 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764886459; cv=none; b=ZhMQ5Hm9Bc9mlpgTCHTnCHfn5yUHDMGy/R6KsPW4iVKV8jl1jgxD5Q+AYR3xdvUpc4Cvb6FrSHyMtDTdji600E296YGk0C1yQcoaORIM3mcZrBzfo/InMTjQichVsPKPIaFeL6PZZfdRRl1B6SBEZY2Wf3PVCLD8Z/RSRzPmDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764886459; c=relaxed/simple;
	bh=i1b1OQLbG2VEL7KIHfRWVF/kPVHS15MWLIozPya6duk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SqNj3TI84/TmoXbA8W+nyDJcvNVWnt7nGOySqXYkz8kJgc6Mn5Ltkcd91m3iMOk8XpPReiDwoSJndLCWePa/FAiCjgM34l9yOCb4jiCfcVHi/jH8ilgSFKzTozA9IZm6gt/4gRBdkNM0bDAMWUySzcD/Tw3/mq5lyCyHxFqzM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g696lonn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A98CC4CEFB;
	Thu,  4 Dec 2025 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764886458;
	bh=i1b1OQLbG2VEL7KIHfRWVF/kPVHS15MWLIozPya6duk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g696lonnyXTQm+KvyJU0HUnTuWHNnIXxh7Hly4cwOqoE1gR8xa0A+iBYV3MZHZbe0
	 Xkoy04ujgnzAhNwERmPf+tWeI1BOanrvwwVi3JG55x7fGSCDejnuwcHd2zEdcFGFte
	 1vklZ2/mm9rZNyDEsNr1+qm9p0yW1DOakQF/Qcu6bprBrdp/zuRCihJh4QkfUZBeYH
	 WPbyixIrC42vb9t4oz44VzTTNxycg2P30UTYz+2jRI+L5yaIlPNrZ3fGyFf76/vXo9
	 cQkVXbYYPDy1C6vrzhGtz5ae+BaWONdV8JmRHb0NCL3+83/Mxi/fuDucH5PkfL8Yaz
	 Havgp7oY1lXtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5C063AA9A85;
	Thu,  4 Dec 2025 22:11:17 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle-psci updates for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251201175125.34284-1-ulf.hansson@linaro.org>
References: <20251201175125.34284-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20251201175125.34284-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19
X-PR-Tracked-Commit-Id: 1f67707fafa598e2338dba08e3de0db3e468afd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52206f82d9244546e5790f5ad64465343aa7ffd5
Message-Id: <176488627629.997489.5449329879391180741.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 22:11:16 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  1 Dec 2025 18:51:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52206f82d9244546e5790f5ad64465343aa7ffd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

