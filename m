Return-Path: <linux-pm+bounces-39681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C015FCCD936
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 21:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA0C83007956
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C09345725;
	Thu, 18 Dec 2025 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSMX7B9I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C85B3451AE;
	Thu, 18 Dec 2025 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090594; cv=none; b=jqgEeQF0GsnBnfok+8yxDzLBV4tB2hWPG/EiBcqiZXk+Ubhs3nLw/cY3JycahQaIIKSoyatpiiV5uFAbdt5hR61X34gAQpV4yOY354cCA12QcHaBaxS1os0Mx+5dsJOEhurBQwuhWrL4WEV8hsYtV3fKxy5aaTEhnApO+Xe25YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090594; c=relaxed/simple;
	bh=q0cw+uhrPm459Iq4WfqGHyoZ+vdUi2vEu2g0GN28FZ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P0vBNb0T2VOqoEJ62BVZ4CEK8+uiyfNIftGpeKA4+VTy1dGZo+EVIdLvdaD4dzs4QH8grNf2hT9kHiPfnur39fMzc1ZOvW/BKJSXDS7dyS7g1ltXIcAW3IEwyhpKJ9W6FfxHmolqUhYtMvSlF9UYdVYlp1OHxDUcupfDziBtSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSMX7B9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8E7C113D0;
	Thu, 18 Dec 2025 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090594;
	bh=q0cw+uhrPm459Iq4WfqGHyoZ+vdUi2vEu2g0GN28FZ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kSMX7B9IJzyPGDDuDhnxxr9CyHvCixfBsU0vblYOSSNOBCvhYtedcQBregRHMwT70
	 5c3uxWsyBZ+J6W94WqNxn/BwGeZKfb8mdZ2uKKkc4JRok+7hMCdErlCC2xbHOc7FKm
	 0XRLJ4SVThOSOAe4pY+2eEFvtLBRNfKeHVSpcH9OyjA6pbvhFGtH0MlCxiRQDJH1U9
	 R5nAZRh6M7pNXcpJkJY+OQG1ff6VvO+roxhiv5Ey52+rQw0opW67zoLR1P0Ptv69ni
	 7vyFURrKZ+SpWIx60JizHjxqAm79lE+XreXiLu7wV1tBow1FXTRA3Y9oowGeCiHdxu
	 ve7jVlkVaaCxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 003F5380AA42;
	Thu, 18 Dec 2025 20:40:04 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0go6vKUdZmwAqafyr5LrSGhgGpvfq_whp=KEOvmEp9-HA@mail.gmail.com>
References: <CAJZ5v0go6vKUdZmwAqafyr5LrSGhgGpvfq_whp=KEOvmEp9-HA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0go6vKUdZmwAqafyr5LrSGhgGpvfq_whp=KEOvmEp9-HA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.19-rc2
X-PR-Tracked-Commit-Id: d113735421da322ea144c9778c433de6ff6bc57b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14e0e8d0fcf24963e641ba375aa2e069f0bd2c1c
Message-Id: <176609040415.3123986.4926057127448701090.pr-tracker-bot@kernel.org>
Date: Thu, 18 Dec 2025 20:40:04 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Dec 2025 21:02:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14e0e8d0fcf24963e641ba375aa2e069f0bd2c1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

