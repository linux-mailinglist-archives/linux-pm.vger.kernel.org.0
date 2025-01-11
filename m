Return-Path: <linux-pm+bounces-20262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F3A0A022
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 02:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E167A343B
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 01:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C047713D503;
	Sat, 11 Jan 2025 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFhPYxU3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158B13C8FF;
	Sat, 11 Jan 2025 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736558756; cv=none; b=k9NIuI9Xy4UWbzr/hgptyvBVLtvxWtYB0MXVS5VanhjV+dF4n3DhabV/W/m0WHVNgMNDjkz+WkTWQIk+xw9HZ2KR+81Qfk0V0OiyQTMQx9D5vTMloXIA9VEv9lg4yWyiVg6H1MXM+Jy2+e5KfSdsq6Yor2XxlXUJj3SpcBBVDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736558756; c=relaxed/simple;
	bh=H2BeacE5Yy7sRrfRoMKztkgS05r85ZiWdQQDuQFYhRU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PURmQDUOJTInM4D6sfu16/J5C5J67fDAzknmJftqMLKehJ/A7hKJmiRVYjZYaa4rEtF4qlX8xkq2zrDA0VvbX/54acX0u4N78IofVq2e9rMlmU1Lm7I1ibAIZI7K7gQJrGjsMLi/7QnD80/Ze98gVcNJOPPz/4fQZDV5NSX5gEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFhPYxU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730E0C4CED6;
	Sat, 11 Jan 2025 01:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736558756;
	bh=H2BeacE5Yy7sRrfRoMKztkgS05r85ZiWdQQDuQFYhRU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aFhPYxU3zO8sqPh6arIRTXg3itaySkGXyGLV7UsxZbq6/BuA1US2haPxK+J/YplHD
	 e/amo0kOjl4MYZb88X+uHTXSHgWJd//E5a2VokTS+ssf25W4WX7q51BLJtggTiawFj
	 gJm1g5IAcosNjzv6D2vTpx2rTXDgVrDWKMR2ArsFfolCeiOW/CSPaeI0PNCOUdwr4o
	 9QMHupbaDvNuPQiI9JFj92xJl/WEaph+3MKM0H4RRLKR/pnpvYlmV5FZQhxRf/RFjv
	 yZsX6XQ3xGMDGAoO/1xYS/pcFYOXl0csfgiBGIHyU8jUwtlURPd6kdOK+OJ8ZffeBJ
	 ZvzyNoD9g4siA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF0380AA57;
	Sat, 11 Jan 2025 01:26:19 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.13-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jyAYdA9mJTftkVcDH1OKNEky82s4UAA4A7ODWHHQ3K9Q@mail.gmail.com>
References: <CAJZ5v0jyAYdA9mJTftkVcDH1OKNEky82s4UAA4A7ODWHHQ3K9Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jyAYdA9mJTftkVcDH1OKNEky82s4UAA4A7ODWHHQ3K9Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc7
X-PR-Tracked-Commit-Id: 9164e0912af206a72ddac4915f7784e470a04ace
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da13af839228cc3ec51d9caabea9c0b411dc464a
Message-Id: <173655877819.2259020.13894736945385047311.pr-tracker-bot@kernel.org>
Date: Sat, 11 Jan 2025 01:26:18 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Jan 2025 22:15:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da13af839228cc3ec51d9caabea9c0b411dc464a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

