Return-Path: <linux-pm+bounces-17238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C17D9C280E
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 00:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FFB1F22313
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 23:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63591F6675;
	Fri,  8 Nov 2024 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks9ZlCdl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2A19922F;
	Fri,  8 Nov 2024 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108292; cv=none; b=QknCTJuO3Z+G5qCHT3eD4O9/FhSF/8wIzIR3+0LuzszPeWT4871CFU6EyoCsu1xCqYtbXgTG5m0dxeVGHE+dGEqNeR1Lm3fIz67fPjDGpJZRGrBdKu22m4FavgpaooPzs9WvyI55F2XmMcPZdvHvDUea89NY0kVIB0gkFCcZWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108292; c=relaxed/simple;
	bh=Rk9rR0sTtuWD1Kf9lufwZ08Hg7zAxkyqcf3TUAqcjMg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S5e+DMGUQpF9Xo1WRE4i3lx0cwcTBLLJGRO0HdAejjZfY/MX5CFawE7X/U/Vk+jXyr5mccQW42ocBHWhPRcdgxg4UGBL0TzoBlo17fHE8JNKzv21F0/GVM27i7JWAAtLndzGtdpKtnFTEso/m9HMGa8yl44RQC9F05+BRxDbQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks9ZlCdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0DFC4CECE;
	Fri,  8 Nov 2024 23:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731108292;
	bh=Rk9rR0sTtuWD1Kf9lufwZ08Hg7zAxkyqcf3TUAqcjMg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ks9ZlCdlCansskdP2dSimn7Kn+eYeJPnscdyoqjDPiGJLDptG0XIw4IyfapXvlxJ/
	 IvlrmaAhrN7ZFEyY0bM8zPjouj97mbbYDRE5BprTBwj869sk7PTAxMbczkq38ZhBR5
	 Zduzdy0Kk4uxIW49ry0yIV5MK7LCB14dbiTiDVot/fSxcKZ7814TRG7/RE5Nkqo84i
	 KVSqBkW8hUmPMgOr/VDBrwWkQUJezlwa+e6bb0dYKG2U5PmrOUVBRv8md1Fu13XWqD
	 gu0nKF+inzHDINNg+YL91k9ZEtcda+INSCerTGhgKyxylC5xBjQryEgYoKmnjHJMhE
	 3vST3yMWnNgQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE13809A80;
	Fri,  8 Nov 2024 23:25:03 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hNWYWG78+Y3EYSMkf4=mXB+2yS2QwNQ9Whaic48jLEAA@mail.gmail.com>
References: <CAJZ5v0hNWYWG78+Y3EYSMkf4=mXB+2yS2QwNQ9Whaic48jLEAA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hNWYWG78+Y3EYSMkf4=mXB+2yS2QwNQ9Whaic48jLEAA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc7
X-PR-Tracked-Commit-Id: 92447aa5f6e7fbad9427a3fd1bb9e0679c403206
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f63642c09dbcfe09ba50b896c382e224f7e630f
Message-Id: <173110830182.2790059.12122353086059107949.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 23:25:01 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Nov 2024 21:02:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f63642c09dbcfe09ba50b896c382e224f7e630f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

