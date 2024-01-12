Return-Path: <linux-pm+bounces-2175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE2F82C726
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 23:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905F71F224BD
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 22:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197418044;
	Fri, 12 Jan 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/ZGoO0N"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948BD17753;
	Fri, 12 Jan 2024 22:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B0C7C433F1;
	Fri, 12 Jan 2024 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705098019;
	bh=pS3A6WFkbnnVyBmfTN8JCWQnVt711m5zrh8MnxxiIS4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c/ZGoO0NRh1jdHJOq++8oroN+Y3zMBwp0PZCP4q0oilbvO2wJSpbd4YfYaYTCCACd
	 H4UQFKEchF7BmJhCxBEZYnOxKEH8Gmnz43x86aP6i1qAbNndDCuxInabEY6NmDyhSm
	 6SsGY72N5bsGefCh9hI7/RyfGnMEhLyPHXUqNMfSDagP+9jaNFKX/8AquXgAYqcMvV
	 emK8lmb6+dDJ3RCfO1GqyBWjDtahGMs7RLb0DDLuOvKGNp6E1lqd+eeUmF38AvbOh1
	 yrLktZmauy1ru/h7B+kJz7vE2AoSoUcmq++FCFxsqcCVzqgLsJrnMBNFd9Dn37XwAl
	 AJpO7Pt0+NFvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52CF5DFC697;
	Fri, 12 Jan 2024 22:20:19 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240112113523.44456-1-ulf.hansson@linaro.org>
References: <20240112113523.44456-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240112113523.44456-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.8
X-PR-Tracked-Commit-Id: d6948c13b663a284574cb9e502dd663e70d910e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c4b09cb542fd0c4134e3f87442c89abffbfeedd
Message-Id: <170509801931.4331.1451615370792696885.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 22:20:19 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 12:35:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c4b09cb542fd0c4134e3f87442c89abffbfeedd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

