Return-Path: <linux-pm+bounces-39682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8EFCCD9C1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 21:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A57B306FDB9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 20:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6748D346E47;
	Thu, 18 Dec 2025 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB2E+5Po"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40150346E40;
	Thu, 18 Dec 2025 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090598; cv=none; b=bqZiiKa2HF2r1CsPCZwScpTVPn/QkUajHiAqz8sRMqeppNi/JDuFJtTDn2RDtybMDj03vZPY6wPEBAlIXpS6hBBUUNPl1sG+YcgAJDFpoZFaV7HlCvjv9675115Zglo0+vmRk80Q8y6SiBqSilbcKnkg54pq4N1w/Ofdbg+cUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090598; c=relaxed/simple;
	bh=n7sfPQcIdOvXVQgBU2i3YBnPBhKXSDDvUSe2av/X33I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rl6dAZMQPJPR9doOlWWs7cHx4PTeyzaqiDXu+BnEVxyfDDFz8P8+fOkHnyJsmwCgccFhfdsTIoU4SOP2gx0VC4EDZSbc6HzerGWRqN/y6nLsvjbeHnBYxZz6+rYzYOTrNW6PnkXENV7DL+3buxg6jtU1oaZIvBqn4hRna8FBzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB2E+5Po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0906C116D0;
	Thu, 18 Dec 2025 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090595;
	bh=n7sfPQcIdOvXVQgBU2i3YBnPBhKXSDDvUSe2av/X33I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oB2E+5PoqvtaUuk69WeYDw+cfqAnapj3OL1WJK2dUdaoVzybg4xyYQlgbxTm5DPy9
	 bT5CtUpAaPAQq9kFoSsq3CY2AuMTU/zi5ybMcmySsjZ6RkuN6jxe4xL03ANCkYNnxT
	 R4VDBFJKPrrQ4CmgGJnLrMzBYO13/QXIKxFCmfF2tSTCoSyC0wsgsdJoNqohSBH5FQ
	 WDE1NZNfLG35ujmZHv88/mzDIysLfxLhsIZF2zYzDxXlDp2HuKZFZIOS349Iwqnxe8
	 EfYopIJAsM1iWl7NMzaZ4wgdxsY1xQIIpwDT/tdcldbnbXHX1ofsQgx98tRb7RDIW8
	 /Lnrr/rTFYEtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78F22380AA41;
	Thu, 18 Dec 2025 20:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0grcSP=+3LZha+CDUJM4w_bou8y3d=y9x3xVsAKh5p1pA@mail.gmail.com>
References: <CAJZ5v0grcSP=+3LZha+CDUJM4w_bou8y3d=y9x3xVsAKh5p1pA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0grcSP=+3LZha+CDUJM4w_bou8y3d=y9x3xVsAKh5p1pA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc2
X-PR-Tracked-Commit-Id: 277141a897c715e787f6c51e5db32f2ca90b00dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb23a1198d2317072a44ac1b8f5742f4cb48ce2c
Message-Id: <176609040542.3123986.5247497235383561629.pr-tracker-bot@kernel.org>
Date: Thu, 18 Dec 2025 20:40:05 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Dec 2025 21:03:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb23a1198d2317072a44ac1b8f5742f4cb48ce2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

