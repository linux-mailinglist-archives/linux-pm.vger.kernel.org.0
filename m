Return-Path: <linux-pm+bounces-14399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F397B9B1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4761F2870D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6857C189F39;
	Wed, 18 Sep 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsJyU2Tn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4195F189BBE;
	Wed, 18 Sep 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649837; cv=none; b=JzK3m0ZkSUVXsp+2rP0Sw/iGVu4Ne8EAW6pxNOvN5E3vscHFwvXTw6dJLPrnfVzOOrTW/9jIRmh9XRsTRbtzxoG5FH6C4I/hlIo6xPLzkZLRQw2TntQM9jo28adsT+dOVzwx4rH7vbpOwdP5TPkMs2jFtewjqB7Q02kyBu6BGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649837; c=relaxed/simple;
	bh=MK1LQ2t5FnD4m3GkLxugX/W++Y/oiu4RObC60qfTc/A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YwK4sy13mT131SYeA1vzG5EpzlyiCW97irAth+/1++lA1/noSN0ZzFMVsGrTGLak+A7GY1SmX+i3dWLv8bA0YOyFdmmwo7IUF4stDHrlflmO+j+9+kjPFJLC6B9NsvNXoSV4FyT9r56ycH2HF45mybUEGww3lIxL4Hiz9GGwuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsJyU2Tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24274C4CECD;
	Wed, 18 Sep 2024 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726649837;
	bh=MK1LQ2t5FnD4m3GkLxugX/W++Y/oiu4RObC60qfTc/A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nsJyU2TnCSER0NQ2+xWhbepGLfSOj7Z8Rxtw+ol09zOIiI01Xmr+twCqZNJF/Mi/L
	 hhP7TPD4vacEQl9r0/1PEWV0E/p4qfdSInE5QPlo/XlrNJL4+HmnFzhvoJ/ZZZPAVx
	 615wleV5RIH6xZUS7aAGvi9MHpTP/B7QoCtT0+Ob+D7mjOiRlMX83b2IlMXeBjPhoG
	 sLk5nTfFv9ATWZPIcnmtpU3AxB9n7M0bEtASrGgbUd3cvOEiX6pNCMtIlQWWKhgSot
	 RpUlZOOYwn8LwMbejM6+iXPaHYflJAiN8bQOHUkUlVaKWzoChRUb5mlgxzJUcX/T9k
	 ktL+jo5InWlcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2689E3806655;
	Wed, 18 Sep 2024 08:57:20 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240917094557.6419-1-brgl@bgdev.pl>
References: <20240917094557.6419-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240917094557.6419-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.12-rc1
X-PR-Tracked-Commit-Id: 8b7e0a6c443e855374a426dcdfd0a19912d70df3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fe3c78a2c26dd5ee811024a1b7d6cfb4d654319
Message-Id: <172664983867.725883.1393073165176054279.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:57:18 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 11:45:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fe3c78a2c26dd5ee811024a1b7d6cfb4d654319

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

