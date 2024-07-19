Return-Path: <linux-pm+bounces-11262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B69937D81
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 23:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6581F21A94
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A93B14831D;
	Fri, 19 Jul 2024 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgjWBXw7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012001448F6;
	Fri, 19 Jul 2024 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721425179; cv=none; b=RE06LTpcFipDJSFFKFKMJwOTiaVxqX0h88gEndQy5ia/jeciQXTSDqoM4cDTcPPjdfSdT6ic/H0ipwOPecE29AuVnMBKsuR7tl42Xz9iMWsy5hhsLrZ/GBOvzAiGICeO1sG6VIQWuPr8/tu73OZYX6BSXnDpdZcC4vsSUq8o/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721425179; c=relaxed/simple;
	bh=UwUysGS2ch1pB2hYN25MKw8VRGgbtljJyhKYw33AC8c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F4oIO4fIUCgEoT9WUeTuuvo74QxZ90WG7dZ8gepwpyUMyj1C/1QseQjuUi0BU4AVJ6/BxSO41UGQZjY4LjIgatkcpD+X+uGIY1tFguNjmsKm8dQUJVV48HDRzy64iWFZ+3s2KB2f+oklKKLOWuCa5VDKyhLG0Jw7VW3BJ/o5HUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgjWBXw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 823B1C32782;
	Fri, 19 Jul 2024 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721425178;
	bh=UwUysGS2ch1pB2hYN25MKw8VRGgbtljJyhKYw33AC8c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TgjWBXw7wy1rsdkGYNUk2mKu7kqj6iS98VGzA6FWc1kbylS+9MlP+lj2FfyAThTh1
	 Er7NafykyAmyU6vLi2sojaNHCe8ISXDC8IDX3BqyXQUPFdYDRNqsFBTbGJvqOT4VNL
	 3wnVdtlhMpFnL6TovCAzparmsOH6Iu7oxUahMjox2Mx8wITJLOGepL55aia8K4FONm
	 5IrA2JfPhSeAobqAJ4llfBjoJgLe3o89Q+tq+Dc+hx8Qphhmd6mzBi/5JSE1zsQGez
	 2DsxzbpO9qmNy6ZlFaPl8ZMfOuigBs9sYtnVJfB1UTidZG0kYITqXVeQGsnZpQjaCq
	 n9FMmFo7Mza1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7999DC4332D;
	Fri, 19 Jul 2024 21:39:38 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing fixes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240719093611.29244-1-brgl@bgdev.pl>
References: <20240719093611.29244-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240719093611.29244-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v6.11-rc1
X-PR-Tracked-Commit-Id: 1a8c67a8b21e26843d5641c55f48130b3e323ce8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c67f9084af3f84e63abb44b82316fe0dbccd5d5
Message-Id: <172142517848.30667.5863307250104228312.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 21:39:38 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 11:36:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c67f9084af3f84e63abb44b82316fe0dbccd5d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

