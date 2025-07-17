Return-Path: <linux-pm+bounces-31021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46316B09315
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 19:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773E41C47745
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3530204A;
	Thu, 17 Jul 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCvBM6+q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D5302046;
	Thu, 17 Jul 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772896; cv=none; b=RbeqrNW77OBnl3KvhSC7f9n+RjujWMapADEATvAedY8VRXK4S1PHNFr6cbsCHwaf1PN+SUJTl2IOz1Ei1ynGa4aCbLWTEgNgxMLx0r+1dt5rnG6+FAZbhGz7oF6pmKURE8iVn3p07qr4pBbQOyKNwlyPjZcyyNr2rkJKRK7TwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772896; c=relaxed/simple;
	bh=4m2ofo73CBeLVyWA9o9g2dI2bDoRaMxQSpxqplU3XS4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O6mZlPKtZX4w5i9Nd5W+kSGmC7OkDmIjltG7FcZnufCMZ+zfKTtfnOEm8U2z6xNPPvJ7jtp/W02M8/rQ+mpEjdoqIarF3/5LPiEgS3ENeXoBl+OAk7bN+ltXYlGiNwYhUpgMriTrOQNrQjRjc4ANIZlTc/pUybHsNXZSfskO9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCvBM6+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379AAC4CEE3;
	Thu, 17 Jul 2025 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752772896;
	bh=4m2ofo73CBeLVyWA9o9g2dI2bDoRaMxQSpxqplU3XS4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JCvBM6+qRVuhyMTNu1zAZ8Cut/XsT+/uYqo9649WS48HIMD6PWgrpGtuvsybts0Ik
	 +97XiBdqY8M/4KqFzwsnyQsinI0StLkyuOhg21PTpWWJgT1Um5vv8mmfj4A2IQosJZ
	 3fFxpsHEd0+nmBtKLQsCx+stmN/IZ7XYtPUBlI5UpyUJtaJG1uX9TybBWeat+xOSo/
	 gccIz0xzecRYW5SIWHtAk/TBPe+K+gVAsZ4TT3+USzc0XoxWc4RXOlXUZLOWhw2OyJ
	 FlyGmQWRzjho/pJsuYkca3iY6N+LvKntXzyc8WjIKcQI/C4BtFOVQ+JGDOpc8sEShj
	 +I2KiH00To0HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D21383BAC1;
	Thu, 17 Jul 2025 17:21:57 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gX0Tj5GYLu6rPj2iWfep1shMAZbV740_wr=Gss928CXA@mail.gmail.com>
References: <CAJZ5v0gX0Tj5GYLu6rPj2iWfep1shMAZbV740_wr=Gss928CXA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gX0Tj5GYLu6rPj2iWfep1shMAZbV740_wr=Gss928CXA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc7
X-PR-Tracked-Commit-Id: ebd6884167eac94bae9f92793fcd84069d9e4415
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6e82e5bedd7e924b670cea041d63aba1e03d06e
Message-Id: <175277291603.2014070.6001171859523757681.pr-tracker-bot@kernel.org>
Date: Thu, 17 Jul 2025 17:21:56 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Jul 2025 18:19:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6e82e5bedd7e924b670cea041d63aba1e03d06e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

