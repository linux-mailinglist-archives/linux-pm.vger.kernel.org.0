Return-Path: <linux-pm+bounces-11866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F003F9464F6
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 23:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FEDB21D90
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14E754660;
	Fri,  2 Aug 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsjpr+GU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3349634;
	Fri,  2 Aug 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633709; cv=none; b=Ozli3b+7KY8mUkt2lU6EjuF5TdMRLrHPVYiaWbtzfYAmBDSQ0b8jo6hIWISZIYJRSFTH79XHEMQUhNu2+gG8rqcXA4RqUzlXU/1b2MXmSsOZrTOkXzhi1jZ3LcnB0hZ8jwc3WerQV49HUy5OqVhR9thUGSS80d4DshLvnE6O2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633709; c=relaxed/simple;
	bh=SKdIIs7Macq1MZQ/O2qND95jzDozwLExa7KqRHWBvtM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BqeAHSkfBJGgtn/zy571w/umrzEsRmeV1Jnu5TLO4Me17sAjpsGFdfdX3oNmK2tf6aKyE7x4M75BpkSWeANR+md+aBN1UwfMVtxNaZQlO1Y8/nCB+uAk2d2/KT5Y66pWc9FMj6wEPs3hyCnFsYN0rLaf8D5D/rzmxeNCn+TyWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsjpr+GU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FCCDC32782;
	Fri,  2 Aug 2024 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722633709;
	bh=SKdIIs7Macq1MZQ/O2qND95jzDozwLExa7KqRHWBvtM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tsjpr+GU4fW5Ylp6a+gQjNlG+zDoISJ1A3AQ2WsymAxWiV/DaEaZcJQ9LkPPhg8iA
	 MGOJ5H7eMcuc2K0rAraCi8y8aD6Yduh6WRX8rvnLy8CEsjPoVwkXMnhbG+IGvjTwXh
	 MJhf6WVQLjfa5vgehf57O9WwJFNQEV49sF2k3v64PvwARtEvfBvN5nm20ZuJg4aCjF
	 1SYaP4p+/Q+XBkV0vtLIjDdu7/EdyjIMFE9tyYDm2pdCVX/0zxXPgn9af1VrryAkFR
	 0KCD2F9gsdWC3RwKMpKB4RpifUF1HYEYei26hi2y4xsaa53TNNwUiMD4AdIzBNlUQu
	 olP1Xvw6oOFeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A1B6D0C60C;
	Fri,  2 Aug 2024 21:21:49 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0izLX1aQNBjAU20O5ZmxU7DnyVHJXf1=teyy5UDoZHmOg@mail.gmail.com>
References: <CAJZ5v0izLX1aQNBjAU20O5ZmxU7DnyVHJXf1=teyy5UDoZHmOg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0izLX1aQNBjAU20O5ZmxU7DnyVHJXf1=teyy5UDoZHmOg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc2
X-PR-Tracked-Commit-Id: a09074228977c24c677c10282f506fa11f88eb93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9ef02e56f0fd3668b6d7cb17f9399ea53f12edd
Message-Id: <172263370922.21514.13054975567836277592.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2024 21:21:49 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Aug 2024 19:50:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9ef02e56f0fd3668b6d7cb17f9399ea53f12edd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

