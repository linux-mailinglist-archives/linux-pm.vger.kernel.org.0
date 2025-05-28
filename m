Return-Path: <linux-pm+bounces-27709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA9AC5E3E
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 02:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8984A204E1
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900619EEC2;
	Wed, 28 May 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDHo2YJR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D261367;
	Wed, 28 May 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392152; cv=none; b=EJd5so52PxD35h6WSh37NID4hJkT5IXBiWXUz1ExtGcdPEGyyiury4PWOqknrSGHSwhaMbnMPSeSoUbYUl/cPbdYoagkoHqDbTgDI/dvpU93BYyGMU1GsL1ZlxH9zfmTc28rOQIjHqT2+pRtCpsF6NquHAgiNuxaf+08GEQvp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392152; c=relaxed/simple;
	bh=gJZEWnYZxiKBXygEE4UGlJ8+3NxbaZluiRnKvY8jBAU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OBlSiHZ3aUNBZengKPDnZ2T/GoPl8kpOWUVaxdGztieElmtxlzdwkGdWGTp0dY1270NsyPuVvQ3fJbuonzcF0/o0qEqP9cR8afEom3TOvdmO+WZsuZW3ZBeELvdaq2FS8dcejAikg75ntfLmCcE0F3UpFn+zqm4QwrUr1Jrz2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDHo2YJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1189CC4CEE9;
	Wed, 28 May 2025 00:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392152;
	bh=gJZEWnYZxiKBXygEE4UGlJ8+3NxbaZluiRnKvY8jBAU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hDHo2YJRl0Oz3NIuJtMNllURYFRzs6tZiYJ5X51thOOlIWqANQm1dQY612L4sbWP+
	 GtFXTdgZAthPuqA9acwzrFtBqfwcsx0EdqVwyBy3916NYC+Iv0eO54i6J/jdQhY0io
	 t/GphVsqenYfHgcUX0fCR4PtCPjVX4YZDMjjVvT6ZQHhnscmKPv9Op85vRnhYaOFnd
	 HfP1J5TcSTSrUb60688owAywQJsh9oHB7qYjMbZXL5UR1Nf481OHjD9QRl7Fl/+Psc
	 TuiwF4q3eiFGYoeTxor9hJXz88SywNW7D/EAvPbLT8rkyltEAY6QaCqCGCpYalZyiW
	 9LuXVCYvNtBeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DDA380AAE2;
	Wed, 28 May 2025 00:29:47 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <qhvmgti6jmqnepwx2fbhgsflclznw7hnjco5xebytwxuh2mf5g@m33klrxrhaew>
References: <qhvmgti6jmqnepwx2fbhgsflclznw7hnjco5xebytwxuh2mf5g@m33klrxrhaew>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <qhvmgti6jmqnepwx2fbhgsflclznw7hnjco5xebytwxuh2mf5g@m33klrxrhaew>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.16
X-PR-Tracked-Commit-Id: b1d8766052eb0534b27edda8af1865d53621bd6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7c18635363f06c1943514c2f4c8170b325302e8
Message-Id: <174839218613.1837144.16932051020055217660.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 00:29:46 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 May 2025 13:41:14 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7c18635363f06c1943514c2f4c8170b325302e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

