Return-Path: <linux-pm+bounces-37151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D02C23109
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 03:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033BD4EEE3B
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 02:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1193A30BBA0;
	Fri, 31 Oct 2025 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3wyasRM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60214A8B;
	Fri, 31 Oct 2025 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879132; cv=none; b=arGylaPQieUV07/4E4Emqnlykn+1t09yvvZ/5dmbpIdVL35mkpAUbn5jem7srj4WeQzztfoboGOupdexwLzmRpVlpMG0Cpw5wzrlZSxgDxjjZa7MY+s75hTxpCEmffjZfQU8GlorQx0t4QbaHlPsUitzaSu+MSIacDMFusZNg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879132; c=relaxed/simple;
	bh=SCSIk9IedYum+h/zE/p3ryNiPP7mRH6mvv5r/yeAOTc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rVCvu35ar7IBBOmNsQLtWPYmFU7YRULBunB5tfkIgcxEQdQCRxPmqg3Eb2X7YUyc9DRi+pzxoTEHLKTRdRQr6oeDJJBsSF64gY8p1soY5Bw0knlgZeLAN2+Lx9FcGrhYxxhd04j1Xmq1kVWu3DhZcKJrivxhqUEmh56rmNeeNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3wyasRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2518C4CEFD;
	Fri, 31 Oct 2025 02:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761879131;
	bh=SCSIk9IedYum+h/zE/p3ryNiPP7mRH6mvv5r/yeAOTc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t3wyasRM42cs/AYp/6Gm/kLwC9pa9h8JJTz4Qj+jLOo/kfJCTvpgUbajSPu5VKeGt
	 EbA2MstCgIj1KZAFYXoaaOyInVy64gZ2C8ia0m8GzzSZ2zKvmuls+gVDUhoakU/WRH
	 dXHC4OxnUACWwjpnqcHDTHcqOie1i96QajV7LGwONoQyo5F8Z1WXD/fVOXOnil9x3K
	 CCjEiRLrDhmqTD1fuJLbvHCuMbAaRylxe2yGAfuMCsR+c+FJlSDOxr7cyjap2ITQys
	 ytrBTNXziN5KDSlGKOrIvGhVxyyO3ubeWPkGqJaCEMt5aCdLmiRmN/yRHQrQtuuoKP
	 LvBFcu2Bwp4TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCE3A78A76;
	Fri, 31 Oct 2025 02:51:49 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i1FFbZZeqtk__gKMy2dc6HREtqm7aBmNpXeFTKz2Kbvg@mail.gmail.com>
References: <CAJZ5v0i1FFbZZeqtk__gKMy2dc6HREtqm7aBmNpXeFTKz2Kbvg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i1FFbZZeqtk__gKMy2dc6HREtqm7aBmNpXeFTKz2Kbvg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc4
X-PR-Tracked-Commit-Id: 590c5cd10675a6ae49f6019502dec5c87aba07e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5dbbb39e11d50a8c426b8d88f5b12031fee49f3
Message-Id: <176187910815.4119220.2876290775081256394.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 02:51:48 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Oct 2025 20:57:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5dbbb39e11d50a8c426b8d88f5b12031fee49f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

