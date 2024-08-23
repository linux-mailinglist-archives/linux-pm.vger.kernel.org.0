Return-Path: <linux-pm+bounces-12813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6828795C9D5
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99D8B24F98
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8717E006;
	Fri, 23 Aug 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmPyBgj5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DD15383E;
	Fri, 23 Aug 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407210; cv=none; b=HYlUMdpv0dbTUyAyruVNYbuEAX8MlIEvTV7f4MsSTev76kkm/kXtWMf1u+w/GYXoU/LRip3LRxa6BQv8MtFKnj2flKT4GVcaUyjcp2k9WnPYZA6Fyx10dFitO2S8BBiLNEODAVDNoJMGXOfGLeY6UpvE0qrlzW4wyf9bypql2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407210; c=relaxed/simple;
	bh=fGoBD7M7Ro4AqRntv9VUq8/LJC56lXbULjQ9qQIIVc8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TZSPzwWTM414qOuKYPqQLutzRT0T50346NzGCDvcFWngC7135aEYXG26uWUauriM+Sna+rtEfLz6BRWXhtUf+t6ARxabgW5p8QemeqEKRyNS3pLhA0vA8GE49hLIwLGm6VIxwUnJNiBV1WH8nuBORB/0FJkZmMRKOy5wvSvEJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmPyBgj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521F5C32786;
	Fri, 23 Aug 2024 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724407210;
	bh=fGoBD7M7Ro4AqRntv9VUq8/LJC56lXbULjQ9qQIIVc8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DmPyBgj5z/8aFwerJBrXNKKO8ULA5Hr7DJHP9VufAJGeQLnQUH5byXKpyVDxVB3Z6
	 eOMeJyxQjRSKGx6xScbdmxIR5zmL4WmTdI3+Il6k1TvOwBgpozEhk23nOYgt0aZI4v
	 w8FW8HhjdsS+qBvjBDw2lrCTA4TSqVyRZ4WsXYWSHUBwMoPWQCMkInioec7gDg9sIb
	 nzg70tcIlFoCOlp6DqWzn78ITCCgoTuc/jCemsd5monK5JsBUCMI5LaTLGpqMVCcDY
	 E5yskIi+/3OrJ737dUXxcD9QZclFCLUicPVf9Ib2mfWxTt0q05kIY63boLSpgxkpf+
	 7nRtmEPOhJK0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DF53804CB0;
	Fri, 23 Aug 2024 10:00:10 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing fixes for v6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240823094628.34085-1-brgl@bgdev.pl>
References: <20240823094628.34085-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240823094628.34085-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git pwrseq-fixes-for-v6.11-rc5
X-PR-Tracked-Commit-Id: a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d5f968a177d468cd13568ef901c5be84d83d32b
Message-Id: <172440720954.2916351.14241254705797611587.pr-tracker-bot@kernel.org>
Date: Fri, 23 Aug 2024 10:00:09 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 11:46:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git pwrseq-fixes-for-v6.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d5f968a177d468cd13568ef901c5be84d83d32b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

