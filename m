Return-Path: <linux-pm+bounces-25733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5EA93EE4
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 22:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8794680A9
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 20:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72B02528E9;
	Fri, 18 Apr 2025 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGC49ay7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE72517A7;
	Fri, 18 Apr 2025 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008043; cv=none; b=RefXVrQoRft9bZmgQymQmrE1zMQjKs0mdEdKOd+ZyAup2blkSMTrew7HuQkyvppwJMSE2W2WNejorcx/4raBm73wGveDibk8HIN7EKgmhxcVRTIRBR1yaVPmr8wlVO/lDmzRMHD7jecC6vrm5n0gf8iFuBc//vOMV/PS8jvArwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008043; c=relaxed/simple;
	bh=hvllrf2up2uyk0JZj5Yql3uRbhOwybx7KGmiwdkMJ1c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=stw+ImEPgH38usZyA9Rqp/EGvM5w5b/l4xfTcednU52C9IXCiNLkmDnsIbtHhUCKpxg4vYVw3T6YE9AFl2+V2OHSlL4wPpZsRSFzSZlWBIMfUjcvVATDaPXLTVp+j5nh9tBEXBdgHZwB5qFSoe7WlQy5wpMv5+REmHvxZbDjB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGC49ay7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180F2C4CEEC;
	Fri, 18 Apr 2025 20:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745008043;
	bh=hvllrf2up2uyk0JZj5Yql3uRbhOwybx7KGmiwdkMJ1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UGC49ay72xho5HxpSCVc5pa/2Ex4gUpFIKwLFL7RXtn2gMkg/fnacyH4Hrgk68gwD
	 27vPR12bS6ZJrAEm+Tc2+WuTHIFo4zEK5F+hdV5hhqdZkKSNdmGDrVxA5F9tC8G/Zg
	 YMSd+Zw83MlsXXHVO8NOvK36HI9mPE705olSeWDbTWB9w+7Gt5YX5HM+e13uP7xAmD
	 /8Vsq2Gdwk7ULdTEH8cW0Bpw9XEJgRd4I1TefXecQPYKpFNfkzU7BMTnEuSGB68Y0w
	 /K7Hc7su3sw2yNG3o8OVq2baOsWNfMieY5CYxpAl6X1qwHe8D//yvtwTiA2GGQNByI
	 pzJJjXyjeP0RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711F43822E09;
	Fri, 18 Apr 2025 20:28:02 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gpDf9mBFGRjnrU8LaPzc0foCeGhzTkOu1FwooyGFzSzg@mail.gmail.com>
References: <CAJZ5v0gpDf9mBFGRjnrU8LaPzc0foCeGhzTkOu1FwooyGFzSzg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gpDf9mBFGRjnrU8LaPzc0foCeGhzTkOu1FwooyGFzSzg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc3
X-PR-Tracked-Commit-Id: f3b25a1b48191048e2f190d878fc3175fc08ffaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb64c513b5fbc5a3290d89cbafcc8f9b07a29a46
Message-Id: <174500808105.316726.3718240873949478966.pr-tracker-bot@kernel.org>
Date: Fri, 18 Apr 2025 20:28:01 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Apr 2025 21:32:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb64c513b5fbc5a3290d89cbafcc8f9b07a29a46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

