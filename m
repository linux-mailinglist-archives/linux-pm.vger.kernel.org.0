Return-Path: <linux-pm+bounces-13293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263C496734D
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 23:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6CBB21FD6
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9D17C9E3;
	Sat, 31 Aug 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjcbJH/Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4C17B4F5;
	Sat, 31 Aug 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725138632; cv=none; b=go7knLmI/2djbG/bDHuPd2PXFDvdARnAY610BY2K/Ra7H82hdaUy0NzKuGI7BTxGu4KJMuAY1IWqUJ4OpVsXMdHqPXVNFZdcqho5ElxwUGOHEFtjTDrlSQc0eInhJuclRAxvWbwLcUW8S9n1A/nU8Olj/IL7OZJIgPGRac+mupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725138632; c=relaxed/simple;
	bh=p5J810gzXvICw5jj3vaRxpoFErmOah5ALjGJhciFh1M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UvMjUeZXP8WJ4sX5zigJ+huIQ+Gm/yXI4LtAuC8K+MUQKyC0Wu9Ha2G122amTHEWT6DE/o4IMTm/EIoeXOThq9vgt9BP3I/Y8lnlXr92rPu2f08eXUdsfSStNvPw6XUcqdYT8tq2fPiRbhh2QVp2LEX0I8lrA47AhcnhO+oZ4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjcbJH/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06B0C4CEC0;
	Sat, 31 Aug 2024 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725138631;
	bh=p5J810gzXvICw5jj3vaRxpoFErmOah5ALjGJhciFh1M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DjcbJH/YcZhGs4pkYHaA57z3P8TaLkoHkZ371gsQT2skqkbAQIAsI0CpkJaszbgbv
	 hkGaVGK0UjuJMMHQbA4yP/0g6XwTw7aTMuvxEm9//LWr6WyhU3+rdWMy0BdgYD6ViY
	 o95I1y/b+xaPHwt8xP3fTIOdrQlgnV5Xa+ktr4XMnbCIJ82HA2wvsmghV1d1cBUvyC
	 NIyMhdZkH9SQBhueoq3Oe95/XpWdh3aSZVUVdPyjtqDf27Sw9r0m8wY44JOlAm23dN
	 b4hRx5C8CsuKurWN5Tz5TY5V3QVuakkDD3F/mHKWi//z/ZzwkgxXAtdJvuU5MQRU10
	 N5Ubvgm6pnb6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715F13809A80;
	Sat, 31 Aug 2024 21:10:33 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing fixes for v6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240831194038.557316-1-brgl@bgdev.pl>
References: <20240831194038.557316-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240831194038.557316-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v6.11-rc6
X-PR-Tracked-Commit-Id: d8b762070c3fde224f8b9ea3cf59bc41a5a3eb57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8463be84486c19221198a76436d9177f395bb2eb
Message-Id: <172513863194.2930508.11269425137429688019.pr-tracker-bot@kernel.org>
Date: Sat, 31 Aug 2024 21:10:31 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 31 Aug 2024 21:40:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8463be84486c19221198a76436d9177f395bb2eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

