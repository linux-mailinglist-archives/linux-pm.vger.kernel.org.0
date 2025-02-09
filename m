Return-Path: <linux-pm+bounces-21604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D9A2DFEA
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 19:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4321647B5
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD31E25E7;
	Sun,  9 Feb 2025 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/TaVpCn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2B192B8C;
	Sun,  9 Feb 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739125946; cv=none; b=bT/L5fwW6Fgi5Kr6nagFPr00Bq4XUQ44q6eOuL+MMg9eRC+7/R/yL0FkqCsnHbQ38Hc7XYMHkd0/eqNuYrIGxnXHUyQtCgtdwiDoRxIIEJ9SiGGbDzqKdlUXSpNl9bZ/yrjRWUZWlI9e0zzaALq7xBqSbmPPBZiX1nYD3Jsj7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739125946; c=relaxed/simple;
	bh=Hd8BKRh2tMFdmOCooVYjpwJGGHiAzpF4vKEQZ5Sulag=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qZRHSCmXz/E/Bv2BqrLgWulXPIxaksv9wd/BKVIaLdrZxVzt/BcqAb+0xALejrpPf3i+8C6Zp0/tGH+UplfLC8szOwtNOSz0fsjK+gugE0kgJBEWlL1crWkrz67P8gktKGPvYBIp2euuiQ3ilkLvSpZQhubvprX4BwtWwQVuNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/TaVpCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CB8C4CEDD;
	Sun,  9 Feb 2025 18:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739125945;
	bh=Hd8BKRh2tMFdmOCooVYjpwJGGHiAzpF4vKEQZ5Sulag=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V/TaVpCnCZTANNRb4fXfTo32y5ur4oU22qTcyEC7LmvZ9p2StoBDfiAgXMewrO6jR
	 rLCCtSuQ95u1Z2L2prqp8gj/Jmi+l3zaWxVcXRHHEr+clvINIS3GuJEO4alLt0Kh+t
	 AcObxlNJHcDKoKZIDBzMXAYA+DJIXkrLBNQ2gs7NX1+4+049FsJngNysqKSfMV2odL
	 PtKKJ4/1v6+IZf07qoFLr7SfV0IB3MMC/4iiSvJEO+JPaSSJjwLLPhp6OnRc4aL1W2
	 STLaN7rDhV6ZgS51kiSgawEAEITNt6QQKof/bTqvDKTvljwq25jg2SmcUe3f23O2kh
	 B40vg9G1UJ04A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4F380AAEB;
	Sun,  9 Feb 2025 18:32:55 +0000 (UTC)
Subject: Re: [GIT PULL] Additional power management fix for v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ggiSiuop5WeC5AZOHC_P_etyiOOW-EZstc3_i_8dEz3w@mail.gmail.com>
References: <CAJZ5v0ggiSiuop5WeC5AZOHC_P_etyiOOW-EZstc3_i_8dEz3w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ggiSiuop5WeC5AZOHC_P_etyiOOW-EZstc3_i_8dEz3w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc2-2
X-PR-Tracked-Commit-Id: 7585946243d614bd2cd4e13377be2c711c9539e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 146339ddb8b7520ee486389c7b0a7b24d68e5f60
Message-Id: <173912597391.2868883.18277980170846640719.pr-tracker-bot@kernel.org>
Date: Sun, 09 Feb 2025 18:32:53 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 9 Feb 2025 15:04:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/146339ddb8b7520ee486389c7b0a7b24d68e5f60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

