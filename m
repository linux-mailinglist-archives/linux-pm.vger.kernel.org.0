Return-Path: <linux-pm+bounces-27597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EB9AC27EB
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFEE9E42A2
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34AB296FCB;
	Fri, 23 May 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvbYfOjD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78921296D26;
	Fri, 23 May 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019069; cv=none; b=XsgjdwgP2QCzbmP5OkrC5hz8YvZR3T7blFeieACnQJf0fcwvyHNFmAnWoZavSpwKaKSwTRPiAaH95I65L5KEug3IjI1daxrHLOhZuLGo1leWP4a4Fj49lDXlnwm/zucmpIx38nN/d8vgy6hksMnfdLS2IldtsHkUunjG04c3dZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019069; c=relaxed/simple;
	bh=QCNLeg1eIDnhSEBsotWoZ7Cdi7uOOQCHPM5NmVDVyPQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FgWsI484SjAQYTEHBTbeNJr17HdTSFS2riw82CIZcc35Lbul8iC4xDH2XVSogaXAFryPyWYa1TadaK7zVUVEjh/q+tJbwrrZ9Q75KreMb6KV1XadPet4//2TFkRUDeL49C95YX7zUNc7hOkdY+HgQZwmGBMrPmFtUICrp05BMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvbYfOjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82EBC4CEE9;
	Fri, 23 May 2025 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748019068;
	bh=QCNLeg1eIDnhSEBsotWoZ7Cdi7uOOQCHPM5NmVDVyPQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AvbYfOjD/gi/1GC97I0Jt3q0ST5lTx1V25utdj5JoIPkETpZXz0Dq0+nzGcjPXBGR
	 k3nfLz4QIOHSLNblwuZu668ZyMD+NeNTPMhjigj2CXJUq5hYvLbRKU8+lP69cCTcec
	 JNrq1jd/YnbxSN9mrm0OTDyqdw9a6zYviNoytYvhbLNtlx3FYyXfzTUC9FeUNFdgrK
	 ojM0TsZUhAxp/aONqCMRdBIyj45oryCQp/etBtGDLk/x+P8jJBKVXIllQ9tSwh178o
	 AYdo/uiTpWgPUtAhtRAJoqOH+Wx1eLkJPyWKcH1wFpU2TAuGB3Iqs7mE2hQQpfgF1S
	 6jpQI9TojsbMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7110A380DBEB;
	Fri, 23 May 2025 16:51:45 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for final v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j7MgC5SheA+8A-QiznuCyT9cRG6spXZS4d10OVGPmgfw@mail.gmail.com>
References: <CAJZ5v0j7MgC5SheA+8A-QiznuCyT9cRG6spXZS4d10OVGPmgfw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j7MgC5SheA+8A-QiznuCyT9cRG6spXZS4d10OVGPmgfw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.15-rc8
X-PR-Tracked-Commit-Id: cf948c8e274e8b406e846cdf6cc48fe47f98cf57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7586ac7c340c3672f116052c1d150f134810965b
Message-Id: <174801910395.3663029.18440796244398718733.pr-tracker-bot@kernel.org>
Date: Fri, 23 May 2025 16:51:43 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 17:51:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.15-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7586ac7c340c3672f116052c1d150f134810965b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

