Return-Path: <linux-pm+bounces-28169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9113ACF86A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 21:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9271C189E383
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFB27C842;
	Thu,  5 Jun 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlyQePWc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385365FEE6;
	Thu,  5 Jun 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153169; cv=none; b=li5LPFz/kX/zKiuiy5tBJ5c8YYlm80muMAKBrfp7xd3ABze2Us32y7AeNhcog80bJez5IcyvMoQllPCmv47BvumMUAtlg7fGl2ZxBU45BMXJC3tMC+bsxQoHEaTTeZO26WPHBsSxz/EFjlhx94x3viJfnRuktAAWhIomssQJQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153169; c=relaxed/simple;
	bh=2vCTRriFvgVJBP/Lq30iL/1OL8pYDeS9RFxclbxGhVg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UPUlxKwsHtsTODRaJr+1K+TsLioXwwBE7Ws7HSHDKHHp3JgCQvbePsyBC0XsMrRyOo1gYs1YleA7DVThyGFZMsNQ92l+BFnR+x8ntXyRQV4IJTNzf/lEz4q39uCrdCDfpqilQZfn1mLxGV8qJuw0wZZJUTEbSdjQRDUNI5LRFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlyQePWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18490C4CEE7;
	Thu,  5 Jun 2025 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749153169;
	bh=2vCTRriFvgVJBP/Lq30iL/1OL8pYDeS9RFxclbxGhVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZlyQePWc+QKBFjhEUmuPW0CaqwneW3vAVgd7oKeN9MIMoFIz7RBqM4VP5jXd3/q7p
	 2NoOAVsTSDeDOXF+ouWGF+Rmg0BjmD4euJbK4Eb/FM7bpsz9GZjgaknK4UEW/M/0IZ
	 nLtq8oZU01SdapDIa0rq3HxZ0DQi7Nzec+O4EUN3X1IJtsfVNcZzCGR8Xb833nlKdQ
	 MLbOdbZAqccJGIGwWe4uIAsloaxMSNfTPa3IHvvcvnMzpc7wgWG7p9Jg9cFyCAZZ5S
	 mIAi+QzvKW4/w1Wk8BtdaRstN45pOhSAvaZZG3vcXw1gOaQP5DSuHWDzOTXGltsyYt
	 SIQIa+PXBfL9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EAB39D60B4;
	Thu,  5 Jun 2025 19:53:22 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hBGhVuwsfQW=-MDp3nLL_5epaYYHqmPY-DY9_g6wciSQ@mail.gmail.com>
References: <CAJZ5v0hBGhVuwsfQW=-MDp3nLL_5epaYYHqmPY-DY9_g6wciSQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hBGhVuwsfQW=-MDp3nLL_5epaYYHqmPY-DY9_g6wciSQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc1-3
X-PR-Tracked-Commit-Id: 8887abccf8aa16795f23ef3a3b25650cb8aa804c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e271ed52b344ac02d4581286961d0c40acc54c03
Message-Id: <174915320068.3217379.7026462050758907526.pr-tracker-bot@kernel.org>
Date: Thu, 05 Jun 2025 19:53:20 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Jun 2025 20:55:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e271ed52b344ac02d4581286961d0c40acc54c03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

