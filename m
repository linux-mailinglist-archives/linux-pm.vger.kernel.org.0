Return-Path: <linux-pm+bounces-15552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F049199ACC1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 21:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58AD1C25789
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673401D049F;
	Fri, 11 Oct 2024 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbGOAaub"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3A1D0437;
	Fri, 11 Oct 2024 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675236; cv=none; b=BW/D1BZB1Ze+ELrkjdYk8pFlAmMqI5PJfQI5vsD+m+uTBkZrHSfgBG4fSOxJUxmSeAvaJc3xtHNYmXNy+bLMIWCM4ZO6M7QY0HGucr4kZ3Y/FFg7TS+lmvz82Nni3BUv7t4VE8QxNGt7FW0+WetidhPgo2trGBppTLWpa2vv0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675236; c=relaxed/simple;
	bh=tuBGNPWPkCK5d+dgCDWynTpF9YJT/7i8qnVr74vxSbw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a5WaGJlSjFquVaYqWnxr8BNYYGxQ75AUnOz2ahFCN5VYQTvQVyHXGhn837q3vyGqwenv1LsiSIlfxtxpxEhT2wv7jQh26O/MYvg2nVvOUiTkvaGUzH+a2ZAAbPCVoy735QPtB28R0upzaxUzVpFSKJJCW1IU7MMHmR26Xk3su1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbGOAaub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23111C4CEC3;
	Fri, 11 Oct 2024 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675236;
	bh=tuBGNPWPkCK5d+dgCDWynTpF9YJT/7i8qnVr74vxSbw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nbGOAaubQlcMrtvZ38yXy9WI7OCpiS9SS7qnCougFA90VvHcOQ5MjWwglyU0CJpF+
	 y1MbdnKiQS+bKpGVbHnvtMOJKJMD0axOgjix1d1sOtg2lFfUSTyRVbjYxR2pPjc9MQ
	 wPGx4aQMIfxJNY2awc1a6H7D2PhlW8Vw8TdzTftfvMRtxcX6BMH2D0il+cSxglmGhZ
	 M24N6cUGKbFjuTnrDZX6JxOvvLCiS5KCu9LzRFrSsM7L/r4Mcj802xF9tbnkTCPVoG
	 2z3xgk3XMPsgYTq3P8AdCaQF1JvE0O5/FJRfZG/rcVg2Wn098BqE9t2FIdLmrDVWAH
	 qBybK9FwAgjFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4F38363FB;
	Fri, 11 Oct 2024 19:34:01 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/opp fixes for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241011103029.477385-1-ulf.hansson@linaro.org>
References: <20241011103029.477385-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20241011103029.477385-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12-rc1
X-PR-Tracked-Commit-Id: 7738568885f2eaecfc10a3f530a2693e5f0ae3d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22e6abaa7263b3cbfce3c1d1f80307571ec66f7a
Message-Id: <172867524047.2975359.9165714631973447403.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 19:34:00 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 12:30:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22e6abaa7263b3cbfce3c1d1f80307571ec66f7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

