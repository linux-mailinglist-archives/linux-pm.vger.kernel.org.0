Return-Path: <linux-pm+bounces-31723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF56B17C43
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 06:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB005870A1
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 04:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A68A1B3930;
	Fri,  1 Aug 2025 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV3w44+f"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B818DB1C;
	Fri,  1 Aug 2025 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754024020; cv=none; b=Aj8ACwlNWbiNNTvPMduzotekxx8GttXvq0C0i7FvTw28DfDBrFBEbEy7SPSXHmlzoR2ZlbkpEzWy9fiQVsXdu6MgOmW55BtrgwfmyhafWzR7HzjUFs8/xMZ2d0lsGBRDatlY8adFX4592uZTBODIk+bCgmLrN4W0crx/i5qaYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754024020; c=relaxed/simple;
	bh=tZ0wKsgx+opt9hj1bP9PLZ5svAxl7z/FdH6Mykc/XHc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LiAGu6mBrGUt0fs/1pJ9knwwA2BLmKCs5oByyBwIyhJ44vHWjcArkWLGjn2mjkLmWyXMySHfIDXjr2MRlj1vg710cPlq0E74qX0yClAsreBI6p9w6CcxpyRBX9r5N6zIWa/9y3BE2ZJFhdARTgK4aYel0r1ojEM1I3rL0qDHfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV3w44+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A37C4CEE7;
	Fri,  1 Aug 2025 04:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754024020;
	bh=tZ0wKsgx+opt9hj1bP9PLZ5svAxl7z/FdH6Mykc/XHc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hV3w44+fdlcG1Vsc1H35t+ZB3156vKL/8I2tYNvNUWxo4E5f5YaK14Ew9/lsdSrNk
	 J5Av/uUHmJypaa9vyhT7jWNHeVGscd9q2F39y4uXc7TunQjhsACtGwNOvH0O9mayNF
	 hxMAC6edBJiOfleG/53zffQVjIEQ8dAURCIGTflBOElSVxp4iBRpLau8KqP4bQo87M
	 H1EEdDESLGhFeO4UNkS8RWbbnKfrpYqNRd272FdwrFTb7HJjOhZoGUEdroDa0GYo0y
	 Mst7HFlbKFwfCVDotoSzHuP/beobNUWp7yBo43CCnTRYqDaM0VkkfsWUOHnsN9MFPh
	 gUgGautJyrDjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE419383BF51;
	Fri,  1 Aug 2025 04:53:56 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <ipmplcihen5gpch4qg2rixwmdoad23w4d5qtdchcv24qx2mkrj@5bsvfer4a5lw>
References: <ipmplcihen5gpch4qg2rixwmdoad23w4d5qtdchcv24qx2mkrj@5bsvfer4a5lw>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ipmplcihen5gpch4qg2rixwmdoad23w4d5qtdchcv24qx2mkrj@5bsvfer4a5lw>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.17
X-PR-Tracked-Commit-Id: 7b41a2341fa62babda5d5c7a32c632e9eba2ee11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07b43820437bd96f31f5d7f9baf4453fcb7dedbf
Message-Id: <175402403526.3436555.426145994695515908.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 04:53:55 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Aug 2025 03:01:04 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07b43820437bd96f31f5d7f9baf4453fcb7dedbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

