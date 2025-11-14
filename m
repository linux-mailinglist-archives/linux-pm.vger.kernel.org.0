Return-Path: <linux-pm+bounces-38080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A5895C5F6B6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 22:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE3A735F942
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6735C195;
	Fri, 14 Nov 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwtfw0pb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F035C18A;
	Fri, 14 Nov 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156583; cv=none; b=be8aJ3ArHx6z6aSslYxBCU/vBf0mx73y+3hJl694nPV62libytAOf8FFaIKEvRsEGBjlaKhc89rAoS7n/xxWTEX/WCOSEYQyvWLMWFkb3IzhmJifjpR9TMRxnM5xM/AyQVD2o+7dCb9j2rBWk8qCTKxdQ8Pr9uTZc74HicbtZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156583; c=relaxed/simple;
	bh=cXiTKb+J/2SYyIzJUk+sk/CI7+/XXtxQoJeF7Igyxv4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ebxe2rrYtMZ9TmHspik175GU/N53bsbHoJwEXFPUgTR1PHShAo9BzCWKEnVy0rL2dpRxph17pH/5CzQh+ZPbkxr64qHxD7EnSHxSGs95sBTgBbbdno4J+zIr1u/NjFK1uKTSqXpdfWge/H0EVUbQpL/lisllHrnO7rv2NyzYZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwtfw0pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F370C4CEF5;
	Fri, 14 Nov 2025 21:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763156583;
	bh=cXiTKb+J/2SYyIzJUk+sk/CI7+/XXtxQoJeF7Igyxv4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cwtfw0pbuIHZ+WaTGIuR2giaqRSC8JMXU7zPhUtvGG/SA4oU+j04at2oK34HjYBK0
	 OCYZYlN8sg+6sxGTonxBK7oMXegA69JbhgiUya/+ajTotP8JRlx6BbsLQogd5NzI8C
	 iBfSWauM1kDEq9wXDnhGZ1LJ4suVAYjZDBJZs1Fjz6cvgoKvaJNnfcqZYVQMnS+jpc
	 Ffjvbhr8ZzL8ElCAwO0C0ows9byEsJZUoImqB421/7uuQHoLKRlUnxcMoSCE6rqO32
	 ebf+nN+0qSJqFf2XiF3DFHTUsLAa5DVMPwANcUK229hP7GemOEEtWxNojAKN0BkJSs
	 K9ZgUFXXkARQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6A3A78A5E;
	Fri, 14 Nov 2025 21:42:33 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251114161152.92955-1-ulf.hansson@linaro.org>
References: <20251114161152.92955-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251114161152.92955-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.18-rc2
X-PR-Tracked-Commit-Id: bbde14682eba21d86f5f3d6fe2d371b1f97f1e61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 241e99dbdcdfa715989555fa1d83025a8ce95775
Message-Id: <176315655168.1846194.15632016111013064431.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 21:42:31 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Nov 2025 17:11:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/241e99dbdcdfa715989555fa1d83025a8ce95775

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

