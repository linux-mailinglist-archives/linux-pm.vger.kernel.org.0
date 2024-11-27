Return-Path: <linux-pm+bounces-18185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F19DAF7D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 00:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49FFB2255A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 22:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B632D204081;
	Wed, 27 Nov 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjMJSMiR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D775203700;
	Wed, 27 Nov 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748352; cv=none; b=O9p3lk0/bffxYfu0BWc3DU/0IGiMQIQboPn5hurwNqkTwRA84H3ttPewRWP5P+pDddmXjIPE8+yw39iJwZbaKxalXOEyLGP3u+N2vWf2qsoDnmPLoqFHQJdC0l8Hm3vZK1PVPinoo5pmGSh0ngjE5p2GqScVL1nJR6wFwu80LMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748352; c=relaxed/simple;
	bh=4FOCYieM1QAFO/+neIlTbG+6OcqZu0hFJzElhn/gyWo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fqgYUDO3xQjLdLWjD531I7UKsNqwGJ9ism+aiIUbbMolsuGvLb9ThzcpasT0+dWPutpYG0i4oU0AbioILoL4KKNihf7HF/Jve4S0DPx80ZYGA6mJnSnc+TFkn6H5DmFTF08VV5QymwNwNwWP1xhJk2SMHFj4tlYK4wi/0JgLRk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjMJSMiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5E8C4CECC;
	Wed, 27 Nov 2024 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732748352;
	bh=4FOCYieM1QAFO/+neIlTbG+6OcqZu0hFJzElhn/gyWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DjMJSMiRHNR8vm/viER3YP5CPqOxEuTqOTRKn10D0dg6ifuqGK/i1N/b/IQILCU36
	 1YUp+LWJbWjJL7qZ4yBWScML++f2AKp3zQ8W/7sAQIOBV0rFmPOmUBkYYgczdFeGLE
	 mXvzUETzK6AS60mAX7ksOrD4F3VjPtKi5c7uUSeMRJUvOQ3Po7DpTL6d0NAC616wCJ
	 /gPn6ywMpzYvbNIJ6KMc3lY6A1m52h/+YWByVMMPk+A66hZWXH+tLPNfFylVivgdNV
	 zLSdjGWtaH8DCcZ6HRxafXT6usRs0N9SQokw8UWTwnrBD699srxic70e34E7GxAQI4
	 +trqI6MXVjfuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5E380A944;
	Wed, 27 Nov 2024 22:59:26 +0000 (UTC)
Subject: Re: [GIT PULL] Additional thermal control updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gpH46U5bJ5OvZ6JXAvFkzb3P6+=N3zBOPSvQNjgmCHDg@mail.gmail.com>
References: <CAJZ5v0gpH46U5bJ5OvZ6JXAvFkzb3P6+=N3zBOPSvQNjgmCHDg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gpH46U5bJ5OvZ6JXAvFkzb3P6+=N3zBOPSvQNjgmCHDg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc1-3
X-PR-Tracked-Commit-Id: 4dc333c6c28c49943a571f09c3868e5058552016
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92b459d82a6ec472d01f18edd532946aea80df6a
Message-Id: <173274836497.1238022.14548822949257560391.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 22:59:24 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 19:34:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92b459d82a6ec472d01f18edd532946aea80df6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

