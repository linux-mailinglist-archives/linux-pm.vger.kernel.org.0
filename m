Return-Path: <linux-pm+bounces-40156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44212CF03F2
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 19:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EFCA3017EF0
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 18:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606A20010C;
	Sat,  3 Jan 2026 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKRScet5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4DD82866;
	Sat,  3 Jan 2026 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767464127; cv=none; b=jOuAqI9HThTD5f3autfEE0GedHpxATUh7sStsYGAyDQudvEORAngAvFT8FWS9hJSZiC3t9yLRfuO8gsJC4vfk/B6U4YqCh2Mf0Asf0icePcEOLG4jTV3Us8O6h5d/F50d3hXy9CNgmlPFOfuDRO7gvbVWXS1TWz1So3DJKYn7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767464127; c=relaxed/simple;
	bh=hFpX56ln6Yt9IaSkek/+j4UlTv6P2fbyqZTt/s4bWGA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qPfh1raJYVyOrA32kDOcvOyixB+LxAE/Gc23XL+UnqzFalw5U6rtJPVjmdUHJt71paTXl3VU0U3B57/hz1NJSlsptQFYACwulfaXi2ixYZYMVZz4D9VzpLGQW3zgLXhBbzkCHXQBHuumX0UtPMF9/jXvIRoJ+fA61mk8gTGvbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKRScet5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEF8C113D0;
	Sat,  3 Jan 2026 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767464127;
	bh=hFpX56ln6Yt9IaSkek/+j4UlTv6P2fbyqZTt/s4bWGA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZKRScet5qiaSNilXdLTXMT6RgzRGv4La34DKPCcWvLBLdjWpgjPA5mnjr1GsK+FNL
	 rQVDv3igC3150/n5ePRsp/daUmcBPmU/Vf2j+XDY2NKSLgBQKrVAcHgyIo9POF2TWs
	 KW3I7q+4ZYZO3abXxij9pfhyERVPESbJA2GLCe6AaK99a7ILdnRbsx4XS3/ooRaP4q
	 J0MGnmpooUvjBgVKoTaIse2kRa+E2oR+xSL9wJ3lETlCO145dlrNzxgA8ovKqBFvMT
	 d3aZ0CwMiCIWjOczPANRJbxiEDpL+MqyUNRd4JkLfPfSoZflZWjEzUatztvnW05Eio
	 Yzb7i+baoOEeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BBBA7380A97D;
	Sat,  3 Jan 2026 18:12:07 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.19-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260103093751.58526-1-ulf.hansson@linaro.org>
References: <20260103093751.58526-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260103093751.58526-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3
X-PR-Tracked-Commit-Id: 73cb5f6eafb0ac7aea8cdeb8ff12981aa741d8fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aacb0a6d604ac9953b261963efe25ae7521b7c58
Message-Id: <176746392631.4169496.6609966638803957076.pr-tracker-bot@kernel.org>
Date: Sat, 03 Jan 2026 18:12:06 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  3 Jan 2026 10:37:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aacb0a6d604ac9953b261963efe25ae7521b7c58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

